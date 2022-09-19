Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CE5BCC9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiISNKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiISNK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 09:10:26 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C217061;
        Mon, 19 Sep 2022 06:10:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWPyn1jNKz9v7gP;
        Mon, 19 Sep 2022 21:04:33 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHA14TaihjId9cAA--.3S2;
        Mon, 19 Sep 2022 14:09:53 +0100 (CET)
Message-ID: <64e8ef59363bcd0f314d4e1eb7483f4dd2b7dbcf.camel@huaweicloud.com>
Subject: Re: [PATCH v17 11/12] selftests/bpf: Add test for
 bpf_verify_pkcs7_signature() kfunc
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 19 Sep 2022 15:09:37 +0200
In-Reply-To: <045a177ebb15bbf406c4c4d75f48dd45e810be8e.camel@huaweicloud.com>
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
         <20220909120736.1027040-12-roberto.sassu@huaweicloud.com>
         <CACYkzJ7uraUdmGV9gMmTZs1OMb_3Q2DttoaxU-irmrXFudOweQ@mail.gmail.com>
         <045a177ebb15bbf406c4c4d75f48dd45e810be8e.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHA14TaihjId9cAA--.3S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7Xw4ftw1UJFWUuF1UAwb_yoW8ZFW3pF
        18Ga1DGr48tr17Gw1Iv3WYqrWxt395Xr1UWr1UX34j9r92qr9rCr4xKrW5ur9IqrZYkr4Y
        v3y2g3ya9rn5u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj4M3uwAAs7
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-09-19 at 13:17 +0200, Roberto Sassu wrote:
> On Thu, 2022-09-15 at 17:11 +0100, KP Singh wrote:
> > On Fri, Sep 9, 2022 at 1:10 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > 
> > [...]
> > 
> > > +}
> > > diff --git
> > > a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > new file mode 100644
> > > index 000000000000..4ceab545d99a
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > > @@ -0,0 +1,100 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> > > + *
> > > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > + */
> > > +
> > > +#include "vmlinux.h"
> > > +#include <errno.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +#define MAX_DATA_SIZE (1024 * 1024)
> > > +#define MAX_SIG_SIZE 1024
> > > +
> > > +typedef __u8 u8;
> > > +typedef __u16 u16;
> > > +typedef __u32 u32;
> > > +typedef __u64 u64;
> > 
> > I think you can avoid this and just use u32 and u64 directly.
> 
> Thanks, yes.
> 
> > +
> > > +struct bpf_dynptr {
> > > +       __u64 :64;
> > > +       __u64 :64;
> > > +} __attribute__((aligned(8)));
> > > +
> > 
> > I think you are doing this because including the uapi headers
> > causes
> > type conflicts.
> > This does happen quite often. What do other folks think about doing
> > something like
> > 
> > #define DYNPTR(x) ((void *)x)
> > 
> > It seems like this will be an issue anytime we use the helpers with
> > vmlinux.h and users
> > will always have to define this type in their tests.
> 
> It seems it is sufficient to use struct bpf_dynptr somehow in the
> kernel code. That causes the definition to be exported with BTF. Not
> sure what would be the proper place to do that. When I tried, I
> declared a unused variable.

Easier:

BTF_TYPE_EMIT(struct bpf_dynptr);

I added it in bpf_dynptr_from_mem(), right?

Thanks

Roberto

