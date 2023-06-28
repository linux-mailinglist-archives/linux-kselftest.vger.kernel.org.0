Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78772740AAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjF1IJf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 04:09:35 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48362 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjF1IEt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 04:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB7B61323;
        Wed, 28 Jun 2023 06:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDFEC433C0;
        Wed, 28 Jun 2023 06:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687934771;
        bh=/fBZ9cbSiRyinkC8H30RlCqMLrhBXaEf9+MR3DHs4I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJIzgLxArGj7Io7qmYRX/fDLAClIv/nZa8WwlJeGEn59EQ7DpbRTwClBZWwlz+xqu
         iU4VZxFf4XYSNWuTUY+M6g8MgwA6/yEKiy4quy30WS2JZD3v0B2TPOp+4elt0MRqWz
         6zaOyP4tHrSxKnx51WIY5rZ3AyPx6yEhjbuQbP7s=
Date:   Wed, 28 Jun 2023 08:46:08 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Du, Fan" <fan.du@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <2023062805-drove-privatize-ae2c@gregkh>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
 <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
 <c85324480053af20e6f0409e28fbc5e156c54143.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85324480053af20e6f0409e28fbc5e156c54143.camel@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 02:16:45AM +0000, Huang, Kai wrote:
> > You really shouldn't be putting attestation validation logic in the
> > kernel.
> 
> Agreed.  The data blob for remote verification should be just some data blob to
> the kernel.  I think the kernel shouldn't even try to understand the data blob
> is for which architecture.  From the kernel's perspective, it should be just
> some data blob that the kernel gets from hardware/firmware or whatever embedded
> in the root-of-trust in the hardware after taking some input from usrspace for
> the unique identity of the blob that can be used to, e.g., mitigate replay-
> attack, etc.

Great, then use the common "data blob" api that we have in the kernel
for a very long time now, the "firwmare download" api, or the sysfs
binary file api.  Both of them just use the kernel as a pass-through and
do not touch the data at all.  No need for crazy custom ioctls and all
that mess :)

thanks,

greg k-h
