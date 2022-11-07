Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFB61F951
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiKGQVR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiKGQUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:20:43 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A7B205E5;
        Mon,  7 Nov 2022 08:20:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5brC4vK5z9v7gG;
        Tue,  8 Nov 2022 00:13:31 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDn0G0WMGljx9JGAA--.121S2;
        Mon, 07 Nov 2022 17:19:47 +0100 (CET)
Message-ID: <ae11a88f0a56ff6164a2ae9d8f07e1c8da28c264.camel@huaweicloud.com>
Subject: Re: [RESEND][RFC][PATCH 2/3] bpf-lsm: Limit values that can be
 returned by security modules
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org
Date:   Mon, 07 Nov 2022 17:19:28 +0100
In-Reply-To: <CAADnVQ+nmneJGNRHHh8yAbrewnD_SVsZmw1U=CzNf8AD38BTrw@mail.gmail.com>
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
         <20221028165423.386151-2-roberto.sassu@huaweicloud.com>
         <CACYkzJ5gFu5a-NoKFD6XFNYMDyP+iPon=kHMimJybmNexbhAPg@mail.gmail.com>
         <38c3ff70963de4a7a396c0fad84349c7c39c0f07.camel@huaweicloud.com>
         <CAADnVQ+K0NMFKV8pQR+ZMHMM9KArRsLSv-F82_qbK4+4xaPxrg@mail.gmail.com>
         <7ecbf4fff621bb3340422ff668452c0bbf4c4e71.camel@huaweicloud.com>
         <CAADnVQ+nmneJGNRHHh8yAbrewnD_SVsZmw1U=CzNf8AD38BTrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDn0G0WMGljx9JGAA--.121S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr15Zw47KF4UZrWUCrWxZwb_yoW3Xry7pF
        WfJFyYkr4vyr43Jw1ava1rZa1Fyr1fKr4UXrnxJr1Yvw1qyrn8tr1UKr1Y9F95Gr1UKw1j
        qr42qFy3u34DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4UnjwAAsQ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-11-07 at 08:00 -0800, Alexei Starovoitov wrote:
> On Mon, Nov 7, 2022 at 4:33 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Fri, 2022-11-04 at 17:42 -0700, Alexei Starovoitov wrote:
> > > On Fri, Nov 4, 2022 at 8:29 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Thu, 2022-11-03 at 16:09 +0100, KP Singh wrote:
> > > > > On Fri, Oct 28, 2022 at 6:55 PM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > 
> > > > > > BPF LSM defines a bpf_lsm_*() function for each LSM hook, so that
> > > > > > security modules can define their own implementation for the desired hooks.
> > > > > > 
> > > > > > Unfortunately, BPF LSM does not restrict which values security modules can
> > > > > > return (for non-void LSM hooks). Security modules might follow the
> > > > > > conventions stated in include/linux/lsm_hooks.h, or put arbitrary values.
> > > > > > 
> > > > > > This could cause big troubles, as the kernel is not ready to handle
> > > > > > possibly malicious return values from LSMs. Until now, it was not the
> > > > > 
> > > > > I am not sure I would call this malicious. This would be incorrect, if
> > > > > someone is writing a BPF LSM program they already have the powers
> > > > > to willingly do a lot of malicious stuff.
> > > > > 
> > > > > It's about unknowingly returning values that can break the system.
> > > > 
> > > > Maybe it is possible to return specific values that lead to acquire
> > > > more information/do actions that the eBPF program is not supposed to
> > > > cause.
> > > > 
> > > > I don't have a concrete example, so I will use the word you suggested.
> > > > 
> > > > > > case, as each LSM is carefully reviewed and it won't be accepted if it
> > > > > > does not meet the return value conventions.
> > > > > > 
> > > > > > The biggest problem is when an LSM returns a positive value, instead of a
> > > > > > negative value, as it could be converted to a pointer. Since such pointer
> > > > > > escapes the IS_ERR() check, its use later in the code can cause
> > > > > > unpredictable consequences (e.g. invalid memory access).
> > > > > > 
> > > > > > Another problem is returning zero when an LSM is supposed to have done some
> > > > > > operations. For example, the inode_init_security hook expects that their
> > > > > > implementations return zero only if they set the name and value of the new
> > > > > > xattr to be added to the new inode. Otherwise, other kernel subsystems
> > > > > > might encounter unexpected conditions leading to a crash (e.g.
> > > > > > evm_protected_xattr_common() getting NULL as argument).
> > > > > > 
> > > > > > Finally, there are LSM hooks which are supposed to return just one as
> > > > > > positive value, or non-negative values. Also in these cases, although it
> > > > > > seems less critical, it is safer to return to callers of the LSM
> > > > > > infrastructure more precisely what they expect.
> > > > > > 
> > > > > > As eBPF allows code outside the kernel to run, it is its responsibility
> > > > > > to ensure that only expected values are returned to LSM infrastructure
> > > > > > callers.
> > > > > > 
> > > > > > Create four new BTF ID sets, respectively for hooks that can return
> > > > > > positive values, only one as positive value, that cannot return zero, and
> > > > > > that cannot return negative values. Create also corresponding functions to
> > > > > > check if the hook a security module is attached to belongs to one of the
> > > > > > defined sets.
> > > > > > 
> > > > > > Finally, check in the eBPF verifier the value returned by security modules
> > > > > > for each attached LSM hook, and return -EINVAL (the security module cannot
> > > > > > run) if the hook implementation does not satisfy the hook return value
> > > > > > policy.
> > > > > > 
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > ---
> > > > > >  include/linux/bpf_lsm.h | 24 ++++++++++++++++++
> > > > > >  kernel/bpf/bpf_lsm.c    | 56 +++++++++++++++++++++++++++++++++++++++++
> > > > > >  kernel/bpf/verifier.c   | 35 +++++++++++++++++++++++---
> > > > > >  3 files changed, 112 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > > > > index 4bcf76a9bb06..cd38aca4cfc0 100644
> > > > > > --- a/include/linux/bpf_lsm.h
> > > > > > +++ b/include/linux/bpf_lsm.h
> > > > > > @@ -28,6 +28,10 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > > > >                         const struct bpf_prog *prog);
> > > > > > 
> > > > > >  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> > > > > > +bool bpf_lsm_can_ret_pos_value(u32 btf_id);
> > > > > > +bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id);
> > > > > > +bool bpf_lsm_cannot_ret_zero(u32 btf_id);
> > > > > > +bool bpf_lsm_cannot_ret_neg_value(u32 btf_id);
> > > > > > 
> > > > > 
> > > > > This does not need to be exported to the rest of the kernel. Please
> > > > > have this logic in bpf_lsm.c and export a single verify function.
> > > > > 
> > > > > Also, these really don't need to be such scattered logic, Could we
> > > > > somehow encode this into the LSM_HOOK definition?
> > > > 
> > > > The problem is that a new LSM_HOOK definition would apply to every LSM
> > > > hook, while we need the ability to select subsets.
> > > > 
> > > > I was thinking, but I didn't check yet, what about using BTF_ID_FLAGS,
> > > > introducing a flag for each interval (<0, 0, 1, >1) and setting the
> > > > appropriate flags for each LSM hook?
> > > 
> > > Before adding infra to all hooks, let's analyze all hooks first.
> > > I thought the number of exceptions is very small.
> > > 99% of hooks will be fine with IS_ERR.
> > > If so, adding an extra flag to every hook will cause too much churn.
> > 
> > If I counted them correctly, there are 12 hooks which can return a
> > positive value. Among them, 6 can return only 1. 3 should not return a
> > negative value.
> > 
> > A reason for making this change in the LSM infrastructure would be that
> > the return values provided there would be the official reference for
> > anyone dealing with LSM hooks (e.g. redefining the LSM_HOOK macro).
> > 
> > Another reason would be that for new hooks, the developer introducing
> > them would have to provide the information. BPF LSM would use that
> > automatically (otherwise it might get out of sync).
> 
> I'd prefer these 12 hooks to get converted to IS_ERR instead.
> Especially those that can only return 1... why aren't they void?

Sorry, I meant can only return 1 as positive value (but can return 0 or
a negative value).

Not sure it is a good idea to change the conventions.

> > The idea would be to use BTF_ID_FLAGS() with the flags coming from
> > lsm_hook_defs.h, and to check if a flag is set depending on the
> > interval of the return value provided by the eBPF program.
> 
> BTF_ID_FLAGS is not appropriate for this.

Uhm, why not? If you store the flags in the BTF ID set, the
implementation would be something like this.

Assuming that a hook definition becomes:

LSM_HOOK(int, 0, LSM_RET_NEG | LSM_RET_ZERO, path_unlink,
         const struct path *dir, struct dentry *dentry)


In bpf_lsm.c, we would have:

#include <linux/lsm_hook_defs.h>
#undef LSM_HOOK

#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...) \
	BTF_ID_FLAGS(func, bpf_lsm_##NAME, RET_FLAGS)
BTF_SET_START(bpf_lsm_hooks)
#include <linux/lsm_hook_defs.h>
#undef LSM_HOOK
BTF_SET_END(bpf_lsm_hooks)

bool bpf_lsm_ret_value_allowed(u32 btf_id, ...)
{
	u32 *flags = btf_id_set8_contains(&bpf_lsm_hooks, btf_id);

	if (lsm_ret < 0 && !(*flags & LSM_RET_NEG))
		return false;

	...


	return true;
}

Thanks

Roberto

