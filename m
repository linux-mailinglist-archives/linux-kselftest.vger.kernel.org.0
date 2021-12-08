Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D082346D133
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhLHKqQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 05:46:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:61605 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhLHKqP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 05:46:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="225063546"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="225063546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="600594517"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2021 02:42:43 -0800
Received: from MahaWorkThinkPad.amr.corp.intel.com (MahaWorkThinkPad.amr.corp.intel.com [10.252.128.137])
        by linux.intel.com (Postfix) with ESMTP id A39B95806D1;
        Wed,  8 Dec 2021 02:42:42 -0800 (PST)
Message-ID: <e4bbeeec741c186090dc3da4fecfab034dde8d0f.camel@linux.intel.com>
Subject: Re: [V2 4/6] platform/x86: Add Intel Software Defined Silicon driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Leon Romanovsky <leon@kernel.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Wed, 08 Dec 2021 02:42:42 -0800
In-Reply-To: <YbBbZ+JMk9eEgNKl@unreal>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
         <20211207171448.799376-5-david.e.box@linux.intel.com>
         <YbBbZ+JMk9eEgNKl@unreal>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-12-08 at 09:14 +0200, Leon Romanovsky wrote:
> On Tue, Dec 07, 2021 at 09:14:46AM -0800, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > activating additional silicon features. Features are enabled through a
> > license activation process.  The SDSi driver provides a per socket, sysfs
> > attribute interface for applications to perform 3 main provisioning
> > functions:
> > 
> > 1. Provision an Authentication Key Certificate (AKC), a key written to
> >    internal NVRAM that is used to authenticate a capability specific
> >    activation payload.
> > 
> > 2. Provision a Capability Activation Payload (CAP), a token authenticated
> >    using the AKC and applied to the CPU configuration to activate a new
> >    feature.
> > 
> > 3. Read the SDSi State Certificate, containing the CPU configuration
> >    state.
> > 
> > The operations perform function specific mailbox commands that forward the
> > requests to SDSi hardware to perform authentication of the payloads and
> > enable the silicon configuration (to be made available after power
> > cycling).
> > 
> > The SDSi device itself is enumerated as an auxiliary device from the
> > intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> > 
> > Link: https://github.com/intel/intel-sdsi
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Mark Gross <markgross@kernel.org>
> > ---
> > V2
> >   - Use sysfs_emit() in guid_show()
> >   - Fix language in ABI, suggested by Bjorn
> >   - Fix wrong directory name in ABI doc
> 
> <...>
> 
> > @@ -0,0 +1,77 @@
> > +What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X
> 
> <...>
> 
> > +static const struct auxiliary_device_id sdsi_aux_id_table[] = {
> > +	{ .name = "intel_vsec.sdsi" },
> 
> Are you sure that this sysfs is correct?
> 
> Auxiliary bus set device name as a combination of module name plus suffix.
> 
>   172 int __auxiliary_device_add(struct auxiliary_device *auxdev, const char
> *modname)
>   173 {
>   174         struct device *dev = &auxdev->dev;
>   175         int ret;
>  ....
>   181
>   182         ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name,
> auxdev->id);
> 
> Thanks

Yes. 'intel_vsec' is the module name, 'sdsi' is the suffix, and 'X' is meant to
indicate the unique id. Will change to '*' instead of 'X'.

Thanks

David

