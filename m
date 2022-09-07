Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF05B05D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIGN4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiIGN4m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 09:56:42 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FFADCF1;
        Wed,  7 Sep 2022 06:56:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n202so11504551iod.6;
        Wed, 07 Sep 2022 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xCr5IfXbnWRVy56541cseKXHt2wL8aVLKZHqdZtBKrQ=;
        b=nGRaMBOtAKpvODXCs+1dFgwXrHc3U7hcQ4+ZY6PvcTgT37mkH3DmHaQ2F7jKyaLLHi
         BCcHGazwLdgXjnPpJqaoW2hB8DItHIzoC2oQXYzKbLauTQZenHm13rG7gUzKVHXEvmvK
         UQ8Y12t7KnkNMQY2AYp8yazCQGQhDEDWLcIeuSOFV6HUjVbAq7+WDMDkNspMUiVKtchB
         5KkjRltbPOs/rh9WbRSdW3Zrl3Vp38E2cK1FwP2I+4sXq6S3MsUz/RcETigFiP2fTqdt
         LDL01gOFJf6y5r0txf3rRYkSonMNFQQRsz6skcfgmBI8hh1eoyOv3ImZL0llW2gdPPON
         Uplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xCr5IfXbnWRVy56541cseKXHt2wL8aVLKZHqdZtBKrQ=;
        b=ctgqzJFH/AMKPii5gZY1K87QKe8/3hsTYNb3l/Fkx0zqBQq4s1HsinguDW4+XPVtt1
         RWbgpsbVNevJW3RHzs0mQIDWzRwT7HpQRZTPs/kLZabd86mA/7VTpj8pwmBcsE/tFx49
         xOKFFxDeXtGj0QLFS6EEAqndPjWRAnFEahm5ksXSfAozE8lPkyPpiAk9qWhZp+uS4vrh
         R6A8UrIfZlQLtI6euMdoqfTsHKVcIfpgRRaI7MIOOvzamCPd9bWIIhcK5J3wtAARdOJw
         ovBg+OI2qHPL2kbKREzd+lZwkjA6vqRX526299Z3szf7mmT0KSaJ2eRX2KAGFzgzDn9u
         Mq9A==
X-Gm-Message-State: ACgBeo2jKofeOGQuN/y+dG+ihD19nFLaDLNW+A8diH3cUGjctZjssjvv
        47lVFGCR+61i9upXmirJjUCjQZ86XT5fphKQusA=
X-Google-Smtp-Source: AA6agR6cxEwgSaO5jjVba+NJx99o5zuSNghUNIL7K8pHJ8r4fxQHsHLTdjPOKE90DjrWe4nAoWvjANBQjOGoMlZl4xw=
X-Received: by 2002:a05:6638:2105:b0:34a:694:4fa4 with SMTP id
 n5-20020a056638210500b0034a06944fa4mr2426121jaj.116.1662558992030; Wed, 07
 Sep 2022 06:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <20220905143318.1592015-8-roberto.sassu@huaweicloud.com> <CAP01T77F-A7igW+vp5RhzcqzRJymO6YRvNR2cfsh+2fKNy56YA@mail.gmail.com>
 <3d32decb1fda80e261d9ed08decfdca45614c4af.camel@huaweicloud.com>
 <CAP01T76csO9pdL=KLU4s7M__GnEifmKEB0pb7genw3UN8tA=FQ@mail.gmail.com> <879ed2183ffd0147ca86bb355c03be5dbe19392d.camel@huaweicloud.com>
In-Reply-To: <879ed2183ffd0147ca86bb355c03be5dbe19392d.camel@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 7 Sep 2022 15:55:54 +0200
Message-ID: <CAP01T77y+7tGAUKXzNtchPLKFmWm6PAvxCnwm1Lqqjusj1JbRQ@mail.gmail.com>
Subject: Re: [PATCH v16 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 7 Sept 2022 at 14:20, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Wed, 2022-09-07 at 04:28 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 6 Sept 2022 at 10:08, Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Tue, 2022-09-06 at 04:57 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >
> > > > > Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF
> > > > > security
> > > > > modules
> > > > > the ability to check the validity of a signature against
> > > > > supplied
> > > > > data, by
> > > > > using user-provided or system-provided keys as trust anchor.
> > > > >
> > > > > The new kfunc makes it possible to enforce mandatory policies,
> > > > > as
> > > > > eBPF
> > > > > programs might be allowed to make security decisions only based
> > > > > on
> > > > > data
> > > > > sources the system administrator approves.
> > > > >
> > > > > The caller should provide the data to be verified and the
> > > > > signature
> > > > > as eBPF
> > > > > dynamic pointers (to minimize the number of parameters) and a
> > > > > bpf_key
> > > > > structure containing a reference to the keyring with keys
> > > > > trusted
> > > > > for
> > > > > signature verification, obtained from bpf_lookup_user_key() or
> > > > > bpf_lookup_system_key().
> > > > >
> > > > > For bpf_key structures obtained from the former lookup
> > > > > function,
> > > > > bpf_verify_pkcs7_signature() completes the permission check
> > > > > deferred by
> > > > > that function by calling key_validate(). key_task_permission()
> > > > > is
> > > > > already
> > > > > called by the PKCS#7 code.
> > > > >
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Acked-by: KP Singh <kpsingh@kernel.org>
> > > > > ---
> > > > >  kernel/trace/bpf_trace.c | 45
> > > > > ++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 45 insertions(+)
> > > > >
> > > > > diff --git a/kernel/trace/bpf_trace.c
> > > > > b/kernel/trace/bpf_trace.c
> > > > > index 7a7023704ac2..8e2c026b0a58 100644
> > > > > --- a/kernel/trace/bpf_trace.c
> > > > > +++ b/kernel/trace/bpf_trace.c
> > > > > @@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
> > > > >         kfree(bkey);
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > > > > +/**
> > > > > + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> > > > > + * @data_ptr: data to verify
> > > > > + * @sig_ptr: signature of the data
> > > > > + * @trusted_keyring: keyring with keys trusted for signature
> > > > > verification
> > > > > + *
> > > > > + * Verify the PKCS#7 signature *sig_ptr* against the supplied
> > > > > *data_ptr*
> > > > > + * with keys in a keyring referenced by *trusted_keyring*.
> > > > > + *
> > > > > + * Return: 0 on success, a negative value on error.
> > > > > + */
> > > > > +int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern
> > > > > *data_ptr,
> > > > > +                              struct bpf_dynptr_kern *sig_ptr,
> > > > > +                              struct bpf_key *trusted_keyring)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       if (trusted_keyring->has_ref) {
> > > > > +               /*
> > > > > +                * Do the permission check deferred in
> > > > > bpf_lookup_user_key().
> > > > > +                * See bpf_lookup_user_key() for more details.
> > > > > +                *
> > > > > +                * A call to key_task_permission() here would
> > > > > be
> > > > > redundant, as
> > > > > +                * it is already done by keyring_search()
> > > > > called by
> > > > > +                * find_asymmetric_key().
> > > > > +                */
> > > > > +               ret = key_validate(trusted_keyring->key);
> > > > > +               if (ret < 0)
> > > > > +                       return ret;
> > > > > +       }
> > > > > +
> > > > > +       return verify_pkcs7_signature(data_ptr->data,
> > > > > +                                     bpf_dynptr_get_size(data_
> > > > > ptr)
> > > > > ,
> > > > > +                                     sig_ptr->data,
> > > > > +                                     bpf_dynptr_get_size(sig_p
> > > > > tr),
> > > >
> > > > MIssing check for data_ptr->data == NULL before making this call?
> > > > Same
> > > > for sig_ptr.
> > >
> > > Patch 3 requires the dynptrs to be initialized. Isn't enough?
> > >
> >
> > No, it seems even initialized dynptr can be NULL at runtime. Look at
> > both ringbuf_submit_dynptr and ringbuf_discard_dynptr.
> > The verifier won't know after ringbuf_reserve_dynptr whether it set
> > it
> > to NULL or some valid pointer.
> >
> > dynptr_init is basically that stack slot is now STACK_DYNPTR, it says
> > nothing more about the dynptr.
> >
> > As far as testing this goes, you can pass invalid parameters to
> > ringbuf_reserve_dynptr to have it set to NULL, then make sure your
> > helper returns an error at runtime for it.
>
> I see, thanks.
>
> I did a quick test. Pass 1 as flags argument to bpf_dynptr_from_mem()
> (not supported), and see how bpf_verify_pkcs7_signature() handles it.
>
> Everything seems good, the ASN1 parser called by pkcs7_parse_message()
> correctly handles zero length.
>
> So, I will add just this test, right?
>

Yeah, if it handles it correctly, just adding a test to make sure it
stays that way in the future would be fine.
