Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621A64A6B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiLLSPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiLLSOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 13:14:35 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D363F0;
        Mon, 12 Dec 2022 10:11:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NW8cw22X3z9v7Z3;
        Tue, 13 Dec 2022 02:03:28 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAX7GJ9bpdj28EJAA--.1472S2;
        Mon, 12 Dec 2022 19:10:18 +0100 (CET)
Message-ID: <314e38b8931d0bf6d7d9deec7605dbf5b0c51c7e.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v2 2/7] bpf: Mark ALU32 operations in bpf_reg_state
 structure
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 12 Dec 2022 19:10:01 +0100
In-Reply-To: <CAADnVQJedxOdWnDfLcK-o5SiKK-2Qkw-b=-kiP_8rryF3MgtpQ@mail.gmail.com>
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
         <20221207172434.435893-3-roberto.sassu@huaweicloud.com>
         <CAADnVQKhWEtqAkMnWR8Twpc6uPo_MWnAf68R-xeM=YVqxkLOyQ@mail.gmail.com>
         <17749b60bcffdc05ce0343199c14ef3cf2d54010.camel@huaweicloud.com>
         <CAADnVQJedxOdWnDfLcK-o5SiKK-2Qkw-b=-kiP_8rryF3MgtpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX7GJ9bpdj28EJAA--.1472S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWruF4xtryfXr1xGr1kuFg_yoWxGFyrpr
        W3GF17Kr4kWr1xZrnrtws8XFnYyF10y3WUWF98Gry2vwnxKFy7Ar17KFyYk3WDAr10yr1S
        qr1DXrsFqw4DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj4aN6wAFsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-12-12 at 09:04 -0800, Alexei Starovoitov wrote:
> On Mon, Dec 12, 2022 at 4:45 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Sat, 2022-12-10 at 18:28 -0800, Alexei Starovoitov wrote:
> > > On Wed, Dec 7, 2022 at 9:25 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > BPF LSM needs a reliable source of information to determine if the return
> > > > value given by eBPF programs is acceptable or not. At the moment, choosing
> > > > either the 64 bit or the 32 bit one does not seem to be an option
> > > > (selftests fail).
> > > > 
> > > > If we choose the 64 bit one, the following happens.
> > > > 
> > > >       14:       61 10 00 00 00 00 00 00 r0 = *(u32 *)(r1 + 0)
> > > >       15:       74 00 00 00 15 00 00 00 w0 >>= 21
> > > >       16:       54 00 00 00 01 00 00 00 w0 &= 1
> > > >       17:       04 00 00 00 ff ff ff ff w0 += -1
> > > > 
> > > > This is the last part of test_deny_namespace. After #16, the register
> > > > values are:
> > > > 
> > > > smin_value = 0x0, smax_value = 0x1,
> > > > s32_min_value = 0x0, s32_max_value = 0x1,
> > > > 
> > > > After #17, they become:
> > > > 
> > > > smin_value = 0x0, smax_value = 0xffffffff,
> > > > s32_min_value = 0xffffffff, s32_max_value = 0x0
> > > > 
> > > > where only the 32 bit values are correct.
> > > > 
> > > > If we choose the 32 bit ones, the following happens.
> > > > 
> > > > 0000000000000000 <check_access>:
> > > >        0:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0)
> > > >        1:       79 10 08 00 00 00 00 00 r0 = *(u64 *)(r1 + 8)
> > > >        2:       67 00 00 00 3e 00 00 00 r0 <<= 62
> > > >        3:       c7 00 00 00 3f 00 00 00 r0 s>>= 63
> > > > 
> > > > This is part of test_libbpf_get_fd_by_id_opts (no_alu32 version). In this
> > > > case, 64 bit register values should be used (for the 32 bit ones, there is
> > > > no precise information from the verifier).
> > > > 
> > > > As the examples above suggest that which register values to use depends on
> > > > the specific case, mark ALU32 operations in bpf_reg_state structure, so
> > > > that BPF LSM can choose the proper ones.
> > > 
> > > I have a hard time understanding what is the problem you're
> > > trying to solve and what is the proposed fix.
> > 
> > The problem is allowing BPF LSM programs to return positive values when
> > LSM hooks expect zero or negative values. Those values could be
> > converted to a pointer, and escape the IS_ERR() check.
> 
> The bigger goal is clear.
> 
> > The challenge is to ensure that the verifier prediction of R0 is
> > accurate, so that the eBPF program is not unnecessarily rejected.
> 
> There is a code in the verifier already that checks ret values.
> lsm restrictions should fit right in.
> 
> > > The patch is trying to remember the bitness of the last
> > > operation, but what for?
> > > The registers are 64-bit. There are 32-bit operations,
> > > but they always update the upper 32-bits of the register.
> > > reg_bounds_sync() updates 32 and 64 bit bounds regardless
> > > whether the previous operation was on 32 or 64 bit.
> > 
> > Ok, yes. I also thought that using the 64 bit register should be ok,
> > but selftests fail.
> 
> maybe selftests are buggy?
> they fail with patch 3 alone without patch 2 ?
> please explain exactly the problem.

Ok, I let it run getting what the verifier provides (smin/smax).

smin_value = 0xffffffff, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0xffffffff,
Invalid R0, cannot return > 1
#10      bpf_cookie:FAIL

smin_value = 0x0, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0x0,
Invalid R0, cannot return 1
#58/1    deny_namespace/unpriv_userns_create_no_bpf:FAIL
#58      deny_namespace:FAIL

smin_value = 0x0, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0x0,
Invalid R0, cannot return 1
#100     libbpf_get_fd_by_id_opts:FAIL

smin_value = 0xfffffffe, smax_value = 0xfffffffe,
s32_min_value = 0xfffffffe, s32_max_value = 0xfffffffe,
#114     lookup_key:FAIL

smin_value = 0xffffffff, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0xffffffff,
Invalid R0, cannot return > 1
#210     test_ima:FAIL

smin_value = 0xffffffff, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0xffffffff,
Invalid R0, cannot return > 1
#211     test_local_storage:FAIL

smin_value = 0xffffffff, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0xffffffff,
Invalid R0, cannot return > 1
#212     test_lsm:FAIL

As you can see, these tests fail because smin or smax are positive
values.

I kept the selftest patches. In test_lsm, for example, ret is a
parameter, populated by previous eBPF programs. In this case, I added
an additional check to explicitly reject positive values.

> > Regarding your comment, I have not seen reg_bounds_sync() for the case
> > R = imm.
> 
> because it's unnecessary there.

	__mark_reg_known(regs + insn->dst_reg,
			 (u32)insn->imm);

This prevents smin/smax from being negative. But I know that this was
patched by Jann Horn. Remembering the endianness of the operation,
makes it clear what register value you should use.

> > > It seems you're trying to hack around something that breaks
> > > patch 3 which also looks fishy.
> > 
> > I thought it was a good idea that changes in the LSM infrastructure are
> > automatically reflected in the boundaries that BPF LSM should enforce.
> 
> That's fine. Encoding restrictions in lsm_hook_defs.h
> is the cleanest approach.
> 
> > If not, I'm open to new ideas. If we should use BTF ID sets, I'm fine
> > with it.
> > 
> > > Please explain the problem first with a concrete example.
> > 
> > Ok, I have a simple one:
> > 
> > $ llvm-objdump -d test_bpf_cookie.bpf.o
> > 
> > 0000000000000000 <test_int_hook>:
> > 
> > [...]
> > 
> >        8:       85 00 00 00 0e 00 00 00 call 14
> >        9:       b4 06 00 00 ff ff ff ff w6 = -1
> >       10:       5e 08 07 00 00 00 00 00 if w8 != w0 goto +7 <LBB11_3>
> >       11:       bf 71 00 00 00 00 00 00 r1 = r7
> >       12:       85 00 00 00 ae 00 00 00 call 174
> >       13:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >       15:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0)
> >       16:       4f 02 00 00 00 00 00 00 r2 |= r0
> >       17:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) = r2
> > 
> > smin_value = 0xffffffff, smax_value = 0xffffffff,
> > s32_min_value = 0xffffffff, s32_max_value = 0xffffffff,
> 
> and this applies where?

This is in check_return_code(), for BPF_PROG_TYPE_LSM.

> what reg are you talking about?

R0.

> Where is the issue?

s32_min_value/s32_max_value are the values we should get.

Roberto

