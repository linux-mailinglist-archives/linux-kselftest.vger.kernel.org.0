Return-Path: <linux-kselftest+bounces-17109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63EC96B6A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1C01C21D5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57521CCB20;
	Wed,  4 Sep 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0qnAtoL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CEE194C82;
	Wed,  4 Sep 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442117; cv=none; b=AlJiJUoyQCCa0hx8vmn1SkKwPdLkRThOHMg6FnjHe4e0tITFXo8gBhRSZag2z8UefP8+Fc3XX09HtO6hhIWOvGTZ0dkmtqqiZ3Q1G/k2j4WcHzzf1zGh/+FpZKUJNgKFfgwQJM9UV7JKCsgsGR38BXnOr11Qw3SH5wJZMTe4J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442117; c=relaxed/simple;
	bh=wVd0NiSMYOwyNYPSg54Kae5BLw0H1CLenDtv8FfQz90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8xqrCCVV8ebfbIkmZ8uTF+18Y/lSczMvO+V0mgwXM1NfLVJ9Fpwbf78q+ISy5xf9+LZHpTAZUNPYqcWIvm251zq9b3yq7wYdw9OHyNSuRW8xEwW2VlH9eqEnBCKwSJp890/76/7s89Qd3XkTZQA3fa1xfF6WK6TfSYKxntbTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0qnAtoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F7C4CEC2;
	Wed,  4 Sep 2024 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725442117;
	bh=wVd0NiSMYOwyNYPSg54Kae5BLw0H1CLenDtv8FfQz90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0qnAtoLDltqVbotcG8J/m3L6KLiiuWE8eingJmhNC1aIpqoxOrXtxrquVt8VO09L
	 /vlVE9GQAJh1/PRW7JEkTQ/IKqzhVeg4NnAFC9M8no8XygvVqTVnJorGc66H/3mHqx
	 K8+rliS/J72YCv0M3eV15sysxy8eEt3ZKXcFSLdANqVChGPOO6mDnpyY9n8gwyG+1b
	 /gPB4ILDyIFeIwqWx53sjfjJspMFIJsN7Cvd1e4ORB+Fa4WQJ1JOMwipxtyy6S6+/p
	 CYstfjtE7k2nizwDBJr2TgtIVZvVOjzseVllgjZ4zAtRbchKzbOtYQG2gUMsEaRiv8
	 gcDnvvaE7BSrQ==
Date: Wed, 4 Sep 2024 11:28:32 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jikos@kernel.org>, Vicki Pfau <vi@endrift.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH HID 4/7] HID: bpf: allow BPF programs to force using
 hid-generic
Message-ID: <qqhroxk7rroagnb5panttyhie72nmxbxl3fpzmw75pstj4duvv@oudsj3zlkshp>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
 <20240903-hid-bpf-hid-generic-v1-4-9511a565b2da@kernel.org>
 <20240903053656.GA968953@quokka>
 <whzoigqsbgmhxhk7qws4o63l23a5ravmpqyro4kvajomypljgf@x5pakwey5wej>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <whzoigqsbgmhxhk7qws4o63l23a5ravmpqyro4kvajomypljgf@x5pakwey5wej>

On Sep 03 2024, Benjamin Tissoires wrote:
> On Sep 03 2024, Peter Hutterer wrote:
> > On Tue, Sep 03, 2024 at 01:14:34AM +0900, Benjamin Tissoires wrote:
> > > The use case is when we fix a device through HID-BPF, 99% of the cases
> > > we want the device to use hid-generic now instead of a dedicated device.
> > 
> > s/dedicated device/dedicated driver/ in the commit message
> > 
> > > That's because the dedicated device might also want to change the report
> > > descriptor, or will be handling the device in a different way the new
> > > fixed device is using.
> > > 
> > > In hid-core, after matching for the device (so that we only call this new
> > > hook on compatible drivers), we call for `.hid_bpf_driver_probe`.
> > > The function can not communicate with the device because it is not yet
> > > started, but it can make educated guesses and decide to:
> > > - let hid-core decide by itself
> > > - force the use of this driver (by comparing the provided name with
> > >   "hid-generic" for instance)
> > > - force hid-core to ignore this driver for this device.
> > > 
> > > For API stability, we don't rely on a bitfield or a return value for
> > > chosing hid-core behavior. We simply have a couple of writeable fields
> > > in the new struct hid_bpf_driver, and then hid-core can make its educated
> > > decision.
> > > 
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > >  Documentation/hid/hid-bpf.rst        |  2 +-
> > >  drivers/hid/bpf/hid_bpf_dispatch.c   | 31 ++++++++++++++++++++++++++++
> > >  drivers/hid/bpf/hid_bpf_struct_ops.c |  3 +++
> > >  drivers/hid/hid-core.c               |  6 ++++++
> > >  include/linux/hid_bpf.h              | 40 ++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 81 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
> > > index 5939eeafb361..05a43f11cdab 100644
> > > --- a/Documentation/hid/hid-bpf.rst
> > > +++ b/Documentation/hid/hid-bpf.rst
> > > @@ -190,7 +190,7 @@ User API data structures available in programs:
> > >  -----------------------------------------------
> > >  
> > >  .. kernel-doc:: include/linux/hid_bpf.h
> > > -   :identifiers: hid_bpf_ctx
> > > +   :identifiers: hid_bpf_ctx hid_bpf_driver
> > >  
> > >  Available API that can be used in all HID-BPF struct_ops programs:
> > >  ------------------------------------------------------------------
> > > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> > > index a272a086c950..2df136d64152 100644
> > > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > > @@ -189,6 +189,37 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
> > >  }
> > >  EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
> > >  
> > > +int call_hid_bpf_driver_probe(struct hid_device *hdev, struct hid_driver *hdrv,
> > > +			      const struct hid_device_id *id)
> > > +{
> > > +	struct hid_bpf_driver drv = { 0 };
> > > +	struct hid_bpf_ops *e;
> > > +	int idx;
> >  +
> > > +	if (strscpy(drv.name, hdrv->name, sizeof(drv.name)) < 0)
> > > +		return 0;
> > > +
> > > +	idx = srcu_read_lock(&hdev->bpf.srcu);
> > > +	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
> > > +				 srcu_read_lock_held(&hdev->bpf.srcu)) {
> > > +		if (!e->hid_driver_probe)
> > > +			continue;
> > > +
> > > +		e->hid_driver_probe(hdev, &drv, id);
> > > +	}
> > > +
> > > +	srcu_read_unlock(&hdev->bpf.srcu, idx);
> > > +
> > > +	if (drv.force_driver)
> > > +		return 1;
> > > +
> > > +	if (drv.ignore_driver)
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(call_hid_bpf_driver_probe);
> > > +
> > >  static int device_match_id(struct device *dev, const void *id)
> > >  {
> > >  	struct hid_device *hdev = to_hid_device(dev);
> > > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > > index cd696c59ba0f..1e13a22f73a1 100644
> > > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > > @@ -46,6 +46,7 @@ static int hid_bpf_ops_check_member(const struct btf_type *t,
> > >  	case offsetof(struct hid_bpf_ops, hid_rdesc_fixup):
> > >  	case offsetof(struct hid_bpf_ops, hid_hw_request):
> > >  	case offsetof(struct hid_bpf_ops, hid_hw_output_report):
> > > +	case offsetof(struct hid_bpf_ops, hid_driver_probe):
> > >  		break;
> > >  	default:
> > >  		if (prog->sleepable)
> > > @@ -79,6 +80,8 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
> > >  		WRITE_RANGE(hid_device, name, true),
> > >  		WRITE_RANGE(hid_device, uniq, true),
> > >  		WRITE_RANGE(hid_device, phys, true),
> > > +		WRITE_RANGE(hid_bpf_driver, force_driver, false),
> > > +		WRITE_RANGE(hid_bpf_driver, ignore_driver, false),
> > >  	};
> > >  #undef WRITE_RANGE
> > >  	const struct btf_type *state = NULL;
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 988d0acbdf04..7845f0a789ec 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -2639,10 +2639,16 @@ static bool hid_check_device_match(struct hid_device *hdev,
> > >  				   struct hid_driver *hdrv,
> > >  				   const struct hid_device_id **id)
> > >  {
> > > +	int ret;
> > > +
> > >  	*id = hid_match_device(hdev, hdrv);
> > >  	if (!*id)
> > >  		return false;
> > >  
> > > +	ret = call_hid_bpf_driver_probe(hdev, hdrv, *id);
> > > +	if (ret)
> > > +		return ret > 0;
> > > +
> > >  	if (hdrv->match)
> > >  		return hdrv->match(hdev, hid_ignore_special_drivers);
> > >  
> > > diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> > > index d4d063cf63b5..20693c218857 100644
> > > --- a/include/linux/hid_bpf.h
> > > +++ b/include/linux/hid_bpf.h
> > > @@ -9,6 +9,7 @@
> > >  #include <uapi/linux/hid.h>
> > >  
> > >  struct hid_device;
> > > +struct hid_driver;
> > >  
> > >  /*
> > >   * The following is the user facing HID BPF API.
> > > @@ -80,6 +81,22 @@ struct hid_ops {
> > >  
> > >  extern struct hid_ops *hid_ops;
> > >  
> > > +/**
> > > + * struct hid_bpf_driver - User accessible data for the ``hid_bpf_probe``
> > > + * struct_ops
> > > + *
> > > + * @name: the name of the driver currently being treated
> > > + * @force_driver: set this to ``true`` to force hid-core to use this driver,
> > > + *		  bypassing any further decision made by this driver
> > > + * @ignore_driver: set this to ``true`` to force hid-core to ignore this driver,
> > > + *                bypassing any further decision made by this driver
> > 
> > If I set both to false or true, what happens? The two seem to be
> 
> force_driver has priority over ignore_driver.
> 
> > mutually exclusive, in userspace I'd use an enum here to have a
> > NOOP/FORCE_DRIVER/IGNORE_DRIVER value range (that can be extended later).
> > Maybe something like that is an option?
> 
> enum also has the advantage to be exported in vmlinux.h.
> 
> FWIW, the idea behind adding new fields in a struct was to get the
> backward compatibility for free. Because the verifier/relocator will see
> if we are using the correct field entries.
> 
> OTOH, maybe we can make the function return the afformended enum, and
> drop those two fields.
> 
> I think we should probably abort processing of any bpf sets the return
> value to anything else than NOOP.
> 
> I'll work a little bit more on that.
> 
> Cheers,
> Benjamin
> 
> > 
> > > + */
> > > +struct hid_bpf_driver {
> > > +	__u8 name[64];
> > > +	bool force_driver;
> > > +	bool ignore_driver;
> > > +};
> > > +
> > >  /**
> > >   * struct hid_bpf_ops - A BPF struct_ops of callbacks allowing to attach HID-BPF
> > >   *			programs to a HID device
> > > @@ -178,6 +195,25 @@ struct hid_bpf_ops {
> > >  	 */
> > >  	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, u64 source);
> > >  
> > > +	/**
> > > +	 * @hid_driver_probe: called before the kernel ``.probe()`` function
> > > +	 *
> > > +	 * It has the following arguments:
> > > +	 *
> > > +	 * ``hdev``: The HID device kernel representation
> > > +	 *
> > > +	 * ``hdrv``: A BPF partially writeable representation of a HID driver
> > > +	 *
> > > +	 * ``id``: The device match structure found in the driver
> > > +	 *
> > > +	 * Note that the device has not been started yet, and thus kfuncs like
> > > +	 * ``hid_hw_output_report`` will likely fail.
> > 
> > Just to confirm, I can access the device's report descriptor though? For

I forgot to reply to this comment:
no, you don't :)

> > the devices that we're looking at (e.g. the foot pedals pretending to be
> > an apple keyboard) the driver name and what we can set in HID_BPF_CONFIG
> > are not going to be enough, we'll have to check the rdesc too.

You can check this in the probe syscall before unbinding/rebinding the
device. The device is uniquely linked to the bpf program you loaded, so
in theory this is sufficient.

Cheers,
Benjamin

> > 
> > Cheers,
> >   Peter
> > 
> > > +	 *
> > > +	 * This function is useful to force/ignore a given supported HID driver,
> > > +	 * by writing ``true`` in ``hdrv->force_driver`` or ``hdrv->ignore_driver``
> > > +	 */
> > > +	void (*hid_driver_probe)(struct hid_device *hdev, struct hid_bpf_driver *hdrv,
> > > +				 const struct hid_device_id *id);
> > >  
> > >  	/* private: do not show up in the docs */
> > >  	struct hid_device *hdev;
> > > @@ -213,6 +249,8 @@ void hid_bpf_disconnect_device(struct hid_device *hdev);
> > >  void hid_bpf_destroy_device(struct hid_device *hid);
> > >  int hid_bpf_device_init(struct hid_device *hid);
> > >  u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size);
> > > +int call_hid_bpf_driver_probe(struct hid_device *hdev, struct hid_driver *hdrv,
> > > +			      const struct hid_device_id *id);
> > >  #else /* CONFIG_HID_BPF */
> > >  static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
> > >  						u8 *data, u32 *size, int interrupt,
> > > @@ -228,6 +266,8 @@ static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
> > >  static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
> > >  static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
> > >  static inline int hid_bpf_device_init(struct hid_device *hid) { return 0; }
> > > +static inline int call_hid_bpf_driver_probe(struct hid_device *hdev, struct hid_driver *hdrv,
> > > +					    const struct hid_device_id *id) { return 0; }
> > >  /*
> > >   * This specialized allocator has to be a macro for its allocations to be
> > >   * accounted separately (to have a separate alloc_tag). The typecast is
> > > 
> > > -- 
> > > 2.46.0
> > > 

