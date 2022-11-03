Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704826180BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 16:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKCPLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKCPLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 11:11:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088DBAA
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57834B8270F
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 15:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067A9C433C1
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667488219;
        bh=ewhJrs7iVBajHat39GJj2Bvn4oi2wS3pS9klk+VGHKE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sPIDKngJei93NhA+m5oQNtDyp33vm42H29FsmtdshFyZX1U4Nu67SjMGdZNu8xkFv
         xri5Pvb6fhcZ0oStK6HSTosg5i+RADwob6KzWJ5JaJkQv7g37Dbn9mVnpO0vSgU6/Y
         Tn0/uT8YMGBc1ZRvfyQKXZpfaZGtnl8zGSAXztTAbK9Xirrz8ynpEUQx568CXJ4FV3
         12rAL/4beoR0iqvX0jcSrVrxnJAl1Kcsm8qbJEekuC47ZrDM6I0UcIQT8AXr68Fs7w
         KxNkuP9dTk2N2CCHImdxBh/OPyE0XEn0jEc2kN5ZIWa7qClEsEE1o9V7JOWNisQP/a
         FxvyixxcBmEaQ==
Received: by mail-ed1-f43.google.com with SMTP id i21so3460134edj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 08:10:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf3yr1ZxUSIbbZ+HRoCLbaJq+sU+nAhoQ7FjnlMLEZhMc3ottNJ1
        VnjPBjyi26bXcgj5Cg4nsuoMyD6wYEq3sfKnxVu18g==
X-Google-Smtp-Source: AMsMyM4Cg6hX3EpnVpClZ01WmQnXuKDsfT4wK4DfY7RDGiifjvu9l3DsMTn43RgsCL9r9814r/hJWGZIoSbvDrkuMOc=
X-Received: by 2002:a05:6512:10c2:b0:4a2:ed6:4f4e with SMTP id
 k2-20020a05651210c200b004a20ed64f4emr12527874lfg.136.1667488207006; Thu, 03
 Nov 2022 08:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com> <20221028165423.386151-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221028165423.386151-2-roberto.sassu@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 16:09:56 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5gFu5a-NoKFD6XFNYMDyP+iPon=kHMimJybmNexbhAPg@mail.gmail.com>
Message-ID: <CACYkzJ5gFu5a-NoKFD6XFNYMDyP+iPon=kHMimJybmNexbhAPg@mail.gmail.com>
Subject: Re: [RESEND][RFC][PATCH 2/3] bpf-lsm: Limit values that can be
 returned by security modules
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, revest@chromium.org,
        jackmanb@chromium.org, shuah@kernel.org, paul@paul-moore.com,
        casey@schaufler-ca.com, zohar@linux.ibm.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.bouchinet@clip-os.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 28, 2022 at 6:55 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> BPF LSM defines a bpf_lsm_*() function for each LSM hook, so that
> security modules can define their own implementation for the desired hooks.
>
> Unfortunately, BPF LSM does not restrict which values security modules can
> return (for non-void LSM hooks). Security modules might follow the
> conventions stated in include/linux/lsm_hooks.h, or put arbitrary values.
>
> This could cause big troubles, as the kernel is not ready to handle
> possibly malicious return values from LSMs. Until now, it was not the

I am not sure I would call this malicious. This would be incorrect, if
someone is writing a BPF LSM program they already have the powers
to willingly do a lot of malicious stuff.

It's about unknowingly returning values that can break the system.

> case, as each LSM is carefully reviewed and it won't be accepted if it
> does not meet the return value conventions.
>
> The biggest problem is when an LSM returns a positive value, instead of a
> negative value, as it could be converted to a pointer. Since such pointer
> escapes the IS_ERR() check, its use later in the code can cause
> unpredictable consequences (e.g. invalid memory access).
>
> Another problem is returning zero when an LSM is supposed to have done some
> operations. For example, the inode_init_security hook expects that their
> implementations return zero only if they set the name and value of the new
> xattr to be added to the new inode. Otherwise, other kernel subsystems
> might encounter unexpected conditions leading to a crash (e.g.
> evm_protected_xattr_common() getting NULL as argument).
>
> Finally, there are LSM hooks which are supposed to return just one as
> positive value, or non-negative values. Also in these cases, although it
> seems less critical, it is safer to return to callers of the LSM
> infrastructure more precisely what they expect.
>
> As eBPF allows code outside the kernel to run, it is its responsibility
> to ensure that only expected values are returned to LSM infrastructure
> callers.
>
> Create four new BTF ID sets, respectively for hooks that can return
> positive values, only one as positive value, that cannot return zero, and
> that cannot return negative values. Create also corresponding functions to
> check if the hook a security module is attached to belongs to one of the
> defined sets.
>
> Finally, check in the eBPF verifier the value returned by security modules
> for each attached LSM hook, and return -EINVAL (the security module cannot
> run) if the hook implementation does not satisfy the hook return value
> policy.
>
> Cc: stable@vger.kernel.org
> Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf_lsm.h | 24 ++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 56 +++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c   | 35 +++++++++++++++++++++++---
>  3 files changed, 112 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 4bcf76a9bb06..cd38aca4cfc0 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -28,6 +28,10 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>                         const struct bpf_prog *prog);
>
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> +bool bpf_lsm_can_ret_pos_value(u32 btf_id);
> +bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id);
> +bool bpf_lsm_cannot_ret_zero(u32 btf_id);
> +bool bpf_lsm_cannot_ret_neg_value(u32 btf_id);
>

This does not need to be exported to the rest of the kernel. Please
have this logic in bpf_lsm.c and export a single verify function.

Also, these really don't need to be such scattered logic, Could we
somehow encode this into the LSM_HOOK definition?

>  static inline struct bpf_storage_blob *bpf_inode(
>         const struct inode *inode)
> @@ -51,6 +55,26 @@ static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
>         return false;
>  }
>
> +static inline bool bpf_lsm_can_ret_pos_value(u32 btf_id)
> +{
> +       return false;
> +}
> +
> +static inline bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id)
> +{
> +       return false;
> +}
> +
> +static inline bool bpf_lsm_cannot_ret_zero(u32 btf_id)
> +{
> +       return false;
> +}
> +
> +static inline bool bpf_lsm_cannot_ret_neg_value(u32 btf_id)
> +{
> +       return false;
> +}
> +
>  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>                                       const struct bpf_prog *prog)
>  {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index d6c9b3705f24..3dcb70b2f978 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -348,6 +348,62 @@ bool bpf_lsm_is_sleepable_hook(u32 btf_id)
>         return btf_id_set_contains(&sleepable_lsm_hooks, btf_id);
>  }
>
> +/* The set of hooks which are allowed to return a positive value. */
> +BTF_SET_START(pos_ret_value_lsm_hooks)
> +BTF_ID(func, bpf_lsm_vm_enough_memory)
> +BTF_ID(func, bpf_lsm_inode_getsecurity)
> +BTF_ID(func, bpf_lsm_inode_listsecurity)
> +BTF_ID(func, bpf_lsm_inode_need_killpriv)
> +BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
> +BTF_ID(func, bpf_lsm_getprocattr)
> +BTF_ID(func, bpf_lsm_setprocattr)
> +BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
> +BTF_ID(func, bpf_lsm_key_getsecurity)
> +BTF_ID(func, bpf_lsm_ismaclabel)
> +BTF_ID(func, bpf_lsm_audit_rule_known)
> +BTF_ID(func, bpf_lsm_audit_rule_match)
> +BTF_SET_END(pos_ret_value_lsm_hooks)
> +
> +bool bpf_lsm_can_ret_pos_value(u32 btf_id)
> +{
> +       return btf_id_set_contains(&pos_ret_value_lsm_hooks, btf_id);
> +}
> +
> +BTF_SET_START(one_ret_value_lsm_hooks)
> +BTF_ID(func, bpf_lsm_vm_enough_memory)
> +BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
> +BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
> +BTF_ID(func, bpf_lsm_ismaclabel)
> +BTF_ID(func, bpf_lsm_audit_rule_known)
> +BTF_ID(func, bpf_lsm_audit_rule_match)
> +BTF_SET_END(one_ret_value_lsm_hooks)
> +
> +bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id)
> +{
> +       return btf_id_set_contains(&one_ret_value_lsm_hooks, btf_id);
> +}
> +
> +/* The set of hooks which are not allowed to return zero. */
> +BTF_SET_START(not_zero_ret_value_lsm_hooks)
> +BTF_ID(func, bpf_lsm_inode_init_security)
> +BTF_SET_END(not_zero_ret_value_lsm_hooks)
> +
> +bool bpf_lsm_cannot_ret_zero(u32 btf_id)
> +{
> +       return btf_id_set_contains(&not_zero_ret_value_lsm_hooks, btf_id);
> +}
> +
> +/* The set of hooks which are not allowed to return a negative value. */
> +BTF_SET_START(not_neg_ret_value_lsm_hooks)
> +BTF_ID(func, bpf_lsm_vm_enough_memory)
> +BTF_ID(func, bpf_lsm_audit_rule_known)
> +BTF_SET_END(not_neg_ret_value_lsm_hooks)
> +
> +bool bpf_lsm_cannot_ret_neg_value(u32 btf_id)
> +{
> +       return btf_id_set_contains(&not_neg_ret_value_lsm_hooks, btf_id);
> +}
> +
>  const struct bpf_prog_ops lsm_prog_ops = {
>  };
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7f0a9f6cb889..099c1bf88fed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10623,9 +10623,38 @@ static int check_return_code(struct bpf_verifier_env *env)
>
>         case BPF_PROG_TYPE_LSM:
>                 if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
> -                       /* Regular BPF_PROG_TYPE_LSM programs can return
> -                        * any value.
> -                        */
> +                       /* < 0 */
> +                       if (tnum_in(tnum_range((u64)(~0) << 31, (u64)(~0)), reg->var_off)) {
> +                               if (bpf_lsm_cannot_ret_neg_value(env->prog->aux->attach_btf_id)) {
> +                                       verbose(env, "Invalid R0, cannot return negative value\n");
> +                                       return -EINVAL;
> +                               }
> +                       /* = 0 */
> +                       } else if (tnum_equals_const(reg->var_off, 0)) {
> +                               if (bpf_lsm_cannot_ret_zero(env->prog->aux->attach_btf_id)) {
> +                                       verbose(env, "Invalid R0, cannot return zero value\n");
> +                                       return -EINVAL;
> +                               }
> +                       /* = 1 */
> +                       } else if (tnum_equals_const(reg->var_off, 1)) {
> +                               if (!bpf_lsm_can_ret_pos_value(env->prog->aux->attach_btf_id)) {
> +                                       verbose(env, "Invalid R0, cannot return positive value\n");
> +                                       return -EINVAL;
> +                               }
> +                       /* > 1 */
> +                       } else {
> +                               if (!bpf_lsm_can_ret_pos_value(env->prog->aux->attach_btf_id)) {
> +                                       verbose(env, "Invalid R0, cannot return positive value\n");
> +                                       return -EINVAL;
> +                               }
> +
> +                               if (bpf_lsm_can_ret_only_one_as_pos_value(env->prog->aux->attach_btf_id)) {
> +                                       verbose(env,
> +                                               "Invalid R0, can return only one as positive value\n");
> +                                       return -EINVAL;
> +                               }
> +                       }
> +
>                         return 0;
>                 }
>                 if (!env->prog->aux->attach_func_proto->type) {
> --
> 2.25.1
>
