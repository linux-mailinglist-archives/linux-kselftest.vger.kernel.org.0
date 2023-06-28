Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BB740C6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbjF1JIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjF1JEY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEF3595;
        Wed, 28 Jun 2023 02:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89FE561276;
        Wed, 28 Jun 2023 09:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDCAC433C0;
        Wed, 28 Jun 2023 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687942953;
        bh=dZ8ewtgN7+nQ8HFCPwMwFbD5X/40NMNmnlkYkea6Iqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4Ni7XDNzGqsmBfx9rCiTuMO4Rbz5g8lx7ujGD3cwkr3aUIVy8zh8n5HiwhgYrUEO
         8Fn09MGTbBZWGIAO0UJiAwEfgWLT9oJoP1qajsNFxwm9mz/fdQ8E21qW3FOvXQ+v+w
         upAwUY0M0SsU7obLCi96V8Utj+Xqp0CqbpNxW3Mw=
Date:   Wed, 28 Jun 2023 11:02:30 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <2023062825-rebel-happily-09fd@gregkh>
References: <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
 <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
 <c85324480053af20e6f0409e28fbc5e156c54143.camel@intel.com>
 <2023062805-drove-privatize-ae2c@gregkh>
 <e30fb40d736ccc60672316c5d20aaf1ab7c94dcf.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30fb40d736ccc60672316c5d20aaf1ab7c94dcf.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 08:56:30AM +0000, Huang, Kai wrote:
> On Wed, 2023-06-28 at 08:46 +0200, gregkh@linuxfoundation.org wrote:
> > On Wed, Jun 28, 2023 at 02:16:45AM +0000, Huang, Kai wrote:
> > > > You really shouldn't be putting attestation validation logic in the
> > > > kernel.
> > > 
> > > Agreed.  The data blob for remote verification should be just some data blob to
> > > the kernel.  I think the kernel shouldn't even try to understand the data blob
> > > is for which architecture.  From the kernel's perspective, it should be just
> > > some data blob that the kernel gets from hardware/firmware or whatever embedded
> > > in the root-of-trust in the hardware after taking some input from usrspace for
> > > the unique identity of the blob that can be used to, e.g., mitigate replay-
> > > attack, etc.
> > 
> > Great, then use the common "data blob" api that we have in the kernel
> > for a very long time now, the "firwmare download" api, or the sysfs
> > binary file api.  Both of them just use the kernel as a pass-through and
> > do not touch the data at all.  No need for crazy custom ioctls and all
> > that mess :)
> > 
> 
> I guess I was talking about from "kernel shouldn't try to parse attestation data
> blob" perspective.  Looking at AMD's attestation flow (I have no deep
> understanding of AMD's attestation flow), the assumption of "one remote
> verifiable data blob" isn't even true -- AMD can return "attestation report"
> (remote verifiable) and the "certificate" to verify it separately:
> 
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snp-attestation.html
> 
> On the other hand, AFAICT Intel SGX-based attestation doesn't have a mechanism
> "for the kernel" to return certificate(s), but choose to embed the
> certificate(s) to the Quote itself.  I believe we can add such mechanism (e.g.,
> another TDVMCALL) for the kernel to get certificate(s) separately, but AFAICT it
> doesn't exist yet.
> 
> Btw, getting "remote verifiable blob" is only one step of the attestation flow.
> For instance, before the blob can be generated, there must be a step to
> establish the attestation key between the machine and the attestation service. 
> And the flow to do this could be very different between vendors too.
> 
> That being said, while I believe all those differences can be unified in some
> way, I think the question is whether it is worth to put such effort to try to
> unify attestation flow for all vendors.  As Erdem Aktas mentioned earlier, "the
> number of CPU vendors for confidential computing seems manageable".

So you think that there should be a custom user/kernel api for every
single different CPU vendor?  That's not how kernel development works,
sorry.  Let's try to unify them to make both the kernel, and userspace,
sane.

And Dan is right, if this is handling keys, then the key subsystem needs
to be used here instead of custom ioctls.

thanks,

greg k-h
