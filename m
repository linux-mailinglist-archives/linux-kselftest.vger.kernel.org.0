Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE06411F7
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 01:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiLCAYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 19:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiLCAYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 19:24:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239DD80E9;
        Fri,  2 Dec 2022 16:24:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o13so15111106ejm.1;
        Fri, 02 Dec 2022 16:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2loMqsiSWHn8Spuu+M+LHawRFTbsBo2tswnPTtpYUgE=;
        b=oEOyOdmw9oXfAXVgrnKHoZpyVBKl25HYQWqdZuGfQDFG7N0K8/urjETgEQQ8/B7kAQ
         WwJ+6Y7kS9fyqQLSNl+d4gMnoiuLAdvYPib8d2LjV6Xl2oBEvGFy6SJC8xb4dOL4lusb
         YQoA1tvWXqOOOnx9DMvoZo1MZRwupg/1B1l55TpQgwWEa+9eOMOgORJr3kHgGAgZzbUj
         DI/QC+rpDzE/MZdTnsG2KSLHgn4CxuT3LMK17YMZiAaLw5++zQLWKDxDwROT0DaQoGMY
         D0g3ItYXXtLKg36vbgcF8wIXr/QVDsXDSDOCNLWC95JSyJc193kG/zXPEcLH2eG2WXk1
         8ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2loMqsiSWHn8Spuu+M+LHawRFTbsBo2tswnPTtpYUgE=;
        b=GHQHPM6b/2BJCA/MW+vaL2maKeCIiKOptEbN06Pgg99GamIQf2IlO7kaLsJHeRJaUQ
         UD6uErtBOGoieTDefus2ASKeAW8LMdCcH3CVu+PpMLT0ua73uZIlc2maLB1gGbfqBqXR
         h1wT97oFjktigAxBg4tQGG/mMa4v3bG9g4AZI24eFpfMp6e+bNcPzjBfPZP2KBSnssAE
         W31po5qcjaTVEVVB9bUgG5ex5JPfhUkuDNHq6CILCALC6yNcPbD3Sq6V791//a8sPJca
         ylo4GlARxfIf/QZzVQHsnvq6AMDmTsqYmXue+YkY3xm9oEArN2usunl+i/uFzL58IGam
         n0nA==
X-Gm-Message-State: ANoB5pkaIwxPT0RMK6NR+EJ5KC247p4u8qo6hnUQq8E96zeAdGB4kw/X
        11kY16xhOCmKShscHD2W1QeneElQ9JTa5jxaQ0yg8noq
X-Google-Smtp-Source: AA0mqf7MkmI6dUUsU+TjHt/xRpAIK7q5M76t3VO2Jxz169ZnhRM1BefPvXBatpjSkL0fm2OIScX9tO8uN5mxAVM1wqY=
X-Received: by 2002:a17:907:80cd:b0:7bb:35b4:777d with SMTP id
 io13-20020a17090780cd00b007bb35b4777dmr4471082ejc.302.1670027048471; Fri, 02
 Dec 2022 16:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20221201190939.3230513-1-james.hilliard1@gmail.com>
In-Reply-To: <20221201190939.3230513-1-james.hilliard1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Dec 2022 16:23:56 -0800
Message-ID: <CAEf4BzYrT1VGj43A3Xg60cSMSX658iL2+yp8a5Xk=8Ez3sj_Ew@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: add GCC compatible builtins to bpf_legacy.h
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 1, 2022 at 11:10 AM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> The bpf_legacy.h header uses llvm specific load functions, add
> GCC compatible variants as well to fix tests using these functions
> under GCC.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: David Faust <david.faust@oracle.com>
> ---

Please use [PATCH bpf-next] prefix to target patches for bpf-next
tree. This helps some of our automation.

>  tools/testing/selftests/bpf/bpf_legacy.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_legacy.h b/tools/testing/selftests/bpf/bpf_legacy.h
> index 845209581440..256c2a90aa20 100644
> --- a/tools/testing/selftests/bpf/bpf_legacy.h
> +++ b/tools/testing/selftests/bpf/bpf_legacy.h
> @@ -2,6 +2,15 @@
>  #ifndef __BPF_LEGACY__
>  #define __BPF_LEGACY__
>
> +#if __GNUC__ && !__clang__
> +/* Functions to emit BPF_LD_ABS and BPF_LD_IND instructions.  We
> + * provide the "standard" names as synonyms of the corresponding GCC
> + * builtins.  Note how the SKB argument is ignored.
> + */
> +#define load_byte(skb,off) __builtin_bpf_load_byte((off))
> +#define load_half(skb,off) __builtin_bpf_load_half((off))
> +#define load_word(skb,off) __builtin_bpf_load_word((off))

added space between skb, and off. And we don't need those extra ()
around off, right? I stripped them away, but let me know if that's
wrong.

> +#else
>  /* llvm builtin functions that eBPF C program may use to
>   * emit BPF_LD_ABS and BPF_LD_IND instructions
>   */
> @@ -11,6 +20,7 @@ unsigned long long load_half(void *skb,
>                              unsigned long long off) asm("llvm.bpf.load.half");
>  unsigned long long load_word(void *skb,
>                              unsigned long long off) asm("llvm.bpf.load.word");
> +#endif
>
>  #endif
>
> --
> 2.34.1
>
