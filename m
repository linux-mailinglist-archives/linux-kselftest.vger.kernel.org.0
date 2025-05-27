Return-Path: <linux-kselftest+bounces-33838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFCAC4A7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948803B993D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79291FAC4B;
	Tue, 27 May 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WsHtfjyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A981DF26E;
	Tue, 27 May 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335514; cv=none; b=eWy4V8wQmH0ZUwjKWfeeKBxHauc9QK0fjh4NNBs3p0Ft6mDJhPHgk3noSTEMG7cZDnhMnrdSg9NGIxl+i1fQ8tILGqaTK55H5rAFdC1nuwZJHVsQWl2O0u2M7wZtgLdoNuJGo62Ru8L7MFTDB7jAQgtZsb0K7FSpFTykfGDCeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335514; c=relaxed/simple;
	bh=q9A5It0VcKJo2Z0sOBgikusUjjLmdwUMhdXXAWimklU=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=ZiXnbxk7AGGP5le5WEduWlyC22u8RbgVakpEdgHddXyHnr1OmYdRy7psfhmYaDjbg/spZyqOASqwslmTnsl2ZopuYooxF6l7kxUWbCwFyNTFV9c+mDG1i7+Dk4vfuYo89Vht4E7TCrQNMgkPKGae+n83U09ZdBBB4kErPWgMHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WsHtfjyb; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 701CF43137;
	Tue, 27 May 2025 08:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748335510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzPRMr1l+fHaNToRkbY1GkYZ/zbxBgq6V8xrU1tHPf8=;
	b=WsHtfjyboYTn/inoED+hlu32+QYRGzVRTfeTxdp4gHe0upe98p4LMB8qXn4HvSNRYlUo0P
	7X5QOwXR+mVsIlNhhLnSgqo56DgD0KhdaRFeMMV+rIhpTm4V5EDCbnOqYO448ucWaJ8lih
	yTsdqmHp3lKzba+38ROjgdOTObnT5A1u3HMSCn4xndSuwcNscAQekWO5izBz6Yfp4RiqlO
	snkxmUjnPsQZEuO2D48+cvX0sqhldyw6b4Ml/ZwU9FsLdaS2PW8qUagGqfstCDPPoFg/Lw
	4eE0U/M9lzRCgpLz1w8SjY1h3XgCpUfQxbTC+klPVsmED9PpYGvnksdxgwljsg==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 10:45:07 +0200
Message-Id: <DA6T7OEF94IG.2BH2PWTCVEOTA@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
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
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250522-many_args_arm64-v2-0-d6afdb9cf819@bootlin.com>
 <20250522-many_args_arm64-v2-1-d6afdb9cf819@bootlin.com>
 <8d184497-fecf-497f-8b4c-bcd4b0a697ce@huaweicloud.com>
In-Reply-To: <8d184497-fecf-497f-8b4c-bcd4b0a697ce@huaweicloud.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleelfeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgffkffhvfevufgggffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffefiedtuedvgfekkeefteelkedvheehvdetuedtgfekueeuheelhfdvgfdtvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmeguieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemugeihedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeftddprhgtphhtthhopeiguhhkuhhohhgriheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrf
 hgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Xu, thanks for the review

On Tue May 27, 2025 at 10:11 AM CEST, Xu Kuohai wrote:
> On 5/22/2025 6:14 PM, Alexis Lothor=C3=A9 wrote:
>
> [...]
>
>> -static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
>> +struct arg_aux {
>> +	/* how many args are passed through registers, the rest of the args ar=
e
>> +	 * passed through stack
>> +	 */
>> +	int args_in_regs;
>> +	/* how many registers are used to pass arguments */
>> +	int regs_for_args;
>> +	/* how much stack is used for additional args passed to bpf program
>> +	 * that did not fit in original function registers
>> +	 **/
>
> nit: "**/" should be "*/"

ACK

[...]

>> +	a->ostack_for_args =3D 0;
>> +
>> +	/* the rest arguments are passed through stack */
>> +	for (a->ostack_for_args =3D 0, a->bstack_for_args =3D 0;
>> +	     i < m->nr_args; i++) {
>
> a->ostack_for_args is initialized twice.
>
> move all initializations before the loop?

ACK

>> +		/* We can not know for sure about exact alignment needs for
>> +		 * struct passed on stack, so deny those
>> +		 */
>> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
>> +			return -EOPNOTSUPP;
>
> leave the error code as is, namely, return -ENOTSUPP?

Actually this change follows a complaint from checkpatch:

"WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"

>> +		stack_slots =3D (m->arg_size[i] + 7) / 8;
>> +		/* AAPCS 64 C.14: arguments passed on stack must be aligned to
>> +		 * max(8, arg_natural_alignment)
>> +		 */
>> +		a->bstack_for_args +=3D stack_slots * 8;
>> +		a->ostack_for_args =3D round_up(a->ostack_for_args + stack_slots * 8,=
 8);
>
> since a->ostack_for_args starts from 0 and is always incremented
> by multiples of 8, round_up() to 8 is not needed.

True. This is a (partial) remnant from the first attempt to handle more
exotic alignments like large structs or __int128, but that's indeed not
needed for this current version. I'll clean it up.

[...]

>> +	for (i =3D a->args_in_regs; i < m->nr_args; i++) {
>> +		slots =3D (m->arg_size[i] + 7) / 8;
>> +		/* AAPCS C.14: additional arguments on stack must be
>> +		 * aligned on max(8, arg_natural_alignment)
>> +		 */
>> +		soff =3D round_up(soff, 8);
>> +		if (for_call_origin)
>> +			doff =3D  round_up(doff, 8);
>
> since both soff and doff start from multiples of 8 and are
> incremented by 8 each time, the two round_up()s are also
> not needed.

ACK. I guess the small AAPCS mention can go too then.

>
>> +		/* verifier ensures arg_size <=3D 16, so slots equals 1 or 2 */
>> +		while (slots-- > 0) {
>> +			emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
>> +			/* if there is unused space in the last slot, clear
>> +			 * the garbage contained in the space.
>> +			 */
>> +			if (slots =3D=3D 0 && !for_call_origin)
>> +				clear_garbage(ctx, tmp, m->arg_size[i] % 8);
>> +			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
>> +			soff +=3D 8;
>> +			doff +=3D 8;
>> +		}
>> +	}
>> +}
>
> [...]




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


