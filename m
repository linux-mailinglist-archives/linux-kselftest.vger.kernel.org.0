Return-Path: <linux-kselftest+bounces-26937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3446A3B2C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802931675B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D641C3C11;
	Wed, 19 Feb 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iQvGlwUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58E1BEF71;
	Wed, 19 Feb 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951079; cv=none; b=Q3joQjQPy1MuKCW8FFDr9fWtaGKrtJDAFe3GQiMXDBp4S485lqoszsVqyabLhglSURRUzLgvnSgoxUW2kKM66+xXAdWVi8Zz8JjC9QaWmZdb1SNfXzWr80Y53zCBsUNvSL+5U5QC9bqR1d/jurjVU/89BlneD6+G7fmhBfPp7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951079; c=relaxed/simple;
	bh=JNLUMbnFqJXutgxvcHQL9cO9N2ZVoR71NPVabf4+bWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7hrQc80apZE0d6ZcOihOPPt+QNuJWzRJPVOkF7hU3bqmUyxgOEmv6z/fL8OPU4fTY21YwdGhOuZ1noPtYEyNOJ7eNR8dy1BbACEkMOsOIY2Oj3qFZC0w7qZcsalQFCLMnOgbeeocmWaasdh4WK8AnMJc5Tpf/LmWGy76e7OGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iQvGlwUT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6979441ED;
	Wed, 19 Feb 2025 07:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739951069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPsHp+vytkzxnMXgitj2n5MJUVi6FZObC5a+EhW2+yM=;
	b=iQvGlwUT+79eHQ8JoqYojxwWezGyWuwDqe2KQUxcryko7oPdXMvps9RaJOmv8eZYGZj9/h
	BnoBvPy9PlIWYZb3bxLyjywiRAPjGz1Fe8kz7F9HXApIrqAlMX5jmH2MBVqm8lctMXRAKm
	loiz8SAAOrWIcIzdWXw3w8VsC2rOPFQLHTZZmqAPR4QFOhmzlb5VoyBeT2aCE46RMwPW0u
	3f+Sw2uVeu8A1UR0zg4f3ybCGHHfRO4dmQQdkkFzAp4RVc5dfl6ET+5UEJru+S7Vf49/Km
	Tw/jHdBywagwdIUZmjeoqu+kXHYH4/4j2quyCvqhHYyVgHV8X9LIMis4WxIKuA==
Message-ID: <e3838d93-04e3-4e96-af53-e9e63550d7ba@bootlin.com>
Date: Wed, 19 Feb 2025 08:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: tc_links/tc_opts: Unserialize
 tests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
 <Z7T6J4BpIrBcsWPM@mini-arch>
 <CAADnVQLktLYJ5_jjve0A=oOWZFRvs3NGfuQUXwpCmw6q+U_Ltw@mail.gmail.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <CAADnVQLktLYJ5_jjve0A=oOWZFRvs3NGfuQUXwpCmw6q+U_Ltw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeiueejvdevvedvtdekteejieeuvdfgjefgvddtvdevjeegleeufeekteevkedvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopehsthhfohhmihgthhgvvhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi,

On 2/19/25 4:40 AM, Alexei Starovoitov wrote:
> On Tue, Feb 18, 2025 at 1:22 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
>>
>> On 02/17, Bastien Curutchet (eBPF Foundation) wrote:
>>> Hi all,
>>>
>>> Both tc_links.c and tc_opts.c do their tests on the loopback interface.
>>> It prevents from parallelizing their executions.
>>>
>>> Use namespaces and the new append_tid() helper to allow this
>>> parallelization.
>>>
>>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>>
>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>
>> LGTM, thank you! Optionally, if there is more to convert, we can think
>> about moving create_and_open_tid_ns to the test_progs itself. For example,
>> if the test name starts with ns_, test_progs can probably do the
>> create_and_open_tid_ns/netns_free part?
> 
> That's a good idea.
> Let's do it now.
> Otherwise most of the patch 2 will be reverted when it's introduced.
> 

Ok, I'll send a V2 with this in test_progs.


Best regards,
Bastien


