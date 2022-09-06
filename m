Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623525AE1CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiIFIBZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 04:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiIFIBX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 04:01:23 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF526D9EC;
        Tue,  6 Sep 2022 01:01:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MMHkP10Lcz9v7N7;
        Tue,  6 Sep 2022 15:55:41 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3n5Mh_hZjjTgnAA--.65018S2;
        Tue, 06 Sep 2022 09:00:47 +0100 (CET)
Message-ID: <663480e6bdfd9809c9e367bfc8df95d7a1323723.camel@huaweicloud.com>
Subject: Re: [PATCH v16 06/12] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
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
Date:   Tue, 06 Sep 2022 10:00:30 +0200
In-Reply-To: <CAP01T74HKXuf9Aig4v3zsL1rwQAGRpUtTiaN2djWsMiJmaqF_A@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-7-roberto.sassu@huaweicloud.com>
         <CAP01T74HKXuf9Aig4v3zsL1rwQAGRpUtTiaN2djWsMiJmaqF_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3n5Mh_hZjjTgnAA--.65018S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15ArWrAryUWr4UXF47Jwb_yoWrtw4xpF
        W8CF4rCFWDJFy7Gr93Zw1avF9a9w4vgr17K3srG34kAr9a9rn7Gr4fWF4a93s5Ar4xur1I
        vF1jgw43Cr15ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4KmdgAAsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 04:43 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
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
> 
> With a small nit below,
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> >  include/linux/bpf.h          |   8 +++
> >  include/linux/verification.h |   8 +++
> >  kernel/trace/bpf_trace.c     | 135
> > +++++++++++++++++++++++++++++++++++
> >  3 files changed, 151 insertions(+)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9dbd7c3f8929..f3db614aece6 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2595,4 +2595,12 @@ static inline void bpf_cgroup_atype_get(u32
> > attach_btf_id, int cgroup_atype) {}
> >  static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
> >  #endif /* CONFIG_BPF_LSM */
> > 
> > +struct key;
> > +
> > +#ifdef CONFIG_KEYS
> > +struct bpf_key {
> > +       struct key *key;
> > +       bool has_ref;
> > +};
> > +#endif /* CONFIG_KEYS */
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/include/linux/verification.h
> > b/include/linux/verification.h
> > index a655923335ae..f34e50ebcf60 100644
> > --- a/include/linux/verification.h
> > +++ b/include/linux/verification.h
> > @@ -17,6 +17,14 @@
> >  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
> >  #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
> > 
> > +static inline int system_keyring_id_check(u64 id)
> > +{
> > +       if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * The use to which an asymmetric key is being put.
> >   */
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 68e5cdd24cef..7a7023704ac2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -20,6 +20,8 @@
> >  #include <linux/fprobe.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/sort.h>
> > +#include <linux/key.h>
> > +#include <linux/verification.h>
> > 
> >  #include <net/bpf_sk_storage.h>
> > 
> > @@ -1181,6 +1183,139 @@ static const struct bpf_func_proto
> > bpf_get_func_arg_cnt_proto = {
> >         .arg1_type      = ARG_PTR_TO_CTX,
> >  };
> > 
> > +#ifdef CONFIG_KEYS
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +                 "kfuncs which will be used in BPF programs");
> > +
> > +/**
> > + * bpf_lookup_user_key - lookup a key by its serial
> > + * @serial: key handle serial number
> > + * @flags: lookup-specific flags
> > + *
> > + * Search a key with a given *serial* and the provided *flags*.
> > + * If found, increment the reference count of the key by one, and
> > + * return it in the bpf_key structure.
> > + *
> > + * The bpf_key structure must be passed to bpf_key_put() when done
> > + * with it, so that the key reference count is decremented and the
> > + * bpf_key structure is freed.
> > + *
> > + * Permission checks are deferred to the time the key is used by
> > + * one of the available key-specific kfuncs.
> > + *
> > + * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a
> > requested
> > + * special keyring (e.g. session keyring), if it doesn't yet
> > exist.
> > + * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without
> > waiting
> > + * for the key construction, and to retrieve uninstantiated keys
> > (keys
> > + * without data attached to them).
> > + *
> > + * Return: a bpf_key pointer with a valid key pointer if the key
> > is found, a
> > + *         NULL pointer otherwise.
> > + */
> > +struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> > +{
> > +       key_ref_t key_ref;
> > +       struct bpf_key *bkey;
> > +
> > +       if (flags & ~KEY_LOOKUP_ALL)
> > +               return NULL;
> > +
> > +       /*
> > +        * Permission check is deferred until the key is used, as
> > the
> > +        * intent of the caller is unknown here.
> > +        */
> > +       key_ref = lookup_user_key(serial, flags,
> > KEY_DEFER_PERM_CHECK);
> > +       if (IS_ERR(key_ref))
> > +               return NULL;
> > +
> > +       bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
> 
> Since this function (due to lookup_user_key) is sleepable, do we
> really need GFP_ATOMIC here?

Daniel suggested it for bpf_lookup_system_key(), so that the kfunc does
not have to be sleepable. For symmetry, I did the same to
bpf_lookup_user_key(). Will switch back to GFP_KERNEL.

Thanks

Roberto

