Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7646D16B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 11:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhLHLAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 06:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhLHLAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 06:00:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C4C061746;
        Wed,  8 Dec 2021 02:56:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9849ECE211F;
        Wed,  8 Dec 2021 10:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3112C00446;
        Wed,  8 Dec 2021 10:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638961002;
        bh=YmoSRhVx+XS3GhwZscBKqGixn80XjIhiN8IbjQ3yi8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZMauFwC8qHxW/F1ZfOS1j25FV4hGlbOXTlx8lisivGwI8BMpPgKNAKE64qf+vGYb
         Mof7teYM3rSH1KC1mfoQSFid2LqVu8XzbV0KyBugJxpKemu7016aKhTYyYLkMgdCms
         1UrNXxl4ImOURK2RUCXAdaoPXUxX8bAbxXdE7JuB7JUvfjAAzB4anqGr4Idlqjrwz/
         hqBLrFLmpmtoe+Y4K0Qlw9rh6/g2tLGpewYsw9ZBQBumAnP0NNJomcBwwkbOrqSCcX
         XWfpbaMZ1m8qr1kemhD5zL8rsEcjvbnoPcLeFET8LuKa9ecOmfbi4ladMzNiLmXjbF
         AFdTDX6ovkHXA==
Date:   Wed, 8 Dec 2021 12:56:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 4/6] platform/x86: Add Intel Software Defined Silicon driver
Message-ID: <YbCPZjz6CIjJqZqm@unreal>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-5-david.e.box@linux.intel.com>
 <YbBbZ+JMk9eEgNKl@unreal>
 <e4bbeeec741c186090dc3da4fecfab034dde8d0f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4bbeeec741c186090dc3da4fecfab034dde8d0f.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 02:42:42AM -0800, David E. Box wrote:
> On Wed, 2021-12-08 at 09:14 +0200, Leon Romanovsky wrote:
> > On Tue, Dec 07, 2021 at 09:14:46AM -0800, David E. Box wrote:
> > > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > > activating additional silicon features. Features are enabled through a
> > > license activation process.  The SDSi driver provides a per socket, sysfs
> > > attribute interface for applications to perform 3 main provisioning
> > > functions:
> > > 
> > > 1. Provision an Authentication Key Certificate (AKC), a key written to
> > >    internal NVRAM that is used to authenticate a capability specific
> > >    activation payload.
> > > 
> > > 2. Provision a Capability Activation Payload (CAP), a token authenticated
> > >    using the AKC and applied to the CPU configuration to activate a new
> > >    feature.
> > > 
> > > 3. Read the SDSi State Certificate, containing the CPU configuration
> > >    state.
> > > 
> > > The operations perform function specific mailbox commands that forward the
> > > requests to SDSi hardware to perform authentication of the payloads and
> > > enable the silicon configuration (to be made available after power
> > > cycling).
> > > 
> > > The SDSi device itself is enumerated as an auxiliary device from the
> > > intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> > > 
> > > Link: https://github.com/intel/intel-sdsi
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > ---
> > > V2
> > >   - Use sysfs_emit() in guid_show()
> > >   - Fix language in ABI, suggested by Bjorn
> > >   - Fix wrong directory name in ABI doc
> > 
> > <...>
> > 
> > > @@ -0,0 +1,77 @@
> > > +What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X
> > 
> > <...>
> > 
> > > +static const struct auxiliary_device_id sdsi_aux_id_table[] = {
> > > +	{ .name = "intel_vsec.sdsi" },
> > 
> > Are you sure that this sysfs is correct?
> > 
> > Auxiliary bus set device name as a combination of module name plus suffix.
> > 
> >   172 int __auxiliary_device_add(struct auxiliary_device *auxdev, const char
> > *modname)
> >   173 {
> >   174         struct device *dev = &auxdev->dev;
> >   175         int ret;
> >  ....
> >   181
> >   182         ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name,
> > auxdev->id);
> > 
> > Thanks
> 
> Yes. 'intel_vsec' is the module name, 'sdsi' is the suffix, and 'X' is meant to
> indicate the unique id. Will change to '*' instead of 'X'.

No, it is ok, I don't think that it is worth to change.

Thanks

> 
> Thanks
> 
> David
> 
