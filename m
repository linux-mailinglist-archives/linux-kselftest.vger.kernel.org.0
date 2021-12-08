Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28846CE2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 08:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhLHHS1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 02:18:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45330 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhLHHS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 02:18:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E8FBB81691;
        Wed,  8 Dec 2021 07:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BC0C00446;
        Wed,  8 Dec 2021 07:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638947692;
        bh=AWG3rNQnFaUqlVZi6qDgg8+9yS/8b11qWAJbuAsLQwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeYOTtDkErFpuDGtcd6GYC/LZ7toAO2LM14xQDUSZkNqC0l5jc3Mo45rFRPVJNpfx
         lzUW58lBRDO5xRk+BMW7lDfSzS2JUDkQM4XS7ACZgn2qHdPQadOsFi+COgHol21q+7
         lIenJ0x6mvE4ApbPEw1+ZcM+vnHL2UXBr+d8h9m+xCYj+nF3489g0FGBpBSa3rwR2L
         HfSYSLQ0Wzj21PIqPiVZxekjDniB2mDYfXCGJrLFsXtS8cSlN4mjPCoOn6McXp6e7y
         oIKHTZf5UX7ENjgEP0wNgXcpZCXhDsdDBBXzK/nvzm1MAQluSDUaaxPhZPz52XyKUZ
         gmcV4fHYfrwSQ==
Date:   Wed, 8 Dec 2021 09:14:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 4/6] platform/x86: Add Intel Software Defined Silicon driver
Message-ID: <YbBbZ+JMk9eEgNKl@unreal>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207171448.799376-5-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 07, 2021 at 09:14:46AM -0800, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.  The SDSi driver provides a per socket, sysfs
> attribute interface for applications to perform 3 main provisioning
> functions:
> 
> 1. Provision an Authentication Key Certificate (AKC), a key written to
>    internal NVRAM that is used to authenticate a capability specific
>    activation payload.
> 
> 2. Provision a Capability Activation Payload (CAP), a token authenticated
>    using the AKC and applied to the CPU configuration to activate a new
>    feature.
> 
> 3. Read the SDSi State Certificate, containing the CPU configuration
>    state.
> 
> The operations perform function specific mailbox commands that forward the
> requests to SDSi hardware to perform authentication of the payloads and
> enable the silicon configuration (to be made available after power
> cycling).
> 
> The SDSi device itself is enumerated as an auxiliary device from the
> intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> 
> Link: https://github.com/intel/intel-sdsi
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V2
>   - Use sysfs_emit() in guid_show()
>   - Fix language in ABI, suggested by Bjorn
>   - Fix wrong directory name in ABI doc

<...>

> @@ -0,0 +1,77 @@
> +What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X

<...>

> +static const struct auxiliary_device_id sdsi_aux_id_table[] = {
> +	{ .name = "intel_vsec.sdsi" },

Are you sure that this sysfs is correct?

Auxiliary bus set device name as a combination of module name plus suffix.

  172 int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
  173 {
  174         struct device *dev = &auxdev->dev;
  175         int ret;
 ....
  181
  182         ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name, auxdev->id);

Thanks
