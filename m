Return-Path: <linux-kselftest+bounces-17798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491597610D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 08:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789811C22167
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A1188CA7;
	Thu, 12 Sep 2024 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="M3SyxtvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCbvp2pT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D65028C;
	Thu, 12 Sep 2024 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121453; cv=none; b=RwLGA75/ayWwaiKSs3z5fIEc3YB1MfrjyGQZMyIrZ4sX+OHB1qY0S/QEZh8LIkGJJhZa4bZS7o397S4dx7UY4jJQkMwWQ1qnqo8Ug6//5ztZsD+MOjH2s+5wmlbzjgDTDLCyuYH0DWUWU+91wRDRnLh75M0sgqOubVM0Dmxv8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121453; c=relaxed/simple;
	bh=kbYJiF6jPrl6B4HZ/oc1OWhI1LwpJSqM8A5kS4JT1OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXWYnf3DdDaeWE55QscD571S781a2m8EdO01zZVVi0aDMg2rEoZOWJ0PNgNwKmzcsKxkg5JCN5IkrG2gVFxDWPoUOaQXqMjZD4AOxTQUNI//hX4klY90DO18re/QAvrkWnkhrVEndOU+u6QJZQtbdxaP4KFXTpea0p4yb2f7JYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=M3SyxtvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCbvp2pT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACE6011402E9;
	Thu, 12 Sep 2024 02:10:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Sep 2024 02:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1726121450; x=1726207850; bh=0nD5pzeuAh
	1E4W3B+9CT7q3mBAtGFaHeDO2wy99F/Uw=; b=M3SyxtvXezTRUbdjysmrUibFNQ
	U+6MU0yO9Tt3m4nNsJyGwhyVQBkK8aArTVndILYmtdTpvg9gtehafTyfn2uVsR22
	ouVtq45pl3FUrjL/KTkZkwGWjB24G7z04s2R0HtQnAy8BMZD8+loVWXCLMHUj8nS
	oCDOZafyAv36YOE/fJ2CmzQah/wLWqllFdZjJLuKCEDYR/XIGLkr2XlrdJ8b8BDs
	K902mnj9G+/7MDiQlFV3XxP1QeVJ7r1Qy6C+7UH+wwMg5mF4kBWIMNCL3Bq4yDmm
	KIXZsAIZjkZtXsTG84fxQEdhfsq1bYk5QEnCZhPWgCTwOKZVQJ8HKLhLhPhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726121450; x=1726207850; bh=0nD5pzeuAh1E4W3B+9CT7q3mBAtG
	FaHeDO2wy99F/Uw=; b=eCbvp2pTL7js4B+RQCjhdkoQnKMg0jtKzsCq6+JqgmCG
	7muJONbLBWUddbrempeowLJnp6e6Xra1/Y9el2Rt5BM8Kd6PT7zHuAMDVW+a0Kkk
	6VyaPTvvX+S/nh+BdKKa6AQ7EKvGmLWh7RZwiIDz8xegby8rNNXOj6soki8BmerS
	Hyfw99z/zyD80FG3D13/iTRGhd0wJuhXAmuvAHv6qW3u3W7o37jADeGDVczd1BQN
	cF+JsCU2O3gfTMYqEjIiSAcWB0qEuGjwtEzSVApmU6I9/ONl+WxIllAd4e0snBZB
	DGZ4jVX9OE57D8oTI94KGAsITSvGO25Truori7u6XQ==
X-ME-Sender: <xms:6oXiZrOZy4YJdENlltVsYw_I03uxmAuERHE6N4jAz3grPMkMQsovHw>
    <xme:6oXiZl9fwYMYIAoCiu4GSLExnEVufQquWBfBkOQVVLD1vFbLB7caqHnlwmP0UNNKF
    o2O0339e2KuSCU6iu0>
X-ME-Received: <xmr:6oXiZqRN-RkCIkxfy5BX2If_8vmHgpvyB0GZzVaFGoCeN91hhP2j8JS0wYiKYCdldb1mHl1AbkhhlzV7GaHeaQ1KJhnGla95O6ze>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrvghtvghrucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrh
    gvrhesfihhohdqthdrnhgvtheqnecuggftrfgrthhtvghrnhepkedvkeegheefjefgvddu
    fffhveehjeffvefgiefgkefhudeifedugfetudfgtefgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseif
    hhhoqdhtrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhk
    ohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihesvghnughrihhfthdrtghomh
    dprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6oXiZvvS-hopthftEolupZnJnvsCG2oQyqgJq30vwi9fZACIkfGHZQ>
    <xmx:6oXiZjcbATwrFNazBNJF6QBxUT_CGBD1MV-QxaSBmcOJIVH00LSZRw>
    <xmx:6oXiZr2chtTF4G8CapEahqzkQhC3WHC_GRnUb5jD0Z3xKMO1GXIzfw>
    <xmx:6oXiZv8b_ERmFRShM02qaIuzwXx-d8_XF9azZDJmUMJbNoDjZ3VlBw>
    <xmx:6oXiZizn5nC7tc7TLWmsuE8jipH5iss_r1IPHJ6Efs4SN2QUY8B0q_DI>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 02:10:47 -0400 (EDT)
Date: Thu, 12 Sep 2024 16:10:29 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Vicki Pfau <vi@endrift.com>,
	Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH HID v2 02/11] HID: core: save one kmemdup during .probe()
Message-ID: <20240912061029.GA559032@quokka>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
 <20240910-hid-bpf-hid-generic-v2-2-083dfc189e97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-2-083dfc189e97@kernel.org>

On Tue, Sep 10, 2024 at 11:43:38PM +0900, Benjamin Tissoires wrote:
> Turns out the first kmemdup is only required for the .report_fixup()
> driver callback. There is no need to do two kmemdup() in a raw in case

typo: "in a row"?

Cheers,
  Peter

> .report_fixup() is not present.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> new in v2
> ---
>  drivers/hid/hid-core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a5f5415571cb..172746a082f9 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1206,7 +1206,7 @@ int hid_open_report(struct hid_device *device)
>  	struct hid_item item;
>  	unsigned int size;
>  	const __u8 *start;
> -	__u8 *buf;
> +	__u8 *buf = NULL;
>  	const __u8 *end;
>  	const __u8 *next;
>  	int ret;
> @@ -1227,14 +1227,18 @@ int hid_open_report(struct hid_device *device)
>  	if (WARN_ON(!start))
>  		return -ENODEV;
>  
> -	buf = kmemdup(start, size, GFP_KERNEL);
> -	if (buf == NULL)
> -		return -ENOMEM;
> +	if (device->driver->report_fixup) {
> +		/*
> +		 * device->driver->report_fixup() needs to work
> +		 * on a copy of our report descriptor so it can
> +		 * change it.
> +		 */
> +		buf = kmemdup(start, size, GFP_KERNEL);
> +		if (buf == NULL)
> +			return -ENOMEM;
>  
> -	if (device->driver->report_fixup)
>  		start = device->driver->report_fixup(device, buf, &size);
> -	else
> -		start = buf;
> +	}
>  
>  	start = kmemdup(start, size, GFP_KERNEL);
>  	kfree(buf);
> 
> -- 
> 2.46.0
> 

