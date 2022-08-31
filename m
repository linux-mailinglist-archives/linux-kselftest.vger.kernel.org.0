Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C745A8281
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiHaP5A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiHaP4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 11:56:40 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793ABFEBE;
        Wed, 31 Aug 2022 08:56:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MHpYS0HrPz9xHv8;
        Wed, 31 Aug 2022 23:50:52 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3n5N7hA9jAUoRAA--.35375S2;
        Wed, 31 Aug 2022 16:55:52 +0100 (CET)
Message-ID: <827bd5dc3b1ee88b14af53f4575da1b62c8ae452.camel@huaweicloud.com>
Subject: Re: [PATCH v14 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and set KEY_LOOKUP_FLAGS_ALL
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        David Howells <dhowells@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel =?ISO-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 31 Aug 2022 17:55:35 +0200
In-Reply-To: <CAADnVQLCyts0JZ7_=rTp8vP67ET4PjVsZ0Cis0XKUpeCdC13LA@mail.gmail.com>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
         <20220830161716.754078-6-roberto.sassu@huaweicloud.com>
         <Yw7NKJfhyJqIWUcx@kernel.org> <Yw7o43Ivfo3jRwQg@kernel.org>
         <cad9a20cadc074cf15dcd0d8eb63b43c98a2f13d.camel@huaweicloud.com>
         <CAADnVQLCyts0JZ7_=rTp8vP67ET4PjVsZ0Cis0XKUpeCdC13LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3n5N7hA9jAUoRAA--.35375S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4xtw48Kw1fGF17Jr45trb_yoWxZFb_Ar
        yrArs3Jrn7CFWktF90g3s7GFZrJF1UJr1fX3Z8Kw4ak398JF4Utr4F9ryfXrZ5Ka1fXFZ5
        Gr45GF9aqa42gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj356zAAAs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-08-31 at 08:33 -0700, Alexei Starovoitov wrote:
> On Wed, Aug 31, 2022 at 2:24 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > > > > +#define KEY_LOOKUP_CREATE        0x01
> > > > > +#define KEY_LOOKUP_PARTIAL       0x02
> > > > > +#define KEY_LOOKUP_FLAGS_ALL     (KEY_LOOKUP_CREATE |
> > > > > KEY_LOOKUP_PARTIAL)
> > > > 
> > > > IMHO this could be just KEY_LOOKUP_ALL.
> 
> Since this is supposed to be kernel internal flags
> please make them enum, so that bpf progs can auto-adjust
> (with the help of CORE) to changes in this enum.
> With #define there is no way for bpf prog to know
> when #define changed in the future kernels.

Ok, will add in the next version.

Thanks

Roberto

