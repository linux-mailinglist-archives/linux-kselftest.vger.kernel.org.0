Return-Path: <linux-kselftest+bounces-38621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DAB1F1BC
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 02:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B785A2CAE
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F22472B4;
	Sat,  9 Aug 2025 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EOWyDjpt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA51CFBC
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Aug 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754700397; cv=none; b=XCvUuSepTk/dfV2gZMjP0OhjgfyNwwG9CvazHzYEgJchQIrgjT/CUU+kscB65GxV7J2LiaLy7T7YosKjOaX1dr7FB0YeUpVTlOE0GmZbfN3d1mMxhMR/KSfHKZ1rXDWX0GBrTeAGN2A3pZm4oOXQ0mBIDzTK6ui8YevZYk2iTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754700397; c=relaxed/simple;
	bh=/wTFlBhbCrz8/H86cMuZoDjsflrTawHAuy5CIt6OSb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hN24HPrVVgd2lIiC1BjNbBTG6u9IUzmuy+AYo1jnnbYjkkb1NOBLFVHaZL/IPTUhrwzCW77KddALTsA1DoRuAuawySLvwhX3fxsdVNp+5UZV1aouBN3/4w7b3ogAk3efuCRLZm8HU3QdRCjHK/eV6dOYaWPhAEieGgJ0tmVwf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EOWyDjpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A02C4CEF4;
	Sat,  9 Aug 2025 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754700396;
	bh=/wTFlBhbCrz8/H86cMuZoDjsflrTawHAuy5CIt6OSb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EOWyDjpt55dfKZmBaABJBoGwUfCNL5NdCri/JOvIzvZayUfGNdoUDLSdm8wh/fB1T
	 /U0TTBlYZd5Yp1FCYPY1CJsWgYAmQ3SXNjKcIPfX7Ixzzl4NNcQZQeXVWm5Ekr5HEe
	 V6dfix6UJix72n+wgL/5szlcCPstgcZvvqlS6vJA=
Date: Fri, 8 Aug 2025 17:46:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, <david@redhat.com>,
 <lorenzo.stoakes@oracle.com>, <dev.jain@arm.com>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
Message-Id: <20250808174635.0a9cd13097373faff629f927@linux-foundation.org>
In-Reply-To: <13D32FD8-FAC8-468A-9C92-23A1B61610C3@nvidia.com>
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
	<0467FDBA-A2CF-4CF0-ACCD-760ECD30BA8A@nvidia.com>
	<207BD61A-5561-4E8C-B867-D1CFCAD37509@nvidia.com>
	<13D32FD8-FAC8-468A-9C92-23A1B61610C3@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Aug 2025 12:01:47 -0400 Zi Yan <ziy@nvidia.com> wrote:

> > Wait. It seems that mm-new is different from Linus' tree[1]. I wonder
> > what is going on.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/mm/split_huge_page_test.c?h=v6.16#n109
> 
> Wei, it seems that you lost the race to Muhammad Usama Anjum's cleanup patch[1].
> You might need to add nr_hpages back.
> 
> [1] https://lore.kernel.org/all/20250731160132.1795351-6-usama.anjum@collabora.com/T/#u
> 

Ah, thanks, I'll drop this version of "selftests/mm: do
check_huge_anon() with a number been passed in".

