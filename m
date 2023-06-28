Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644367407AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjF1BgX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 21:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF1BgW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 21:36:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67034198A
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 18:36:20 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4007b5bafceso83061cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687916179; x=1690508179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76q3czNHBGF97J8zUfgBzI1kFFF4VkjgowoEBA/iOwY=;
        b=y26X29gqmEGqKXrFtZryTyXDzQ9ewY6D9loFvzylkwQasUaA3rhMju6tAIXM45FOCP
         EiMe0MCGmWBUFKrsCbSYBusOLFWu0jf2ch1nvHU2ezj0YlibSSfCAj3pkfhCVHzE1K7H
         Z7NtUDgJupEmpBLcz2JwUP0Ew4wYs1sF5cUDLma1QWvlN3N/adRlgN+tfnFyRaGsxpnh
         SbXxUiJzn2QLtTTP3iL+pFTRkz2lk8L1MKva4dy/j5S7MgRwhh1nEATI68dFDXZfdONG
         FhiCx9DGJTIiGbbLlNXJi17Unkk3M74ZWytzQwiWvh1eVm0Sq9lBTa4tZoll5SdOHuaw
         8eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687916179; x=1690508179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76q3czNHBGF97J8zUfgBzI1kFFF4VkjgowoEBA/iOwY=;
        b=koCn3Ae9Wd9oqXJJm2B9JCreZzYCPL9ZblSbfZaL818zXXWjWel4WPbecTxDaD7rg1
         0av2APvSOfTLHOkKS5SOX2YTklJSeA7LydbgwRWUG3NkHfW90srTJdyL1FtZceEChri/
         v9pcMrGN+GgGDOIPczKcBynR4jSa4GSfoo6cKEgLap1OV/Vhz3PBvNGDb9HHmZQ+oKNq
         3jh9ROY0lAiDfcOyQHPsbxmrIsBy/nlB9kTU83ECKLjvQmPCiXjIUZi67CuWllEFkgGD
         eGTRnN1Cj9uZeVapY2/iMvPY+n9JfPPNmKts3qQiIT3o4Y+dLyyKHc3Qd2dZXDG8nTid
         lquw==
X-Gm-Message-State: AC+VfDxBeKM0+fwH8hOCqgRYUC0bIODhf9a5Atxih2Y68ivc+EuZtT3f
        5yd7kpLy1hkItnefnhVuSGZn2J9NO0zh4CHU1seTKQ==
X-Google-Smtp-Source: ACHHUZ7sVzuwnmV3HryX+9qLq3qI6jRIEjo2b86t4SeBiyuoth4UHt8vts7j6aJsIac12Y3Yp0QqGwhzwhLl3ASLDT8=
X-Received: by 2002:ac8:5710:0:b0:3ef:343b:fe7e with SMTP id
 16-20020ac85710000000b003ef343bfe7emr130387qtw.2.1687916179378; Tue, 27 Jun
 2023 18:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com> <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 27 Jun 2023 18:36:07 -0700
Message-ID: <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27, 2023 at 5:13=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
> [..]
> >
> > The VMPL-based separation that will house the supervisor module known
> > as SVSM can have protocols that implement a TPM command interface, or
> > an RTMR-extension interface, and will also need to have an
> > SVSM-specific protocol attestation report format to keep the secure
> > chain of custody apparent. We'd have different formats and protocols
> > in the kernel, at least, to speak to each technology.
>
> That's where I hope the line can be drawn, i.e. that all of this vendor
> differentiation really only matters inside the kernel in the end.
>
> > I'm not sure it's worth the trouble of papering over all the... 3-4
> > technologies with similar but still weirdly different formats and ways
> > of doing things with an abstracted attestation ABI, especially since
> > the output all has to be interpreted in an architecture-specific way
> > anyway.
>
> This is where I need help. Can you identify where the following
> assertion falls over:
>
> "The minimum viable key-server is one that can generically validate a
> blob with an ECDSA signature".
>
> I.e. the fact that SEV and TDX send different length blobs is less
> important than validating that signature.
>
> If it is always the case that specific fields in the blob need to be
> decoded then yes, that weakens the assertion. However, maybe that means
> that kernel code parses the blob and conveys that parsed info along with
> vendor attestation payload all signed by a Linux key. I.e. still allow
> for a unified output format + signed vendor blob and provide a path to
> keep all the vendor specific handling internal to the kernel.
>

All the specific fields of the blob have to be decoded and subjected
to an acceptance policy. That policy will most always be different
across different platforms and VM owners. I wrote all of
github.com/google/go-sev-guest, including the verification and
validation logic, and it's going to get more complicated, and the
sources of the data that provide validators with notions of what
values can be trusted will be varied. The formats are not
standardized. The Confidential Computing Consortium should be working
toward that, but it's a slow process. There's IETF RATS. There's
in-toto.io attestations. There's Azure's JWT thing. There's a signed
serialized protocol buffer that I've decided is what Google is going
to produce while we figure out all the "right" formats to use. There
will be factions and absolute gridlock for multiple years if we
require solidifying an abstraction for the kernel to manage all this
logic before passing a report on to user space.

Now, not only are the field contents important, the certificates of
the keys that signed the report are important. Each platform has its
own special x509v3 extensions and key hierarchy to express what parts
of the report should be what value if signed by this key, and in TDX's
case there are extra endpoints that you need to query to determine if
there's an active CVE on the associated TCB version. This is how they
avoid adding every cpu's key to the leaf certificate's CRL.

You really shouldn't be putting attestation validation logic in the
kernel. It belongs outside of the VM entirely with the party that will
only release access keys to the VM if it can prove it's running the
software it claims, on the platform it claims. I think Windows puts a
remote procedure call in their guest attestation driver to the Azure
attestation service, and that is an anti-pattern in my mind.

> > ARM's Confidential Computing Realm Management Extensions (RME) seems
> > to be going along the lines of a runtime measurement register model
> > with their hardware enforced security. The number of registers isn't
> > prescribed in the spec.
> >
> > +Joey Gouly +linux-coco@lists.linux.dev as far as RME is concerned, do
> > you know who would be best to weigh in on this discussion of a unified
> > attestation model?



--=20
-Dionna Glaze, PhD (she/her)
