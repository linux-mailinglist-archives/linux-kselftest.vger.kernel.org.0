Return-Path: <linux-kselftest+bounces-32475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB34AAB92D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E223A497D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF492FD1D0;
	Tue,  6 May 2025 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lCbzDop2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A62FDED5;
	Tue,  6 May 2025 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493080; cv=none; b=Fahx803gu3/BRIg3/QtUm0j7bqW+VnvXPrgUUZSzB7LbjmYNPSW1TzPqz3SyZFOsZjmrqD2F2OD5ylMsdtZwuFmjrA7e2GbUGad7IAP+bWxwVnBzxxwaCcl8vQK/8NzJWhCZFb//Y79ZuAMTsA4UrBM0Xlf9T6KHbWXoLnoi+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493080; c=relaxed/simple;
	bh=NKn6va4RrIYH/N6ivqU3SO3bMLdN5tCZagXJqpCl7bw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YK+tHyRY1oDIlYqTJRrQfnXKwklVbyuyDTeTHSQ4Gq0WPt3hjd0M6S+CeyiijcXSpfF9+1bWaKlBJ9eGVQcx1bYCb2iijlnfdIR2qXETAFFViJ6udxmfJTEXbZv7Rl8/7gHicTJ4b4wBu2po1kfRPcWffa7XChs3HpmpUwfc9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lCbzDop2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA55C4CEE4;
	Tue,  6 May 2025 00:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746493079;
	bh=NKn6va4RrIYH/N6ivqU3SO3bMLdN5tCZagXJqpCl7bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCbzDop2tuZRBHs7+HWg2DPEi+0xrZWB+39oDtiHhNAotLlgG+bAvExdX26jbYNXr
	 ncH8qkcQ2et7VSbhfPjp3Pbg6ZpvOG6OM4shnlVY4UMoIS8UoaWqhA1fXwKtX7Oh1F
	 pg6yUK3C5y6WJ2C5s5cxSMmgUljccviq7AmiEXlg=
Date: Mon, 5 May 2025 17:57:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: shuah@kernel.org, peterx@redhat.com, jackmanb@google.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-Id: <20250505175758.5d1671329270d4fea87e81d0@linux-foundation.org>
In-Reply-To: <20250504094825.491-1-ujwal.kundur@gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
	<20250504094825.491-1-ujwal.kundur@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 May 2025 15:18:25 +0530 Ujwal Kundur <ujwal.kundur@gmail.com> wrote:

> This patch refactors macros and non-composite global variable
> definitions into a struct that is defined at the start of a test and is
> passed around instead of relying on global vars.

The uffd tests have changed somewhat in the MM development tree.  Can
you please redo this again the mm-new branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm?

Thanks.


