Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD942668444
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 21:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjALUuW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 15:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjALUt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 15:49:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9025471C
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 12:20:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k19so14617158pfg.11
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 12:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qSjE1VvRbPXJ5r4XzLx17PZDp1t5KVaqJ2AEZ4GlVw=;
        b=AmJStk62XZYs69MWgzxpuT3vfBxY5afaIrLoL2S3wdmRvqZKn1U7IArJ0cOBbT1/LJ
         yeB7Ho2R7AARXi8kR04Z05DcOPCPEgwc8arHXeKzhkS0nYj7zAVXBQ6lYKXz/OTKxvfg
         LVueMMpxoG+2m+0WmnPol0DvGoizDs28jcHpmCiUVtdrSMOIuxlnC+OC+U0k9IB54Ppc
         HzEaIAYvXP5Fgcgd/S2Nkx8oZsex69KmExFmjB6U9GORX7KPjQ+fDBjy8fmHxVTcdfRa
         hGsTrKUUfGTLYW9d7eUUjqvGTxRVBBEIDisgw9N3KSMsalvOSxUdZFk+xkos+CLcL3za
         h3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qSjE1VvRbPXJ5r4XzLx17PZDp1t5KVaqJ2AEZ4GlVw=;
        b=vpjuBaqrUG319hwmpMKLql0QGkRC9Hnn63nDFQRt1kzTeHnTDQkmDW615QJDyNU9m3
         JA29NFJEnkHkUYCm3y4NX4ce13Rlw6HAaXIKxjJ6CcxI9wUiANnHP9xVyrtK9T4SE4id
         MZyFvtufHb41ZUJxOPPWTFrWy/Ew9iiJVIm01zAuIfyrovl5Futp4xACJc3YeQisR7/p
         R8sAWVoadG7n+lsF0I0FfRQeIJ6zpMQKG/SokekUCsGelfm2ssPUAIyjCmx1xp9n9dYY
         ZNsf2wLxK0mV7SYQLzBvB7FRD1BXHlwiaDSgQtU/q1vhgrDXvxj4dYNmw9VmLZkqQ99p
         B8Kg==
X-Gm-Message-State: AFqh2kq2e2ASQSrowQWkI4EOKZ8BOmzVtBmm9RUZRCM9q+Fj38ghEJKF
        uv7YJEWoMW+U8bErqEhel1VHioviRalExZ7XffvYVn/mQlFp+g==
X-Google-Smtp-Source: AMrXdXtC9yOgGx2bPJjD3/ghQwCgSCmI+XBzfxXEggijGen8Keatcg5FP0p4b0Ro+YZ+NeNni44s2PGBb4AAfetsW8M=
X-Received: by 2002:aa7:914e:0:b0:578:202d:a33a with SMTP id
 14-20020aa7914e000000b00578202da33amr4164118pfi.23.1673554827750; Thu, 12 Jan
 2023 12:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
In-Reply-To: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Jan 2023 12:20:18 -0800
Message-ID: <CAKwvOdmJtg2=D64hgxBLkQbabVSPTtn8VLxEvbuRf064sm5NAg@mail.gmail.com>
Subject: Re: [PATCH 0/6] kselftest/arm64: Build fixes for clang
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 12, 2023 at 11:52 AM Mark Brown <broonie@kernel.org> wrote:
>
> This series provides a few small build fixes and Makefile tweaks which
> allow us to build the arm64 selftests using clang as well as GCC.  I
> also fixed one minor issue I noticed in the MTE Makefile while doing the
> updates there.
>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> To: Shuah Khan <shuah@kernel.org>
> To: Nathan Chancellor <nathan@kernel.org>
> To: Nick Desaulniers <ndesaulniers@google.com>
> To: Tom Rix <trix@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for the patches! They LGTM! For the series:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> ---
> Mark Brown (6):
>       kselftest/arm64: Fix .pushsection for strings in FP tests
>       kselftest/arm64: Remove redundant _start labels from FP tests
>       kselftest/arm64: Don't pass headers to the compiler as source
>       kselftest/arm64: Initialise current at build time in signal tests
>       kselftest/arm64: Support build of MTE tests with clang
>       kselftest/arm64: Remove spurious comment from MTE test Makefile
>
>  tools/testing/selftests/arm64/fp/assembler.h        |  2 +-
>  tools/testing/selftests/arm64/fp/fp-pidbench.S      |  1 -
>  tools/testing/selftests/arm64/fp/fpsimd-test.S      |  1 -
>  tools/testing/selftests/arm64/fp/sve-test.S         |  1 -
>  tools/testing/selftests/arm64/fp/za-test.S          |  1 -
>  tools/testing/selftests/arm64/mte/Makefile          | 21 +++++++++++++++------
>  tools/testing/selftests/arm64/signal/Makefile       |  8 ++++++--
>  tools/testing/selftests/arm64/signal/test_signals.c |  4 +---
>  8 files changed, 23 insertions(+), 16 deletions(-)
> ---
> base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
> change-id: 20230111-arm64-kselftest-clang-f734b6b0c057
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>



-- 
Thanks,
~Nick Desaulniers
