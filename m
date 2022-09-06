Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39F15AE1ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 10:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiIFII1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 04:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbiIFII0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 04:08:26 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02652E7E;
        Tue,  6 Sep 2022 01:08:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MMHwJ5hqLz9xqvl;
        Tue,  6 Sep 2022 16:04:16 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnYl3P_xZj3EYnAA--.22559S2;
        Tue, 06 Sep 2022 09:07:55 +0100 (CET)
Message-ID: <3d32decb1fda80e261d9ed08decfdca45614c4af.camel@huaweicloud.com>
Subject: Re: [PATCH v16 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, joannelkoong@gmail.com
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
Date:   Tue, 06 Sep 2022 10:07:41 +0200
In-Reply-To: <CAP01T77F-A7igW+vp5RhzcqzRJymO6YRvNR2cfsh+2fKNy56YA@mail.gmail.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-8-roberto.sassu@huaweicloud.com>
         <CAP01T77F-A7igW+vp5RhzcqzRJymO6YRvNR2cfsh+2fKNy56YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnYl3P_xZj3EYnAA--.22559S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rWF4fWw17ZrWftry7Jrb_yoW5ZF1DpF
        W8KF4Y9ry8JF12yF13Za1fua4Sk3yvqw17W3sxt3s3ZrnY9r1xuF18tF45W3sYkry8try2
        vFyIqrya9wn8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4KmiQAAse
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 04:57 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security
> > modules
> > the ability to check the validity of a signature against supplied
> > data, by
> > using user-provided or system-provided keys as trust anchor.
> > 
> > The new kfunc makes it possible to enforce mandatory policies, as
> > eBPF
> > programs might be allowed to make security decisions only based on
> > data
> > sources the system administrator approves.
> > 
> > The caller should provide the data to be verified and the signature
> > as eBPF
> > dynamic pointers (to minimize the number of parameters) and a
> > bpf_key
> > structure containing a reference to the keyring with keys trusted
> > for
> > signature verification, obtained from bpf_lookup_user_key() or
> > bpf_lookup_system_key().
> > 
> > For bpf_key structures obtained from the former lookup function,
> > bpf_verify_pkcs7_signature() completes the permission check
> > deferred by
> > that function by calling key_validate(). key_task_permission() is
> > already
> > called by the PKCS#7 code.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Acked-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 45
> > ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 7a7023704ac2..8e2c026b0a58 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
> >         kfree(bkey);
> >  }
> > 
> > +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > +/**
> > + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> > + * @data_ptr: data to verify
> > + * @sig_ptr: signature of the data
> > + * @trusted_keyring: keyring with keys trusted for signature
> > verification
> > + *
> > + * Verify the PKCS#7 signature *sig_ptr* against the supplied
> > *data_ptr*
> > + * with keys in a keyring referenced by *trusted_keyring*.
> > + *
> > + * Return: 0 on success, a negative value on error.
> > + */
> > +int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
> > +                              struct bpf_dynptr_kern *sig_ptr,
> > +                              struct bpf_key *trusted_keyring)
> > +{
> > +       int ret;
> > +
> > +       if (trusted_keyring->has_ref) {
> > +               /*
> > +                * Do the permission check deferred in
> > bpf_lookup_user_key().
> > +                * See bpf_lookup_user_key() for more details.
> > +                *
> > +                * A call to key_task_permission() here would be
> > redundant, as
> > +                * it is already done by keyring_search() called by
> > +                * find_asymmetric_key().
> > +                */
> > +               ret = key_validate(trusted_keyring->key);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       return verify_pkcs7_signature(data_ptr->data,
> > +                                     bpf_dynptr_get_size(data_ptr)
> > ,
> > +                                     sig_ptr->data,
> > +                                     bpf_dynptr_get_size(sig_ptr),
> 
> MIssing check for data_ptr->data == NULL before making this call?
> Same
> for sig_ptr.

Patch 3 requires the dynptrs to be initialized. Isn't enough?

Thanks

Roberto

