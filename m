Return-Path: <linux-kselftest+bounces-21299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5459B9295
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8143FB209EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21C1A072A;
	Fri,  1 Nov 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="J/1qwaVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WD4Sy3tW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C14158DD0;
	Fri,  1 Nov 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469169; cv=none; b=BbjZzMWCAO813W0yIcjW5A87l/yW6LxXL/LF7n/51lN8Ov2JZ0FaAdiNIvm2+LYdaaZ8nQ9BKYO6aTILjQod0fUW0WLgocMSfIthg1zwgwrKs9HyxFRoqR8WaF6bYYIbSC2Y86r6uKOxh6rekBdnAWeWHisdPXPqLr/MEzZsVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469169; c=relaxed/simple;
	bh=naw23hsmsf6GRAwCdWA77TY/jiszs6qesqCKe7WNEDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJy+K8/KmdsOkGWmwW+8neIqskL7MBau/XoZhXCZys/BZbNOUkt2GagISvFkMaetzeAAPQ8mNCR43KAkVW0B9HbWXcDfH40MXaBe7capRuhLhy0rbsxfORqxfsNb195ZGQu3yYdhWpeae96wtEdDx6x16FRwJg30irEND23cOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=J/1qwaVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WD4Sy3tW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 14A8911400F7;
	Fri,  1 Nov 2024 09:52:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 01 Nov 2024 09:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730469161; x=1730555561; bh=OM4a9KmiKy
	BYymvUt/3Ss+GNBym2SjdQJLLohwjJ+bo=; b=J/1qwaVPoY/CP3CWiMVOQ4zh/9
	xHWItsbIbKTvINImd8nAjP3dhcsjUI6rp7jMHlGeGAx4Tt1fhvJzDe+briiACM3M
	6TXY7L+OXAF8r3g95jS+WbqmVZZqhkLJ8yXTo6Rb9DziyfGwYD85Pdaxft1RBExI
	POTVb2ynsA1g5ZmJDD/SruWn+vD3bM+CDa6oTxrE/4BMLyB8Fn+vTVNGCEjsJpbK
	bvoji4QcxieO93sTZUxztnkFtyOCbMVB4fJztrNEzngY4r5MDKaIJpK9Lnzyi0fQ
	laJOVC3+KH3AEnomEEGZ0omdxkpaUQemCUBpjymFcIwfxLyUNL4xVl3cUi9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730469161; x=1730555561; bh=OM4a9KmiKyBYymvUt/3Ss+GNBym2SjdQJLL
	ohwjJ+bo=; b=WD4Sy3tW1u5Wc7jnHI/lUlfuItn6PTNPneLNtw1EOIN3RxBK5CY
	Wa014ELgAy6rxuA4Rwg19SC/7MxA8dSioyxi5hUaZubLhRXM6qoN/kNYhMvAqgCu
	zBMQIybjF3b4LljZCZfAtSB5Ky/AsysXY7/bGLSDw9j++I1hNm0YqvgBUKrBPrju
	kV79UUKlPTRXAY/FaveOXu5oupjOiyAcmj7fJWb8O8cHO3Iys7WykwnUKSklv0CF
	/wp2R323CL+8UC68V9o+UO8R4t4TSl44c4FJcYL4v1MJov8KFUD4W69ZOzwzKtTo
	hQg1KstbG7fDpyVUQSI64tAojkzFA4NsZuQ==
X-ME-Sender: <xms:Kd0kZ4r1TXm3h3fsDELlcIm9VJFWC0QSikt4C6vi1iFp2Bd92N2WIw>
    <xme:Kd0kZ-qj-f8oumc10ND6ehhQpVaoaOnGiBpnz-nwVSfBT5aHyMc8APHsFn3mvuFv1
    4aTa4FRve1G0vem0g>
X-ME-Received: <xmr:Kd0kZ9Nep0UT1SJRFM0TxApcCetfjETsVkuzpD0Gx24Ow7hW_JBnARK5g-W7VXW_4OMldH1S6IS6kQ5w1FQ-qyGwEEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvden
    ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
    ftrfgrthhtvghrnheptdejueetkeehfeeuleeugfevieffkefhteefiedvfeehuefhjeeg
    vdeiffeihfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtth
    hopegurghvihgughhofiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhmohgrrhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhhithdquggvvhesghhoohhglhgvgh
    hrohhuphhsrdgtohhmpdhrtghpthhtohepsghrvghnuggrnhdrhhhighhgihhnsheslhhi
    nhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Kd0kZ_5d3LDLh1DekeT9AwgpKb3K3LEt2rH5_8b5VVkBofwhBOCNMw>
    <xmx:Kd0kZ379sXAOM_dQgTdOjQQt3gsPVQCaFLaD-VWVZrz4d9ROio3T_A>
    <xmx:Kd0kZ_i-llo3F56A_mcGNlURkBAej3eiHke5eGkODjH_XqytylXGwQ>
    <xmx:Kd0kZx6x_5A2QAd5kXrXGN1txawY5U3pxRMBRlpwkfhPrU9CTRo5Pw>
    <xmx:Kd0kZ6b8G-q6L1C_peNDYwxmMN0fIFxoi8yj9Ab28GI69MWSlBPgbTp->
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 09:52:41 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 5AE2289888E9; Fri, 01 Nov 2024 14:52:39 +0100 (CET)
Date: Fri, 1 Nov 2024 14:52:39 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kunit: enable hardware acceleration when available
Message-ID: <jhmonkl53vrgz3pjhbbopvrx6infgbezlsvba3luccrpwtnmtb@ptobfcxrr4ud>
References: <20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com>
 <20241025-kunit-qemu-accel-macos-v1-2-2f30c26192d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z4djprvhauy3hwsd"
Content-Disposition: inline
In-Reply-To: <20241025-kunit-qemu-accel-macos-v1-2-2f30c26192d4@gmail.com>


--z4djprvhauy3hwsd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] kunit: enable hardware acceleration when available
MIME-Version: 1.0

On Fri, Oct 25, 2024 at 05:03:54PM -0400, Tamir Duberstein wrote:
> @@ -124,6 +125,29 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>  				'-no-reboot',
>  				'-nographic',
>  				'-serial', self._serial] + self._extra_qemu_params
> +		accelerators = {
> +			line.strip()
> +			for line in subprocess.check_output([qemu_binary, "-accel", "help"], text=True).splitlines()
> +			if line and line.islower()
> +		}
> +		if 'kvm' in accelerators:
> +			try:
> +				with open('/dev/kvm', 'rb+'):
> +					qemu_command.extend(['-accel', 'kvm'])
> +			except OSError as e:
> +				print(e)
> +		elif 'hvf' in accelerators:
> +			try:
> +				for line in subprocess.check_output(['sysctl', 'kern.hv_support'], text=True).splitlines():
> +					if not line:
> +						continue
> +					key, value = line.split(':')
> +					if key == 'kern.hv_support' and bool(value):
> +						qemu_command.extend(['-accel', 'hvf'])
> +						break
> +			except subprocess.CalledProcessError as e:
> +				print(e)
> +

QEMU supports falling back if one accelerator is not available, if you
specify multiple like -accel kvm:tcg.  Couldn't you rely on that rather
than re-implementing the availability checks here?

--z4djprvhauy3hwsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmck3R8ACgkQ+dvtSFmy
ccDsHBAAonD29UCU+Ic/GmKgoVj3InBFyhVA3AlAE7jqh2rO8nzwjmHY7t9mGXIV
36XHtgv5f7HK5b3pixZbULMDnWRhreT7TMYSQ/7T5GGXvlDYyXQsuwjyNhehdJQF
PlGpIhyM33pjI6TEEKs579h771hrSGwtrDfzKToMEDKYYbM36fPP/YWOnCMSeJeA
2FhyoW8pd5FgQDbDVgsHZQFDk9m9g3R3sTKwl8zyUDdG8PCh5go4k7WTLRlCGzAd
uJxdEG7IjLs3xiaTILDpFBWPcnPDlvqrd9IYCQvNQbVpFAJo7zfoZyeodIiczBAf
ydNjaC4vB43TebBepQQDw2dWOKssbzEnxlDIHDuATVcWGRqOX35p71bjPrK+2ge+
RJ6x4qabr+BYUw62YiFz/JxYMqtf2xfovYhJFyvUfVQBlg9eN159V+7fSd6MS4tW
gBO54874n8Lt2GftkqvFIqZu9hbDby6j1Kece+sVjmKvHntf9g+JQYbh6ZqpdzLr
ms4zvSwasn4i+dSBemTeORjcsSqOSplA882gTV/uwEpbh3+Ss+7TJnWcIB2G6ppD
4whU8T+yURQCP2Kll+/JUp2w5MGXFb4XiLEomwivL4fBoQwGwXIe8rZ/1sfg9YZk
rBPdywmjODmm/axrAekXdU15EcCYLonX7gzhy7OxEM55V17o+7Q=
=N5Ic
-----END PGP SIGNATURE-----

--z4djprvhauy3hwsd--

