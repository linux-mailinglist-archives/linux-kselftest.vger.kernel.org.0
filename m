Return-Path: <linux-kselftest+bounces-33349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA6ABCA2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 23:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5E31BA005B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68920F09B;
	Mon, 19 May 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBqPD5mx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778D225D6;
	Mon, 19 May 2025 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690812; cv=none; b=VTrxRrRhomfa246Wtsq95MnxaOFo4l349wq3IqAVx+iFbvwWSVP2kXi+EQ7nfao5qmBVece3rL38sh3pJlpFo4eVCF4pXuA0V/DGxfjJkkDywthgMrljZyFGTlUb9lVZTWqmogaFoL/nGMuzWN1UniCcvqfak+gUrShKIecoX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690812; c=relaxed/simple;
	bh=5Tqih6qRB9Dw8bV2Zi91XBdmS/pZ4ah1GCTxMg76G5M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BeGdlfkX0o7C9w7EoE8MJurv6g4xlJcmwaAJzD0+4vLqD9gKe4V3D289j1+QqH3OYB/ko/+2BJHOFmpQqFAZKeOJD0SfovxyYWMOt16qOrMso7y0UJRxvzXBtggsvI0iosBfh2+wnIC2Tjby9FZQZuMTLxF/JRKicLWLYdnFRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fBqPD5mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99391C4CEE4;
	Mon, 19 May 2025 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747690811;
	bh=5Tqih6qRB9Dw8bV2Zi91XBdmS/pZ4ah1GCTxMg76G5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBqPD5mxpfqPGnEesCOOJFk6lnD0kJQujF/lf9nIXGFuqALyPgNCAjaJYT3dQqne/
	 N9vqZjUwLo511/nsrZKMFgFQvqTAiASoiOdT1Pn0V+dVdHLUm8ZTPLAF9sq7MW+urZ
	 mR4lX8K/lnmwKZCE0GZZIlPJqMPW2bNafqaxHhuk=
Date: Mon, 19 May 2025 14:40:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>, peterx@redhat.com,
 shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-Id: <20250519144011.c6735e89e2ce230761bbcf9c@linux-foundation.org>
In-Reply-To: <CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
	<20250510160335.1898-1-ujwal.kundur@gmail.com>
	<D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com>
	<CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 19:20:31 +0530 Ujwal Kundur <ujwal.kundur@gmail.com> wrote:

> I'm not sure about the protocol here, should I roll a PATCH v4 or a
> new patch entirely?

Those two are the same thing.

I dropped the v3 patch, my inbox eagerly awaits v4, thanks.

