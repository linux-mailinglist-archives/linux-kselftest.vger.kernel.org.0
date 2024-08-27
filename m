Return-Path: <linux-kselftest+bounces-16416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122E96108F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D428245D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BA1C5788;
	Tue, 27 Aug 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gNkRFx7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0D12E4D;
	Tue, 27 Aug 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771421; cv=none; b=EGPBZb6KHac/EcL/nHaFSud6+gBVCn1PJmF3TbqXosbmELmsF+AJXsfjn9IeLFQXoI2vXrtplIFlmwUoR/ZFVxkBgQtxofwyok+Wgi50IAmB0qRQRZ0BalrAdMfLN4SmnFD6uXhsDVcCbOUWwku7hoWohXNaH11aASKG3zI9Yzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771421; c=relaxed/simple;
	bh=3LdfTk2eXBo6yP81wFqOEsxHLs9nRTugq7KjVMeulg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcSRZVMxW70/Z4409GIknAs3qKP0R/flsma26nBfeqMGGrJizl2Uh+6YSHTvKuUcTwqgvDP7CnB8Lhv9s/MGVVT63wh3H1ekF6TMBuaeqbE7vsrIfu5gevY9jzItHKufN5UdIghxDETE0JW3Dgk5uuu9vKFzHxSiyQlK4WKp2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gNkRFx7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A368C4AF52;
	Tue, 27 Aug 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gNkRFx7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724771419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozr61Az0zObNdiXVnO409xiLK0YqnDxcIobLagUaHuI=;
	b=gNkRFx7TXCBIX0+B01bdm68e+z/ANi1r99z82XDxEAN2rxviqBAkBl+hJr+BIsFfsrA/mC
	vJTje96xPXs0iY5TW8zoBGaReovruL0g9BwYBDVCavUIR531T51NznXpkuQLTkEJDn9Nuo
	dyGCf7UIrCXzh+0DnNFmJq0Cr2KaXVI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 981e7471 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 15:10:18 +0000 (UTC)
Date: Tue, 27 Aug 2024 17:10:14 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
Message-ID: <Zs3sVv43djP3W2yc@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site>
 <Zs3blfx1inX_FQLR@zx2c4.com>
 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
 <Zs3fhiSlXg2aCGa8@zx2c4.com>
 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
 <Zs3qEMQOv5MAipox@zx2c4.com>
 <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>

On Tue, Aug 27, 2024 at 11:05:14PM +0800, Xi Ruoyao wrote:
> On Tue, 2024-08-27 at 17:00 +0200, Jason A. Donenfeld wrote:
> > The effect of this patch is to replace include/uapi with usr/include, so
> > it will break for you too.
> > 
> > What I'm wondering is why yours and mine work like that, while Ruoyao's
> > breaks. He makes a good argument as to why this patch is the "right
> > way", even if it breaks our workflow...
> 
> Because arch/loongarch/include/uapi/asm/sigcontext.h includes
> <linux/posix_types.h>, but the files for x86 and ppc do not.
> 
> I cannot see how this inclusion is useful anyway, so maybe I can just
> remove the inclusion and paper over the real issue for now?

The kselftest people might disagree with papering it over and may prefer
your patch, but your solution does sound better to me...

