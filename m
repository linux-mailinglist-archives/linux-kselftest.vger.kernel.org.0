Return-Path: <linux-kselftest+bounces-31427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41651A993B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78F9466244
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A07290081;
	Wed, 23 Apr 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RI7Tw1As"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7A28A1DB;
	Wed, 23 Apr 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422703; cv=none; b=s+BHgmS/iGw6pFi8//D2ygWqhEvwCeZpI7iL7ZzjwpMa4J+h2BRzhSc7XhZJK3iJFtQwVzzdK8z8BixhLnr+UxywOHLYJK60ZYNT+VFmfTAexCQs4xQn760Rt0Ad1fWIrpVM6z9xTuVJrJHyyNzlqYU2wr/sdsiY9pfKs2P9zv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422703; c=relaxed/simple;
	bh=Abk3WUggpCh+pV9/jGehaWPhGHzsr5iDxN7IoX5cqEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EuPAQzh4QFDodIhDPBSJSI7AOnnLOMHO7A5xlkTFN/qlKZLZc5z/RkNuAqCMDz9tXcMQlLf78bfpq6o1MJfb5drL8lmA3RweaJJLMgttBMsyR97b+12vP+NAKH4fMgrsXAozvK3YCeXYi6qtECCmTyn1M+NEmvMooTZt9DyA0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RI7Tw1As; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1449D43201;
	Wed, 23 Apr 2025 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745422694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Abk3WUggpCh+pV9/jGehaWPhGHzsr5iDxN7IoX5cqEk=;
	b=RI7Tw1As9wOTHmRLRlOtw+97DusGjkgz5iMRLKZN4zcskq36CRb9ussT2NX7gXEdh90q7r
	POeVrueShYUjYRyn65z8VBjfO7iTqa/ZspwQMggtDMw3E7uMMC48R6WZou47bJ0oCgze/d
	xb5vD9tIm0T9icAfYRLJuQE1aslLweYHBA0hMYlsY/FV97+ZuevI1AS2ZMiBYPewPNmzHP
	vroE13/rb7Gl2LXV09Id2Du0mc/S0jjLsyK+HNJgSCKUPB9FLTgL3SLZiwDSQ71MgYofaA
	OsbniHoJmQ711I/9rNmlgjJpQ10ueCniBFkZSq8VBczxUgBqcTzGumXVtj+Zww==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 17:38:09 +0200
Message-Id: <D9E4PE3RTE37.2LU30RI1ZS6XL@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Florent Revest"
 <revest@chromium.org>, "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <9da88811-cce0-41df-8069-2e8b67541c39@huaweicloud.com>
 <D9BLCJSCHE9A.1IKHK3XBPF8MU@bootlin.com>
 <8b800c09-eade-4dcf-90f6-2f5a78170bc4@huaweicloud.com>
In-Reply-To: <8b800c09-eade-4dcf-90f6-2f5a78170bc4@huaweicloud.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeileejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepgihukhhuohhhrghisehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhn
 hdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

On Mon Apr 21, 2025 at 4:14 AM CEST, Xu Kuohai wrote:
> On 4/21/2025 12:02 AM, Alexis Lothor=C3=A9 wrote:
>> Hi Xu,
>>=20
>> On Thu Apr 17, 2025 at 4:10 PM CEST, Xu Kuohai wrote:
>>> On 4/17/2025 3:14 PM, Alexis Lothor=C3=A9 wrote:
>>>> Hi Andrii,
>>>>
>>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
>>>>> On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fou=
ndation)
>>>>> <alexis.lothore@bootlin.com> wrote:

[...]

>> Ah, thanks for those clear examples, I completely overlooked this
>> possibility. And now that you mention it, I feel a bit dumb because I no=
w
>> remember that you mentioned this in Puranjay's series...
>>=20
>> I took a quick look at the x86 JIT compiler for reference, and saw no co=
de
>> related to this specific case neither. So I searched in the kernel for
>> actual functions taking struct arguments by value AND being declared wit=
h some
>> packed or aligned attribute. I only found a handful of those, and none
>> seems to take enough arguments to have the corresponding struct passed o=
n the
>> stack. So rather than supporting this very specific case, I am tempted
>> to just return an error for now during trampoline creation if we detect =
such
>> structure (and then the JIT compiler can keep using data size to compute
>> alignment, now that it is sure not to receive custom alignments). Or am =
I
>> missing some actual cases involving those very specific alignments ?
>>=20
>
> How can we reliably 'detect' the case? If a function has such a parameter
> but we fail to detect it, the BPF trampoline will pass an incorrect value
> to the function, which is also unacceptable.

That's a question I still have to answer :) I imagined being able to detect
it thanks to some info somewhere in BTF, but I have to dig further to find
how.


Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


