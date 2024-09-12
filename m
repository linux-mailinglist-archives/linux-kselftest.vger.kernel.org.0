Return-Path: <linux-kselftest+bounces-17799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A4976114
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2211C22C73
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFF13CFB7;
	Thu, 12 Sep 2024 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="j8+LAdJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmIliIJr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A136189F2A;
	Thu, 12 Sep 2024 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121627; cv=none; b=TIDfz1stG1okIjY//MUuKKEAh74rP5HoRKl12MngCL/TyS9bVhtwV0tLU+l8kC4NXlOustKg4jdc0I5zN3JGVaX+adGqvmPe6c6HrGn72NOKMjyHwR6a9pO71ZjiUOu6CBl/faZuXowpskXtDNEGg2gApmz3pjzu0snzhV2VtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121627; c=relaxed/simple;
	bh=BoQDVRthtqE+Gqlz8Lz2NTTlPMmQIBRBNASIepQ2WFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFwQpSQg8Bu28IJ8y1TNLhTJktIxS4KyRwHiqpIusexjk2CBVFI48yVmRYz+HgHRwUpv+i+ulj2iVBd2COyp37/dRcDvSpCXlkhbiOtrTXXzb5h96SnlKP250P5LjGY8Z4n/9/3A5itWibl9BaZ1zh6C1SqIBfBTH0Ikl6GkSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=j8+LAdJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UmIliIJr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A604F13800E0;
	Thu, 12 Sep 2024 02:13:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Sep 2024 02:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1726121624; x=1726208024; bh=isC2Kp1hIU
	WEayfUMBsVtTA7t2dFaQ1PBjNe7RjZtw8=; b=j8+LAdJ/WBluH5v7RLVgv7AQz1
	mswF4YRFa1Ysw9rbOyWunN/53aEf4jpuBL8FmJh93Dk4nk1zpFKVawyiQo3j4dPD
	dZGG7QuZOg3JFTj5mWpfA2R2p1YJAqkvMDaHevCk1KQRb2YC6d9L76g2Gtv249Yq
	hJ95mXzgj6Wp4yTeocWvrS7ctQFij0ttoqcuzl1QdRjilnsk65GybnmmPKj0TKcr
	4yEBKrXkhERldOecOZp/Z3cFjYDmDkEvYsa/DILQ2jOe+Ilx6YqhnElpnCoUPwOz
	pn0dut1sxwOalxqVgh9OZ85E8VPL+KI9BpdA8xKJ00gwLgy2X3zMfBuomIng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726121624; x=1726208024; bh=isC2Kp1hIUWEayfUMBsVtTA7t2dF
	aQ1PBjNe7RjZtw8=; b=UmIliIJrLL4BJhNgVUzndBtRDUkjlQQo200RPvaTyATe
	aQdR0ENWVZXJcjn0WPAxNObdagJE/csVn2LL9nB5O7iOS2/8IY///XDvNHYD+fuP
	/Hi45pJ2MAOXU82LGQG/qr2OP5xBauZ3DygOWARHdlmYBOUQOxoKYXjEOZTHhROp
	84Skad/2L8YZx6NOuYNsww+GJoR/pvkEzgymSyYm/wo2yKpjyevWAsGdTfMulbBe
	HnTbtYrnQN32eQHAcSmAMOyfpEQd0XniUluqaxVGn8LoAgBnukAQ/udSu4ZIEKWT
	qIUjkh88y3eHW5RmL8txkV+XV1OLIu0P90ZnjUIoFA==
X-ME-Sender: <xms:mIbiZu6tAquVzh7oZ6gw5wXUF_3PCIotOOLCFI49MNQ9QAAbjeXNbw>
    <xme:mIbiZn7-xTswAPZ44NJkaRnY0bgsKxEtErh4Sck-G2jDgzUI6N4thlF739ECdJPfU
    sQTYPiI5Glpwak0FqM>
X-ME-Received: <xmr:mIbiZtfnei3U-eLNH0m7UrT9BnbiCwu8_0-NqkQ0xerpqQEJBpOoFRuMzT7Q5fKxW6AwKS5qZt3iUxGYkfNq-2scKM2EY1L2SGJo>
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
X-ME-Proxy: <xmx:mIbiZrJMtzqMuIXIwG0yKxOZ6xidZx075Z1IEhPNX6ND7vufzLmgUQ>
    <xmx:mIbiZiJYT_tLTFUQcgNpA4R4SUPkY_4lbzPDBSlcdF9s6uwU3zoi2w>
    <xmx:mIbiZsyuNYY74NjyhlHVVrYTXHD3IEHywLMRxvTuQxSZpkGHguFRDA>
    <xmx:mIbiZmJGlN5iJNY8d4HsXHBfdlfweyMNDhE5PdM2Eqa8vxUumJ_aXQ>
    <xmx:mIbiZh90H2d8cipr2GmQ0DnDr1uL9zPSSaHbrDp0ebLqWobcYJhcS-up>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 02:13:41 -0400 (EDT)
Date: Thu, 12 Sep 2024 16:13:25 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Vicki Pfau <vi@endrift.com>,
	Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH HID v2 08/11] HID: add per device quirk to force bind to
 hid-generic
Message-ID: <20240912061325.GA558003@quokka>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
 <20240910-hid-bpf-hid-generic-v2-8-083dfc189e97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-8-083dfc189e97@kernel.org>

On Tue, Sep 10, 2024 at 11:43:44PM +0900, Benjamin Tissoires wrote:
> We already have the possibility to force not binding to hid-generic and
> rely on a dedicated driver, but we couldn't do the other way around.
> 
> This is useful for BPF programs where we are fixing the report descriptor
> and the events, but want to avoid a specialized driver to come after BPF
> which would unwind everything that is done there.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> changes in v2:
> - rely on hdev->quirks for that instead of a new struct for hid_driver

I like this one a lot more than the previous approach, series is 

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

although for 01 and 06 this should be taken with a grain of salt :)

Cheers,
  Peter

> ---
>  drivers/hid/hid-core.c    | 5 +++--
>  drivers/hid/hid-generic.c | 3 +++
>  include/linux/hid.h       | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 37e52759a931..bf63e2819baf 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2665,9 +2665,10 @@ static bool hid_check_device_match(struct hid_device *hdev,
>  	/*
>  	 * hid-generic implements .match(), so we must be dealing with a
>  	 * different HID driver here, and can simply check if
> -	 * hid_ignore_special_drivers is set or not.
> +	 * hid_ignore_special_drivers or HID_QUIRK_IGNORE_SPECIAL_DRIVER
> +	 * are set or not.
>  	 */
> -	return !hid_ignore_special_drivers;
> +	return !hid_ignore_special_drivers && !(hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER);
>  }
>  
>  static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index f9db991d3c5a..88882c1bfffe 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -40,6 +40,9 @@ static bool hid_generic_match(struct hid_device *hdev,
>  	if (ignore_special_driver)
>  		return true;
>  
> +	if (hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER)
> +		return true;
> +
>  	if (hdev->quirks & HID_QUIRK_HAVE_SPECIAL_DRIVER)
>  		return false;
>  
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d41fa18f1e03..b3a9586363c9 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -359,6 +359,7 @@ struct hid_item {
>   * | @HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP:
>   * | @HID_QUIRK_HAVE_SPECIAL_DRIVER:
>   * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
> + * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
>   * | @HID_QUIRK_FULLSPEED_INTERVAL:
>   * | @HID_QUIRK_NO_INIT_REPORTS:
>   * | @HID_QUIRK_NO_IGNORE:
> @@ -384,6 +385,7 @@ struct hid_item {
>  #define HID_QUIRK_HAVE_SPECIAL_DRIVER		BIT(19)
>  #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
>  #define HID_QUIRK_NOINVERT			BIT(21)
> +#define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
>  #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
>  #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
>  #define HID_QUIRK_NO_IGNORE			BIT(30)
> 
> -- 
> 2.46.0
> 

