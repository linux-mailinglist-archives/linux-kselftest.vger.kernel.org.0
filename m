Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C91765E34
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 23:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjG0V3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 17:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjG0V3s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 17:29:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD973588
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:29:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e97fcc60so1131459b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690493360; x=1691098160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypAMONzQ9lM309vcGdh+Fb16cWv7RYOttEkuLSf+C9Q=;
        b=Bwo2x8zf58r3/17nU/dEA+lgi98417VBN10q9GpXZ2yX5bWgvClfFlRZrYgWh6vxOe
         r0mqw4aODhaJ2EjfLMEWChHMJo67QiYL7UuI76V0B5V0sBJqx633/8IdKvZ62MQ2+DUl
         J6GIo9C/bwVjsIs63nkDd9w15op+eE3bPam4/TK3NShywE+8Xx/75LaHkeodFIhEIwPp
         is5HGGIxHwP3BUX1Gg8ys2pqCCyqagzNp8TAZ2n3ah5xe/s8AuEUZyERBtbzxBBvh8e7
         XW1EoV/f/B6VtHMfKKSgdzL/ZzdtxWPLIZShgMFFsPR1z034QbJg23p3Jo+apDeFjXi3
         3MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493360; x=1691098160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypAMONzQ9lM309vcGdh+Fb16cWv7RYOttEkuLSf+C9Q=;
        b=LaGnCQzFGcJAT8H2+6nQZLYCWLnl5AEcLtdPb+IvXgo5kTSaeNfS+qBUuHmB89nL+r
         P+W45IHT7Ad5oKx4LwilCKezPi8zenZHofhuBUfOURS8b713eju0lh5GGDUnhUQV6o2P
         lpRmRlntIjkjn2jDCsmJXAOwcLZ+QLcJC2oAQbf3d/y+NBnZxpgHrOVpHNyJGhyGPz4I
         yj4mKj/5RzD3GlM09iPgmIyn45fS8QWFX0fLSrUsVxVt6om1Z99CIDGgI0xTMIbBKyY+
         z13WpmJoyvpPUIW0Gw8Rm0oPyQwGXuld2+9s8bca2aqrYJokaVHf+nBc/ssDuoD/j34w
         JxRw==
X-Gm-Message-State: ABy/qLbYT3NrfwpgLTUcPyG54d91KM72CRXQQMi3yNrTegZtNJeB9JhY
        sFtNUy0z1Iyfe117c3ZkiD12O5bHt0RQKpJH898=
X-Google-Smtp-Source: APBJJlGB3S/nfKRJRrxAvCsM8dZOvIKZplWkk6B2QF6oZQ+44PkE/bkn/usw/Q968tVlGDZwNJliog==
X-Received: by 2002:a05:6a20:7351:b0:133:656e:fe1e with SMTP id v17-20020a056a20735100b00133656efe1emr268970pzc.47.1690493360245;
        Thu, 27 Jul 2023 14:29:20 -0700 (PDT)
Received: from ghost ([2601:c0:ca7f:e7c0:e300:c3dd:e089:386])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7870e000000b00686c77a2905sm1906083pfo.20.2023.07.27.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:29:20 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:29:16 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v7 1/4] RISC-V: mm: Restrict address space for
 sv39,sv48,sv57
Message-ID: <ZMLhrFfoerPIxRL7@ghost>
References: <20230726164620.717288-1-charlie@rivosinc.com>
 <20230726164620.717288-2-charlie@rivosinc.com>
 <20230727-unruffled-joyride-410fc348ce7b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-unruffled-joyride-410fc348ce7b@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 01:33:41PM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> On Wed, Jul 26, 2023 at 09:45:55AM -0700, Charlie Jenkins wrote:
> > Make sv48 the default address space for mmap as some applications
> > currently depend on this assumption. A hint address passed to mmap will
> > cause the largest address space that fits entirely into the hint to be
> > used. If the hint is less than or equal to 1<<38, an sv39 address will
> > be used. An exception is that if the hint address is 0, then a sv48
> > address will be used. After an address space is completely full, the next
> > smallest address space will be used.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/elf.h       |  2 +-
> >  arch/riscv/include/asm/pgtable.h   | 13 ++++++++-
> >  arch/riscv/include/asm/processor.h | 47 +++++++++++++++++++++++++-----
> >  3 files changed, 53 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> > index c24280774caf..5d3368d5585c 100644
> > --- a/arch/riscv/include/asm/elf.h
> > +++ b/arch/riscv/include/asm/elf.h
> > @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
> >   * the loader.  We need to make sure that it is out of the way of the program
> >   * that it will "exec", and that there is sufficient room for the brk.
> >   */
> > -#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
> > +#define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
> >  
> >  #ifdef CONFIG_64BIT
> >  #ifdef CONFIG_COMPAT
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 75970ee2bda2..530f6a171a2b 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -63,12 +63,23 @@
> >   * position vmemmap directly below the VMALLOC region.
> >   */
> >  #ifdef CONFIG_64BIT
> > +#define VA_BITS_SV39 39
> > +#define VA_BITS_SV48 48
> > +#define VA_BITS_SV57 57
> > +
> > +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
> > +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> > +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> > +
> >  #define VA_BITS		(pgtable_l5_enabled ? \
> > -				57 : (pgtable_l4_enabled ? 48 : 39))
> > +				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
> >  #else
> >  #define VA_BITS		32
> >  #endif
> 
> Please, at the very least, build test things for rv32 if you are going
> to change things in mm:
> io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_SV39'
> io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_SV39'
> io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_SV39'
> io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_SV39'
> io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_SV39'
> io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
> mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
> 
> Thanks,
> Conor.
Thanks for that catch, I sent out a new patch to fix that up. There were
also some problems with 32-bit compat support that I resolved.

