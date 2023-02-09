Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D7691092
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 19:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBISpQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 13:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBISpO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 13:45:14 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE45AB07
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 10:45:13 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a9so3129337ljr.13
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9Vua8LHA9JDjb46CzlFrnWZQdagkljpU9vsHTc0DF8=;
        b=4Asl2/b/Hg5mXqTofzECxhuPfV/1ELQIDimYZFo5ccuAteJziSJW3pYDXsJDmq7Y+p
         lpDDHNBVBIsZjuYrhT/8CO7je+D0yRIjnKBMx7GuQ3Iwx4I+G+nLehVUbH0TEajH6s3U
         IGsZgyI4UYvCbVRF6nLgaIyeCV3hvJ8a2V3A2Vjy++cLtMJNGrdeWeSVfxiocHfTBnmv
         cOjTcm/RJ8fTXs6aU7mjTOA1KODjFpjh2yfJC5p0X/XOKH0yKrgYtdSeuIdVkI7TSyDb
         19CjtZZWizsZnlrnI2iIceIRDLtgL1q5rBjOWBiImMnlyVTMwktoAUn5RJDzF2BRDSRK
         /9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9Vua8LHA9JDjb46CzlFrnWZQdagkljpU9vsHTc0DF8=;
        b=lWzSqLjwcWriFgYpEeFa6kiy2FLKbEw1oKWOAZyfJgvpJnLVXYXFMhUho2BCyE2MZa
         TamIl8nPhKBk4c3obByWmcWGJoALraYIPFW6XoLhPMoClvxnjmJ1Iwh59BXxGSdqeiim
         6EeQO16auALFf6RlZKwy2I/TEwRCftf8d1az4k9M2edI818Ketf+e73lKPJ8DFDuQ/4k
         15LV7IWRBk1NgpZf8zKxHG7murAbSd6/jClSry9sxWeL91mcULYYOYAnLV+JQxhz+ga7
         IlSqFtsJV5Xs26nejyaCuHaHF8IPto8ucQHZ9fP1xFxmADm3+wZnVV6JfE9T41tOwNon
         zf5w==
X-Gm-Message-State: AO0yUKXYo8Q76NPpVJA9cbFfKuvu9b2jLhm7TXsginKhZjiTJ5gQRjfS
        4zzcCTZf2bpwYsg9g8bai117HuUr5pleddoNu7TxEw==
X-Google-Smtp-Source: AK7set9BEO75w+/zGEdYth0f1dUrFoFb09CZjL4/pITzFZUZHnpCtKSQrnmioh62h4aT4HugkczFG9LjIBQvWztIKT8=
X-Received: by 2002:a2e:6f14:0:b0:293:125c:284f with SMTP id
 k20-20020a2e6f14000000b00293125c284fmr2100576ljc.148.1675968312327; Thu, 09
 Feb 2023 10:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-7-evan@rivosinc.com>
 <Y+FwvI+xRg7zMhSx@sirena.org.uk>
In-Reply-To: <Y+FwvI+xRg7zMhSx@sirena.org.uk>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 9 Feb 2023 10:44:36 -0800
Message-ID: <CALs-HsvQiRm-guFMy-E4J+CTLoOMoxb=JiedbtFrdXwzz-oSoA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] selftests: Test the new RISC-V hwprobe interface
To:     Mark Brown <broonie@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 6, 2023 at 1:27 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 12:14:55PM -0800, Evan Green wrote:
>
> > +int main(int argc, char **argv)
> > +{
>
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/libc.S
>
> > +.global _start
> > +_start:
> > +.option push
> > +.option norelax
> > +     la gp, __global_pointer$
> > +.option pop
> > +
> > +     la sp, stack
> > +
> > +     la t0, heap
> > +     la t1, brk
> > +     REG_S t0, 0(t1)
> > +
> > +     li a0, 0
> > +     li a1, 0
> > +
> > +     call main
>
> This looks like it's just a standard program entry but I don't speak
> RISC-V asm so I might be missing something.  If that's the case might it
> make sense to use nolibc here?

I think I can just remove this file entirely along with -nostdlib, and
just let the compiler add in this glue.
-Evan
