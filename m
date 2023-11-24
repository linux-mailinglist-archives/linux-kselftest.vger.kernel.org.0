Return-Path: <linux-kselftest+bounces-559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7957F7886
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757951C20A4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E533CCB;
	Fri, 24 Nov 2023 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZVEHfkXZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFA12B;
	Fri, 24 Nov 2023 08:04:45 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3328D660739E;
	Fri, 24 Nov 2023 16:04:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700841884;
	bh=LqihOK0Q++RpV7t8zDmObDhhj1W5mEV5lqPp+ZJjtFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVEHfkXZVaaljYC+c+rShwxSy6W2K/woOPGWZ2aqLDOZ/IElPcKWNsZDZC2v90jZc
	 itV08P9+7v8wplZvKM2c8AH0j89MwvO2xkjrU2Da7Nq4nbBiR/Iz5/wRgOZX180uMm
	 sxDwrFQ4TXcC/b8eL6pvt38G8ijksVAFo5rPW7mzJeBfl2sIbxOXidVorvihH3VHUM
	 Vpzfb7olMrTzWM71B/TZR69uSprO0LcdzR87r3uZPkeFWvw35ys81EKwv0I7IVDnOo
	 Q9NBBVJGOn0SL/fQH4wTVvU8P40BMVSGHcssaSbW6M03SeWmSktMAKP/eTxO/Ei5Rd
	 L4ruxXRf40P7w==
From: Laura Nao <laura.nao@collabora.com>
To: dan.carpenter@linaro.org
Cc: broonie@kernel.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	laura.nao@collabora.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rafael@kernel.org,
	robh+dt@kernel.org,
	shuah@kernel.org
Subject: Re: [RFC PATCH 0/2] Add a test to verify device probing on ACPI platforms
Date: Fri, 24 Nov 2023 17:04:42 +0100
Message-Id: <20231124160442.50928-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <431009f0-56e7-46e8-a3a0-a8070554b727@suswa.mountain>
References: <431009f0-56e7-46e8-a3a0-a8070554b727@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/23/23 16:14, Dan Carpenter wrote:
> On Thu, Nov 23, 2023 at 01:09:42PM +0100, Laura Nao wrote:
>>> Your talk was interesting at Linux Plumbers.
>>>
>>> https://www.youtube.com/watch?v=oE73eVSyFXQ [time +2:35]
>>>
>>> This is probably a stupid question, but why not just add something to
>>> call_driver_probe() which creates a sysfs directory tree with all the
>>> driver information?
>>>
>>
>> Thanks for the feedback!
>>
>> Improving the device driver model to publish driver and devices info
>> was indeed another option we considered. We could have a debugfs entry
>> storing this kind of information, similar to what devices_deferred
>> does and in a standardized format. This would provide an interface
>> that is easier to query at runtime for getting a list of devices that
>> were probed correctly.
>> This would cover devices with a driver that's built into the kernel or
>> as a module; in view of catching also those cases where a device is
>> not probed because the relevant config is not enabled, I think we'd
>> still need another way of building a list of devices present on the
>> platform to be used as reference.
> 
> Yeah.  So we'd still need patch #1 as-is and but patch #2 would probably
> be simpler if we had this information in sysfs.  Or a different solution
> would be to do what someone said in the LPC talk and just save the
> output of the previous boot and complain if there was a regression where
> something didn't probe.
> 

Right. The main drawback of using the status of a known good boot as
reference is to keep it up to date over time. If support for a
peripheral gets added at a later stage, the reference needs to be updated
as well.

>>
>> The solution proposed in this RFC follows the same approach used for
>> dt based platforms for simplicity. But if adding a new sysfs entry
>> storing devices and driver info proves to be a viable option for
>> upstream, we can surely explore it and improve the probe test to
>> leverage that.
> 
> You're saying "simplicity" but I think you mean easiest from a political
> point of view.  It's not the most simple format at all.  It's like
> massive detective work to find the information and then you'll have to
> redo it for DT and for USB.  Are there other kinds of devices which can
> be probed?
> 

Yeah, that's what I meant. The ACPI use case is in a way simpler to
handle than the dt one, as we can get information on non removable
devices on enumerable buses such as PCI from the ACPI
tables (leveraging the _ADR objects). But it still requires quite a lot
digging in sysfs to get info on what was actually probed.
So having a list of probed devices would help both use cases.

> I feel like you're not valuing your stuff at the right level.  This
> shouldn't be in debugfs.  It should be a first class citizen in sysfs.
> 
> The exact format for this information is slightly tricky and people will
> probably debate that.  But I think most people will agree that it's
> super useful.
>

Right, agreeing on a format will be tricky. Judging by the response here
and in LPC it's still worth a shot though. I'll put some thought into
this and experiment a bit to come up with a proposal to submit in
another RFC.

Again, thanks for the helpful feedback!

Best,
Laura


