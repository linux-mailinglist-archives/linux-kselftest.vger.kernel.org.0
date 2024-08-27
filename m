Return-Path: <linux-kselftest+bounces-16419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D696128E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E591C20951
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2DF1C9EAF;
	Tue, 27 Aug 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hvs4EFTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F11C8FDC;
	Tue, 27 Aug 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772614; cv=none; b=gtSTHRdKjPx13c+nk6qVGIpOkeXLU3UeoDGKi6jxc5WI1HhZ1KZLuZFzXP41sa8MKV8IBPEsLnaVedbXmgFY5gFiWA8ntedtvlxLsLLfg7Pm1mb+SwfQuKRXisc2uD7KQ2K5hlY3MgV0ByqBN2ldB55/6fYwsfpo4qqu+yTsKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772614; c=relaxed/simple;
	bh=/bKNYyuSyoGc8JtlO5sHv47qRlmSRjzSYB9h5vqwzfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi6NjX4AzY0Uzfnh6bWPvkgEXcW1mnTJnaqL5F9uaDym6JIliIqL03fo3m5lHr47EbMKYumj/hLZ3JY/T0mnNVIO3YEdzyGlwB08x7clIzt/U8DNCgRXMn+Hsdv96JRvx0xwN5rKsNHxprl3bswifD7Wvs3FN3WmAXxBUpnogPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Hvs4EFTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C97C4AF64;
	Tue, 27 Aug 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hvs4EFTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724772610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bKNYyuSyoGc8JtlO5sHv47qRlmSRjzSYB9h5vqwzfk=;
	b=Hvs4EFTyJpqE5HOt8BZ9PDQuGKduNNzBi4KK1m6sOBsdibdMfLwHc65r3ALR4QCvBZcs7S
	D2wFdTbGtBYsQPJAZp4KZYNcsqlvTCKkd4fg/hqf4jOGfULcupKwxF8UGxOVkFRQMOY66M
	utPTh8gKqTSkUjjd778YFUsnHkUpTPY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0879e808 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 15:30:10 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1e4219f8so494730b6e.3;
        Tue, 27 Aug 2024 08:30:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnbNgqVDv2d04ZZO7YWe1LnKvUEAYx6talrdnGUdLsaaCSyn25Y/PQ3eXlfZlFe3g6yXHC4AX/913aFKtz4EJU@vger.kernel.org, AJvYcCXVS2NjK4VHhK0C2wHmDJsPbtgi3uUNpdqarWS2ZPmzdgTm34uon8pWRHOArAdWV9Gxl8U27Z1yTjAtRlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2rxFPDGja384PHCuaDL5SXGhnPDP9TAJGWMEM/AmKnkAKk+s
	UQZ49gObyfOd3X0ogLWohV2JRRjKUY2stjhaa28U16N7cZjxEetups09KW0UV+uJuE+5wzNK2DV
	yKxq1v9kFvEar4KgQoXDEfKoT7iA=
X-Google-Smtp-Source: AGHT+IH3h7K6Nt8QtJQZf7NmuJ279ziJulrVrqF1lhhBIx/PGo/F4yURsl6BxZSeBvp2mYhBa4SPADenk5hiGd3cu5g=
X-Received: by 2002:a05:6870:3514:b0:261:88b:36fe with SMTP id
 586e51a60fabf-273e64f5ab2mr14057921fac.15.1724772608666; Tue, 27 Aug 2024
 08:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827132018.88854-1-xry111@xry111.site> <20240827132018.88854-4-xry111@xry111.site>
 <Zs3blfx1inX_FQLR@zx2c4.com> <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
 <Zs3fhiSlXg2aCGa8@zx2c4.com> <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu> <Zs3qEMQOv5MAipox@zx2c4.com>
 <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>
 <Zs3sVv43djP3W2yc@zx2c4.com> <d1707f9c173f80588c2917f6289c1394802d6229.camel@xry111.site>
In-Reply-To: <d1707f9c173f80588c2917f6289c1394802d6229.camel@xry111.site>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 27 Aug 2024 17:29:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9rpVOy7wteac6BS9N++rsEELA98QR-LEjWLD8MjSLoJvA@mail.gmail.com>
Message-ID: <CAHmME9rpVOy7wteac6BS9N++rsEELA98QR-LEjWLD8MjSLoJvA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Jinyang He <hejinyang@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:29=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
> Or, I can add $(KHDR_INCLUDES) but also keep
> -isystem $(top_srcdir)/include/uapi, so "make -C tools/testing/selftests
> TARGETS=3DvDSO" will still (happens to) work on x86 and ppc (without
> headers in kernel-tree/usr).

Oh, the porquenolosdos solution. That sounds good to me.

Jason

