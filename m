Return-Path: <linux-kselftest+bounces-33841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D884AAC4B4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596F2189B4A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55E24DD14;
	Tue, 27 May 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xb2vwIHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54B2517B9;
	Tue, 27 May 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748337208; cv=none; b=hb/p28DMJMAlLA37fjD9RNAVKptRGp7IQBOM8xozFBKX1S36065McwvSThlt/Vtmb/n6/tjW2egspVtxJPCL0Hrf22F3ZIMzY76S3u97RtcngMBRdkAaDpbKBcLQqT6BW0ccLacqwq3M37QgREPzB41uR5yyGNmM39UrWiNKSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748337208; c=relaxed/simple;
	bh=zAuOrHemnpeLyMupl1/xQld0ci1rYZ5ezTxSN+CP3lU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TQgLeFllz6dSDLCa1l0pRfSvVMsg2R1ps4Kjf3B3y/HotJaQQxLJ/WqocNJvHyLeSlcNu5/QoX8X98uzOyWDPrCtLA0DPkEpoiDTwGzZytwwCZte9rCrnwzzB3/GQmESDdOxBcWhJWVC0lw/yVQAdDhJ8KAY7arJsWCZw6e0yEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xb2vwIHV; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72BCA43289;
	Tue, 27 May 2025 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748337203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg9vGp1YHkXIBdUOEtw6pvaguTK4l9KgzQWa/jWZ448=;
	b=Xb2vwIHVkxdOdtkzTqahMB8Ob0dPQkUA3ReoZGJM1L+qUX1Vj82fd4mZq3PzhNP32O1Jkx
	rxSGUArUiUNECAYK3qxLtiRJm5PaVkldh1ripu3EGGANBnyTGQYq5Z+wUniIQZpG3OSQyk
	fxy6iFkZ1zsno/GpVwOBAXOScSRK5Mgsp+pYsnop4MUJoH89/jvP3BX3j5OL2l62j7QPHZ
	TRfxyJo+oz1CBl0pusuylCCBt1fFB0hODm+XfsGwexCOGnNlrkkNuQndIhVhgWYEdQAkkB
	hu1CaDW+KPMGWdK7cB6wT/wJ4KKgUCIsA72wVLDaMj7d8mqzcV15qqamYMzVfw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 11:13:21 +0200
Message-Id: <DA6TTA76AU5Z.32W0O8EORBCQC@bootlin.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>
Cc: "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, "Xu Kuohai"
 <xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, arm64: Support up to 12 function
 arguments
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250522-many_args_arm64-v2-0-d6afdb9cf819@bootlin.com>
 <20250522-many_args_arm64-v2-1-d6afdb9cf819@bootlin.com>
 <8d184497-fecf-497f-8b4c-bcd4b0a697ce@huaweicloud.com>
 <DA6T7OEF94IG.2BH2PWTCVEOTA@bootlin.com>
 <5535f49f-8903-4055-b99a-cf8b2d4666e1@huaweicloud.com>
In-Reply-To: <5535f49f-8903-4055-b99a-cf8b2d4666e1@huaweicloud.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleelleculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefgfffhhefhfeegkefhffduhfehkeevffeluefhlefgfeeuveehvdekudfhheevnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmeguieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemugeihedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeftddprhgtphhtthhopeiguhhkuhhohhgriheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrf
 hgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

On Tue May 27, 2025 at 11:09 AM CEST, Xu Kuohai wrote:
> On 5/27/2025 4:45 PM, Alexis Lothor=C3=A9 wrote:
>
> [...]
>
>>>> +		/* We can not know for sure about exact alignment needs for
>>>> +		 * struct passed on stack, so deny those
>>>> +		 */
>>>> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>>>> +			return -EOPNOTSUPP;
>>> leave the error code as is, namely, return -ENOTSUPP?
>> Actually this change follows a complaint from checkpatch:
>>=20
>> "WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"
>
> Seems we can just ignore this warning, as ENOTSUPP is already used
> throughout bpf, and the actual value -524 is well recognized.

Ok, then I'll switch it back to ENOTSUPP


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


