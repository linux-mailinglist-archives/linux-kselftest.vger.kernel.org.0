Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B593763819
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjGZNw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 09:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjGZNwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 09:52:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB926AC
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 06:52:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e6541c98so6298821b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690379540; x=1690984340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ey/D5M5CPmKQzId6+XsuiPGSyzaXamRUEWGT1BcC7g8=;
        b=oljGFhSavZjxkXX9CucTy5gLK6qGX0I821ndm/pPrymKSKvJ3P/6/lBeLNfqGQ4Prz
         yG8vGsi8TbRKYjWbNGsB7yiDHaa22xpMOxU5nHjrXLOpOpFIaRgQgmi30rvNMGGaQlnA
         aPogyoGDwEByaH6x2bu+i8DUJ8aQuv5RYESZZc2lxWmys95qEqie9+VLr28t9jXKQoGb
         ACUOHsx+Kh0P0USxXLLtGjTtYmJCoHLrvO3TngfJVNsHF6lP/Mjr03UuslceDWRR7aFU
         P220Nkr1pYqcfa9oPNp6sOExUOn8A0YJcEA5TAhibvstRj/Q8VU7/V3AREKD6GV4ila3
         mM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379540; x=1690984340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey/D5M5CPmKQzId6+XsuiPGSyzaXamRUEWGT1BcC7g8=;
        b=Nt0IdN79OyiGyi0vsWuLxGq3k4Q/sAw0cc8Z77/2/yrMrV92g/dPqGbbDk75esasgd
         UOWvwCZZuDUjqkA976TO3P82bXAHrU6aLjTMCkq3RxGS7gu0aCprcJC5qH0OXsC67QeV
         6jaE5W6KPSiRPmodZ0C6qfDTs1jHWhAa1ZbgOlOQzviqTmUYeydJDeyAz1GBjnl6A2VU
         oRU7JvN10CP9UlKDQRWjicAUHMUmqWdzM8F7HBEZDQsCOJ3ZfFDzakTG1dRYZWi7bKmv
         2sfAMZNc1yCYLbR2tuZkEfNmxIbiw3aBMWryA1GQw2aOVanpmZNJYIApWtX1VbBrsYN4
         BvvQ==
X-Gm-Message-State: ABy/qLa2inH+SCEryz/kXiiQsbN+te/ReCNGqKSavvrXREvcaoI3dZ7s
        hw3s+1f1KffOJHXza3/sm469qQ==
X-Google-Smtp-Source: APBJJlGGggspPA6ImxibgpDOjxq8NwN3+9CEYkMOcJSUt5QiwCOV4FVffsYERBKNj9SOSpMuSGApCw==
X-Received: by 2002:a05:6a00:234c:b0:686:c7be:5259 with SMTP id j12-20020a056a00234c00b00686c7be5259mr2598630pfj.32.1690379540161;
        Wed, 26 Jul 2023 06:52:20 -0700 (PDT)
Received: from ghost ([2601:c0:ca7f:e7c0:14ff:979a:dd27:29d7])
        by smtp.gmail.com with ESMTPSA id d134-20020a63368c000000b0055be951145csm12722952pga.36.2023.07.26.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:52:19 -0700 (PDT)
Date:   Wed, 26 Jul 2023 09:52:15 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Subject: Re: [PATCH v6 4/4] RISC-V: mm: Document mmap changes
Message-ID: <ZMElD/V0G715rf/S@ghost>
References: <20230714165508.94561-1-charlie@rivosinc.com>
 <20230714165508.94561-5-charlie@rivosinc.com>
 <CAHVXubgSLhsMdS3aFbSuPNf2d_FXhztnFtRnbjsMstH5coCHWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubgSLhsMdS3aFbSuPNf2d_FXhztnFtRnbjsMstH5coCHWA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 08:59:12AM +0200, Alexandre Ghiti wrote:
> On Fri, Jul 14, 2023 at 6:56 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > The behavior of mmap is modified with this patch series, so explain the
> > changes to the mmap hint address behavior.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> > index 5462c84f4723..892412b91300 100644
> > --- a/Documentation/riscv/vm-layout.rst
> > +++ b/Documentation/riscv/vm-layout.rst
> > @@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
> >     ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
> >     ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
> >    __________________|____________|__________________|_________|____________________________________________________________
> > +
> > +
> > +Userspace VAs
> > +--------------------
> > +To maintain compatibility with software that relies on the VA space with a
> > +maximum of 48 bits the kernel will, by default, return virtual addresses to
> > +userspace from a 48-bit range (sv48). This default behavior is achieved by
> > +passing 0 into the hint address parameter of mmap. On CPUs with an address space
> > +smaller than sv48, the CPU maximum supported address space will be the default.
> > +
> > +Software can "opt-in" to receiving VAs from another VA space by providing
> > +a hint address to mmap. A call to mmap is guaranteed to return an address
> > +that will not override the unset left-aligned bits in the hint address,
> > +unless there is no space left in the address space. If there is no space
> > +available in the requested address space, an address in the next smallest
> > +available address space will be returned.
> > +
> > +For example, in order to obtain 48-bit VA space, a hint address greater than
> > +:code:`1 << 38` must be provided.
> 
> Is this correct? Shouldn't the hint be strictly greater than the
> address space it targets? In patch 1, you state that "A hint address
> passed to mmap will cause the largest address space that fits entirely
> into the hint to be used", it seems contradictory to me.
> 
That is a mistake, it should have a hint address greater than 1 << 47. I
will fix up the wording here.
> > Note that this is 38 due to sv39 userspace
> > +ending at :code:`1 << 38` and the addresses beyond this are reserved for the
> > +kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
> > +than or equal to :code:`1 << 47` must be provided.
> > --
> > 2.41.0
> >
