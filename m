Return-Path: <linux-kselftest+bounces-14183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E093B85A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C508DB230A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1913AD23;
	Wed, 24 Jul 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ORt1BnIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F313A25D;
	Wed, 24 Jul 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855202; cv=none; b=J/7TEgZCwfVBBjsi0l68/k45Cuw8/JGOV/tbZImuWbv2VBDiBaipD0t6NiO4aG3TpTZtOU9HuAuwrnQ5sdO9//4qW8UaYBfkyLV+s9m/e7i/poJWymauP5lg5mnNrw2gJwb2QnS3YgWfP28kKMoKDbyEakAUoa0CXsa5oLGXIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855202; c=relaxed/simple;
	bh=IdEkuDLYXvlMwP77NGfR9MdgDJozrzSaUqXB1e5Y3VU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c7tCzJMALU+8Nwld7AjO3abtRU0N7VnqYji9pSEjDKRqBGeiXunylrHqVeaL+kpJnB9hZq3W+zx1r7uFm3p38K6CKb1yADiRh0ky+0ZN5ApGOGoOwdhXweljlvBD1Cx8S6H2gZ5Um6m30wvbpauPDf0AIp4KVtDV2tslOH407rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ORt1BnIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFB9C32781;
	Wed, 24 Jul 2024 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721855202;
	bh=IdEkuDLYXvlMwP77NGfR9MdgDJozrzSaUqXB1e5Y3VU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORt1BnIHVN7EgLCoQYyckS2fpG+gGAknnsDp9PttpKCu8ZWIIoxmcErobY6xihWcI
	 HOGaWY6FgtgAM+S1QXfq92yyNaA4yeyzP2neEWNB6JhM6bMfWK+8jnJ3E9evCn1gih
	 YRwx4K4AxyKysivZ95aK9UkpqMm37SnsAMlvJh4k=
Date: Wed, 24 Jul 2024 14:06:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] selftests: mm: add s390 to ARCH check
Message-Id: <20240724140641.a3b44292494b308d3689b51d@linux-foundation.org>
In-Reply-To: <20240724200955.14882-1-npache@redhat.com>
References: <20240724200955.14882-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 14:09:55 -0600 Nico Pache <npache@redhat.com> wrote:

> When compiling with ARCH already set, the s390x ARCH is actually s390.
> Add s390 to the ARCH check list, so we can properly build selftests for
> s390.
> 

Unclear what "properly" means.  I assume it partially works?

I'm assuming that properly building selftests for s390 is desirable, so
a cc:stable is needed?  Is there a suitable Fixes:?

I'd really prefer not to assume!  A more detailed changelog which
describes the problem would be helpful, thanks.

