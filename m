Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FF5B0817
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIGPKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiIGPKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 11:10:19 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67B30F7D;
        Wed,  7 Sep 2022 08:10:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MN5Bs5Dljz9xHvx;
        Wed,  7 Sep 2022 23:04:37 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHw10qtBhjIYssAA--.26582S2;
        Wed, 07 Sep 2022 16:09:42 +0100 (CET)
Message-ID: <d447540b5adce25efaa29ef1bce001f2bc0a2d12.camel@huaweicloud.com>
Subject: Re: [PATCH v16 00/12] bpf: Add kfuncs for PKCS#7 signature
 verification
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
Date:   Wed, 07 Sep 2022 17:09:29 +0200
In-Reply-To: <CAP01T764z59qczE37=jf-zPkS2zPuzDyCjdngBDnG-GOovG-rQ@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <CAP01T77aq-UP02JYp1Vu-LE--K1ieCyfKfyZPw-a7DDKQ7_F+g@mail.gmail.com>
         <b846cedb14235db6950a55e7eec2eff9e9ab56ec.camel@huaweicloud.com>
         <57cedc7a3008248b5147d03e2f4bd0b33ad9a146.camel@huaweicloud.com>
         <CAP01T764z59qczE37=jf-zPkS2zPuzDyCjdngBDnG-GOovG-rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBHw10qtBhjIYssAA--.26582S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1fGryUJrWxGF1kuw1xZrb_yoW5Xr1UpF
        W8AFy5KF4ktryUCw4xKry5uFy8t3y7JF12qrn8t34UZas0vr1FkFWIyr43uFWq9r1kCw1a
        v39IqFy7Xr1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj365RQAAs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-09-07 at 16:57 +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed, 7 Sept 2022 at 16:49, Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Tue, 2022-09-06 at 09:35 +0200, Roberto Sassu wrote:
> > > On Mon, 2022-09-05 at 21:26 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Mon, 5 Sept 2022 at 16:34, Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > One of the desirable features in security is the ability to
> > > > > restrict import
> > > > > of data to a given system based on data authenticity. If data
> > > > > import can be
> > > > > restricted, it would be possible to enforce a system-wide
> > > > > policy
> > > > > based on
> > > > > the signing keys the system owner trusts.
> > > > > 
> > > > > This feature is widely used in the kernel. For example, if
> > > > > the
> > > > > restriction
> > > > > is enabled, kernel modules can be plugged in only if they are
> > > > > signed with a
> > > > > key whose public part is in the primary or secondary keyring.
> > > > > 
> > > > > For eBPF, it can be useful as well. For example, it might be
> > > > > useful
> > > > > to
> > > > > authenticate data an eBPF program makes security decisions
> > > > > on.
> > > > > 
> > > > > [...]
> > > > 
> > > > CI is crashing with NULL deref for test_progs-no_alu32 with
> > > > llvm-
> > > > 16,
> > > > but I don't think the problem is in this series. This is most
> > > > likely
> > > > unrelated to BPF, as the crash happens inside
> > > > kernel/time/tick-sched.c:tick_nohz_restart_sched_tick.
> > > > 
> > > > This was the same case in
> > > > https://lore.kernel.org/bpf/CAP01T74steDfP6O8QOshoto3e3RnHhKtAeTbnrPBZS3YJXjvbA@mail.gmail.com.
> > > > 
> > > > So,
> > > > https://github.com/kernel-patches/bpf/runs/8194263557?check_suite_focus=true
> > > > and
> > > > https://github.com/kernel-patches/bpf/runs/7982907380?check_suite_focus=true
> > > > 
> > > > look similar to me, and may not be related to BPF. They only
> > > > trigger
> > > > during runs compiled using LLVM 16, so maybe some compiler
> > > > transformation is surfacing the problem?
> > > 
> > > Yes, I saw that too. Not sure what the cause could be.
> > > 
> > 
> > Another occurrence, this time with gcc:
> > 
> > https://github.com/robertosassu/vmtest/runs/8230071814?check_suite_focus=true
> > 
> 
> ... and it seems like this run does not even have your patches,
> right?
> 

Uhm, the kernel patches are there. The tests except the verifier ones
weren't successfuly applied, probably due to the deny list.

One thing in common with the failures seems when the panic happens,
when test_progs reaches verif_twfw. I will try to execute this and
earlier tests to reproduce the panic locally.

Roberto

