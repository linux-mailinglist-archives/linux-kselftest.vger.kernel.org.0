Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42865A68DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiH3Qye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 12:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3Qyd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 12:54:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3FE6F;
        Tue, 30 Aug 2022 09:54:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cu2so23485671ejb.0;
        Tue, 30 Aug 2022 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f+s1k0QulyVXl2cK6VcOd5dpUM4UDZztKU/w4k+ArrM=;
        b=ci58jmQlGnU2jB4nlRYAOnSraJY1ggplK67rwPALlfMK1VRtx4W6BJUOC7DmxpTfr0
         6rwi8kdaQBT+oT5MNxkLj+CmrZ3P3sqAGLAE3KK3NkF7zkpt1iSEcsZc72KOlv3tMNdP
         ebsqwYz4DKdKwVEs6+7taCAxp2dw4n3qdyZOjKjbcCNLzISL/A+lxVnEoXkQUrZHRwyt
         eH5qb1SfE0jQi/mUY7MJ0BRbVivlbUKvRuVQ8A2O5ic1UzDA3ZFmeTwsdESpYtu0yl0O
         dKh5+0NrNDAm/xjuAaqi/vAsZ9YljZpPuYFdl7Fg4bErSTbou1VZaPKRlT3m6v07NhAX
         4g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f+s1k0QulyVXl2cK6VcOd5dpUM4UDZztKU/w4k+ArrM=;
        b=8F+EYyEE4o0zzVMRYbq2qRr4s7q18KggU5L0K1DSdOTUMPk7VkmHkS0lVGLg/cssul
         ke01VapQywVcUbOy0VY2Cnj7M8OPztHt7D26Yb/AfHZT6ZaGcmXtPO/so7bh1Xx9xPv1
         PIWzKokFj8Jur1NyOPVHsWFmPUluvbs42mpUSJV1NC7KY3IWO3+LdEz5WNjKWuTOwXse
         rTLb5UkSuJmq/0Ra7XVuyZDqeaHOtTSn31k4of5wzH7Qy8mi4tOpvSf79nQ2LQIaEJQZ
         DgGWn4EUp/6oOYsVKTd+Jmp9xO9WFn+5fX4jFokvf7U4HmeampOAKiQm0nO4Z3k5ZAjo
         5VXg==
X-Gm-Message-State: ACgBeo0tijqCI6PZiTnWW/8A+P0JklZNx7EK76rcuryfhaMpHbI9M/Pr
        Hm8x9++mE0ME0uEX8lmEY79UlXW5aDKUPS84Mt8=
X-Google-Smtp-Source: AA6agR7SC44Sm+boGLEfKHaUzccEMv81eM5eoBTV4ajaGZB8+mYygPKcBYZWDV9QOhempE3NPLc7H827Z67nhgtqRSM=
X-Received: by 2002:a17:906:ef8f:b0:731:4a01:7781 with SMTP id
 ze15-20020a170906ef8f00b007314a017781mr18235299ejb.268.1661878471414; Tue, 30
 Aug 2022 09:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com> <20220830161716.754078-13-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220830161716.754078-13-roberto.sassu@huaweicloud.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 30 Aug 2022 09:54:20 -0700
Message-ID: <CAJnrk1ZzLkc_TBpqejSOYOpLOVgtPJty2X_3v8i4UgDLR+59VQ@mail.gmail.com>
Subject: Re: [PATCH v14 12/12] selftests/bpf: Add verifier tests for dynamic
 pointers parameters in kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 9:22 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add verifier tests to ensure that only supported dynamic pointer types are
> accepted, that the passed argument is actually a dynamic pointer, and that
> the passed argument is a pointer to the stack.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../bpf/verifier/kfunc_dynptr_param.c         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c
>
> diff --git a/tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c
> new file mode 100644
> index 000000000000..8abb8d566321
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c
> @@ -0,0 +1,72 @@
> +{
> +       "kfunc dynamic pointer param: type not supported",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -16),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_MOV64_IMM(BPF_REG_2, 8),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_MOV64_REG(BPF_REG_4, BPF_REG_6),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_ringbuf = { 3 },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type",
> +       .result = REJECT,
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_verify_pkcs7_signature", 12 },
> +       },
> +},
> +{
> +       "kfunc dynamic pointer param: arg not a dynamic pointer",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized",
> +       .result = REJECT,
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_verify_pkcs7_signature", 5 },
> +       },
> +},
> +{
> +       "kfunc dynamic pointer param: arg not a pointer to stack",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, 0),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack",
> +       .result = REJECT,
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_verify_pkcs7_signature", 3 },
> +       },
> +},

Is this logic testable in plain C BPF code? I tend to side with Andrii
[0] about finding these kinds of tests hard to maintain and read.

[0] https://lore.kernel.org/bpf/CAEf4BzZJvr+vcO57TK94GM7B5=k2wPgAub4BBJf1Uz0xNpCPVg@mail.gmail.com/

> --
> 2.25.1
>
