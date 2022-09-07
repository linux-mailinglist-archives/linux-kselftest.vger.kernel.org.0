Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B415B03D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIGMUq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGMUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 08:20:43 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142BA99E5;
        Wed,  7 Sep 2022 05:20:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MN1RD4lVdz9xs5w;
        Wed,  7 Sep 2022 20:15:04 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBn411qjBhjxRcsAA--.26101S2;
        Wed, 07 Sep 2022 13:20:09 +0100 (CET)
Message-ID: <879ed2183ffd0147ca86bb355c03be5dbe19392d.camel@huaweicloud.com>
Subject: Re: [PATCH v16 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     joannelkoong@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 07 Sep 2022 14:19:51 +0200
In-Reply-To: <CAP01T76csO9pdL=KLU4s7M__GnEifmKEB0pb7genw3UN8tA=FQ@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-8-roberto.sassu@huaweicloud.com>
         <CAP01T77F-A7igW+vp5RhzcqzRJymO6YRvNR2cfsh+2fKNy56YA@mail.gmail.com>
         <3d32decb1fda80e261d9ed08decfdca45614c4af.camel@huaweicloud.com>
         <CAP01T76csO9pdL=KLU4s7M__GnEifmKEB0pb7genw3UN8tA=FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBn411qjBhjxRcsAA--.26101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xZry7Zw4kAr4fur15Arb_yoWrur48pF
        W8KF4YkrWkJr12yrnFqa1fZF9akrW0qw17W3sxt343ArnYvr17CF18tF4UuF9Ykr18Gryj
        vry0qFy3uw15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4K2DgAAsG
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-09-07 at 04:28 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 6 Sept 2022 at 10:08, Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Tue, 2022-09-06 at 04:57 +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF
> > > > security
> > > > modules
> > > > the ability to check the validity of a signature against
> > > > supplied
> > > > data, by
> > > > using user-provided or system-provided keys as trust anchor.
> > > > 
> > > > The new kfunc makes it possible to enforce mandatory policies,
> > > > as
> > > > eBPF
> > > > programs might be allowed to make security decisions only based
> > > > on
> > > > data
> > > > sources the system administrator approves.
> > > > 
> > > > The caller should provide the data to be verified and the
> > > > signature
> > > > as eBPF
> > > > dynamic pointers (to minimize the number of parameters) and a
> > > > bpf_key
> > > > structure containing a reference to the keyring with keys
> > > > trusted
> > > > for
> > > > signature verification, obtained from bpf_lookup_user_key() or
> > > > bpf_lookup_system_key().
> > > > 
> > > > For bpf_key structures obtained from the former lookup
> > > > function,
> > > > bpf_verify_pkcs7_signature() completes the permission check
> > > > deferred by
> > > > that function by calling key_validate(). key_task_permission()
> > > > is
> > > > already
> > > > called by the PKCS#7 code.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Acked-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  kernel/trace/bpf_trace.c | 45
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 45 insertions(+)
> > > > 
> > > > diff --git a/kernel/trace/bpf_trace.c
> > > > b/kernel/trace/bpf_trace.c
> > > > index 7a7023704ac2..8e2c026b0a58 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
> > > >         kfree(bkey);
> > > >  }
> > > > 
> > > > +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > > > +/**
> > > > + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> > > > + * @data_ptr: data to verify
> > > > + * @sig_ptr: signature of the data
> > > > + * @trusted_keyring: keyring with keys trusted for signature
> > > > verification
> > > > + *
> > > > + * Verify the PKCS#7 signature *sig_ptr* against the supplied
> > > > *data_ptr*
> > > > + * with keys in a keyring referenced by *trusted_keyring*.
> > > > + *
> > > > + * Return: 0 on success, a negative value on error.
> > > > + */
> > > > +int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern
> > > > *data_ptr,
> > > > +                              struct bpf_dynptr_kern *sig_ptr,
> > > > +                              struct bpf_key *trusted_keyring)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       if (trusted_keyring->has_ref) {
> > > > +               /*
> > > > +                * Do the permission check deferred in
> > > > bpf_lookup_user_key().
> > > > +                * See bpf_lookup_user_key() for more details.
> > > > +                *
> > > > +                * A call to key_task_permission() here would
> > > > be
> > > > redundant, as
> > > > +                * it is already done by keyring_search()
> > > > called by
> > > > +                * find_asymmetric_key().
> > > > +                */
> > > > +               ret = key_validate(trusted_keyring->key);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +       }
> > > > +
> > > > +       return verify_pkcs7_signature(data_ptr->data,
> > > > +                                     bpf_dynptr_get_size(data_
> > > > ptr)
> > > > ,
> > > > +                                     sig_ptr->data,
> > > > +                                     bpf_dynptr_get_size(sig_p
> > > > tr),
> > > 
> > > MIssing check for data_ptr->data == NULL before making this call?
> > > Same
> > > for sig_ptr.
> > 
> > Patch 3 requires the dynptrs to be initialized. Isn't enough?
> > 
> 
> No, it seems even initialized dynptr can be NULL at runtime. Look at
> both ringbuf_submit_dynptr and ringbuf_discard_dynptr.
> The verifier won't know after ringbuf_reserve_dynptr whether it set
> it
> to NULL or some valid pointer.
> 
> dynptr_init is basically that stack slot is now STACK_DYNPTR, it says
> nothing more about the dynptr.
> 
> As far as testing this goes, you can pass invalid parameters to
> ringbuf_reserve_dynptr to have it set to NULL, then make sure your
> helper returns an error at runtime for it.

I see, thanks.

I did a quick test. Pass 1 as flags argument to bpf_dynptr_from_mem()
(not supported), and see how bpf_verify_pkcs7_signature() handles it.

Everything seems good, the ASN1 parser called by pkcs7_parse_message()
correctly handles zero length.

So, I will add just this test, right?

Thanks

Roberto

