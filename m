Return-Path: <linux-kselftest+bounces-17056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B67296A46D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF221F24AFA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002518BB9F;
	Tue,  3 Sep 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S56LHYJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CE18890E;
	Tue,  3 Sep 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381172; cv=none; b=id8LDYEcSKkMBB2LUJ8I1gXUCC5iC/Z0WUbhJHE1OUXOBvi9cs+ppXpRgC3n2V6Hz0kY7u/3xeO7G0B7S1q9jeCxNi5dhAz+J01ZJPyTRU1Sz1Uqik+FrJYcTIYh7MbvN8ClO+R57ZlRe7jED38qnaZcQzd7yElNgwnXDNEctmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381172; c=relaxed/simple;
	bh=2iAkElkTK/udwI8HgSznE9zh+ynrt0U4FDl3K/v607E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diQO++7Gh6N/dubLDrMDF3/XttI2U+51FuWppum6IRXg5tyP4aSlxrOKAoz0gvhaa1Dl0Jx23zB+Yypms4B8hu/oPTk/PbPdILJRpX8DzNE2tpLNwr8tewMHiDyhTaqdT0LNirNIMlBVdUNcJ4YbwnRfy+FDkqExO6FTeVXrGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S56LHYJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD696C4CEC4;
	Tue,  3 Sep 2024 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381172;
	bh=2iAkElkTK/udwI8HgSznE9zh+ynrt0U4FDl3K/v607E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S56LHYJw98veiO9YdjMnYR0fPO/mg177QmaOu8u8i7+ky5/+u2Ia3F+l++JWTQGPr
	 S0nzhSP5O/f1JGKxzC6R3/dic0oHq/Y0UP/ChD4ds7mUi0W8RBIpN6gA9NWISKdf4W
	 JT6W6PnTF6yNktSsqvO2etAh78mHs7kkMYSbCD3Dx1AQi/Hw/Hm64EE0XMiXwH3VgR
	 nKzwA+e28zWBpp3OQjSj7VQE1fN3QzPtXBwZ75GFxkeSgyErIfVbsZOVKiHc723Ap6
	 5AnRt8913+LCt0ReB6JpMlbjGG/GSqx5AkaI85iG/RkzrRh9djvs9JVmmeeV5aiviW
	 jwfHYEB51SD0A==
Date: Tue, 3 Sep 2024 18:32:46 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jikos@kernel.org>, Vicki Pfau <vi@endrift.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH HID 6/7] HID: bpf: Allow to control the connect mask of
 hid-generic from BPF
Message-ID: <daailcz2telf6yrt5wdswtyhj7ggu7o66ztho2tgyzg5uq6ky4@ljkd5wqbl2gc>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
 <20240903-hid-bpf-hid-generic-v1-6-9511a565b2da@kernel.org>
 <20240903055745.GB968953@quokka>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903055745.GB968953@quokka>

On Sep 03 2024, Peter Hutterer wrote:
> On Tue, Sep 03, 2024 at 01:14:36AM +0900, Benjamin Tissoires wrote:
> > We make struct hid_device_id writeable and use the .driver_data field
> > of hid-generic as the connect mask.
> 
> I think this needs to be spelled out a bit more: for this to work the
> driver *must* be hid-generic, otherwise this doesn't work. But I'm a bit
> confused why we have a custom fields for force/ignore driver but 
> whether the device is connected (and thus uses the driver) is hidden in
> an effectively undocumented private field of one specific driver.

It's hid-generic only because that is the less intrusive approach. I'm
not sure we want an override from BPF for any drivers, as suddenly you
will get some harder-than-required bugs with drivers not exposing input
when they should.

> 
> Wouldn't it be easier to add another boolean (or enum entry, see my
> other comment) to hid_bpf_driver? This way *how* it happens is hidden
> from the API as well - you say "hidraw only please" and the kernel does
> the rest (through hid-generic or otherwise).

I thought at that, but again, given that I wanted to enable this only
for hid-generic, it felt weird to have a field that works for just one
driver.

Also, after I sent the series, I realized that it was probably not great
for Steam/SDL: today they basically set uaccess on the hidraw nodes, but
now we are going to require some root permissions to disable the event
node.

I'll need to think more but we probably need something more like
udev-hid-bpf where you can load the "disable event node on hidraw open"
BPF once, and forget about it, and make this bpf recognize that
SDL/Steam is opening the hidraw node, and therefore it needs to
reconnect the device. But this is not possible to do with this series
(and maybe not with the current infrastructure).

Cheers,
Benjamin

> 
> Cheers,
>   Peter
> 
> > 
> > This way, we can control from a HID-BPF program if a device needs to
> > be exported through hidraw and/or hid-input mainly.
> > 
> > This is useful in case we want to have a third party program that directly
> > talks to the hidraw node and we don't want regular input events to be
> > emitted. This third party program can load a BPF program that instructs
> > hid-generic to rebind on the device with hidraw only and then open the
> > hidraw node itself.
> > 
> > When the application is closed, the BPF program is unloaded and the normal
> > driver takes back the control of the device.
> > 
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
> >  drivers/hid/hid-core.c               | 14 ++++++++------
> >  drivers/hid/hid-generic.c            |  5 +++--
> >  3 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > index 1e13a22f73a1..bb755edd02f0 100644
> > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > @@ -80,6 +80,7 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
> >  		WRITE_RANGE(hid_device, name, true),
> >  		WRITE_RANGE(hid_device, uniq, true),
> >  		WRITE_RANGE(hid_device, phys, true),
> > +		WRITE_RANGE(hid_device_id, driver_data, false),
> >  		WRITE_RANGE(hid_bpf_driver, force_driver, false),
> >  		WRITE_RANGE(hid_bpf_driver, ignore_driver, false),
> >  	};
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 7845f0a789ec..2bd279b23aa4 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2637,15 +2637,17 @@ EXPORT_SYMBOL_GPL(hid_compare_device_paths);
> >  
> >  static bool hid_check_device_match(struct hid_device *hdev,
> >  				   struct hid_driver *hdrv,
> > -				   const struct hid_device_id **id)
> > +				   struct hid_device_id *id)
> >  {
> > +	const struct hid_device_id *_id = hid_match_device(hdev, hdrv);
> >  	int ret;
> >  
> > -	*id = hid_match_device(hdev, hdrv);
> > -	if (!*id)
> > +	if (!_id)
> >  		return false;
> >  
> > -	ret = call_hid_bpf_driver_probe(hdev, hdrv, *id);
> > +	memcpy(id, _id, sizeof(*id));
> > +
> > +	ret = call_hid_bpf_driver_probe(hdev, hdrv, id);
> >  	if (ret)
> >  		return ret > 0;
> >  
> > @@ -2662,7 +2664,7 @@ static bool hid_check_device_match(struct hid_device *hdev,
> >  
> >  static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
> >  {
> > -	const struct hid_device_id *id;
> > +	struct hid_device_id id;
> >  	int ret;
> >  
> >  	if (!hid_check_device_match(hdev, hdrv, &id))
> > @@ -2677,7 +2679,7 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
> >  	hdev->driver = hdrv;
> >  
> >  	if (hdrv->probe) {
> > -		ret = hdrv->probe(hdev, id);
> > +		ret = hdrv->probe(hdev, &id);
> >  	} else { /* default probe */
> >  		ret = hid_open_report(hdev);
> >  		if (!ret)
> > diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> > index f9db991d3c5a..5cd1f3a79a4b 100644
> > --- a/drivers/hid/hid-generic.c
> > +++ b/drivers/hid/hid-generic.c
> > @@ -64,11 +64,12 @@ static int hid_generic_probe(struct hid_device *hdev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +	return hid_hw_start(hdev, id->driver_data);
> >  }
> >  
> >  static const struct hid_device_id hid_table[] = {
> > -	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
> > +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID),
> > +		.driver_data = HID_CONNECT_DEFAULT },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(hid, hid_table);
> > 
> > -- 
> > 2.46.0
> > 

