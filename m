Return-Path: <linux-kselftest+bounces-24444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E25A10700
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 13:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FC13A3970
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A331C5F22;
	Tue, 14 Jan 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pX1Gf6ls"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D23236A91
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858577; cv=none; b=GxchOWiIoUVpEaZKnmsMuNi8cwnDToiKntSelyz5gsFD3o0IVSIz9MsAmqvJc9UqxknqnR61JfyXKeLNbbQm+QVtHkdMxHCE3NnA51tUoDMNhIhnK3fL8QZbupukROglpIH+pNzCXJfdKULcxEKghBfRuPiaS2jd93lFTEWOEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858577; c=relaxed/simple;
	bh=g6ds6X1npbWjUxsB+xGoK9OtDHG1EXdUEvY+n2sqM6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiPzjvLNMxVK8Q5q9fx93ZyYjkkGXbhocc7DGxHFl4cy19Ong86Nx3zotcnrmAJZW8dTBphuCbS7aScTyIbghkf21LLJ81VIlmfX1/dp/U5fKn0Xsr8I5eYbE4McTjZ7udplRKZTGrgc6KRuvROsYomK08oxzSht17FcQgpN2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pX1Gf6ls; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeec07b705so862093466b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736858573; x=1737463373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rnsF0zy3GsMYA4HPmzwMOUoBG6xfZOolcTLSwhE6xZE=;
        b=pX1Gf6lsPuqjIlSgMLKLaYg3TL/ynvW00d36lEvS9CISu0A7kPbcZwxePuTGXQV1xu
         6N/DtgzclNpfVDEEfS9G7Sa4ylMBasKphQtx9KNFATY8qG/81iidUAY63zpQtDicJnZJ
         30n0b4G1yex4sEe8MWIIjhTZZJ6OX7op/483YyU6f9Aj++eS2YSR2R83UdCplGsLayRW
         DasRpKWjVQZSQpSlUjr7YRUoT2gy17LkRmkoUpiPGptULKVkduw08+EKR46XE/ACh/ox
         L7D4iUjT1HLhLe3r7RrDaW/rKjHcBIIzz9tD+EnckcuPCBTCeCmAcgvHiG/FIbI6MO52
         a+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736858573; x=1737463373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnsF0zy3GsMYA4HPmzwMOUoBG6xfZOolcTLSwhE6xZE=;
        b=Wdze4Q//d4YP9WRl3g0oOpAjqz9JrQExUDGc8OpkB0MY+D2pv69VuxWJeQAiFtgx63
         qnO1HbGSz2p+jidcOvbRPwyUoo5pKtVYzPbTr4QdDKNZmUkr16nFs8lcAcMUk8jDB4mQ
         pSZ7F5Z8JQY9EEnBDgB9pLRpkuD69xCEgEgZLtk9rRfV7Ycw0NDTmGBFmVsXxOM3vgbE
         CCut8yjr7KSUPqZVKJymXZWOTf2HubcQsyZ5kJrFAHymHRe8ja5q/F7NvXS1MEl5OqgQ
         6l2LQteydpZy6v7/bkJEzETxc6NVxU6n3feQmwBCR5zhmJ7M0CYLgvBXT71JgVb3+YFC
         dbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqGI5vRYPB/+juT/EWex27HoIkizPGxtwJpzbHwXqXPiAmknHOTKQ8CjRK1EUe7c1HRCZuV7+ZrUkLurICex0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3Nm+TcV/yRqNRD79T0+W++31IhGvSQ2yulLynw3g47WYocIG
	jDdlyKtCo8EEGtq4t27rPradDbMN2j+tNZnOmXfDREmYHaNG+DOuLlILPx9ji3s=
X-Gm-Gg: ASbGncs03fxFk3KtafViQmfZ6+adqpf9ODE7Fu+6meh8hYQSIUzm095bqpmH49P3RhD
	MrzcDZCLQKHrJ/FEvAaGhKOw7ehCxUVKQ5eNCHOOxZPcGHb4vromDLClMfYISeQef+E1NgGZFfS
	OLwDIhLE7kOVGtxQ/AyjyGDoXP+zbCHY0P+p+PmWjqEZy7ogRr5pKtft/xLx6ITW2kMlDVbqzlB
	jXcjlKI1OBN8K0jrHAoi8UHr6yiNqedTGIlIuslpdAiNInfQlSkYePIoQQoeUdJ2nba3WO2DVP1
	v/o70ZP+sS+SOgkN4+H4+GZmwN2HwdtRb7Pv0DpI2w==
X-Google-Smtp-Source: AGHT+IGa+w+7nxPE26Y4gseiHljadCRzoNaxIWh+TeYU2ACFrAbllLGBqDkEYDrnuQQTlrSybqPOXA==
X-Received: by 2002:a17:907:c588:b0:ab2:c208:732d with SMTP id a640c23a62f3a-ab2c2087cbbmr2016364966b.40.1736858572698;
        Tue, 14 Jan 2025 04:42:52 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c2d58sm6155924a12.39.2025.01.14.04.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 04:42:52 -0800 (PST)
Date: Tue, 14 Jan 2025 13:42:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, alexghiti@rivosinc.com, 
	andybnac@gmail.com, aou@eecs.berkeley.edu, charlie@rivosinc.com, cleger@rivosinc.com, 
	conor.dooley@microchip.com, conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, 
	jesse@rivosinc.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, shuah@kernel.org
Subject: Re: [External] Re: [PATCH v4 2/3] RISC-V: hwprobe: Expose Zicbom
 extension and its block size
Message-ID: <20250114-6f373c6dd685cf322c89e7d5@orel>
References: <20250114021936.17234-1-cuiyunhui@bytedance.com>
 <20250114021936.17234-3-cuiyunhui@bytedance.com>
 <7c181d03-b0d0-4b81-bbd0-06943a58a287@sifive.com>
 <CAEEQ3wm7-O5U3jjbQ1+XgVvk+G7csMPAxzGoV=K5WczCOsbQ5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wm7-O5U3jjbQ1+XgVvk+G7csMPAxzGoV=K5WczCOsbQ5g@mail.gmail.com>

On Tue, Jan 14, 2025 at 08:17:02PM +0800, yunhui cui wrote:
> Hi Samuel，
> 
> On Tue, Jan 14, 2025 at 1:28 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
> >
> > Hi Yunhui,
> >
> > On 2025-01-13 8:19 PM, Yunhui Cui wrote:
> > > Expose Zicbom through hwprobe and also provide a key to extract its
> > > respective block size.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
> > >  arch/riscv/include/asm/hwprobe.h      | 2 +-
> > >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
> > >  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
> > >  4 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > > index 955fbcd19ce9..0ea7754b2049 100644
> > > --- a/Documentation/arch/riscv/hwprobe.rst
> > > +++ b/Documentation/arch/riscv/hwprobe.rst
> > > @@ -242,6 +242,9 @@ The following keys are defined:
> > >    * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
> > >         defined in version 1.0 of the RISC-V Pointer Masking extensions.
> > >
> > > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
> > > +       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> > > +
> > >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
> > >       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
> > >       mistakenly classified as a bitmask rather than a value.
> > > @@ -281,6 +284,9 @@ The following keys are defined:
> > >  * :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF`: An enum value describing the
> > >       performance of misaligned vector accesses on the selected set of processors.
> > >
> > > +* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
> > > +  represents the size of the Zicbom block in bytes.
> > > +
> > >    * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN`: The performance of misaligned
> > >      vector accesses is unknown.
> >
> > The new key needs to go further down, below this list of possible values for the
> > previous key.
> I guess you mean to put it after
> RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED, right?

Yes, notice how all the RISCV_HWPROBE_MISALIGNED_VECTOR_* defines are
indented under RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF indicating
they're part of the RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF group.

Thanks,
drew

> 
> >
> > Regards,
> > Samuel
> >
> > >
> > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > > index 1ce1df6d0ff3..89379f9a2e6e 100644
> > > --- a/arch/riscv/include/asm/hwprobe.h
> > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > @@ -8,7 +8,7 @@
> > >
> > >  #include <uapi/asm/hwprobe.h>
> > >
> > > -#define RISCV_HWPROBE_MAX_KEY 10
> > > +#define RISCV_HWPROBE_MAX_KEY 11
> > >
> > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > >  {
> > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > > index 3af142b99f77..b15c0bd83ef2 100644
> > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > @@ -73,6 +73,7 @@ struct riscv_hwprobe {
> > >  #define              RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
> > >  #define              RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
> > >  #define              RISCV_HWPROBE_EXT_SUPM          (1ULL << 49)
> > > +#define              RISCV_HWPROBE_EXT_ZICBOM        (1ULL << 50)
> > >  #define RISCV_HWPROBE_KEY_CPUPERF_0  5
> > >  #define              RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
> > >  #define              RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
> > > @@ -94,6 +95,7 @@ struct riscv_hwprobe {
> > >  #define              RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW            2
> > >  #define              RISCV_HWPROBE_MISALIGNED_VECTOR_FAST            3
> > >  #define              RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED     4
> > > +#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE  11
> > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > >
> > >  /* Flags */
> > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > index cb93adfffc48..04150e62f998 100644
> > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > @@ -106,6 +106,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> > >               EXT_KEY(ZCA);
> > >               EXT_KEY(ZCB);
> > >               EXT_KEY(ZCMOP);
> > > +             EXT_KEY(ZICBOM);
> > >               EXT_KEY(ZICBOZ);
> > >               EXT_KEY(ZICOND);
> > >               EXT_KEY(ZIHINTNTL);
> > > @@ -278,6 +279,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > >               if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > >                       pair->value = riscv_cboz_block_size;
> > >               break;
> > > +     case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
> > > +             pair->value = 0;
> > > +             if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
> > > +                     pair->value = riscv_cbom_block_size;
> > > +             break;
> > >       case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
> > >               pair->value = user_max_virt_addr();
> > >               break;
> >
> 
> Thanks,
> Yunhui

