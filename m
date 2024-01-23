Return-Path: <linux-kselftest+bounces-3419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0338391BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F121028271C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9E5C5FF;
	Tue, 23 Jan 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4I66temL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DA50271;
	Tue, 23 Jan 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021492; cv=none; b=boq8GU4r3MbDya0ztrMMjbljZ+6fhJzA904OL5xNhpSPnfU0z3FNUWj/0bqNqhX1sus/skPi8vuplp7VpKVg1IOnuFB1EiAaQcZETAqUeWGwyMO3Vaj+q6ki0fqREus2HArOrAQuXw8ZN3emp+QeDxyq8sb8I3VTh4GEIw4raAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021492; c=relaxed/simple;
	bh=wEw+KYIsI+l2yNlbx9fd4O3Ky0EddoloG2ibdw/iJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiuHJE2Z3fb3Qca8MDNYfCNTOuKgtfMc4I4hm8WRQ+gDivpuemNeii6vFTq62NbeL/DaSU1zJ/J+VIYMctjGl11/HKOqzOlPFNbjbbEaul27ZjP/2ZNc8lRyDMiORbSDcPi7LVM9pNZhmeLHFCXerXo/Pl/MlrahSRswKjhNCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4I66temL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706021488;
	bh=wEw+KYIsI+l2yNlbx9fd4O3Ky0EddoloG2ibdw/iJBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4I66temLW7YZ/eOjiSK0m5zzsPhHoocpYfI5SF81LwSYVevO1XceIsj6e4G1UfiJZ
	 5TqbcaXxf49DgUjaBqJPD5IxKgYkp+2lIUgRUkPx5P2qEudzs/Um4tuAVcxKeEv7nV
	 CK6sA2J/ieXPk+ufcNaplofq5PW3T6FM6k8vNvFS+6Ej+HUErWAQ9CA9ybCAnu+5Jq
	 LwS2fzBbOE7o6rl70wV+/3Avr16hg3XuSt8v9xaRuVjOuf7kQhEYwl4c6niegPyh4B
	 CvrHlDBMMbxi3sz9XFsLOLQ+46Y/PXa++OOFpc2RFJ5gUYCligNHza2A1lNVJUjbEN
	 uFYyCs25J4qyA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4370337820AD;
	Tue, 23 Jan 2024 14:51:21 +0000 (UTC)
Date: Tue, 23 Jan 2024 11:50:49 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernelci@lists.linux.dev,
	kernel@collabora.com, Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] kselftest: devices: Add sample board file for XPS
 13 9300
Message-ID: <2ea14eb2-d5b3-40b2-af4b-d14fe398886f@notapiano>
References: <20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
 <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
 <7aa0df3d-ae9d-414d-ad7f-ed7588e70f3e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aa0df3d-ae9d-414d-ad7f-ed7588e70f3e@collabora.com>

On Tue, Jan 23, 2024 at 12:08:22PM +0100, AngeloGioacchino Del Regno wrote:
> Il 22/01/24 19:53, Nícolas F. R. A. Prado ha scritto:
> > Add a sample board file describing the file's format and with the list
> > of devices expected to be probed on the XPS 13 9300 machine as an
> > example x86 platform.
> > 
> > Test output:
> > 
> > TAP version 13
> > Using board file: boards/Dell Inc.,XPS 13 9300.yaml
> > 1..22
> > ok 1 /pci-controller/14.0/usb2-controller/9/camera.device
> > ok 2 /pci-controller/14.0/usb2-controller/9/camera.0.driver
> > ok 3 /pci-controller/14.0/usb2-controller/9/camera.1.driver
> > ok 4 /pci-controller/14.0/usb2-controller/9/camera.2.driver
> > ok 5 /pci-controller/14.0/usb2-controller/9/camera.3.driver
> > ok 6 /pci-controller/14.0/usb2-controller/10/bluetooth.device
> > ok 7 /pci-controller/14.0/usb2-controller/10/bluetooth.0.driver
> > ok 8 /pci-controller/14.0/usb2-controller/10/bluetooth.1.driver
> > ok 9 /pci-controller/2.0/gpu.device
> > ok 10 /pci-controller/2.0/gpu.driver
> > ok 11 /pci-controller/4.0/thermal.device
> > ok 12 /pci-controller/4.0/thermal.driver
> > ok 13 /pci-controller/12.0/sensors.device
> > ok 14 /pci-controller/12.0/sensors.driver
> > ok 15 /pci-controller/14.3/wifi.device
> > ok 16 /pci-controller/14.3/wifi.driver
> > ok 17 /pci-controller/1d.0/0.0/ssd.device
> > ok 18 /pci-controller/1d.0/0.0/ssd.driver
> > ok 19 /pci-controller/1d.7/0.0/sdcard-reader.device
> > ok 20 /pci-controller/1d.7/0.0/sdcard-reader.driver
> > ok 21 /pci-controller/1f.3/audio.device
> > ok 22 /pci-controller/1f.3/audio.driver
> > Totals: pass:22 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   .../devices/boards/Dell Inc.,XPS 13 9300.yaml      | 40 ++++++++++++++++++++++
> >   1 file changed, 40 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml b/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml
> > new file mode 100644
> > index 000000000000..ff932eb19f0b
> > --- /dev/null
> > +++ b/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml	
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# This is the device definition for the XPS 13 9300.
> > +# The filename "Dell Inc.,XPS 13 9300" was chosen following the format
> > +# "Vendor,Product", where Vendor comes from
> > +# /sys/devices/virtual/dmi/id/sys_vendor, and Product comes from
> > +# /sys/devices/virtual/dmi/id/product_name.
> > +#
> > +# See google,spherion.yaml for more information.
> 
> What if - instead of taking google,spherion.yaml as an example - you create a new
> file named something like
> 
> "example,device.yaml"
> 
> that would be a fantasy device, bringing examples for all .. or most of .. the
> currently supported types/devices?
> 
> You would also move the nice documentation that you wrote in spherion.yaml to the
> new example,device.yaml and ask to refer to that instead in all of the real device
> specific definitions.
> 
> # SPDX-License-Identifier: GPL-2.0 <--- (GPL-2.0 OR MIT) like device trees perhaps?
> #
> # This is the device definition for the Example Device
> # The filename "Example Device" was chosen following the format
> # "Vendor,Product", where:
> #  - Vendor is "Example" and comes from /sys/devices/virtual/dmi/id/sys_vendor
> #  - Product is "Device" and comes from /sys/devices/virtual/dmi/id/product_name
> #
> # ....the rest of the blurb goes here
> #
> 
> - type : .... this that the other
>   devices:
>     - the least amount of device descriptions that you can use for documenting how
>       to write this stuff :-)
> 
> Anything against that?

That'd also work. Though I feel like a single example file for both a DT-based
and an ACPI-based platform might get unnecessarily confusing (given the
different way for identifying the machine - DMI vs DT compatible - and for
identifying the root level controller - ACPI UID vs DT MMIO).

I also feel like a real machine example is helpful to have.

In my opinion, your suggestion would make much more sense - and be needed even -
if we had several machine files in this directory, so that the documentation
stands out among them. However the feedback that I got from Shuah during
Plumbers was that maintaining per-machine files in-tree wasn't going to happen.
So these two files serve as the documentation, with real-life examples, that
other machines could build upon in a separate repository.

Thanks,
Nícolas

