Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455F5A21AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiHZHWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiHZHWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:22:12 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37302C10A;
        Fri, 26 Aug 2022 00:22:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MDWNZ51Pzz9v7Gh;
        Fri, 26 Aug 2022 15:16:46 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnthJ4dAhj+iNOAA--.37625S2;
        Fri, 26 Aug 2022 08:21:41 +0100 (CET)
Message-ID: <67c4a5e7cf363a6c9b79a436690c4c3f469652de.camel@huaweicloud.com>
Subject: Re: [PATCH v13 05/10] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Daniel =?ISO-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 26 Aug 2022 09:21:25 +0200
In-Reply-To: <CAPhsuW5iVRSCQsMRC7bGHw=ZHW1Y7y0SccQG-i-7=umHF2yJEQ@mail.gmail.com>
References: <20220823150035.711534-1-roberto.sassu@huaweicloud.com>
         <20220823150035.711534-6-roberto.sassu@huaweicloud.com>
         <CAPhsuW5iVRSCQsMRC7bGHw=ZHW1Y7y0SccQG-i-7=umHF2yJEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDnthJ4dAhj+iNOAA--.37625S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUZry5Jw4ftr1fCF4fGrg_yoW8XF1fpF
        W8CF4FkFs5Ka47CF9av3WavrySgw4v9r17K3srWr1Utr9Fkr1kGr4kCr4a9ry5Arn29r18
        WryYgF43Cry5Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
        CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj35RKgABsj
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-08-25 at 22:56 -0700, Song Liu wrote:
> On Tue, Aug 23, 2022 at 8:02 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the bpf_lookup_user_key(), bpf_lookup_system_key() and
> > bpf_key_put()
> > kfuncs, to respectively search a key with a given key handle serial
> > number
> > and flags, obtain a key from a pre-determined ID defined in
> > include/linux/verification.h, and cleanup.
> > 
> > Introduce system_keyring_id_check() to validate the keyring ID
> > parameter of
> > bpf_lookup_system_key().
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/bpf.h          |   6 ++
> >  include/linux/verification.h |   8 +++
> >  kernel/trace/bpf_trace.c     | 135
> > +++++++++++++++++++++++++++++++++++
> >  3 files changed, 149 insertions(+)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 6041304b402e..991da09a5858 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2586,4 +2586,10 @@ static inline void bpf_cgroup_atype_get(u32
> > attach_btf_id, int cgroup_atype) {}
> >  static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
> >  #endif /* CONFIG_BPF_LSM */
> > 
> > +#ifdef CONFIG_KEYS
> 
> Do we need to declare struct key here?
> 
> > +struct bpf_key {
> > +       struct key *key;
> > +       bool has_ref;
> > +};
> > +#endif /* CONFIG_KEYS */
> >  #endif /* _LINUX_BPF_H */
> > 

If there is a better place, I will move there.

Thanks

Roberto

