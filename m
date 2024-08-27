Return-Path: <linux-kselftest+bounces-16414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FEC960FAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23692B24D07
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407E1C57AB;
	Tue, 27 Aug 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FVSK+On5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7882FB2;
	Tue, 27 Aug 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770843; cv=none; b=iHDa+lDAwqDvVY2UY866q525jQxn4o4Olt96tbTT2VTxXBMK0b5QnrFUgn8utFkCtradTX0rFvZhGeel7p4kx5vOp/ldsRPNcxkoaHKfToMNOqRPvVNC/xOB5sUk57E3cwcKOV8jwGIKaT8UaI1jreM1GStaiIEfEu2S5kM03SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770843; c=relaxed/simple;
	bh=Tmg80kMTBFUUT+iDbGdYLeFocZVX442hzN8UVSBRyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joepv71+9Y55Q16tg05rwOF1y/2SYKr3MV5TKqN1Ac9x6YO1C/at5Zrqpq/qrDLR4VWpPaNfCdss8bj13lSSMlND7h2uvwKaY62YTS0TmEcFxEfFYVF2QUy/yK7NTBxhnKLZg3VobK0YVDNer9pZnr8LGEljBXC2V6klOghmT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=FVSK+On5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D8C4DDE8;
	Tue, 27 Aug 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FVSK+On5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724770839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXYnkcrSaMC6IPJBLXl7iO1BsSgLf6mc/vnU/2p22DY=;
	b=FVSK+On5m+VqmEPi37+KJnpvs5DtDkzqalrhLeQC8u5dOwrn/KYfcu+WVQAc/pomCG4hlO
	5eP67RG/BuEcUedBhgNPyX1eAXrqVrYWaA3hZuBXiOTXxewK+Z3Vc42nVRjEU7VO+fBJym
	h3aNz19JeJsQ8foZfkV9C5Hqy0aW4cQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9be28a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 15:00:39 +0000 (UTC)
Date: Tue, 27 Aug 2024 17:00:32 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
Message-ID: <Zs3qEMQOv5MAipox@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site>
 <Zs3blfx1inX_FQLR@zx2c4.com>
 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
 <Zs3fhiSlXg2aCGa8@zx2c4.com>
 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>

On Tue, Aug 27, 2024 at 04:50:59PM +0200, Christophe Leroy wrote:
> 
> 
> Le 27/08/2024 à 16:41, Xi Ruoyao a écrit :
> > On Tue, 2024-08-27 at 16:15 +0200, Jason A. Donenfeld wrote:
> > 
> > /* snip */
> > 
> >> gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../tools/include -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include    vdso_test_getrandom.c parse_vdso.c  -o /home/zx2c4/Projects/random-linux/tools/testing/selftests/vDSO/vdso_test_getrandom
> >> vdso_test_getrandom.c:43:41: error: field ‘params’ has incomplete type
> >>     43 |         struct vgetrandom_opaque_params params;
> >>        |                                         ^~~~~~
> >>
> >> $ ls /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include
> >> headers_check.pl  Makefile
> >>
> >> Since I don't build in there, this directory is empty.
> > 
> > In the toplevel Makefile:
> > 
> > kselftest-%: headers FORCE
> >      $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> > 
> > So running "make kselftest-all" to build the self tests should have
> > already caused make to build the "headers" target, which puts the
> > headers into usr/include.
> > 
> > I don't think it's supported to build self tests w/o invoking the
> > toplevel Makefile: many other self tests use KHDR_INCLUDES as well, so
> > generally building with something like "make -C tools/testing/selftests"
> > just won't work.
> > 
> 
> My usr/include/ is also empty (only Makefile and headers_check.pl) and 
> building directly in tools/testing/selftests/vDSO works for me.
> 
> The command is:
> 
> ppc-linux-gcc -std=gnu99 -D_GNU_SOURCE= -isystem 
> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include 
> -isystem 
> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi 
>     vdso_test_getrandom.c parse_vdso.c  -o 
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getrandom
> 
> I believe I get the needed headers through : -isystem 
> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi

The effect of this patch is to replace include/uapi with usr/include, so
it will break for you too.

What I'm wondering is why yours and mine work like that, while Ruoyao's
breaks. He makes a good argument as to why this patch is the "right
way", even if it breaks our workflow...

> 
> Christophe
> 
> PS: By the way, did you see the -DBULID_VDSO for the chacha test ? Don't 
> know the impact though ....

Yes and https://lore.kernel.org/all/20240827145454.3317093-1-Jason@zx2c4.com/

