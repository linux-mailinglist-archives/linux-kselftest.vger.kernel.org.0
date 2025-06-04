Return-Path: <linux-kselftest+bounces-34330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D7ACE3AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF53A36A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5200F18C02E;
	Wed,  4 Jun 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WJQ/VWxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC381AC8;
	Wed,  4 Jun 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058296; cv=none; b=Em1313WlpiqKdKhv4qATqWyim1thSJhPhPaS3Pnj0CRRbxEv0vb0Nfp9OYUwbI9YK42mYVv/VP9G5dB6W5xWCPfSyQo7WeRf8gvDsufccNzfc+bPH0D5o00p6RQTJ8bZs45QEYVc27PPzozhQxdV8ZHlwdlx4xs1xv9/J98DSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058296; c=relaxed/simple;
	bh=MWXRvUe9Er4znH/AsHQZLrU5RXMXc/v8wZVtsMhvu7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxXOuXRKOshSB5HwwOiBEj7TPKlY8j3x9KUX8HEDI9Ker3DQIK1xJ++0Pa9h6Z44UoUNFOr+3f7+sNBbzrN1U44n6z23etW2e8xyxwipi7FbtYIO+P2+S2X3Ovgdtu81ZWbEWp0R4a1uGG2nM18r9LVpID9Z3kmj6W+DKnjx2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WJQ/VWxP; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749058290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cblBX32hBSMGN1bRDDUz9lTIgViFoNWr1i8Qx9BOzE8=;
	b=WJQ/VWxP668jiRTd22ItARHZuzMoQhmaB3SO9vl1+6W071uWHgtq0WoRfz95O3x72EkcxN
	nK2Fw6Mj7kwzdJRBT7BaXuujz/MetlaBuXdFjGnGGXFy27OLanDhT1Kr6hd6AZ1ws9O/2i
	NQA4CGWnOHunrOES5pTIOxAnVt98148=
Date: Wed, 4 Jun 2025 10:31:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Question] attributes encoding in BTF
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Florent Revest <revest@chromium.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 dwarves@vger.kernel.org
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
 <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/4/25 2:02 AM, Alexis LothorÃ© wrote:
> Hi all,
> a simpler version of this series has been merged, and so I am now taking a
> look at the issue I have put aside in the merged version: dealing with more
> specific data layout for arguments passed on stack. For example, a function
> can pass small structs on stack, but this need special care when generating
> the corresponding bpf trampolines. Those structs have specific alignment
> specified by the target ABI, but it can also be altered with attributes
> packing the structure or modifying the alignment.
> 
> Some platforms already support structs on stack (see
> tracing_struct_many_args test), but as discussed earlier, those may suffer
> from the same kind of issue mentioned above.
> 
> On Wed Apr 23, 2025 at 9:24 PM CEST, Alexis Lothoré wrote:
>> Hi Andrii,
>>
>> On Wed Apr 23, 2025 at 7:15 PM CEST, Andrii Nakryiko wrote:
>>> On Thu, Apr 17, 2025 at 12:14 AM Alexis Lothoré
>>> <alexis.lothore@bootlin.com> wrote:
>>>>
>>>> Hi Andrii,
>>>>
>>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
> 
> [...]
> 
>>> I'd suggest looking at btf__align_of() in libbpf (tools/lib/bpf/btf.c)
>>> to see how we calculate alignment there. It seems to work decently
>>> enough. It won't cover any arch-specific extra rules like double
>>> needing 16-byte alignment (I vaguely remember something like that for
>>> some architectures, but I might be misremembering), or anything
>>> similar. It also won't detect (I don't think it's possible without
>>> DWARF) artificially increased alignment with attribute((aligned(N))).
>>
>> Thanks for the pointer, I'll take a look at it. The more we discuss this
>> series, the less member size sounds relevant for what I'm trying to achieve
>> here.
>>
>> Following Xu's comments, I have been thinking about how I could detect the
>> custom alignments and packing on structures, and I was wondering if I could
>> somehow benefit from __attribute__ encoding in BTF info ([1]). But
>> following your hint, I also see some btf_is_struct_packed() in
>> tools/lib/bpf/btf_dump.c that could help. I'll dig this further and see if
>> I can manage to make something work with all of this.
> 
> Andrii's comment above illustrates well my current issue: when functions
> pass arguments on stack, we are missing info for some of them to correctly
> build trampolines, especially for struct, which can have attributes like
> __attribute__((packed)) or __attribute__((align(x))). [1] seems to be a
> recent solution implemented for BTF to cover this need. IIUC it encodes any
> arbitratry attribute affecting a data type or function, so if I have some
> struct like this one in my kernel or a module:
> 
> struct foo {
>      short b
>      int a;
> } __packed;
> 
> I would expect the corresponding BTF data to have some BTF_KIND_DECL_TAG
> describing the "packed" attribute for the corresponding structure, but I
> fail to find any of those when running:
> 
> $ bpftool btf dump file vmlinux format raw
> 
> In there I see some DECL_TAG but those are mostly 'bpf_kfunc', I see not
> arbitrary attribute like 'packed' or 'aligned(x)'.
> 
> What I really need to do in the end is to be able to parse those alignments
> attributes info in the kernel at runtime when generating trampolines, but I
> hoped to be able to see them with bpftool first to validate the concept.
> 
> I started taking a look further at this and stumbled upon [2] in which Alan
> gives many more details about the feature, so I did the following checks:
> - kernel version 6.15.0-rc4 from bpf-next_base: it contains the updated
>    Makefile.btf calling pahole with `--btf_features=attributes`
> - pahole v1.30
>    $ pahole --supported_btf_features
>    encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var,attributes
>    This pahole comes from my distro pkg manager, but I have also done the
>    same test with a freshly built pahole, while taking care of pulling the
>    libbpf submodule.
> - bpftool v7.6.0
>      bpftool v7.6.0
>      using libbpf v1.6
>      features: llvm, skeletons
> 
> Could I be missing something obvious ? Or did I misunderstand the actual
> attribute encoding feature ?

Hi Alexis.

The changes recently landed in pahole and libbpf re attributes had a 
very narrow goal: passing through particular attributes for some BPF 
kfuncs from the kernel source to vmlinux.h

BTF now has a way of encoding any attribute (as opposed to only bpf 
type/decl tags) by setting type/decl tag kind flag [1]. So it is 
possible to represent attributes like packed and aligned in BTF.

However, the BTF tags need to be generated by something, in case of 
vmlinux by pahole. Pahole generates BTF by parsing DWARF. And, as far as 
I understand, attributes are not (can not be?) represented in DWARF in a 
generic way, it really depends on specifics of the attribute.

In order to support packed/aligned, pahole needs to know how to figure 
them out from DWARF input and add the tags to BTF. And this does not 
happen right now, which is why you don't see anything in bpftool output.

[1] 
https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

> 
> Thanks,
> 
> Alexis
> 
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/all/CA+icZUW31vpS=R3zM6G4FMkzuiQovqtd+e-8ihwsK_A-QtSSYg@mail.gmail.com/
> 


