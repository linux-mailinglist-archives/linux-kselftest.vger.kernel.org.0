Return-Path: <linux-kselftest+bounces-19081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D0A991351
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 01:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B571C22F7A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 23:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02746154BE0;
	Fri,  4 Oct 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sLqgR0EU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C381798C;
	Fri,  4 Oct 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086093; cv=none; b=SkfvFvjI7d+3uitgbrjepx9516zaFxMY9uFqAhRx2Xgr7K2S1VO+FUIA/jsIfttk/wog18Z2fFacBaJtWigbSG7pDQ+xF5Foz//+ttDMP5YxIH10OAzMPOTfOs3JCp/1Y6tKDP0wi3x5z+HOArE9m7TdId6UJ5nQpJkKInaiWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086093; c=relaxed/simple;
	bh=LZdx3gL0E/kNckUlBb5kMa7MM9Cgn/wNq0iRBxAsnhI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s+bzaClun8bJFsRAETb5mWL9p8Ipin5U3sboH9wfLTxEV4IbEN14yyT/gHPkNKazO7Z1Fi3DWcKbWxzWp+bLXQuKjreiWLc4yDBMMp9WdzInV7B9+4xVNA5aBb7DM6G1dZt8DkMhVNCESEN/Z2jtTP1TxyYk3hsG93Io5KjtYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sLqgR0EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3D5C4CEC6;
	Fri,  4 Oct 2024 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728086093;
	bh=LZdx3gL0E/kNckUlBb5kMa7MM9Cgn/wNq0iRBxAsnhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sLqgR0EUWnEWQb8EqNX0usuYc/hjXeB4nbUmaHjuI+ltUanpS9PpIFPNjTtC5cov5
	 1m1TjD++q6FDFY44DY/OxkgOA1/+VIsk1BhM1ktW6baPYN08mlbMu/phPn/BFG98mK
	 OwXou9kMMwlD1VhacmtC1HuK2EbnWHlXyIZq2QNU=
Date: Fri, 4 Oct 2024 16:54:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Lokesh
 Gidra <lokeshgidra@google.com>, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] selftests/mm: fix deadlock after pthread_create
Message-Id: <20241004165452.a28856a9404a5a67d6fd201d@linux-foundation.org>
In-Reply-To: <20241003211716.371786-1-edliaw@google.com>
References: <20241003211716.371786-1-edliaw@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 21:17:09 +0000 Edward Liaw <edliaw@google.com> wrote:

> On Android arm, pthread_create followed by a fork caused a deadlock in
> the case where the fork required work to be completed by the created
> thread.
> 
> Updated the synchronization primitive to use pthread_barrier instead of
> atomic_bool.
> 
> Applied the same fix to the wp-fork-with-event test.
> 
> Edward Liaw (2):
>   selftests/mm: replace atomic_bool with pthread_barrier_t
>   selftests/mm: fix deadlock for fork after pthread_create on ARM

These fixes have different Fixes: targets, which might cause
backporting issues - some kernels might end up with one patch and not
the other.  Was this intended?  Is it OK?


