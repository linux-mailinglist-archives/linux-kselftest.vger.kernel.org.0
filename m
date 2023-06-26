Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AAC73EAB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjFZS6Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjFZS6W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 14:58:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D5110F4
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:58:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401f4408955so30011cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687805887; x=1690397887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4GUf7WeVm/hCddlw+w8yOJbmt8xnvBLWi12UWuji0U=;
        b=vdz0Dez2/lTX+zwCQBUkHXRY4x+j0rrOwJn7wLjLQlvRHqWprVuuRGKne6jokvw9eh
         HySS8P0q7Z7ygKsrdYvyPEpBnB1lbPekjkPgvXf5XUjHSR5AUiopy2Q2rBpFOBpIslPH
         /qB31zsJGxoHLKO20m1Be74yBCvTCIiIrxOKRzyMnf07NBaZfpS7Gz2pl28keRb0SY3W
         NxT2Z69DjhitkCu/f2cwmjsrMFkQLOBZs0hC12APZuQ07jelCwO+MG54pLgBne6o39fL
         a77ZTRGJ2Nrhotzyq2FL8dQs761op3qMna/9PD06VPt6yGs8glzLbPkUPrXQOUdWzdYq
         1vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805887; x=1690397887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4GUf7WeVm/hCddlw+w8yOJbmt8xnvBLWi12UWuji0U=;
        b=AKnb11mfNZkzQDrBuJdc9LMQzJ4R20VFxVcBzk+EfuGvo++rKg+3/qKLhjM+ryaBri
         4T/NODZcVm1Xwh0De3eOaFc7y5nTzjSTkj3swrzDctxSKUXpw2Ilo53jcqIE3lgueEr1
         NPCfN4f5JzFQ1+4T/VUCjdWEU4++XmdDbV7wTyFubkHj+p52OB6fgUWBhYk0OFtiDZxg
         pcNZhp47HoQHcAdnsBaDdqNwxktASxeQk4GTNJXd21Ilpp6lf4o2WT9+YMqdKbL1+0Bc
         fTmJyZlcPeKD27m9s65/zfFyvV3thsZuVQpHtbqpA0kRs2RMKaeQu2FuykLT2Ba+XmLv
         Q0UA==
X-Gm-Message-State: AC+VfDxw8PN14n3p1AsTjfS43FYqyUlcE6FFxNOBe/HzMCYIPytpraDq
        tp76gk9vNItErFI67t2l7U5jPWrM9xaFmXpJEI1BdA==
X-Google-Smtp-Source: ACHHUZ7CYlGUHng5/0i+SjbkzbOGxMG59lgVDNnwFmM0pQRy0KC0IODREJ/9nPvMXwcwHgqCfj2vlaz02bG/kroyCkQ=
X-Received: by 2002:ac8:57c5:0:b0:3f9:f877:1129 with SMTP id
 w5-20020ac857c5000000b003f9f8771129mr450561qta.29.1687805887403; Mon, 26 Jun
 2023 11:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch> <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
In-Reply-To: <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 26 Jun 2023 11:57:55 -0700
Message-ID: <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation feature
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, brijesh.singh@amd.com, atishp@rivosinc.com,
        gregkh@linuxfoundation.org, linux-coco@lists.linux.dev,
        joey.gouly@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 25, 2023 at 8:06=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Dan,
>
> On 6/23/23 3:27 PM, Dan Williams wrote:
> > Dan Williams wrote:
> >> [ add David, Brijesh, and Atish]
> >>
> >> Kuppuswamy Sathyanarayanan wrote:
> >>> In TDX guest, the second stage of the attestation process is Quote
> >>> generation. This process is required to convert the locally generated
> >>> TDREPORT into a remotely verifiable Quote. It involves sending the
> >>> TDREPORT data to a Quoting Enclave (QE) which will verify the
> >>> integrity of the TDREPORT and sign it with an attestation key.
> >>>
> >>> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> >>> allow the user agent to get the TD Quote.
> >>>
> >>> Add a kernel selftest module to verify the Quote generation feature.
> >>>
> >>> TD Quote generation involves following steps:
> >>>
> >>> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> >>> * Embed the TDREPORT data in quote buffer and request for quote
> >>>   generation via TDX_CMD_GET_QUOTE IOCTL request.
> >>> * Upon completion of the GetQuote request, check for non zero value
> >>>   in the status field of Quote header to make sure the generated
> >>>   quote is valid.
> >>
> >> What this cover letter does not say is that this is adding another
> >> instance of the similar pattern as SNP_GET_REPORT.
> >>
> >> Linux is best served when multiple vendors trying to do similar
> >> operations are brought together behind a common ABI. We see this in th=
e
> >> history of wrangling SCSI vendors behind common interfaces. Now multip=
le
> >> confidential computing vendors trying to develop similar flows with
> >> differentiated formats where that differentiation need not leak over t=
he
> >> ABI boundary.
> > [..]
> >
> > Below is a rough mock up of this approach to demonstrate the direction.
> > Again, the goal is to define an ABI that can support any vendor's
> > arch-specific attestation method and key provisioning flows without
> > leaking vendor-specific details, or confidential material over the
> > user/kernel ABI.
>
> Thanks for working on this mock code and helping out. It gives me the
> general idea about your proposal.
>
> >
> > The observation is that there are a sufficient number of attestation
> > flows available to review where Linux can define a superset ABI to
> > contain them all. The other observation is that the implementations hav=
e
> > features that may cross-polinate over time. For example the SEV
> > privelege level consideration ("vmpl"), and the TDX RTMR (think TPM
> > PCRs) mechanisms address generic Confidential Computing use cases.
>
>
> I agree with your point about VMPL and RTMR feature cases. This observati=
on
> is valid for AMD SEV and TDX attestation flows. But I am not sure whether
> it will hold true for other vendor implementations. Our sample set is not
> good enough to make this conclusion. The reason for my concern is, if you
> check the ABI interface used in the S390 arch attestation driver
> (drivers/s390/char/uvdevice.c), you would notice that there is a signific=
ant
> difference between the ABI used in that driver and SEV/TDX drivers. The S=
390
> driver attestation request appears to accept two data blobs as input, as =
well
> as a variety of vendor-specific header configurations.
>
> Maybe the s390 attestation model is a special case, but, I think we consi=
der
> this issue. Since we don't have a common spec, there is chance that any
> superset ABI we define now may not meet future vendor requirements. One w=
ay to
> handle it to leave enough space in the generic ABI to handle future vendo=
r
> requirements.
>
> I think it would be better if other vendors (like ARM or RISC) can commen=
t and
> confirm whether this proposal meets their demands.
>

The VMPL-based separation that will house the supervisor module known
as SVSM can have protocols that implement a TPM command interface, or
an RTMR-extension interface, and will also need to have an
SVSM-specific protocol attestation report format to keep the secure
chain of custody apparent. We'd have different formats and protocols
in the kernel, at least, to speak to each technology. I'm not sure
it's worth the trouble of papering over all the... 3-4 technologies
with similar but still weirdly different formats and ways of doing
things with an abstracted attestation ABI, especially since the output
all has to be interpreted in an architecture-specific way anyway.

ARM's Confidential Computing Realm Management Extensions (RME) seems
to be going along the lines of a runtime measurement register model
with their hardware enforced security. The number of registers isn't
prescribed in the spec.

+Joey Gouly +linux-coco@lists.linux.dev as far as RME is concerned, do
you know who would be best to weigh in on this discussion of a unified
attestation model?

> >
> > Vendor specific ioctls for all of this feels like surrender when Linux
> > already has the keys subsystem which has plenty of degrees of freedom
> > for tracking blobs with signatures and using those blobs to instantiate
> > other blobs. It already serves as the ABI wrapping various TPM
> > implementations and marshaling keys for storage encryption and other us=
e
> > cases that intersect Confidential Computing.
> >
> > The benefit of deprecating vendor-specific abstraction layers in
> > userspace is secondary. The primary benefit is collaboration. It enable=
s
> > kernel developers from various architectures to collaborate on common
> > infrastructure. If, referring back to my previous example, SEV adopts a=
n
> > RTMR-like mechanism and TDX adopts a vmpl-like mechanism it would be
> > unfortunate if those efforts were siloed, duplicated, and needlessly
> > differentiated to userspace. So while there are arguably a manageable
> > number of basic arch attestation methods the planned expansion of those
> > to build incremental functionality is where I believe we, as a
> > community, will be glad that we invested in a "Linux format" for all of
> > this.
> >
> > An example, to show what the strawman patch below enables: (req_key is
> > the sample program from "man 2 request_key")
> >
> > # ./req_key guest_attest guest_attest:0:0-$desc $(cat user_data | base6=
4)
> > Key ID is 10e2f3a7
> > # keyctl pipe 0x10e2f3a7 | hexdump -C
> > 00000000  54 44 58 20 47 65 6e 65  72 61 74 65 64 20 51 75  |TDX Genera=
ted Qu|
> > 00000010  6f 74 65 00 00 00 00 00  00 00 00 00 00 00 00 00  |ote.......=
......|
> > 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..........=
......|
> > *
> > 00004000
> >
> > This is the kernel instantiating a TDX Quote without the TDREPORT
> > implementation detail ever leaving the kernel. Now, this is only the
>
> IIUC, the idea here is to cache the quote data and return it to the user =
whenever
> possible, right? If yes, I think such optimization may not be very useful=
 for our
> case. AFAIK, the quote data will change whenever there is a change in the=
 guest
> measurement data. Since the validity of the generated quote will not be l=
ong,
> and the frequency of quote generation requests is expected to be less, we=
 may not
> get much benefit from caching the quote data. I think we can keep this lo=
gic simple
> by directly retrieving the quote data from the quoting enclave whenever t=
here is a
> request from the user.
>
> > top-half of what is needed. The missing bottom half takes that material
> > and uses it to instantiate derived key material like the storage
> > decryption key internal to the kernel. See "The Process" in
> > Documentation/security/keys/request-key.rst for how the Keys subsystem
> > handles the "keys for keys" use case.
>
> This is only useful for key-server use case, right? Attestation can also =
be
> used for use cases like pattern matching or uploading some secure data, e=
tc.
> Since key-server is not the only use case, does it make sense to suppport
> this derived key feature?
>
> >
> > ---
> > diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> > index f79ab13a5c28..0f775847028e 100644
> > --- a/drivers/virt/Kconfig
> > +++ b/drivers/virt/Kconfig
> > @@ -54,4 +54,8 @@ source "drivers/virt/coco/sev-guest/Kconfig"
> >
> >  source "drivers/virt/coco/tdx-guest/Kconfig"
> >
> > +config GUEST_ATTEST
> > +     tristate
> > +     select KEYS
> > +
> >  endif
> > diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> > index e9aa6fc96fab..66f6b838f8f4 100644
> > --- a/drivers/virt/Makefile
> > +++ b/drivers/virt/Makefile
> > @@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)              +=3D acrn/
> >  obj-$(CONFIG_EFI_SECRET)     +=3D coco/efi_secret/
> >  obj-$(CONFIG_SEV_GUEST)              +=3D coco/sev-guest/
> >  obj-$(CONFIG_INTEL_TDX_GUEST)        +=3D coco/tdx-guest/
> > +obj-$(CONFIG_GUEST_ATTEST)   +=3D coco/guest-attest/
> > diff --git a/drivers/virt/coco/guest-attest/Makefile b/drivers/virt/coc=
o/guest-attest/Makefile
> > new file mode 100644
> > index 000000000000..5581c5a27588
> > --- /dev/null
> > +++ b/drivers/virt/coco/guest-attest/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_GUEST_ATTEST) +=3D guest_attest.o
> > +guest_attest-y :=3D key.o
> > diff --git a/drivers/virt/coco/guest-attest/key.c b/drivers/virt/coco/g=
uest-attest/key.c
> > new file mode 100644
> > index 000000000000..2a494b6dd7a7
> > --- /dev/null
> > +++ b/drivers/virt/coco/guest-attest/key.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +#include <linux/seq_file.h>
> > +#include <linux/key-type.h>
> > +#include <linux/module.h>
> > +#include <linux/base64.h>
> > +
> > +#include <keys/request_key_auth-type.h>
> > +#include <keys/user-type.h>
> > +
> > +#include "guest-attest.h"
>
> Can you share you guest-attest.h?
>
> > +
> > +static LIST_HEAD(guest_attest_list);
> > +static DECLARE_RWSEM(guest_attest_rwsem);
> > +
> > +static struct guest_attest_ops *fetch_ops(void)
> > +{
> > +     return list_first_entry_or_null(&guest_attest_list,
> > +                                     struct guest_attest_ops, list);
> > +}
> > +
> > +static struct guest_attest_ops *get_ops(void)
> > +{
> > +     down_read(&guest_attest_rwsem);
> > +     return fetch_ops();
> > +}
> > +
> > +static void put_ops(void)
> > +{
> > +     up_read(&guest_attest_rwsem);
> > +}
> > +
> > +int register_guest_attest_ops(struct guest_attest_ops *ops)
> > +{
> > +     struct guest_attest_ops *conflict;
> > +     int rc;
> > +
> > +     down_write(&guest_attest_rwsem);
> > +     conflict =3D fetch_ops();
> > +     if (conflict) {
> > +             pr_err("\"%s\" ops already registered\n", conflict->name)=
;
> > +             rc =3D -EEXIST;
> > +             goto out;
> > +     }
> > +     list_add(&ops->list, &guest_attest_list);
> > +     try_module_get(ops->module);
> > +     rc =3D 0;
> > +out:
> > +     up_write(&guest_attest_rwsem);
> > +     return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(register_guest_attest_ops);
> > +
> > +void unregister_guest_attest_ops(struct guest_attest_ops *ops)
> > +{
> > +     down_write(&guest_attest_rwsem);
> > +     list_del(&ops->list);
> > +     up_write(&guest_attest_rwsem);
> > +     module_put(ops->module);
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_guest_attest_ops);
> > +
> > +static int __guest_attest_request_key(struct key *key, int level,
> > +                                   struct key *dest_keyring,
> > +                                   const char *callout_info, int callo=
ut_len,
> > +                                   struct key *authkey)
> > +{
> > +     struct guest_attest_ops *ops;
> > +     void *payload =3D NULL;
> > +     int rc, payload_len;
> > +
> > +     ops =3D get_ops();
> > +     if (!ops)
> > +             return -ENOKEY;
> > +
> > +     payload =3D kzalloc(max(GUEST_ATTEST_DATALEN, callout_len), GFP_K=
ERNEL);
> > +     if (!payload) {
> > +             rc =3D -ENOMEM;
> > +             goto out;
> > +     }
>
> Is the idea to get the values like vmpl part of the payload?
>
> > +
> > +     payload_len =3D base64_decode(callout_info, callout_len, payload)=
;
> > +     if (payload_len < 0 || payload_len > GUEST_ATTEST_DATALEN) {
> > +             rc =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     rc =3D ops->request_attest(key, level, dest_keyring, payload, pay=
load_len,
> > +                              authkey);
> > +out:
> > +     kfree(payload);
> > +     put_ops();
> > +     return rc;
> > +}
> > +
> > +static int guest_attest_request_key(struct key *authkey, void *data)
> > +{
> > +     struct request_key_auth *rka =3D get_request_key_auth(authkey);
> > +     struct key *key =3D rka->target_key;
> > +     unsigned long long id;
> > +     int rc, level;
> > +
> > +     pr_debug("desc: %s op: %s callout: %s\n", key->description, rka->=
op,
> > +              rka->callout_info ? (char *)rka->callout_info : "\"none\=
"");
> > +
> > +     if (sscanf(key->description, "guest_attest:%d:%llu", &level, &id)=
 !=3D 2)
> > +             return -EINVAL;
> > +
>
> Can you explain some details about the id and level? It is not very clear=
 why
> we need it.
>
> > +     if (!rka->callout_info) {
> > +             rc =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     rc =3D __guest_attest_request_key(key, level, rka->dest_keyring,
> > +                                     rka->callout_info, rka->callout_l=
en,
> > +                                     authkey);
> > +out:
> > +     complete_request_key(authkey, rc);
> > +     return rc;
> > +}
> > +
> > +static int guest_attest_vet_description(const char *desc)
> > +{
> > +     unsigned long long id;
> > +     int level;
> > +
> > +     if (sscanf(desc, "guest_attest:%d:%llu", &level, &id) !=3D 2)
> > +             return -EINVAL;
> > +     return 0;
> > +}
> > +
> > +static struct key_type key_type_guest_attest =3D {
> > +     .name =3D "guest_attest",
> > +     .preparse =3D user_preparse,
> > +     .free_preparse =3D user_free_preparse,
> > +     .instantiate =3D generic_key_instantiate,
> > +     .revoke =3D user_revoke,
> > +     .destroy =3D user_destroy,
> > +     .describe =3D user_describe,
> > +     .read =3D user_read,
> > +     .vet_description =3D guest_attest_vet_description,
> > +     .request_key =3D guest_attest_request_key,
> > +};
> > +
> > +static int __init guest_attest_init(void)
> > +{
> > +     return register_key_type(&key_type_guest_attest);
> > +}
> > +
> > +static void __exit guest_attest_exit(void)
> > +{
> > +     unregister_key_type(&key_type_guest_attest);
> > +}
> > +
> > +module_init(guest_attest_init);
> > +module_exit(guest_attest_exit);
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/td=
x-guest/Kconfig
> > index 14246fc2fb02..9a1ec85369fe 100644
> > --- a/drivers/virt/coco/tdx-guest/Kconfig
> > +++ b/drivers/virt/coco/tdx-guest/Kconfig
> > @@ -1,6 +1,7 @@
> >  config TDX_GUEST_DRIVER
> >       tristate "TDX Guest driver"
> >       depends on INTEL_TDX_GUEST
> > +     select GUEST_ATTEST
> >       help
> >         The driver provides userspace interface to communicate with
> >         the TDX module to request the TDX guest details like attestatio=
n
> > diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coc=
o/tdx-guest/tdx-guest.c
> > index 388491fa63a1..65b5aab284d9 100644
> > --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> > +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > @@ -13,11 +13,13 @@
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/set_memory.h>
> > +#include <linux/key-type.h>
> >
> >  #include <uapi/linux/tdx-guest.h>
> >
> >  #include <asm/cpu_device_id.h>
> >  #include <asm/tdx.h>
> > +#include "../guest-attest/guest-attest.h"
> >
> >  /*
> >   * Intel's SGX QE implementation generally uses Quote size less
> > @@ -229,6 +231,62 @@ static const struct x86_cpu_id tdx_guest_ids[] =3D=
 {
> >  };
> >  MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> >
> > +static int tdx_request_attest(struct key *key, int level,
> > +                           struct key *dest_keyring, void *payload,
> > +                           int payload_len, struct key *authkey)
> > +{
> > +     u8 *tdreport;
> > +     long ret;
> > +
> > +     tdreport =3D kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
> > +     if (!tdreport)
> > +             return -ENOMEM;
> > +
> > +     /* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
> > +     ret =3D tdx_mcall_get_report0(payload, tdreport);
> > +     if (ret)
> > +             goto out;
> > +
> > +     mutex_lock(&quote_lock);
> > +
> > +     memset(qentry->buf, 0, qentry->buf_len);
> > +     reinit_completion(&qentry->compl);
> > +     qentry->valid =3D true;
> > +
> > +     /* Submit GetQuote Request using GetQuote hyperetall */
> > +     ret =3D tdx_hcall_get_quote(qentry->buf, qentry->buf_len);
> > +     if (ret) {
> > +             pr_err("GetQuote hyperetall failed, status:%lx\n", ret);
> > +             ret =3D -EIO;
> > +             goto quote_failed;
> > +     }
> > +
> > +     /*
> > +      * Although the GHCI specification does not state explicitly that
> > +      * the VMM must not wait indefinitely for the Quote request to be
> > +      * completed, a sane VMM should always notify the guest after a
> > +      * certain time, regardless of whether the Quote generation is
> > +      * successful or not.  For now just assume the VMM will do so.
> > +      */
> > +     wait_for_completion(&qentry->compl);
> > +
> > +     ret =3D key_instantiate_and_link(key, qentry->buf, qentry->buf_le=
n,
> > +                                    dest_keyring, authkey);
> > +
> > +quote_failed:
> > +     qentry->valid =3D false;
> > +     mutex_unlock(&quote_lock);
> > +out:
> > +     kfree(tdreport);
> > +     return ret;
> > +}
> > +
> > +static struct guest_attest_ops tdx_attest_ops =3D {
> > +     .name =3D KBUILD_MODNAME,
> > +     .module =3D THIS_MODULE,
> > +     .request_attest =3D tdx_request_attest,
> > +};
> > +
> >  static int __init tdx_guest_init(void)
> >  {
> >       int ret;
> > @@ -251,8 +309,14 @@ static int __init tdx_guest_init(void)
> >       if (ret)
> >               goto free_quote;
> >
> > +     ret =3D register_guest_attest_ops(&tdx_attest_ops);
> > +     if (ret)
> > +             goto free_irq;
> > +
> >       return 0;
> >
> > +free_irq:
> > +     tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
> >  free_quote:
> >       free_quote_entry(qentry);
> >  free_misc:
> > @@ -264,6 +328,7 @@ module_init(tdx_guest_init);
> >
> >  static void __exit tdx_guest_exit(void)
> >  {
> > +     unregister_guest_attest_ops(&tdx_attest_ops);
> >       tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
> >       free_quote_entry(qentry);
> >       misc_deregister(&tdx_misc_dev);
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer



--
-Dionna Glaze, PhD (she/her)
