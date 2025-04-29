Return-Path: <linux-kselftest+bounces-31863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA0AA07B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BF93A92EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC82BCF5F;
	Tue, 29 Apr 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BaZ8t7kO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF3215070;
	Tue, 29 Apr 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920161; cv=none; b=NOFNEZGviUMKvzbPYU0HPm4eJz6pjheVwpyS6f/AEeEFv13f6JJW+WfM8C5476JZUpHew/cwvfLwf0d94VNuTcUJN22iwefwx7KoJOF7PQez1jjbGIypJJM8MpfheFQ2BopRmWlS4xP8FPMNGNNFbA6DRn2xBksf1hnpw8rYu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920161; c=relaxed/simple;
	bh=tqZ0WDpd3UCnsiyB13GsKoIcLdHmxLRzaHRSKG1EEsE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Y1/qkvhAbTCbUpDv4yrdZrYVCMGvvWlZYEp7KwcLmUuevrPJWXMzz1cVP0hD++mDYbqy77XOKitFmcIRl1OWqsfWXx5BjVlBJLkO6+BnMzpVzJ7HXePXp8r3PFfxS/nZIGN3mbTZSpU5Z2RNYnKOi9j0ZdkOUNnORwj2F+k0qj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BaZ8t7kO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 656F74328B;
	Tue, 29 Apr 2025 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745920150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqZ0WDpd3UCnsiyB13GsKoIcLdHmxLRzaHRSKG1EEsE=;
	b=BaZ8t7kO9QR35XhfDlLfJAdORCV3aUUi29DxhEffSeC4/qO92hJbYxjDTNjWePj37YQqqF
	qGV6UZvx7sYqEEapQ2sJNm8niEkNvhO1YEYSUYaDBCnaRPwA/+XiuSdXFeCM0VFFeU/bQY
	63jcFp8qOHYMrHQAugG28HWTCZ2mKc9+ShVrmzLnKjnShPn3uM5fl9OcmuIovrkmIk9dnB
	+mgoGULFSg3PqOsylSrO84e2Aq1HJ8dM5/81jemh5xyMQ8O6QnGTO/ieBXvFUb2f2tyJxA
	AscSm/s01ycVbb1sJuvhgTwL7GxTNG7mEqCS/+UO/dOKPnWJJyxUsEMvUKnq3Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 11:49:08 +0200
Message-Id: <D9J11FERN5K4.1OUFGN6L9LM9E@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf/selftests: add tests to validate
 proper arguments alignment on ARM64
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Eduard
 Zingerman" <eddyz87@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah
 Khan" <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>, "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
 <3a16fae0346d4f733fb1a67ae6420d8bf935dbd8.camel@gmail.com>
 <D9I6TQN2I6B1.QC4FFHEWAURZ@bootlin.com> <m21ptcmdnw.fsf@gmail.com>
 <D9IKA5K8PFAO.21V0PXVU6VPF1@bootlin.com>
In-Reply-To: <D9IKA5K8PFAO.21V0PXVU6VPF1@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetudfgvefhveeugeegudethffgvefhleetgfeijeejieejjeevgedtheegfeekhfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtr
 ggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

On Mon Apr 28, 2025 at 10:41 PM CEST, Alexis Lothor=C3=A9 wrote:
> On Mon Apr 28, 2025 at 6:52 PM CEST, Eduard Zingerman wrote:
>> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> If things really behaved correctly, f would not have the correct value bu=
t
> would still be handled as a 16 bytes value, so the test would not fail wi=
th
> "actual 35 !=3D 43", but something like "actual
> 27254487904906932132179118915584 !=3D 43" (43 << 64 | 35) I guess. I stil=
l
> need to sort this out.

And so indeed, the broken value is a big one:

(gdb) p skel->bss->t11_f
$4 =3D 793209995169510719523
(gdb) p/x skel->bss->t11_f
$5 =3D 0x2b0000000000000023
(gdb)

But we see the 35 (0x23) value in the error log because the formatters used=
 in
ASSERT_EQ truncate the actual value.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


