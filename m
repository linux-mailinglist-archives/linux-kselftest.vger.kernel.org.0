Return-Path: <linux-kselftest+bounces-17019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB2496935E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCC282806
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F211CEABB;
	Tue,  3 Sep 2024 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="vg6/7YIC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYN2FeIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983651CE6ED;
	Tue,  3 Sep 2024 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343084; cv=none; b=thFxQBWPIwzph1EsjKuYrWiwosgJe1Py+DfpSTnAQxuyzgW1YJnATJkyeLBhOe1eVqS+PEL9kPJyw3eTv4Z4cHlvOnB0XvODh0DkLXcyssUn9PCjvDrVY+hprQA86nB3ctgCVVeGmJDJg/asMBbcZOJvb/6kf3mPlrbG1FkjwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343084; c=relaxed/simple;
	bh=ORxlrybr0miEKGUNReRTbzJyZOz1c7Aa8Ya/cInZS1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISmUjMUnavlq7OFWFC6K9UwgEHMJQVtaaSku/nTvvvDNP97CGwu6zDVy+D/koodJBccz0WVx4NXtdS2eM9dzeVMCTfK0SCdxWrK/4iCAKxO2W+R0zfzgOLHsCO0FXSH2uaTxiTyIEQsw1X/UjoWYeqDFJaJngjNUxGe+sp4/CRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=vg6/7YIC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYN2FeIg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A6846138030D;
	Tue,  3 Sep 2024 01:58:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 03 Sep 2024 01:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1725343081; x=1725429481; bh=uXeKgWb/Nb
	mdrKy6APCtXUQCm+rImJ9sCZU2y2bBhlU=; b=vg6/7YICBZHR9f3szRFh/cQig/
	DNaY1aZ5JmhDIIx4KCDfhcLfPpWtP39TITjfCfKLOtSQF5KYXkAE2XuoyT9iC728
	YtxI9UsdAGCnWpf+SVwfE8KlL8yY9uhio8RNfwQaIoE5ZJO6H2uSsYbhNqVUKnx0
	9SHQz3oQKzbee4Aixv9RRPmOmxvfLG6mX/5UJnEITwK4Pys2/Q9aRaFL8w9G3OWO
	3DhupZBSXzRpVgZ7V+cvewVwjGINTrSHxFCi4KrLDGJnRSJqjlpj2B9En/Vlc691
	Gz8IoS5s0enxrSnfD4a2+SnBbPnntKAqQ0zj2jk7R091tQDfvDlzI6fy+psg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725343081; x=1725429481; bh=uXeKgWb/NbmdrKy6APCtXUQCm+rI
	mJ9sCZU2y2bBhlU=; b=QYN2FeIgrnp8fXXVsqgtqSdld5SwhaC0eQ7YDC0dNJIT
	qJkbk1Y1eCYz66vhk0wKUseKlSDrSd76aj2zY28N4F9Z0OxTiLYGSDM2QB1MIhTF
	CnVWWoCSeIUhcdKUAtE/CXB3RtxMCe1X8e1jUVAeZMRtSiR9eto/6rYVW9fzakc5
	c5XgphBVPUXurLHzrjYPS+3Z1zZPPuWQEN3791JW1olsglwBuZ+sf95TjsdM6L+V
	RUNYkhYW95mIDWMRJfK0KhUYU+mwcbLuHBvCWZEZ75vX4h/DmVHw3DRsLXUyunEF
	Q3xLPICYm1UDSs3NZ9sp7CoZCycEhXE+pQsg0C1ldQ==
X-ME-Sender: <xms:aaXWZvO2Kjs83oBigi6qXamK4OdhS7wlDQfD62GgooZm6kZlGrI33g>
    <xme:aaXWZp9TiDv8Nu9Yk8hlDduQlWtpNJCmwf8_8kys0JKyB-kNQgNucCBx_gKj40pKm
    aiVNuMESsWh7tjMYqM>
X-ME-Received: <xmr:aaXWZuTMIMSn9--GEHnBrdxne9BvADl9Bevj4zH9m3MGxjXKVL5pT3DVGXRiwCVSt4daoQR0EpQ4Y-y4XiFuwTwUvGYbch5qJbtW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrvghtvghrucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrh
    gvrhesfihhohdqthdrnhgvtheqnecuggftrfgrthhtvghrnhepkedvkeegheefjefgvddu
    fffhveehjeffvefgiefgkefhudeifedugfetudfgtefgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseif
    hhhoqdhtrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhi
    khhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhisegvnhgurhhifhhtrdgtoh
    hmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    rhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aaXWZjuBH9kiJCw0mc01PZhbRpTKUT6aNshhONPnQhJQ3mPn9EcWyQ>
    <xmx:aaXWZnfMLEm0JzETI8SVFn9VGpEHAWj80Lz_Hxz3nCvYgLbUuOty0A>
    <xmx:aaXWZv2UYJhCGfPlpzDkXF_RJTV102N5Nky9SGhLTggShHPjAI4Egw>
    <xmx:aaXWZj9P1NhHHekCkf6heJrlO3VGD9ioaP_bEcTcYsNxIZtr-12S-g>
    <xmx:aaXWZoVqS8ReMzE7Ij44VaqquyuzicGTLylgFfxoIjLXMAheXr8wSJtp>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 01:57:58 -0400 (EDT)
Date: Tue, 3 Sep 2024 15:57:45 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Vicki Pfau <vi@endrift.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH HID 6/7] HID: bpf: Allow to control the connect mask of
 hid-generic from BPF
Message-ID: <20240903055745.GB968953@quokka>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
 <20240903-hid-bpf-hid-generic-v1-6-9511a565b2da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-hid-bpf-hid-generic-v1-6-9511a565b2da@kernel.org>

On Tue, Sep 03, 2024 at 01:14:36AM +0900, Benjamin Tissoires wrote:
> We make struct hid_device_id writeable and use the .driver_data field
> of hid-generic as the connect mask.

I think this needs to be spelled out a bit more: for this to work the
driver *must* be hid-generic, otherwise this doesn't work. But I'm a bit
confused why we have a custom fields for force/ignore driver but 
whether the device is connected (and thus uses the driver) is hidden in
an effectively undocumented private field of one specific driver.

Wouldn't it be easier to add another boolean (or enum entry, see my
other comment) to hid_bpf_driver? This way *how* it happens is hidden
from the API as well - you say "hidraw only please" and the kernel does
the rest (through hid-generic or otherwise).

Cheers,
  Peter

> 
> This way, we can control from a HID-BPF program if a device needs to
> be exported through hidraw and/or hid-input mainly.
> 
> This is useful in case we want to have a third party program that directly
> talks to the hidraw node and we don't want regular input events to be
> emitted. This third party program can load a BPF program that instructs
> hid-generic to rebind on the device with hidraw only and then open the
> hidraw node itself.
> 
> When the application is closed, the BPF program is unloaded and the normal
> driver takes back the control of the device.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
>  drivers/hid/hid-core.c               | 14 ++++++++------
>  drivers/hid/hid-generic.c            |  5 +++--
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> index 1e13a22f73a1..bb755edd02f0 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -80,6 +80,7 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
>  		WRITE_RANGE(hid_device, name, true),
>  		WRITE_RANGE(hid_device, uniq, true),
>  		WRITE_RANGE(hid_device, phys, true),
> +		WRITE_RANGE(hid_device_id, driver_data, false),
>  		WRITE_RANGE(hid_bpf_driver, force_driver, false),
>  		WRITE_RANGE(hid_bpf_driver, ignore_driver, false),
>  	};
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 7845f0a789ec..2bd279b23aa4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2637,15 +2637,17 @@ EXPORT_SYMBOL_GPL(hid_compare_device_paths);
>  
>  static bool hid_check_device_match(struct hid_device *hdev,
>  				   struct hid_driver *hdrv,
> -				   const struct hid_device_id **id)
> +				   struct hid_device_id *id)
>  {
> +	const struct hid_device_id *_id = hid_match_device(hdev, hdrv);
>  	int ret;
>  
> -	*id = hid_match_device(hdev, hdrv);
> -	if (!*id)
> +	if (!_id)
>  		return false;
>  
> -	ret = call_hid_bpf_driver_probe(hdev, hdrv, *id);
> +	memcpy(id, _id, sizeof(*id));
> +
> +	ret = call_hid_bpf_driver_probe(hdev, hdrv, id);
>  	if (ret)
>  		return ret > 0;
>  
> @@ -2662,7 +2664,7 @@ static bool hid_check_device_match(struct hid_device *hdev,
>  
>  static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
>  {
> -	const struct hid_device_id *id;
> +	struct hid_device_id id;
>  	int ret;
>  
>  	if (!hid_check_device_match(hdev, hdrv, &id))
> @@ -2677,7 +2679,7 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
>  	hdev->driver = hdrv;
>  
>  	if (hdrv->probe) {
> -		ret = hdrv->probe(hdev, id);
> +		ret = hdrv->probe(hdev, &id);
>  	} else { /* default probe */
>  		ret = hid_open_report(hdev);
>  		if (!ret)
> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index f9db991d3c5a..5cd1f3a79a4b 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -64,11 +64,12 @@ static int hid_generic_probe(struct hid_device *hdev,
>  	if (ret)
>  		return ret;
>  
> -	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	return hid_hw_start(hdev, id->driver_data);
>  }
>  
>  static const struct hid_device_id hid_table[] = {
> -	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID),
> +		.driver_data = HID_CONNECT_DEFAULT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, hid_table);
> 
> -- 
> 2.46.0
> 

