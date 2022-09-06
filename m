Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A825AE138
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbiIFHgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 03:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiIFHgl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 03:36:41 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0AA54659;
        Tue,  6 Sep 2022 00:36:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MMHCf3DkZz9v7cH;
        Tue,  6 Sep 2022 15:32:30 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3pF5Y+BZjCS8nAA--.46254S2;
        Tue, 06 Sep 2022 08:36:08 +0100 (CET)
Message-ID: <b846cedb14235db6950a55e7eec2eff9e9ab56ec.camel@huaweicloud.com>
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
Date:   Tue, 06 Sep 2022 09:35:49 +0200
In-Reply-To: <CAP01T77aq-UP02JYp1Vu-LE--K1ieCyfKfyZPw-a7DDKQ7_F+g@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <CAP01T77aq-UP02JYp1Vu-LE--K1ieCyfKfyZPw-a7DDKQ7_F+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwB3pF5Y+BZjCS8nAA--.46254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFykXF18ZrykKw1UWw4xCrg_yoW8Ar4fpF
        W0yFy5KFWDtF17C3yfK3yfGFW5t395G3W2gwnYy34YvFn0gr1SkrWxtr43WFWj9rykCrya
        v39xKFy7ArWDAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4KmIwAAs0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-09-05 at 21:26 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 Sept 2022 at 16:34, Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > One of the desirable features in security is the ability to
> > restrict import
> > of data to a given system based on data authenticity. If data
> > import can be
> > restricted, it would be possible to enforce a system-wide policy
> > based on
> > the signing keys the system owner trusts.
> > 
> > This feature is widely used in the kernel. For example, if the
> > restriction
> > is enabled, kernel modules can be plugged in only if they are
> > signed with a
> > key whose public part is in the primary or secondary keyring.
> > 
> > For eBPF, it can be useful as well. For example, it might be useful
> > to
> > authenticate data an eBPF program makes security decisions on.
> > 
> > [...]
> 
> CI is crashing with NULL deref for test_progs-no_alu32 with llvm-16,
> but I don't think the problem is in this series. This is most likely
> unrelated to BPF, as the crash happens inside
> kernel/time/tick-sched.c:tick_nohz_restart_sched_tick.
> 
> This was the same case in
> https://lore.kernel.org/bpf/CAP01T74steDfP6O8QOshoto3e3RnHhKtAeTbnrPBZS3YJXjvbA@mail.gmail.com.
> 
> So, 
> https://github.com/kernel-patches/bpf/runs/8194263557?check_suite_focus=true
> and 
> https://github.com/kernel-patches/bpf/runs/7982907380?check_suite_focus=true
> 
> look similar to me, and may not be related to BPF. They only trigger
> during runs compiled using LLVM 16, so maybe some compiler
> transformation is surfacing the problem?

Yes, I saw that too. Not sure what the cause could be.

Thanks

Roberto

