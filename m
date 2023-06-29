Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C085742A9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjF2QZk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF2QZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 12:25:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC805CF
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 09:25:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40079620a83so369121cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688055933; x=1690647933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i+VclhX9JPA4GYKeZEUom4kBRpZ1KIdf8SKnr6Czlk=;
        b=lYYVQ83POTy6/9CC8ArxHOFEL2r2JwFNPyDWX+P2beZLfK82lg/k/QqEiUVFBWPCgo
         VmeFAKZKkCzoVlfdqlFTWDVXzNRikIvKionHxYyx1RSL88UsmNo8BH8U5k4Ylma7/sDh
         fFxg/9wDt+eK/72umGrPtF/2wN9RReAjVAYHDHF+jMx84TJyhn8POoLRKrvz4TWF4ue2
         xConQRz9n8xU9Z1SHa8AjD9LE8dgnrIp5+7GRd7o73hkXnik5wnoetttJyzpknEMpT7k
         2xQaj+QRos+VqCRitgTeAx6UoB6HGVgOG0bXdQSF6Hb1YkYFFLJr83x3QjwHOLu8PcZg
         hSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055933; x=1690647933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i+VclhX9JPA4GYKeZEUom4kBRpZ1KIdf8SKnr6Czlk=;
        b=ZnLSc3VpOqB1NDjwb+5ka9tSALZieGKwpcCUrMG6iccHs21JHHc4B6sIIphAD8I8jn
         wM66lCzUIQsiYAFlNdDmo2yi3dH/JiXui5LhGfgeHYLGs+p14J8aHkfY2SIB3sY/skvp
         5jnyU3lPs10qS0y7Efk9LG24VyGZIz5iB90SlK+CW+HibOFJKM7xhzOBgdLSL6tWPndp
         kPuG61TPO77EHag9Q65ZLBfYHUK4XwOkDYe61gphZI/h5WtLK8czsxrBtyLJnRpkszZu
         9sJLIgQTIktmuGm0phZVC1L66a7Qe3XJ3xOFYgA4orprT9xmyO4MrPHeMuzuufalqymS
         ewww==
X-Gm-Message-State: AC+VfDyWgVMsuWgGpnb0ygPwZVWQXdVu3D7rMI1JnXVw7VkpI1naC4+8
        bHU9+C21FKlLmgEY+5Z+MEBa9GWFBS+UjpHEfDVXzQ==
X-Google-Smtp-Source: ACHHUZ4GlcdhSG6HvWkFXq7A7do/fjnsIN9VLRkINS6bTK3+6Z8sQeiMBbqJ2leEce8ozWN8saz37CEHTk7PdmgSBCQ=
X-Received: by 2002:ac8:5b46:0:b0:3f7:ffc8:2f6f with SMTP id
 n6-20020ac85b46000000b003f7ffc82f6fmr703437qtw.28.1688055932634; Thu, 29 Jun
 2023 09:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com> <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com> <649ba059a086_11e68529458@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <649ba059a086_11e68529458@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 29 Jun 2023 09:25:21 -0700
Message-ID: <CAAH4kHYLETfPk-sMD-QSJd0fJ7Qnt04FBwFuEkpnehB5U7D_yw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation feature
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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

>
> First, thank you for engaging, it speeds up the iteration. This
> confirmed my worry that the secondary goal of this proposal, a common
> verification implementation, is indeed unachievable in the near term. A
> few clarifying questions below, but I will let this go.
>
> The primary goal, achievable on a short runway, is more for kernel
> developers. It is to have a common infrastructure for marshaling vendor
> payloads, provide a mechanism to facilitate kernel initiated requests to
> a key-server, and to deploy a common frontend for concepts like runtime
> measurement (likely as another backend to what Keys already understands
> for various TPM PCR implementations).
>

That sounds good, though the devil is in the details. The TPM
situation will be exacerbated by a lower root of trust. The TPM itself
doesn't have a specification for its own attested firmware.

> > All the specific fields of the blob have to be decoded and subjected
> > to an acceptance policy. That policy will most always be different
> > across different platforms and VM owners. I wrote all of
> > github.com/google/go-sev-guest, including the verification and
> > validation logic, and it's going to get more complicated, and the
> > sources of the data that provide validators with notions of what
> > values can be trusted will be varied.
>
> Can you provide an example? I ask only to include it in the kernel
> commit log for a crisp explanation why this proposed Keys format will
> continue to convey a raw vendor blob with no kernel abstraction as part
> of its payload for the foreseeable future.
>

An example is that while there is a common notion that each report
will have some attestation key whose certificate needs to be verified,
there is additional collateral that must be downloaded to

* verify a TDX key certificate against updates to known weaknesses of
the key's details
* verify the measurement in the report against a vendor's signed
golden measurement
* [usually offline and signed by the analyzing principal that the
analysis was done] fully verify the measurement given a build
provenance document like SLSA. The complexity of this analysis could
even engage in static analysis of every commit since a certain date,
or from a developer of low repute... whatever the verifier wants to
do.

These are all in the realm of interpreting the blob for acceptance, so
it's best to keep uninterpreted.

> > The formats are not standardized. The Confidential Computing
> > Consortium should be working toward that, but it's a slow process.
> > There's IETF RATS. There's in-toto.io attestations. There's Azure's
> > JWT thing. There's a signed serialized protocol buffer that I've
> > decided is what Google is going to produce while we figure out all the
> > "right" formats to use. There will be factions and absolute gridlock
> > for multiple years if we require solidifying an abstraction for the
> > kernel to manage all this logic before passing a report on to user
> > space.
>
> Understood. When that standardization process completes my expectation
> is that it slots into the common conveyance method and no need to go
> rewrite code that already knows how to interface with Keys to get
> attestation evidence.
>

I can get on board with that. I don't think there will be much cause
for more than a handful of attestation requests with different report
data, so it shouldn't overwhelm the key subsystem.

> >
> > You really shouldn't be putting attestation validation logic in the
> > kernel.
>
> It was less putting validation logic in the kernel, and more hoping for
> a way to abstract some common parsing in advance of a true standard
> attestation format, but point taken.
>

I think we'll have hardware-provided blobs and host-provided cached
collateral. The caching could be achieved with a hosted proxy server,
but given SEV-SNP already has GET_EXT_GUEST_REQUEST to simplify
delivery, I think it's fair to offer other technologies the chance at
supporting a similar simple solution.

Everything else will have to come from the network or the workload itself.


> > It belongs outside of the VM entirely with the party that will
> > only release access keys to the VM if it can prove it's running the
> > software it claims, on the platform it claims. I think Windows puts a
> > remote procedure call in their guest attestation driver to the Azure
> > attestation service, and that is an anti-pattern in my mind.
>
> I can not speak to the Windows implementation, but the Linux Keys
> subsystem is there to handle Key construction that may be requested by
> userspace or the kernel and may be serviced by built-in keys,
> device/platform instantiated keys, or keys retrieved via an upcall to
> userspace.
>
> The observation is that existing calls to request_key() in the kernel
> likely have reason to be serviced by a confidential computing key server
> somewhere in the chain. So, might as well enlighten the Keys subsystem
> to retrieve this information and skip round trips to userspace run
> vendor specific ioctls. Make the kernel as self sufficient as possible,
> and make SEV, TDX, etc. developers talk more to each other about their
> needs.

That sounds reasonable. I think one wrinkle in the current design is
that SGX and SEV-SNP provide derived keys as a thing separate from
attestation but still based on firmware measurement, and TDX doesn't
yet. It may in the future come with a TDX module update that gets
derived keys through an SGX enclave=E2=80=93who knows. The MSG_KEY_REQ gues=
t
request for a SEV-SNP derived key has some bits and bobs to select
different VM material to mix into the key derivation, so that would
need to be in the API as well. It makes request_key a little weird to
use for both. I don't even think there's a sufficient abstraction for
the guest-attest device to provide, since there isn't a common
REPORT_DATA + attestation level pair of inputs that drive it. If we're
fine with a technology-tagged uninterpreted input blob for key
derivation, and the device returns an error if the real hardware
doesn't match the technology tag, then that could be an okay enough
interface.

I could be convinced to leave MSG_KEY_REQ out of Linux entirely, but
only for selfish reasons. The alternative is to set up a sealing key
escrow service that releases sealing keys when a VM's attestation
matches a pre-registered policy, which is extremely heavy-handed when
you can enforce workload identity at VM launch time and have a safe
derived key with this technology. I think there's a Decentriq blog
post about setting that whole supply chain up ("swiss cheese to
cheddar"), so they'd likely have some words about that.

--=20
-Dionna Glaze, PhD (she/her)
