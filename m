Return-Path: <linux-kselftest+bounces-3402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283D838CFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3369428C200
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA2F5D749;
	Tue, 23 Jan 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WHSJGS+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AC5F545;
	Tue, 23 Jan 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008108; cv=none; b=ZDWCZlYcwbk4AKRIHFCumxrjge64zVNi9erBTg8PZbxOrkAY01kKqctkQ0TyaDcJJ9v4hQzwi6WSIl1lizpph4/suta/GvJvVshGBwhn1u8ps147WZHwkFUOUrZkaAOs4ACUj7s8jQOs/eaDDciK48DQ42Mr2LLlWZ8vHVfVuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008108; c=relaxed/simple;
	bh=ePXcq+3ZYklh/Ja9ctOyMj+QSXTswOpfPk1EoxnOuU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDms6oNGBbjbFBZHEAKQNWfIG0IgacaoqLLB5DXsD/kfL98f8GT72xgVUuQLbwOfDybIceb37hwjuxOt+2KuvBgs5MIiRCWfUDw5Nb0Qp1f7P7v5hGcSBy24dGUmWc49M6LZDfXdOAWzL4nbRZ6vhZzWbHNqjT8ghwywzSnqxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WHSJGS+3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706008104;
	bh=ePXcq+3ZYklh/Ja9ctOyMj+QSXTswOpfPk1EoxnOuU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WHSJGS+3u3ESf596ATW3fy0qn2TXktoZ06Uz5ewlpPDDesf2vkDWRY4ohIN1UQU2G
	 5B520CKex7b/cjHF4YzApi0HsCnwDLfu0N+MKHaV46OWWbL7gXjFGzyr5AI4fmGfWh
	 LX18pgHn3sZeYDx4HtAsZEdZYMYxgp4QcMBqWqUqFOknwhl961AP9qy1cAJVtjJc0X
	 Vcu4x/GdUBD21iP3eOWCTWDpw6UxTaUYmGGDLVjM39+ofyez/vvdu3roY7Rm3Q/Jax
	 jyYby5c7HcVd0z+yH2F21B1DAQqEPuLaVEEaDHmvwzwUcnTt7BEr1sxywPg17uY8mG
	 rUE1GE3yzdgSw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0FEB437820AA;
	Tue, 23 Jan 2024 11:08:23 +0000 (UTC)
Message-ID: <7aa0df3d-ae9d-414d-ad7f-ed7588e70f3e@collabora.com>
Date: Tue, 23 Jan 2024 12:08:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] kselftest: devices: Add sample board file for XPS
 13 9300
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: kernelci@lists.linux.dev, kernel@collabora.com,
 Tim Bird <Tim.Bird@sony.com>, linux-pci@vger.kernel.org,
 David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Doug Anderson <dianders@chromium.org>,
 linux-usb@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Guenter Roeck
 <groeck@chromium.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
 <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/01/24 19:53, Nícolas F. R. A. Prado ha scritto:
> Add a sample board file describing the file's format and with the list
> of devices expected to be probed on the XPS 13 9300 machine as an
> example x86 platform.
> 
> Test output:
> 
> TAP version 13
> Using board file: boards/Dell Inc.,XPS 13 9300.yaml
> 1..22
> ok 1 /pci-controller/14.0/usb2-controller/9/camera.device
> ok 2 /pci-controller/14.0/usb2-controller/9/camera.0.driver
> ok 3 /pci-controller/14.0/usb2-controller/9/camera.1.driver
> ok 4 /pci-controller/14.0/usb2-controller/9/camera.2.driver
> ok 5 /pci-controller/14.0/usb2-controller/9/camera.3.driver
> ok 6 /pci-controller/14.0/usb2-controller/10/bluetooth.device
> ok 7 /pci-controller/14.0/usb2-controller/10/bluetooth.0.driver
> ok 8 /pci-controller/14.0/usb2-controller/10/bluetooth.1.driver
> ok 9 /pci-controller/2.0/gpu.device
> ok 10 /pci-controller/2.0/gpu.driver
> ok 11 /pci-controller/4.0/thermal.device
> ok 12 /pci-controller/4.0/thermal.driver
> ok 13 /pci-controller/12.0/sensors.device
> ok 14 /pci-controller/12.0/sensors.driver
> ok 15 /pci-controller/14.3/wifi.device
> ok 16 /pci-controller/14.3/wifi.driver
> ok 17 /pci-controller/1d.0/0.0/ssd.device
> ok 18 /pci-controller/1d.0/0.0/ssd.driver
> ok 19 /pci-controller/1d.7/0.0/sdcard-reader.device
> ok 20 /pci-controller/1d.7/0.0/sdcard-reader.driver
> ok 21 /pci-controller/1f.3/audio.device
> ok 22 /pci-controller/1f.3/audio.driver
> Totals: pass:22 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   .../devices/boards/Dell Inc.,XPS 13 9300.yaml      | 40 ++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml b/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml
> new file mode 100644
> index 000000000000..ff932eb19f0b
> --- /dev/null
> +++ b/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml	
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This is the device definition for the XPS 13 9300.
> +# The filename "Dell Inc.,XPS 13 9300" was chosen following the format
> +# "Vendor,Product", where Vendor comes from
> +# /sys/devices/virtual/dmi/id/sys_vendor, and Product comes from
> +# /sys/devices/virtual/dmi/id/product_name.
> +#
> +# See google,spherion.yaml for more information.

What if - instead of taking google,spherion.yaml as an example - you create a new
file named something like

"example,device.yaml"

that would be a fantasy device, bringing examples for all .. or most of .. the
currently supported types/devices?

You would also move the nice documentation that you wrote in spherion.yaml to the
new example,device.yaml and ask to refer to that instead in all of the real device
specific definitions.

# SPDX-License-Identifier: GPL-2.0 <--- (GPL-2.0 OR MIT) like device trees perhaps?
#
# This is the device definition for the Example Device
# The filename "Example Device" was chosen following the format
# "Vendor,Product", where:
#  - Vendor is "Example" and comes from /sys/devices/virtual/dmi/id/sys_vendor
#  - Product is "Device" and comes from /sys/devices/virtual/dmi/id/product_name
#
# ....the rest of the blurb goes here
#

- type : .... this that the other
   devices:
     - the least amount of device descriptions that you can use for documenting how
       to write this stuff :-)

Anything against that?

Cheers,
Angelo

> +#
> +- type: pci-controller
> +  # This machine has a single PCI host controller so it's valid to not have any
> +  # key to identify the controller. If it had more than one controller, the UID
> +  # of the controller from ACPI could be used to distinguish as follows:
> +  #acpi-uid: 0
> +  devices:
> +    - path: 14.0
> +      type: usb-controller
> +      usb-version: 2
> +      devices:
> +        - path: 9
> +          name: camera
> +          interfaces: [0, 1, 2, 3]
> +        - path: 10
> +          name: bluetooth
> +          interfaces: [0, 1]
> +    - path: 2.0
> +      name: gpu
> +    - path: 4.0
> +      name: thermal
> +    - path: 12.0
> +      name: sensors
> +    - path: 14.3
> +      name: wifi
> +    - path: 1d.0/0.0
> +      name: ssd
> +    - path: 1d.7/0.0
> +      name: sdcard-reader
> +    - path: 1f.3
> +      name: audio
> 


