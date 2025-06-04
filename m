Return-Path: <linux-kselftest+bounces-34296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF38ACDA75
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88563188C2F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C13242D80;
	Wed,  4 Jun 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n6lAo/+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9851171A1;
	Wed,  4 Jun 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027779; cv=none; b=WGpAXcQNie7aAzoDALmyForHEguh+xDDLyHy0K6T6AZTQIORrJ0fgGX8wXf8+PqjS7+1iIjlkKIYzwjm74bI7ZCS2AgJ0dvTvJdrV9IxYdxR6EvpWiLorc/o5e1layoVWeQ/B0RqJCFUl6OqM1xlklx0qrGxzkmN4wTb++8F8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027779; c=relaxed/simple;
	bh=ACscrL2viB9MccNiRSmG7exlusg6hWuddEnoY03JguA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fMQu8aMhTi36HgwKuG3G7c9lZT/DM2KAeZ7CBPpuLpZCBf0epHua08rHnnNackZKmmVJCaXA8f4fS5dhXIYIyPbEKHvBBl823pZLOS1Dy6P9Lyo7SaqP4jOJo19YgQYxyTdHQ7LVYJ9Vlhnm+owaVBuWlGErBdBZ1iq8bWAa4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n6lAo/+1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83E82432FC;
	Wed,  4 Jun 2025 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749027769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nmq+6v2A71B0bX8QqGblVfzuVcGFArdbHQL7ep/nDU=;
	b=n6lAo/+16LWdc57oz+Z5OQbqq5O62F1rsRLiGS2p6TFSfAjyskbkQtbhDEsZm1KdNCoX0S
	ng17QFnHMgV0DQUmociuS/rHsZLZsGJetjsJ6NFsM1vOioue2IrKX/PXoaZz2QKGB1L3X2
	ecnLSxmzffTC0quPLldjqPasHXpNPmMoqpi/x8t91vxrWfji/OeEnsihZ6dC99WzDo+J3s
	WnZ0TzE5fZD9tN/wijK3T18zor9d7kBJHiFcGPpI+eDK3izPQiW/6fGSkhPIXiyNPhEX04
	pQuHsQO6MB+4XF3FEo9sUOjA23gLZWYAiIHE+0QGRs6OChIvpQttLy7ANz/GfQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Jun 2025 11:02:44 +0200
Message-Id: <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
Subject: [Question] attributes encoding in BTF
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Andrii
 Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Florent Revest" <revest@chromium.org>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
In-Reply-To: <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetueeljeefkeejheduudfgffdvhfegffdvleeggeefvdeikefhleeuhefgtefgudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefvddprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigr
 dhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hi all,
a simpler version of this series has been merged, and so I am now taking a
look at the issue I have put aside in the merged version: dealing with more
specific data layout for arguments passed on stack. For example, a function
can pass small structs on stack, but this need special care when generating
the corresponding bpf trampolines. Those structs have specific alignment
specified by the target ABI, but it can also be altered with attributes
packing the structure or modifying the alignment.

Some platforms already support structs on stack (see
tracing_struct_many_args test), but as discussed earlier, those may suffer
from the same kind of issue mentioned above.

On Wed Apr 23, 2025 at 9:24 PM CEST, Alexis Lothor=C3=A9 wrote:
> Hi Andrii,
>
> On Wed Apr 23, 2025 at 7:15 PM CEST, Andrii Nakryiko wrote:
>> On Thu, Apr 17, 2025 at 12:14=E2=80=AFAM Alexis Lothor=C3=A9
>> <alexis.lothore@bootlin.com> wrote:
>>>
>>> Hi Andrii,
>>>
>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:

[...]

>> I'd suggest looking at btf__align_of() in libbpf (tools/lib/bpf/btf.c)
>> to see how we calculate alignment there. It seems to work decently
>> enough. It won't cover any arch-specific extra rules like double
>> needing 16-byte alignment (I vaguely remember something like that for
>> some architectures, but I might be misremembering), or anything
>> similar. It also won't detect (I don't think it's possible without
>> DWARF) artificially increased alignment with attribute((aligned(N))).
>
> Thanks for the pointer, I'll take a look at it. The more we discuss this
> series, the less member size sounds relevant for what I'm trying to achie=
ve
> here.
>
> Following Xu's comments, I have been thinking about how I could detect th=
e
> custom alignments and packing on structures, and I was wondering if I cou=
ld
> somehow benefit from __attribute__ encoding in BTF info ([1]). But
> following your hint, I also see some btf_is_struct_packed() in
> tools/lib/bpf/btf_dump.c that could help. I'll dig this further and see i=
f
> I can manage to make something work with all of this.

Andrii's comment above illustrates well my current issue: when functions
pass arguments on stack, we are missing info for some of them to correctly
build trampolines, especially for struct, which can have attributes like
__attribute__((packed)) or __attribute__((align(x))). [1] seems to be a
recent solution implemented for BTF to cover this need. IIUC it encodes any
arbitratry attribute affecting a data type or function, so if I have some
struct like this one in my kernel or a module:

struct foo {
    short b
    int a;
} __packed;

I would expect the corresponding BTF data to have some BTF_KIND_DECL_TAG
describing the "packed" attribute for the corresponding structure, but I
fail to find any of those when running:

$ bpftool btf dump file vmlinux format raw

In there I see some DECL_TAG but those are mostly 'bpf_kfunc', I see not
arbitrary attribute like 'packed' or 'aligned(x)'.

What I really need to do in the end is to be able to parse those alignments
attributes info in the kernel at runtime when generating trampolines, but I
hoped to be able to see them with bpftool first to validate the concept.

I started taking a look further at this and stumbled upon [2] in which Alan
gives many more details about the feature, so I did the following checks:
- kernel version 6.15.0-rc4 from bpf-next_base: it contains the updated
  Makefile.btf calling pahole with `--btf_features=3Dattributes`
- pahole v1.30
  $ pahole --supported_btf_features
  encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent=
_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var,attribut=
es
  This pahole comes from my distro pkg manager, but I have also done the
  same test with a freshly built pahole, while taking care of pulling the
  libbpf submodule.
- bpftool v7.6.0
    bpftool v7.6.0
    using libbpf v1.6
    features: llvm, skeletons

Could I be missing something obvious ? Or did I misunderstand the actual
attribute encoding feature ?

Thanks,

Alexis

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linu=
x.dev/
[2] https://lore.kernel.org/all/CA+icZUW31vpS=3DR3zM6G4FMkzuiQovqtd+e-8ihws=
K_A-QtSSYg@mail.gmail.com/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


