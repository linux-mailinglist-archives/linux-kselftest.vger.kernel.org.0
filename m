Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E35ADDB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 05:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiIFDDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiIFDDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 23:03:45 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9966129;
        Mon,  5 Sep 2022 20:03:43 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k9so2189859ils.12;
        Mon, 05 Sep 2022 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WonEhxv9YjSZJfIYzt3temHZiW/VTpi28AD1oH8D+xQ=;
        b=CUvQtCUgVB3m1DTFjkWZ5r98jeKFQ25jDEa60q34OjntJne2QUBgjpEQ/0ElZ8j48N
         fv/5QXadHT3yNq2QUrVd43bZ4LL7AuH6lZtP19jlzQzHV6u2RpcjfjCdE3f3gfz0MJ96
         rRvRP2mZN8dcTlA4dNdZE1mNBwu0gpNbVoVm4HpUA2IJbnfGHoaTDQZ9OK7AsbByDANF
         RROySirZHnPTI2BcJsisvTzXtjUF8h+dKPi6dvpu5MunZFwsHHBBKJfpwQNf8kI6jnhC
         v8SCgGBL6EbgdXtubfIFzrIe6EyApVSe9KlTI5io2w0kq4bzj98Ul2v2Dv6iAEMrm6/G
         iZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WonEhxv9YjSZJfIYzt3temHZiW/VTpi28AD1oH8D+xQ=;
        b=n8ARqmVbYmdHy3p6n2lpYzu/5X1S8Fu828kmr4iijqesP//VO0gj8lVgOcDBUFJ0tz
         2AAqzRqKmLNYVfP1m9EYmNE391BRbhP372JkyT9QZKOpMOjIUqx8+aPcoe9hSSaAlUIz
         nDWPZcdPMQSHS5Dk7s/HZjUl48uyAwLIbY7MN0wl1HabJziX9ZVRaH8IjlCVagbRO4cf
         VuNRrs5Ih+nItBq7Ppeo5bqHFC3JTt/nEx7Uj7y/m7R9vP3PU32zBlyZWx23bVGjDYCf
         6Pk0VJaudHMHyjKMSo3oRTrRg88IY5WAJqLWZ8FvjiAcTbIzoj2ozT9yFcI2aIF3aTuT
         XzOw==
X-Gm-Message-State: ACgBeo2qLrfZlty7kov1W9Bm6+/q/IG+51avUm2PnG4AtLVTTIXJSTgd
        XWNptVB8sC1GAYDr41sIPsYWcEkIIGikDaz/ZQ8=
X-Google-Smtp-Source: AA6agR5ByVxCo4ebFwM6ybcmd7AkDLcgL/E1BoJ/wJmddPfxeNB9KELAkM+k9/U9QnvwYmPxFfxE3VlgT2eDAl8UByA=
X-Received: by 2002:a05:6e02:661:b0:2e2:be22:67f0 with SMTP id
 l1-20020a056e02066100b002e2be2267f0mr26603774ilt.91.1662433423339; Mon, 05
 Sep 2022 20:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-10-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-10-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 05:03:07 +0200
Message-ID: <CAP01T75fKAxU-EsJiaoqnymn2b_+=TAKMOvt0Tdd_+Wm5YaXHw@mail.gmail.com>
Subject: Re: [PATCH v16 09/12] selftests/bpf: Add verifier tests for
 bpf_lookup_*_key() and bpf_key_put()
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
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
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

On Mon, 5 Sept 2022 at 16:36, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add verifier tests for bpf_lookup_*_key() and bpf_key_put(), to ensure that
> acquired key references stored in the bpf_key structure are released, that
> a non-NULL bpf_key pointer is passed to bpf_key_put(), and that key
> references are not leaked.
>
> Also, slightly modify test_verifier.c, to find the BTF ID of the attach
> point for the LSM program type (currently, it is done only for TRACING).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  tools/testing/selftests/bpf/config            |   1 +
>  tools/testing/selftests/bpf/test_verifier.c   |   3 +-
>  .../selftests/bpf/verifier/ref_tracking.c     | 139 ++++++++++++++++++
>  3 files changed, 142 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 0fdd11e6b742..add5a5a919b4 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -30,6 +30,7 @@ CONFIG_IPV6_GRE=y
>  CONFIG_IPV6_SEG6_BPF=y
>  CONFIG_IPV6_SIT=y
>  CONFIG_IPV6_TUNNEL=y
> +CONFIG_KEYS=y
>  CONFIG_LIRC=y
>  CONFIG_LWTUNNEL=y
>  CONFIG_MPLS=y
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index f9d553fbf68a..2dbcbf363c18 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1498,7 +1498,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>                 opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
>         opts.prog_flags = pflags;
>
> -       if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
> +       if ((prog_type == BPF_PROG_TYPE_TRACING ||
> +            prog_type == BPF_PROG_TYPE_LSM) && test->kfunc) {
>                 int attach_btf_id;
>
>                 attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
> diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> index 57a83d763ec1..f18ce867271f 100644
> --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> @@ -84,6 +84,145 @@
>         .errstr = "Unreleased reference",
>         .result = REJECT,
>  },
> +{
> +       "reference tracking: acquire/release user key reference",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, -3),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_lookup_user_key", 2 },
> +               { "bpf_key_put", 5 },
> +       },
> +       .result = ACCEPT,
> +},
> +{
> +       "reference tracking: acquire/release system key reference",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_lookup_system_key", 1 },
> +               { "bpf_key_put", 4 },
> +       },
> +       .result = ACCEPT,
> +},
> +{
> +       "reference tracking: release user key reference without check",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, -3),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_lookup_user_key", 2 },
> +               { "bpf_key_put", 4 },
> +       },
> +       .result = REJECT,
> +},
> +{
> +       "reference tracking: release system key reference without check",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_lookup_system_key", 1 },
> +               { "bpf_key_put", 3 },
> +       },
> +       .result = REJECT,
> +},
> +{
> +       "reference tracking: release with NULL key pointer",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_key_put", 1 },
> +       },
> +       .result = REJECT,
> +},
> +{
> +       "reference tracking: leak potential reference to user key",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, -3),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "Unreleased reference",
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_lookup_user_key", 2 },
> +       },
> +       .result = REJECT,
> +},
> +{
> +       "reference tracking: leak potential reference to system key",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_LSM,
> +       .kfunc = "bpf",
> +       .expected_attach_type = BPF_LSM_MAC,
> +       .flags = BPF_F_SLEEPABLE,
> +       .errstr = "Unreleased reference",
> +       .fixup_kfunc_btf_id = {
> +               { "bpf_lookup_system_key", 1 },
> +       },
> +       .result = REJECT,
> +},
>  {
>         "reference tracking: release reference without check",
>         .insns = {
> --
> 2.25.1
>
