Return-Path: <linux-kselftest+bounces-48173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647FCF2407
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 08:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD7F3015141
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483572D77EA;
	Mon,  5 Jan 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="SBMGwO0p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AF2D24B7;
	Mon,  5 Jan 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599097; cv=none; b=YxaxQVxyq2eXYyZMFbspEvC9hRCR1eOTZGhWoWrSLgmSfOTzdEjFUmV/SpBdyvXCwuUAq7pb9xnVMatAVRHlNbyGndV+ahWSnzHXw0wzsSqhT/nM/Fa10D12LhP6CVNJ+88WX47YrS/K+U+/+n0Oz4SQR1+cvk8BMi8N90AtCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599097; c=relaxed/simple;
	bh=Zr2aBtsyUcA7rmHP55HTRA28GFSHEepQ3UGXI7OYnUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks7JYJw9TxmIot5EzkwSutIQQY+/jS2JhxM1gk2FVaH+qMaTi5fPsx1M8zQmwGS92FYrVI8NTF0n4ySTo9ob1YWp9wasQi3i1TWnQiXx+XjyOPu8RZdVwWBweXDx5tbbc4F4bKKKS5P493ln98BokFnXnyO0S9EsWXd8do5laDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=SBMGwO0p; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1767599091; bh=Zr2aBtsyUcA7rmHP55HTRA28GFSHEepQ3UGXI7OYnUM=;
	h=From:Message-ID:From;
	b=SBMGwO0p7DnRwaxOMTBHFlVRxxrkHIhqk0ClxkzHduCdCMFL9LUbZbmLDuOOigswB
	 aNFSdF4FVm+GZ127PJ5quwtidmVqkP9Z2bN82yP/NpEhlrdsu1SE5VpwR3yjhw0lnl
	 RR0Xg+GSUNmFInLPm7tNC09WEnqSotoaT7/OjGbc=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 53EC6C0943;
	Mon, 05 Jan 2026 08:44:51 +0100 (CET)
Date: Mon, 5 Jan 2026 08:44:50 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
Message-ID: <aVtr8vJd_683mqUO@1wt.eu>
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>

Hi Thomas,

On Sun, Jan 04, 2026 at 11:14:13PM +0100, Thomas Weißschuh wrote:
> Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=v9 for
> 32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=v9 for 32-bit
> SPARC builds. -mcpu=v9 generates instructions which are not recognized
> by qemu-sparc and qemu-system-sparc. Instead qemu-sparc32plus and
> qemu-system-sparc64 with a 64-bit kernel and CONFIG_COMPAT are needed.
>
> Rework the test setup so that -mcpu=v9 also works correctly.

Hmmm doesn't this mean that we're now unable to emit proper sparc32
instructions with this compiler ? I don't know which CPUs the kernel
still supports, but if it still supports these old SS-5, maybe we
should instead pass the correct -mcpu to clang so that it emits the
expected instructions, otherwise we're just hiding the regressing by
upgrading the test machine beyond what the kernel supports ? Of course
if they're no longer supported that's different, but I'm still seeing
traces of SparcStation5 in the code so I don't know what to think about
this.

Thanks,
Willy

