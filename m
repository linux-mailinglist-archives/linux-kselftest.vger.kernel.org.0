Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28134619B9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiKDP3Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiKDP3Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 11:29:24 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6C5582;
        Fri,  4 Nov 2022 08:29:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4N3krz4qShz9xqq7;
        Fri,  4 Nov 2022 23:22:43 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3rPirL2VjChk6AA--.52698S2;
        Fri, 04 Nov 2022 16:28:56 +0100 (CET)
Message-ID: <38c3ff70963de4a7a396c0fad84349c7c39c0f07.camel@huaweicloud.com>
Subject: Re: [RESEND][RFC][PATCH 2/3] bpf-lsm: Limit values that can be
 returned by security modules
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, revest@chromium.org,
        jackmanb@chromium.org, shuah@kernel.org, paul@paul-moore.com,
        casey@schaufler-ca.com, zohar@linux.ibm.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.bouchinet@clip-os.org
Date:   Fri, 04 Nov 2022 16:28:40 +0100
In-Reply-To: <CACYkzJ5gFu5a-NoKFD6XFNYMDyP+iPon=kHMimJybmNexbhAPg@mail.gmail.com>
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
         <20221028165423.386151-2-roberto.sassu@huaweicloud.com>
         <CACYkzJ5gFu5a-NoKFD6XFNYMDyP+iPon=kHMimJybmNexbhAPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwB3rPirL2VjChk6AA--.52698S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF17GFyDGw4DKw1rAr43Wrg_yoWfKw1rpr
        4xJFyYkrWvvFWava43tan5Zws5Ar1Fga1qkr1DGr1Ik3sFvry8tw15Cr1YgFy3ur1UKr1I
        9w4jvF4ag347Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj4UUPQACsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-11-03 at 16:09 +0100, KP Singh wrote:
> On Fri, Oct 28, 2022 at 6:55 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > BPF LSM defines a bpf_lsm_*() function for each LSM hook, so that
> > security modules can define their own implementation for the desired hooks.
> > 
> > Unfortunately, BPF LSM does not restrict which values security modules can
> > return (for non-void LSM hooks). Security modules might follow the
> > conventions stated in include/linux/lsm_hooks.h, or put arbitrary values.
> > 
> > This could cause big troubles, as the kernel is not ready to handle
> > possibly malicious return values from LSMs. Until now, it was not the
> 
> I am not sure I would call this malicious. This would be incorrect, if
> someone is writing a BPF LSM program they already have the powers
> to willingly do a lot of malicious stuff.
> 
> It's about unknowingly returning values that can break the system.

Maybe it is possible to return specific values that lead to acquire
more information/do actions that the eBPF program is not supposed to
cause.

I don't have a concrete example, so I will use the word you suggested.

> > case, as each LSM is carefully reviewed and it won't be accepted if it
> > does not meet the return value conventions.
> > 
> > The biggest problem is when an LSM returns a positive value, instead of a
> > negative value, as it could be converted to a pointer. Since such pointer
> > escapes the IS_ERR() check, its use later in the code can cause
> > unpredictable consequences (e.g. invalid memory access).
> > 
> > Another problem is returning zero when an LSM is supposed to have done some
> > operations. For example, the inode_init_security hook expects that their
> > implementations return zero only if they set the name and value of the new
> > xattr to be added to the new inode. Otherwise, other kernel subsystems
> > might encounter unexpected conditions leading to a crash (e.g.
> > evm_protected_xattr_common() getting NULL as argument).
> > 
> > Finally, there are LSM hooks which are supposed to return just one as
> > positive value, or non-negative values. Also in these cases, although it
> > seems less critical, it is safer to return to callers of the LSM
> > infrastructure more precisely what they expect.
> > 
> > As eBPF allows code outside the kernel to run, it is its responsibility
> > to ensure that only expected values are returned to LSM infrastructure
> > callers.
> > 
> > Create four new BTF ID sets, respectively for hooks that can return
> > positive values, only one as positive value, that cannot return zero, and
> > that cannot return negative values. Create also corresponding functions to
> > check if the hook a security module is attached to belongs to one of the
> > defined sets.
> > 
> > Finally, check in the eBPF verifier the value returned by security modules
> > for each attached LSM hook, and return -EINVAL (the security module cannot
> > run) if the hook implementation does not satisfy the hook return value
> > policy.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/bpf_lsm.h | 24 ++++++++++++++++++
> >  kernel/bpf/bpf_lsm.c    | 56 +++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c   | 35 +++++++++++++++++++++++---
> >  3 files changed, 112 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 4bcf76a9bb06..cd38aca4cfc0 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -28,6 +28,10 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                         const struct bpf_prog *prog);
> > 
> >  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> > +bool bpf_lsm_can_ret_pos_value(u32 btf_id);
> > +bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id);
> > +bool bpf_lsm_cannot_ret_zero(u32 btf_id);
> > +bool bpf_lsm_cannot_ret_neg_value(u32 btf_id);
> > 
> 
> This does not need to be exported to the rest of the kernel. Please
> have this logic in bpf_lsm.c and export a single verify function.
> 
> Also, these really don't need to be such scattered logic, Could we
> somehow encode this into the LSM_HOOK definition?

The problem is that a new LSM_HOOK definition would apply to every LSM
hook, while we need the ability to select subsets.

I was thinking, but I didn't check yet, what about using BTF_ID_FLAGS,
introducing a flag for each interval (<0, 0, 1, >1) and setting the
appropriate flags for each LSM hook?

Roberto

> >  static inline struct bpf_storage_blob *bpf_inode(
> >         const struct inode *inode)
> > @@ -51,6 +55,26 @@ static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> >         return false;
> >  }
> > 
> > +static inline bool bpf_lsm_can_ret_pos_value(u32 btf_id)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline bool bpf_lsm_cannot_ret_zero(u32 btf_id)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline bool bpf_lsm_cannot_ret_neg_value(u32 btf_id)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                                       const struct bpf_prog *prog)
> >  {
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index d6c9b3705f24..3dcb70b2f978 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -348,6 +348,62 @@ bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> >         return btf_id_set_contains(&sleepable_lsm_hooks, btf_id);
> >  }
> > 
> > +/* The set of hooks which are allowed to return a positive value. */
> > +BTF_SET_START(pos_ret_value_lsm_hooks)
> > +BTF_ID(func, bpf_lsm_vm_enough_memory)
> > +BTF_ID(func, bpf_lsm_inode_getsecurity)
> > +BTF_ID(func, bpf_lsm_inode_listsecurity)
> > +BTF_ID(func, bpf_lsm_inode_need_killpriv)
> > +BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
> > +BTF_ID(func, bpf_lsm_getprocattr)
> > +BTF_ID(func, bpf_lsm_setprocattr)
> > +BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
> > +BTF_ID(func, bpf_lsm_key_getsecurity)
> > +BTF_ID(func, bpf_lsm_ismaclabel)
> > +BTF_ID(func, bpf_lsm_audit_rule_known)
> > +BTF_ID(func, bpf_lsm_audit_rule_match)
> > +BTF_SET_END(pos_ret_value_lsm_hooks)
> > +
> > +bool bpf_lsm_can_ret_pos_value(u32 btf_id)
> > +{
> > +       return btf_id_set_contains(&pos_ret_value_lsm_hooks, btf_id);
> > +}
> > +
> > +BTF_SET_START(one_ret_value_lsm_hooks)
> > +BTF_ID(func, bpf_lsm_vm_enough_memory)
> > +BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
> > +BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
> > +BTF_ID(func, bpf_lsm_ismaclabel)
> > +BTF_ID(func, bpf_lsm_audit_rule_known)
> > +BTF_ID(func, bpf_lsm_audit_rule_match)
> > +BTF_SET_END(one_ret_value_lsm_hooks)
> > +
> > +bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id)
> > +{
> > +       return btf_id_set_contains(&one_ret_value_lsm_hooks, btf_id);
> > +}
> > +
> > +/* The set of hooks which are not allowed to return zero. */
> > +BTF_SET_START(not_zero_ret_value_lsm_hooks)
> > +BTF_ID(func, bpf_lsm_inode_init_security)
> > +BTF_SET_END(not_zero_ret_value_lsm_hooks)
> > +
> > +bool bpf_lsm_cannot_ret_zero(u32 btf_id)
> > +{
> > +       return btf_id_set_contains(&not_zero_ret_value_lsm_hooks, btf_id);
> > +}
> > +
> > +/* The set of hooks which are not allowed to return a negative value. */
> > +BTF_SET_START(not_neg_ret_value_lsm_hooks)
> > +BTF_ID(func, bpf_lsm_vm_enough_memory)
> > +BTF_ID(func, bpf_lsm_audit_rule_known)
> > +BTF_SET_END(not_neg_ret_value_lsm_hooks)
> > +
> > +bool bpf_lsm_cannot_ret_neg_value(u32 btf_id)
> > +{
> > +       return btf_id_set_contains(&not_neg_ret_value_lsm_hooks, btf_id);
> > +}
> > +
> >  const struct bpf_prog_ops lsm_prog_ops = {
> >  };
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7f0a9f6cb889..099c1bf88fed 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10623,9 +10623,38 @@ static int check_return_code(struct bpf_verifier_env *env)
> > 
> >         case BPF_PROG_TYPE_LSM:
> >                 if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
> > -                       /* Regular BPF_PROG_TYPE_LSM programs can return
> > -                        * any value.
> > -                        */
> > +                       /* < 0 */
> > +                       if (tnum_in(tnum_range((u64)(~0) << 31, (u64)(~0)), reg->var_off)) {
> > +                               if (bpf_lsm_cannot_ret_neg_value(env->prog->aux->attach_btf_id)) {
> > +                                       verbose(env, "Invalid R0, cannot return negative value\n");
> > +                                       return -EINVAL;
> > +                               }
> > +                       /* = 0 */
> > +                       } else if (tnum_equals_const(reg->var_off, 0)) {
> > +                               if (bpf_lsm_cannot_ret_zero(env->prog->aux->attach_btf_id)) {
> > +                                       verbose(env, "Invalid R0, cannot return zero value\n");
> > +                                       return -EINVAL;
> > +                               }
> > +                       /* = 1 */
> > +                       } else if (tnum_equals_const(reg->var_off, 1)) {
> > +                               if (!bpf_lsm_can_ret_pos_value(env->prog->aux->attach_btf_id)) {
> > +                                       verbose(env, "Invalid R0, cannot return positive value\n");
> > +                                       return -EINVAL;
> > +                               }
> > +                       /* > 1 */
> > +                       } else {
> > +                               if (!bpf_lsm_can_ret_pos_value(env->prog->aux->attach_btf_id)) {
> > +                                       verbose(env, "Invalid R0, cannot return positive value\n");
> > +                                       return -EINVAL;
> > +                               }
> > +
> > +                               if (bpf_lsm_can_ret_only_one_as_pos_value(env->prog->aux->attach_btf_id)) {
> > +                                       verbose(env,
> > +                                               "Invalid R0, can return only one as positive value\n");
> > +                                       return -EINVAL;
> > +                               }
> > +                       }
> > +
> >                         return 0;
> >                 }
> >                 if (!env->prog->aux->attach_func_proto->type) {
> > --
> > 2.25.1
> > 

