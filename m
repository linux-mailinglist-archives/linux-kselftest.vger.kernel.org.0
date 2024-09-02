Return-Path: <linux-kselftest+bounces-16972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D99687C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4605B282DE5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00E187355;
	Mon,  2 Sep 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iEDaMUUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD019E998;
	Mon,  2 Sep 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281043; cv=none; b=YA+VF/2HJKC3lk6kHKs76e12yzy79j8O2zUSsE6uWc1fDAt3SrEvCjtgJnztwpTFtreYYpYCL0MzX/M6TFG9sMhYCJoAtwNGruhsseOoy1DWOf0q4uAt5w9JqPHWSf0poTp4f+VOpYLG6npd54OhS8X51+DHJqyKVfgM8uWKvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281043; c=relaxed/simple;
	bh=Z/MqSDwibNNOwSmy9SNlgAXImBvag7svcBS3F7xHE8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2C30C23D9g7NCbVpmHLfHQRSDL4NWJAj7s2cnLbYU3WKMh/9A+54Rg4J4qbXEMg+soo2R9O/kLNW35aMWLdKRoSOumQCPYmZqQBVtE5xQOraY7HVF5f08amy0Yth0YJzIrwNV7mN7ai1L2TjYKtRjenDjKz/NwQ8YCQqFlTx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=iEDaMUUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA3C4CEC6;
	Mon,  2 Sep 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iEDaMUUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725281040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aV4K9444XI0Q3K5olKe1hWC2BF0Ubr/a28h7+2Pj1I=;
	b=iEDaMUUpcIwjZJ4xz0xNXnWXSbGHaVssQO9Y7Gz2pHueO7YaTkcvypWkr49zNHwJzVLq9q
	/CZ0p4KRNl3zHuvQhxEMYK8lu9MXzbxWhapGB4vyb2S43n4x4+dlAYDxAT86WG0gMkgaLj
	X6br+kRpOv/Bd1ZUfjfYttuXV5lNL4o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 91b03f06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 12:44:00 +0000 (UTC)
Date: Mon, 2 Sep 2024 14:43:57 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>,
	"broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ZtWzDZbJDrViFqke@zx2c4.com>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>
 <ZtSsTkTUCGyxaN_d@zx2c4.com>
 <efca582d-20e9-4871-bcd8-5abcdb0c22f3@csgroup.eu>
 <ZtUS3TecFTjE5A94@zx2c4.com>
 <74494efd-7cfc-4535-a33d-b86fbae1c322@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74494efd-7cfc-4535-a33d-b86fbae1c322@cs-soprasteria.com>

On Mon, Sep 02, 2024 at 12:39:17PM +0000, LEROY Christophe wrote:
> 
> 
> Le 02/09/2024 à 03:20, Jason A. Donenfeld a écrit :
> > On Sun, Sep 01, 2024 at 08:43:10PM +0200, Christophe Leroy wrote:
> >>>> How would this fit in the logic where IIUC you just remove '_64' from
> >>>> 'x86_64' to get 'x86'
> >>>
> >>> Huh? That's not what tools/scripts/Makefile.arch does.
> >>
> >> Hum ... yes sorry I looked at it too quickly and mixed things up with
> >> the other patch.
> >>
> >> Nevertheless, if I understand well what tools/scripts/Makefile.arch does
> >> on an x86_64 for instance:
> >>
> >> uname -m returns x86_64
> >> HOSTARCH = x86 (sed -e s/x86_64/x86)
> >> ARCH = x86
> >> SRCARCH = x86
> >>
> >> If you build with make ARCH=x86_64,
> >> SRCARCH = x86
> >>
> >> So I still can't see how you can use that to know if it is a x86_64 or not.
> > 
> > By the use of CONFIG_X86_32, which is also used elsewhere in that
> > samme makefile for something else (so I assume it's wired up in the
> > context where it counts, and if not, that's a bug that affects both
> > spots and should be fixed)..
> 
> I looks like it is a left-over from the time vDSO selftests were in 
> Documentation/vDSO and were likely built with kernel config.
> 
> CONFIG_X86_32 was brought into tools/testing/selftests/vDSO by commit 
> f9b6b0ef6034 ("selftests: move vDSO tests from Documentation/vDSO") and 
> was meant to pass -lgcc_s when building vdso_standalone_test_x86 for 
> i386, but obviously it doesn't work:
> 
> $ make ARCH=i386 V=1
> gcc -std=gnu99 -O2 -D_GNU_SOURCE=    vdso_test_gettimeofday.c 
> parse_vdso.c  -o 
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
> gcc -std=gnu99 -O2 -D_GNU_SOURCE=    vdso_test_getcpu.c parse_vdso.c  -o 
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getcpu
> gcc -std=gnu99 -O2 -D_GNU_SOURCE=    vdso_test_abi.c parse_vdso.c  -o 
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_abi
> gcc -std=gnu99 -O2 -D_GNU_SOURCE=    vdso_test_clock_getres.c  -o 
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_clock_getres
> gcc -std=gnu99 -O2 -D_GNU_SOURCE=  -ldl  vdso_test_correctness.c  -o 
> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_correctness
> 
> In another place in selftests (tools/testing/selftests/ipc/), they 
> manually add it:
> 
> ifeq ($(ARCH),i386)
>          ARCH := x86
> 	CFLAGS := -DCONFIG_X86_32 -D__i386__
> endif
> ifeq ($(ARCH),x86_64)
> 	ARCH := x86
> 	CFLAGS := -DCONFIG_X86_64 -D__x86_64__
> endif
> 
> 
> So I think this is a confirmation that CONFIG_X86_32 doesn't exist in 
> selftests.

Interesting... Seems like both sites, then, should be fixed somehow...

