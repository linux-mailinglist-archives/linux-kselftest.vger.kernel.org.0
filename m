Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780585AFCFD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 09:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiIGHAz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 03:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIGHAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 03:00:48 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383596D566;
        Wed,  7 Sep 2022 00:00:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MMtM842RNz9yN0j;
        Wed,  7 Sep 2022 14:56:04 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBX011QQRhjeCYrAA--.25373S2;
        Wed, 07 Sep 2022 07:59:43 +0100 (CET)
Message-ID: <d520738c0a3f7eb13ce9d7c9a0f6f6e18501a495.camel@huaweicloud.com>
Subject: Re: [PATCH v16 06/12] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 07 Sep 2022 08:59:25 +0200
In-Reply-To: <CAADnVQLT9nSEqprcX_hmTeAYGVA9cWupVEfvhnyPuzWwrGKHcQ@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-7-roberto.sassu@huaweicloud.com>
         <CAP01T74HKXuf9Aig4v3zsL1rwQAGRpUtTiaN2djWsMiJmaqF_A@mail.gmail.com>
         <663480e6bdfd9809c9e367bfc8df95d7a1323723.camel@huaweicloud.com>
         <CAADnVQLT9nSEqprcX_hmTeAYGVA9cWupVEfvhnyPuzWwrGKHcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBX011QQRhjeCYrAA--.25373S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWfZrykZw13Cry7tw17Awb_yoWkJFg_Zr
        4xCrZ3Zr1UZF1UGrs8tFW3Xa1qyF1kJF10va48t39xWwsrAF48JFWUCrySvFWfGa1xJa43
        Gws5uFyrX34I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4KxsgABs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 11:45 -0700, Alexei Starovoitov wrote:
> On Tue, Sep 6, 2022 at 1:01 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > > > +struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> > > > +{
> > > > +       key_ref_t key_ref;
> > > > +       struct bpf_key *bkey;
> > > > +
> > > > +       if (flags & ~KEY_LOOKUP_ALL)
> > > > +               return NULL;
> > > > +
> > > > +       /*
> > > > +        * Permission check is deferred until the key is used,
> > > > as
> > > > the
> > > > +        * intent of the caller is unknown here.
> > > > +        */
> > > > +       key_ref = lookup_user_key(serial, flags,
> > > > KEY_DEFER_PERM_CHECK);
> > > > +       if (IS_ERR(key_ref))
> > > > +               return NULL;
> > > > +
> > > > +       bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
> > > 
> > > Since this function (due to lookup_user_key) is sleepable, do we
> > > really need GFP_ATOMIC here?
> > 
> > Daniel suggested it for bpf_lookup_system_key(), so that the kfunc
> > does
> > not have to be sleepable.
> 
> Hold on. It has to be sleepable. Just take a look
> at what lookup_user_key is doing inside.
> 

https://lore.kernel.org/bpf/2b1d62ad-af4b-4694-ecc8-639fbd821a05@iogearbox.net/

Roberto

