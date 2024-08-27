Return-Path: <linux-kselftest+bounces-16406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22280960D57
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ABA2815AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243EB19E7DF;
	Tue, 27 Aug 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="n1DK9Q6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAB1DFF5;
	Tue, 27 Aug 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768145; cv=none; b=Wpi4MZFxnKvoza5zSxefFzXPznZoulflxeLsoADr0vE+VDhyHjodiJzbDbFnU6VPX+1nS8ABPluq/5mK0qKwcmwfIYObXc0MVhtmtNWsB6Yd4+MG0zsxE4ctDXZIx0B5Y17RflSqzANvjnegCJltLwpIyHYvlNEbEcG9zi5uSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768145; c=relaxed/simple;
	bh=AR8PJ+UiqD2KHGBWAy5OqFsKQ0kKsJPhPMa3BPwHMys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyoIKfl06pxKUYuw5y92zCzUPmOzDT99FEAbmhFj2nMm5scp3XoTy9575qBNdmI+X5gGy8d4/4z8s6zPsrWY2Ke0aKdelRYCapud5eBr20cgqL04cDk1XAQISVkb3ZkW5gGA2kXC2cKxaqk1q78/cyycmglD3t4ddTYk6Cu9U6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=n1DK9Q6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C702C581AB;
	Tue, 27 Aug 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="n1DK9Q6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724768141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJtKwQReDIyAbQzKAN5WLKqtgiU7ReZHpA8bCOUtZqM=;
	b=n1DK9Q6C45QX0Z4PdSNk6+sAjncf8DQBukQzt2iCkS6aG+AeJLDjEacXLNumsznmMSV/H5
	BNWYtro2G6sYMoARDrMtPqehth131s95Wexs0j6FtXZOznfhp5MCFBUH0ABYIuelqran9y
	J9U36q4btY5005ovzCCltuimSeNJAck=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a575f1cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 14:15:40 +0000 (UTC)
Date: Tue, 27 Aug 2024 16:15:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
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
Message-ID: <Zs3fhiSlXg2aCGa8@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site>
 <Zs3blfx1inX_FQLR@zx2c4.com>
 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>

On Tue, Aug 27, 2024 at 02:07:59PM +0000, LEROY Christophe wrote:
> Le 27/08/2024 à 15:58, Jason A. Donenfeld a écrit :
> > On Tue, Aug 27, 2024 at 09:20:16PM +0800, Xi Ruoyao wrote:
> >> Building test_vdso_getrandom currently leads to following issue:
> >>
> >>      In file included from /home/xry111/git-repos/linux/tools/include/linux/compiler_types.h:36,
> >>                       from /home/xry111/git-repos/linux/include/uapi/linux/stddef.h:5,
> >>                       from /home/xry111/git-repos/linux/include/uapi/linux/posix_types.h:5,
> >>                       from /usr/include/asm/sigcontext.h:12,
> >>                       from /usr/include/bits/sigcontext.h:30,
> >>                       from /usr/include/signal.h:301,
> >>                       from vdso_test_getrandom.c:14:
> >>      /home/xry111/git-repos/linux/tools/include/linux/compiler-gcc.h:3:2: error: #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
> >>          3 | #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
> >>            |  ^~~~~
> >>
> >> It's because the compiler_types.h inclusion in
> >> include/uapi/linux/stddef.h is expected to be removed by the
> >> header_install.sh script, as compiler_types.h shouldn't be used from the
> >> user space.
> >   
> > Hmm. If I run this on my current 6.10-based system, I get:
> > 
> > $ make
> >    CC       vdso_standalone_test_x86
> >    CC       vdso_test_getrandom
> > vdso_test_getrandom.c:43:41: error: field ‘params’ has incomplete type
> >     43 |         struct vgetrandom_opaque_params params;
> >        |                                         ^~~~~~
> > 
> > Because KHDR_INCLUDES is /usr/include instead.
> > 
> > Christophe, any suggestions on this one? And any idea why loongarch is
> > hitting it, but not x86 or ppc?
> > 
> 
> 
> Can you 'make clean' then provide the output of 'make V=1' ?
 
With*out* this patch, the output is:

gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../tools/include -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../include/uapi    vdso_test_getrandom.c parse_vdso.c  -o /home/zx2c4/Projects/random-linux/tools/testing/selftests/vDSO/vdso_test_getrandom

*With* this patch, the output is:

gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../tools/include -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include    vdso_test_getrandom.c parse_vdso.c  -o /home/zx2c4/Projects/random-linux/tools/testing/selftests/vDSO/vdso_test_getrandom
vdso_test_getrandom.c:43:41: error: field ‘params’ has incomplete type
   43 |         struct vgetrandom_opaque_params params;
      |                                         ^~~~~~

$ ls /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include
headers_check.pl  Makefile

Since I don't build in there, this directory is empty.

Jason

