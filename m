Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A66E9AE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjDTRhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 13:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjDTRhN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 13:37:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB25B88
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 10:36:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1146299b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682012206; x=1684604206;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCEy80G5HOek7evJubycy60H7TmBgXN6S6jqg8NE5AA=;
        b=qt34Ca8pJyfInnsKvQsJ+ATBCHwkD8yXhCNubTccdEm/zIin+n/JcbELHJ/pMGu5MD
         8vOKkfU1vdV1wENziP8ftZ/SDgzOnklFq26flU1X2bGDp8mLRs77RpZGKHq8Ht/KwiOA
         fr1kR3jCo8PiqehFpMbwCkSKYX4Y3xMb7Za90C+lrr/1yKWQLAnKRYWc2sYI1SbCVkwq
         bowcnC98V441QK4Lfiwf3ZUB2lVP0Tr0W0wujC42ZvBXRXTnaMgYK2meYa9Uu0p+s4qO
         hj2vCz+La3rz6wS3jMsw82niKWKymLdYox/MVL/XPkxwSiISAR4yjgG+0nMkOAbJsA+T
         kX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012206; x=1684604206;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCEy80G5HOek7evJubycy60H7TmBgXN6S6jqg8NE5AA=;
        b=dzyVZIFulR+QgScYJL0v1eP1oqReAmsGgCKTORyGfo5KmJAJIkPaUuKS1gcnF+M4C8
         doD0oEUknNJL4bAscjk+QD93g/YMmd30/TdHbkPI1BSpI0fVspF3E8Qziw2b6DStZecH
         5w4IrmRi7fzdeiRajTb7vVBbfITH5vRz4FK01pPCWKGsXj1F/nzoe7UJ9jEqGNy2K5gu
         YdyuqGUK18/yIqLxB3XEyN3no1wuiyg2tth571UdWZyjwqJHNAzh/CsHYOsTdr9r7hJv
         Irdzr6dnDK8YcX26NJW3SQZ0c/o64d4uf2P5zRC6mmqAARxdekt2zloImZjjEhhZsASs
         AK2g==
X-Gm-Message-State: AAQBX9eCrbTAwK98FjMbIQgWQmmaOy70cA7DgzrKHkI1sbjt6E6qaUwJ
        H4DQgqOMZSiygaviVg4Fa9q5zA==
X-Google-Smtp-Source: AKy350anLRbb1718rY21erAN2i76dk/7U/I6A0UD9q7UMYTl2QG0KvWi1Xv/8e0rt+P8WT3wygV06g==
X-Received: by 2002:a05:6a20:d906:b0:ef:bd:38 with SMTP id jd6-20020a056a20d90600b000ef00bd0038mr2856576pzb.55.1682012206529;
        Thu, 20 Apr 2023 10:36:46 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id fd22-20020a056a002e9600b0063b6e3e5a39sm1522819pfb.52.2023.04.20.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:36:46 -0700 (PDT)
In-Reply-To: <20230407231103.2622178-1-evan@rivosinc.com>
References: <20230407231103.2622178-1-evan@rivosinc.com>
Subject: Re: [PATCH v6 0/6] RISC-V Hardware Probing User Interface
Message-Id: <168201218504.13763.1031176103296142331.b4-ty@rivosinc.com>
Date:   Thu, 20 Apr 2023 10:36:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Vineet Gupta <vineetg@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Fri, 07 Apr 2023 16:10:57 -0700, Evan Green wrote:
> There's been a bunch of off-list discussions about this, including at
> Plumbers.  The original plan was to do something involving providing an
> ISA string to userspace, but ISA strings just aren't sufficient for a
> stable ABI any more: in order to parse an ISA string users need the
> version of the specifications that the string is written to, the version
> of each extension (sometimes at a finer granularity than the RISC-V
> releases/versions encode), and the expected use case for the ISA string
> (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
> try and keep ABI compatible and it's probably going to continue to grow,
> as even if there's no more complexity in the specifications we'll have
> to deal with the various ISA string parsing oddities that end up all
> over userspace.
> 
> [...]

Applied, thanks!

[1/6] RISC-V: Move struct riscv_cpuinfo to new header
      https://git.kernel.org/palmer/c/ff77cf5b2e03
[2/6] RISC-V: Add a syscall for HW probing
      https://git.kernel.org/palmer/c/ea3de9ce8aa2
[3/6] RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
      https://git.kernel.org/palmer/c/00e76e2c6a2b
[4/6] RISC-V: hwprobe: Support probing of misaligned access performance
      https://git.kernel.org/palmer/c/62a31d6e38bd
[5/6] selftests: Test the new RISC-V hwprobe interface
      https://git.kernel.org/palmer/c/287dcc2b0c83
[6/6] RISC-V: Add hwprobe vDSO function and data
      https://git.kernel.org/palmer/c/aa5af0aa90ba

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

