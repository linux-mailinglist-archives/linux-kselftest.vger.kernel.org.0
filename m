Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53077414D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjF1PYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjF1PYh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 11:24:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8762268E
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 08:24:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fba66f3b14so79885e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687965873; x=1690557873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lN8SGKNkIKsowIbOG24r2oHuv4Nw4qW6wOBZIWClXj8=;
        b=MkkXjC9KhSM2H5uOLgHX8CFDi6yBTUzRKnE7IZmqYQjDDVgYlQg+qY5CrYwNbmQxQK
         UQe6clAFHqdKWTckalVo7ypS12RhXt9HG9fFQR76pTvbR75AwxYfhY1ZB1sHzCJEUKlZ
         8NnXvXTM6bK1For8MOSDjyfg7rIj1kL+b2pOo3WFAUQwCJnw1GrbKJ90+d+RwJb+U5Qz
         7mnmxUD0lw3iLOxPrNzBTBBQeBR/uaXW04tW7Y7yhrFEBKHv0jqxPISbkEUf+ctoYZew
         ZHO5QcCcjfPVZNcWPM4CGU5lUVR8E+23WcXHR+gPcFmbs69Rv+l6X4hr9syJL3aq6iRW
         a0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965873; x=1690557873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN8SGKNkIKsowIbOG24r2oHuv4Nw4qW6wOBZIWClXj8=;
        b=ftlPJXzykV5nMigxqbo3wK4FEF/eSlT57o0N5GPDUqbJZT9KPrTy3XEkPZWNLripSn
         ivukIPKlEGP4cpOZ+GFVxzIJD9q8HfWs5gD350iFthsc/vOJOMOHfjfld1aA+jvezqKj
         jqdRb4kv3+h4y8G65aNmI0sITe6xOLeKqbPVNktcpg+5ODrzyxd414xL3wM9yk3A2oT0
         ikx2byD166Ss+jzEFSWgRXXB/Qh2ixjxioXXsyJbq1QUE22CAK8ZoFc/y1qDEG/NOtaA
         aPRFhbMbo2g3pnkhwjRjaX8W4770VWDhb93Gir1krR3OluuAz77oX9r3VYGHLsPx+Gnu
         608g==
X-Gm-Message-State: AC+VfDy+Io8DpgMW07rGzDA81y43pb7NG2GY5Bnmh0Jib7zqCSTCBlxb
        iE6EIywej3O7xyUUKlMYnoNMUg==
X-Google-Smtp-Source: ACHHUZ419DnKiKqWGEETRVY6hfowx+1eoXsIWIvFGMy0EdeT5Aa1Be3rPvw4EzKFgMcYjQboZIjGrA==
X-Received: by 2002:a05:600c:2247:b0:3fb:a266:3a34 with SMTP id a7-20020a05600c224700b003fba2663a34mr4247463wmm.12.1687965873152;
        Wed, 28 Jun 2023 08:24:33 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f90ab2fff9sm14027515wmi.9.2023.06.28.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:24:32 -0700 (PDT)
Date:   Wed, 28 Jun 2023 17:24:30 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Sathyanarayanan Kuppuswamy 
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
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <ZJxQrs2KrWITNuLE@vermeer>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
 <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27, 2023 at 05:11:07PM -0700, Dan Williams wrote:
> Dionna Amalie Glaze wrote:
> > On Sun, Jun 25, 2023 at 8:06 PM Sathyanarayanan Kuppuswamy
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> [..]
> > > Hi Dan,
> > >
> > > On 6/23/23 3:27 PM, Dan Williams wrote:
> > > > Dan Williams wrote:
> > > >> [ add David, Brijesh, and Atish]
> > > >>
> > > >> Kuppuswamy Sathyanarayanan wrote:
> > > >>> In TDX guest, the second stage of the attestation process is Quote
> > > >>> generation. This process is required to convert the locally generated
> > > >>> TDREPORT into a remotely verifiable Quote. It involves sending the
> > > >>> TDREPORT data to a Quoting Enclave (QE) which will verify the
> > > >>> integrity of the TDREPORT and sign it with an attestation key.
> > > >>>
> > > >>> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> > > >>> allow the user agent to get the TD Quote.
> > > >>>
> > > >>> Add a kernel selftest module to verify the Quote generation feature.
> > > >>>
> > > >>> TD Quote generation involves following steps:
> > > >>>
> > > >>> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> > > >>> * Embed the TDREPORT data in quote buffer and request for quote
> > > >>>   generation via TDX_CMD_GET_QUOTE IOCTL request.
> > > >>> * Upon completion of the GetQuote request, check for non zero value
> > > >>>   in the status field of Quote header to make sure the generated
> > > >>>   quote is valid.
> > > >>
> > > >> What this cover letter does not say is that this is adding another
> > > >> instance of the similar pattern as SNP_GET_REPORT.
> > > >>
> > > >> Linux is best served when multiple vendors trying to do similar
> > > >> operations are brought together behind a common ABI. We see this in the
> > > >> history of wrangling SCSI vendors behind common interfaces. Now multiple
> > > >> confidential computing vendors trying to develop similar flows with
> > > >> differentiated formats where that differentiation need not leak over the
> > > >> ABI boundary.
> > > > [..]
> > > >
> > > > Below is a rough mock up of this approach to demonstrate the direction.
> > > > Again, the goal is to define an ABI that can support any vendor's
> > > > arch-specific attestation method and key provisioning flows without
> > > > leaking vendor-specific details, or confidential material over the
> > > > user/kernel ABI.
> > >
> > > Thanks for working on this mock code and helping out. It gives me the
> > > general idea about your proposal.
> > >
> > > >
> > > > The observation is that there are a sufficient number of attestation
> > > > flows available to review where Linux can define a superset ABI to
> > > > contain them all. The other observation is that the implementations have
> > > > features that may cross-polinate over time. For example the SEV
> > > > privelege level consideration ("vmpl"), and the TDX RTMR (think TPM
> > > > PCRs) mechanisms address generic Confidential Computing use cases.
> > >
> > >
> > > I agree with your point about VMPL and RTMR feature cases. This observation
> > > is valid for AMD SEV and TDX attestation flows. But I am not sure whether
> > > it will hold true for other vendor implementations. Our sample set is not
> > > good enough to make this conclusion. The reason for my concern is, if you
> > > check the ABI interface used in the S390 arch attestation driver
> > > (drivers/s390/char/uvdevice.c), you would notice that there is a significant
> > > difference between the ABI used in that driver and SEV/TDX drivers. The S390
> > > driver attestation request appears to accept two data blobs as input, as well
> > > as a variety of vendor-specific header configurations.
> > >
> > > Maybe the s390 attestation model is a special case, but, I think we consider
> > > this issue. Since we don't have a common spec, there is chance that any
> > > superset ABI we define now may not meet future vendor requirements. One way to
> > > handle it to leave enough space in the generic ABI to handle future vendor
> > > requirements.
> > >
> > > I think it would be better if other vendors (like ARM or RISC) can comment and
> > > confirm whether this proposal meets their demands.
> > >
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

Looking at your keys subsystem based PoC (thanks for putting it
together), I understand that the intention is to pass an attestation
evidence request as a payload to the kernel, in a abstract way.
i.e. the void *data in:
static int guest_attest_request_key(struct key *authkey, void *data)

And then passiing that down to vendor specific handlers
(tdx_request_attest in your PoC) for it to behave as a key server for
that attestation evidence request. The vendor magic of transforming an
attestation request into an actual attestation evidence (typically
signed with platform derived keys) is stuffed into that handler. The
format, content and protection of both the attestation evidence request
and the evidence itself is left for the guest kernel handler (e.g.
tdx_request_attest) to handle.

Is that a fair description of your proposal?

If it is, then it makes sense to me, and could serve as a generic
abstraction for confidential computing guest attestation evidence
requests. I think it could support the TDX, SEV and also the RISC-V
(aka CoVE) guest attestation request evidence flow.

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

I'm not sure which signature we're talking about here.
The final attestation evidence (The blob the guest workload will send to
a remote attestation service) is signed with a platform derived key,
typically rooted into a manufacturer's CA. It is then up to the *remote*
attestation service to authenticate and validate the evidence signature.
Then it can go through the actual attestation verification flow
(comparison against reference values, policy checks, etc). The latter
should be none of the guest kernel's business, which is what your
proposal seems to be heading to.


> If it is always the case that specific fields in the blob need to be
> decoded then yes, that weakens the assertion. 

Your vendor specific key handler may have to decode the passed void
pointer into a vendor specific structure before sending it down to the
TSM/ASP/etc, and that's fine imho.

Cheers,
Samuel.
