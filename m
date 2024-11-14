Return-Path: <linux-kselftest+bounces-22005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736E9C8364
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B942B23A13
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7801EE025;
	Thu, 14 Nov 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DAmkgmDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4F139D1B;
	Thu, 14 Nov 2024 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567356; cv=none; b=QROBMBuiImCwbfVLH+/VcaQLE+TGF2ockjKv9gdBkJz/B3Bzw75GVojOjPoWggMrS9W8uH53dHzVh2njjxKjQXi/dB69JLLe+c1/PKvVDTLoEVznUmvCpzkVshnuv4liS3JVS9QJdn83+PXCE5B/YCYNf2orlM7JFd/7XT2D7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567356; c=relaxed/simple;
	bh=tT+F9FX0TMseZ+QDnocmvAUWXy9+BVnVQc2W1Db5Rss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPQNNwiScBSlYSTPdvuQL29p0c0WYrQNfTKlyIRHwC2qVBrMgT4gYWDvAHcYrgsGVwIg7Q/e5onejpwCQD1KABCBCJX5fhWFvfdT7NkHWELdTvyr/6QGP3huPUnHn9suJ0RLi5+/HJp8Yt6hqdCUXaF8vwzr7jS1QzZbCR6ITSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DAmkgmDN; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731567337; bh=+w0VHjngWLWdo55EvCTs7zQIFu5eV9NVJlcIRyrLvOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DAmkgmDNDnG4ZA3nxM+krvSwbJtvxWV8E7LFy+TbutRxbxURDeK9Gcdm6Lh46WPoV
	 m+VKuUDfO3U7zdodFvEpLxMoINg/Rigr6pmY43iTkPAvEelz77EyXSHMTT7Eyj6z1z
	 ygvwM+zocIvX9CcKZfoGhmA50b54iu+OieT/thT0=
Received: from [IPV6:2408:8207:18a1:fd2f:e457:528e:9ee1:6f68] ([2408:8207:18a1:fd2f:e457:528e:9ee1:6f68])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D912D083; Thu, 14 Nov 2024 14:54:17 +0800
X-QQ-mid: xmsmtpt1731567257tvedqcqio
Message-ID: <tencent_9BB243901B8FF9FC0457B51D1CFF714B6209@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpkWv4L95cwz9okYRFwb4n+GrHtWM3SuwScZZsza+NN1BR9LV7vw
	 Yv/X6Qa+E/JuDiFW6ilYjaaisy7o5ihYVNVaxv3rkIbc4jNwUGRCRHAjUr2AeulZ44O02KiuGLuB
	 uJSKhGyMa5MGYHX70cE8GHFuavCbUxFLfspVxqFEeCySxDGjXPk3xaAu42zgJzN4TAcJPay8+h52
	 jT4v6dJZjAbe38063KKkRB849Pa7DfRSM3T9QdVR2PQNozT8x8JZzvhZ76A9z0olBShiF59wSXAg
	 HR4odeWdFDGH4rp+Kcxi79NhNuw31S5OlIqCcGokcfOS88DYOV7gzAmvQ4nwqN20WV/kXHGwTHTx
	 vxy4f8RAhCPIv9NWdSaRQ9EwNw8TOMLn6R3W+PEy0nH1yqebkDAtQGVOE1K3L//IxZogqMWjuQ59
	 Y24n0oEGzlDa20yogz1CdGL3PpQahTGB1cLxu6kcLwSTe4IKjSJRNnNBPjGJw3wtP8eulYgndQNi
	 aG0MoWxSVdq6hdz6lwQ2ALPNSHjNWXhmZapfHOMyevaaWAw/x1LKf67KpbQ5JQD00bSXkuX2UkOh
	 Sf7imZdpkyhqpttbOlm2+c6gP3isHkAi/XKmKaPFZi3QcutZDZlKm7ZJWq7L5I6CZOcTJaHh1GVs
	 6inWvn/btPA0vKQkZiy4vdURhND4M4Q+FerxUj8Z9oD5PNyRzBj7+d9B5TlPmpEXSYg/OLNcMoxx
	 av9ueh5f62Bc6BLkwV91+xpWTLy3QfiUMnSEyCTZAyvFtdgUkyE8M/I53/GkIVZA9m8fx3WXU24c
	 XWy0iCQKEKY/Xvvtuu+GdIggrDzdc3SimGwMMHFeGFMonKfGsgATBXlo6RCyC6v3rF6Y6Tw6+z55
	 1ZEGfk9pZrdDFOA/Amit/zdN4B1sQxXphzCKGPl8QkwAYltoJEaoIFGKq5iQ8aJnbSUMNYnmeQDJ
	 7U0PlMIHmzyCU8UVPGylHw/h3knu9Jd1pXA9wZZxxu1eiDU+q7g+JlsWJ8cQWr
X-QQ-XMRINFO: MFuljud3PUW4EHVQZqpniSQ=
X-OQ-MSGID: <61fc005e-f777-4ebf-bd1a-709161a9f06c@cyyself.name>
Date: Thu, 14 Nov 2024 14:54:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/14] riscv: hwprobe: Add thead vendor extension
 probing
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Samuel Holland <samuel.holland@sifive.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Guo Ren
 <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>,
 Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
 <20241113-xtheadvector-v11-10-236c22791ef9@rivosinc.com>
 <tencent_5B500856E30E1FB920B6B68D6315EE70CC06@qq.com>
 <ZzVoQi6D0U30p9sg@ghost>
 <tencent_6A95637042401AD5F8BE05C7B4F11CAD7009@qq.com>
 <ZzWAlJm1ShgsZr4m@ghost>
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <ZzWAlJm1ShgsZr4m@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/14/24 12:46, Charlie Jenkins wrote:
> On Thu, Nov 14, 2024 at 11:26:47AM +0800, Yangyu Chen wrote:
>>
>>
>> On 11/14/24 11:02, Charlie Jenkins wrote:
>>> On Thu, Nov 14, 2024 at 10:44:37AM +0800, Yangyu Chen wrote:
>>>>
>>>>
>>>> On 11/14/24 10:21, Charlie Jenkins wrote:
>>>>> Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
>>>>> allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
>>>>> vendor extension.
>>>>>
>>>>
>>>> Hi Charlie,
>>>>
>>>> How about changing the name of the key from
>>>> "RISCV_ISA_VENDOR_EXT_XTHEADVECTOR" to "RISCV_HWPROBE_KEY_VENDOR_EXT_0" and
>>>> use marchid to identify what the vendor is, each vendor will have its own
>>>> bit definition in this value. So we can avoid adding so many hwprobe keys
>>>> for each vendor in the future.
>>>>
>>>> I proposed a commit here: https://github.com/cyyself/linux/commit/36390645d85d1ac75dd71172f167719df4297f59
>>>
>>> I actually originally had this in one of my first versions of this
>>> series but was convinced by Conor to change it. The problem with it was
>>> that tying vendor extensions to mvendorid means that it is enforced by
>>> the kernel that vendors cannot share vendor extensions. It is possible
>>> for vendor A to purchase IP that contains a vendor extension from vendor
>>> B. This vendor extension should work on platforms created by vendor A
>>> and vendor B. However, vendor A and vendor B have different mvendorids,
>>> so the kernel can't support this if it is tied to mvendorid.  It could
>>> be solved by duplicating every extension that vendors have, but then
>>> userspace software would have to keep in mind the mvendorid they are
>>> running on and check the different extensions for the different vendors
>>> even though the implementation of the extension is the same.
>>>
>>> The original conversation where Conor and I agreed that it was better to
>>> have vendor extensions not rely on mvendorid:
>>>
>>> https://lore.kernel.org/linux-riscv/20240416-husband-flavored-96c1dad58b6e@wendy/
>>>
>>
>> Thanks for your explanation. I will strongly agree with Conor's opinion if
>> the feature bitmask does not exist in RISC-V C-ABI.
>>
>> However, as the feature mask defined in RISC-V C-ABI[1] uses the design
>> depending on marchid currently, should we reconsider this key for its use
>> case? The current target_clones and taget_version implemented in GCC[2] and
>> LLVM[3] also use the bitmask defined in C-ABI. I think if we use this key
>> depending on marchid, to make a key shared with all vendors will make this
>> cleaner.
> 
> Changing this will break linux userspace API. It is a non-workable
> solution for the kernel to associate extensions with marchid/mvendorid
> for the reasons provided. I fail to see why this ABI would require the
> kernel to behave in this manner. The ABI provides the marchid to be used
> by function multi-versioning and applications are free to use the
> marchid to change which function they want to compile. However, if they
> want to know if an extension is supported, then they need to use
> hwprobe. If they want to check if xtheadvector is supported, then they> call hwprobe with the xtheadvector key. This is true no matter what the
> mvendorid of the system is.

A userspace software can use either c-api defined feature masks or 
directly use hwprobe syscall. If they use c-api defined feature masks as 
GCC or LLVM did for compiler generated IFUNC resolver, the bitmask is 
guarded by mvendorid. So my point at that time was that if the C-API 
defined way became mainstream, why should we keep this key only for 
T-Head to increase the maintenance overhead?

This has been discussed here before in RISC-V C-API: 
https://github.com/riscv-non-isa/riscv-c-api-doc/pull/74#issuecomment-2128844747

But now (from the last email), you convinced me. So, I would like to 
make the c-api change: 
https://github.com/riscv-non-isa/riscv-c-api-doc/issues/96

> This does not add any complexity, "clean"
> code can equally be written following this scheme or following a scheme
> that relies on mvendorid. Ditching the reliance on mvendorid in the
> kernel allows the kernel to be as generic as possible, and allow
> whatever ABIs or hardware that exist to have a resiliant way of
> communicating with the kernel.
> 

OK. I'm just concerned about when these vendors will add the hwprobe key 
for their own extension, which may introduce a potential merge conflict 
in the kernel tree. It can also be a disaster if the hardware vendor 
ships their kernel with these under-review patches for their products 
with hwprobe key conflict with mainline kernel.

But we can avoid this now by adding each key for each vendor to avoid 
potential conflict in the future. This can be a separate patch for 
future work, so there is nothing to change here.

Thanks,
Yangyu Chen

> - CHarlie
> 
>>
>> [1] https://github.com/riscv-non-isa/riscv-c-api-doc/blob/main/src/c-api.adoc#function-multi-version
>> [2] https://github.com/gcc-mirror/gcc/blob/8564d0948c72df0a66d7eb47e15c6ab43e9b25ce/gcc/config/riscv/riscv.cc#L13016
>> [3] https://github.com/llvm/llvm-project/blob/f407dff50cdcbcfee9dd92397d3792627c3ac708/clang/lib/CodeGen/CGBuiltin.cpp#L14627
>>
>>>>
>>>>> This new key will allow userspace code to probe for which thead vendor
>>>>> extensions are supported. This API is modeled to be consistent with
>>>>> RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
>>>>> corresponding to a supported thead vendor extension of the cpumask set.
>>>>> Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
>>>>> to determine all of the supported thead vendor extensions in one call.
>>>>>
>>>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>>>> Reviewed-by: Evan Green <evan@rivosinc.com>
>>>>> ---
>>>>>     arch/riscv/include/asm/hwprobe.h                   |  3 +-
>>>>>     .../include/asm/vendor_extensions/thead_hwprobe.h  | 19 +++++++++++
>>>>>     .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
>>>>>     arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
>>>>>     arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
>>>>>     arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
>>>>>     arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
>>>>>     .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
>>>>>     8 files changed, 88 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>
>>



