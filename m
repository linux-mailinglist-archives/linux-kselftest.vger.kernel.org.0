Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C572092E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjFBSct (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 14:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjFBScs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 14:32:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB78194;
        Fri,  2 Jun 2023 11:32:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so13826231fa.3;
        Fri, 02 Jun 2023 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685730764; x=1688322764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nYQZPbBU9Q+tVhf3ArmvJ6PCtrAL0shxpJeaKhNfrc=;
        b=D153nE9E3IUcw/8LcEj888wR3oR+D16Q5Nj6KeE2lN4127hhVNJAURBsP725ioS6qx
         LcylJhdwEQ6uOhlD3DcDDvdbsc5PmaGRPlbQhvmwftTJs9grUeHL6EZmpcsg+RAjaB0p
         0N/q37R6MHfz9Uzlw6Ks8Zz0Y9q05tuTykJu2dvrQx8+2UYAMypZQ3rmIPDunmXETAWj
         YFww0OOArfH+ysyk7mSLmHbG8vk0jTgIB/MWstWjaJk22H9/3GCKTES42wezKGJgK8y/
         mVs2FwkmseOP8zw08McJepH1dpRgqV18guvZlrruIe4b/zhrSBaNix7k1nTtPaWi9ad/
         jJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685730764; x=1688322764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nYQZPbBU9Q+tVhf3ArmvJ6PCtrAL0shxpJeaKhNfrc=;
        b=M18GuliTEZbUzSbPqIxp8DJNMkezkD+B4UR6RKpblJLBYVOiK7aWeXOy0irryVhdkL
         m9Fg4gzFRecaXKTjvPqsGTC0paXbI9v+l4B0YDSmaR0VOVhPIhts7dJP0yw2Np45wKM+
         J550sevyYerosNtetCa1mSGIw4eYU3amluRHjLxZvDJt3ktemwxFzyBVlq/ioKeVGH2b
         ORN7wqxiwtATJM8qRlZRWseedNDAJwftrY3Wu6AqrlcXWoP0vyDIwGs+aBJq5fmEP4Dh
         sDzE9hAVPUxA+QthTahneM2rBnE3FZkPBsdZLgjP5IQenMD44Lzaxb7yG/hCeyNx++/D
         dk8A==
X-Gm-Message-State: AC+VfDytRfPDy9CJLZLHz31FMyMAT57JNQIjPTLRx3TSradEdzEzRyYk
        nbtXjOfEaVT1CU52ZRzsh/LtU/Danwwx0IvRfIA=
X-Google-Smtp-Source: ACHHUZ51IyG1RUnGPFpFSevQQqnf18OUEaxR6N7QLjmByPwXYD14JpkaTXWP4LHtmzlvoZa8z9ypgdg9yagTv0IWiG4=
X-Received: by 2002:a2e:b016:0:b0:2a8:b579:225b with SMTP id
 y22-20020a2eb016000000b002a8b579225bmr459633ljk.40.1685730764259; Fri, 02 Jun
 2023 11:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230602065958.2869555-1-imagedong@tencent.com> <20230602065958.2869555-6-imagedong@tencent.com>
In-Reply-To: <20230602065958.2869555-6-imagedong@tencent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 2 Jun 2023 11:32:33 -0700
Message-ID: <CAADnVQLPhhEjp6HfsQhaEdp269MZGs2jBkPtkeBe8i0r-MWnYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: add testcase for
 FENTRY/FEXIT with 6+ arguments
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        benbjiang@tencent.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Menglong Dong <imagedong@tencent.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Manu Bretelle <chantr4@gmail.com>,
        Ross Zwisler <zwisler@google.com>, Eddy Z <eddyz87@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 2, 2023 at 12:03=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Add test7/test12/test14 in fexit_test.c and fentry_test.c to test the
> fentry and fexit whose target function have 7/12/14 arguments.
>
> And the testcases passed:
>
> ./test_progs -t fexit
> $71      fentry_fexit:OK
> $73/1    fexit_bpf2bpf/target_no_callees:OK
> $73/2    fexit_bpf2bpf/target_yes_callees:OK
> $73/3    fexit_bpf2bpf/func_replace:OK
> $73/4    fexit_bpf2bpf/func_replace_verify:OK
> $73/5    fexit_bpf2bpf/func_sockmap_update:OK
> $73/6    fexit_bpf2bpf/func_replace_return_code:OK
> $73/7    fexit_bpf2bpf/func_map_prog_compatibility:OK
> $73/8    fexit_bpf2bpf/func_replace_multi:OK
> $73/9    fexit_bpf2bpf/fmod_ret_freplace:OK
> $73/10   fexit_bpf2bpf/func_replace_global_func:OK
> $73/11   fexit_bpf2bpf/fentry_to_cgroup_bpf:OK
> $73/12   fexit_bpf2bpf/func_replace_progmap:OK
> $73      fexit_bpf2bpf:OK
> $74      fexit_sleep:OK
> $75      fexit_stress:OK
> $76      fexit_test:OK
> Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs -t fentry
> $71      fentry_fexit:OK
> $72      fentry_test:OK
> $140     module_fentry_shadow:OK
> Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/bpf/test_run.c                            | 30 +++++++++++++++-
>  .../testing/selftests/bpf/progs/fentry_test.c | 34 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/fexit_test.c  | 35 +++++++++++++++++++
>  3 files changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index c73f246a706f..e12a72311eca 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -536,6 +536,27 @@ int noinline bpf_fentry_test6(u64 a, void *b, short =
c, int d, void *e, u64 f)
>         return a + (long)b + c + d + (long)e + f;
>  }
>
> +noinline int bpf_fentry_test7(u64 a, void *b, short c, int d, void *e,
> +                             u64 f, u64 g)
> +{
> +       return a + (long)b + c + d + (long)e + f + g;
> +}
> +
> +noinline int bpf_fentry_test12(u64 a, void *b, short c, int d, void *e,
> +                              u64 f, u64 g, u64 h, u64 i, u64 j,
> +                              u64 k, u64 l)
> +{
> +       return a + (long)b + c + d + (long)e + f + g + h + i + j + k + l;
> +}
> +
> +noinline int bpf_fentry_test14(u64 a, void *b, short c, int d, void *e,
> +                              u64 f, u64 g, u64 h, u64 i, u64 j,
> +                              u64 k, u64 l, u64 m, u64 n)
> +{
> +       return a + (long)b + c + d + (long)e + f + g + h + i + j + k + l =
+
> +              m + n;
> +}

Please add test func to bpf_testmod instead of here.
