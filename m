Return-Path: <linux-kselftest+bounces-21996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 420239C80F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B7BB25416
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0391E883C;
	Thu, 14 Nov 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hV5TlN8g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C018BBB6;
	Thu, 14 Nov 2024 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552301; cv=none; b=tQmtmWvgNEso3qa3ipM1TBOX+kYZxDkX/PEoZLzMxEFFi7DGJsWq9NF4Fu1vh2UMs5KexZeu459XbWCQRp8ZKufGPe89Yo5ZZR3WJv4xqMIcGUW2ZDlFt1WPhnN36DWa8e3GMeezu2dm62qaPuSLrlr/NmycWGc3/GXm8HxDbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552301; c=relaxed/simple;
	bh=OP453kPaQhp2G8oLRsZGApokUwIiEJiQ01yz9qZtW3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyf5zvzljlgzXw3Fbd17g1RP7xw+d0Vb/Sd5UERsnARckqC/iyyWgumZzWuehpfJRF+4+ui58LmdBr6oHu0dF9TcqkyC2QgzttssTim6AgLOkbQw/1uH1uOZcGGoOBJQD2qjLcQ4oxaP5w46y3VNUPG31EHLGCm40MRu1LjXGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hV5TlN8g; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731552282; bh=K9VMieeK/AcbTJGiy45ySp4wFRec//PkAXCg86pSVAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hV5TlN8gBoH4d3CsqGpM0WddALcQykFtjEXWpHIwhS6bI2bXO8Pl5WLQPypCFvUOK
	 +x9snkzNBELTeJ/le2WOqyknwlzoM0nI/wM6YC5TjZuwrPSZIT74iPuTxxOB3lk3sa
	 bRUOx4oYpWahRv9EwjRvAUPzy05Jzm7c9OSp7hO4=
Received: from [IPV6:2408:8207:18a1:fd2f:e457:528e:9ee1:6f68] ([2408:8207:18a1:fd2f:e457:528e:9ee1:6f68])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id B25AFED6; Thu, 14 Nov 2024 10:44:37 +0800
X-QQ-mid: xmsmtpt1731552277twisyswv5
Message-ID: <tencent_5B500856E30E1FB920B6B68D6315EE70CC06@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQypsnPJ05m3FqspBwVkFBEd/gU7ENwIHUXFuBRriRwaR2mNKoYlo
	 qngKfW4dHJ9PoBBJv72Sf3cGTli6vqSNlYlRuUuxdT9Uy6dg+deImZxYBrbNuxlx8rdH/3qo/J01
	 Ox4Ho8RraaG8XR4V/NIpDv3dofWDzMBdlPLBJ6Q09xjA3wVG1M7mazg0Dqplno/lh3gjS6WeCku6
	 fj+Nw/p7ZyPYya1nMulZsVWjIWwhlPYlZVtBjF9REUmaGIsDfGBl2URMOx3qucQ7uwWGdcB/By0C
	 gAxIhoGS9+HhX8FQAXnUE0MJZ9t69SVKEcsHMT2Bn3jLnhbNQTdGRLJ0pxEPK7NSjKuvFz1FTn4k
	 57kqaPLnMUm2Hn6wKN4HcKmWsZfQJzhJw3SR+LqNoSzlGP35aqBnrzVWP4Tsd4uhAEs+4R0PZ/YH
	 8Z6INMvfj6+Khl+4xlUTdPbALLjoeCA6XamMNZHmS+ZQlA4BRcVXB6qEckuNuhbZcpRxTQEG76Qg
	 D//XWOW4X9jArIz8MMWiN0ODtjcVQc6VLSC6WA3jiBNWvwftMkpgZ2uDjzaRLtOtiHt7jS7caETn
	 FVfbLDzzE34Q0YpoP85SIocMD6NYvIrKqq1ejhoApSuPLgXJK1Hbb1Ity6BB74ZKdaMe+82B0f/6
	 XSV3dsrfgyFeITr3/jgLrkMIvDh0ceAh9IiucdNgqgj4soA/Tu/whNeda8bh3N+HY7kZdfyp/RXt
	 VTkFN3JoMVng+ax7xhhfXjuLAEM3wgC3oaqNGF/EaEEnbcuQeVBKBQk39jNC7knmNzo1G/Ve2dpx
	 TAHQqDX4zFTQo1E8pjVdvls07UZHqbNZyUWJaIFeYXCy755SlXKwBzyLUCgX6v3Gab6SZf222BPC
	 Y8Qsv+68ncSL5vHlBeg68d/mfbZdARIMtR02Z9gliBiIO6O/5xcP9oHAzbcuQklDMbVx/abUi0RN
	 JKY+NTsvbZ9ACJnXzo/B6s8XcwJAwKgiYr/lvaPJoDi6jPAVcu/Pcfz1J3uDxU+De4vSAY65Ny8s
	 MrrGGgqly7BAS3SKTS
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <21b298dd-6071-41bf-985e-13724c4c730a@cyyself.name>
Date: Thu, 14 Nov 2024 10:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/14] riscv: hwprobe: Add thead vendor extension
 probing
To: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Samuel Holland <samuel.holland@sifive.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Guo Ren
 <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>,
 Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
 <20241113-xtheadvector-v11-10-236c22791ef9@rivosinc.com>
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20241113-xtheadvector-v11-10-236c22791ef9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/14/24 10:21, Charlie Jenkins wrote:
> Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
> allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
> vendor extension.
> 

Hi Charlie,

How about changing the name of the key from 
"RISCV_ISA_VENDOR_EXT_XTHEADVECTOR" to "RISCV_HWPROBE_KEY_VENDOR_EXT_0" 
and use marchid to identify what the vendor is, each vendor will have 
its own bit definition in this value. So we can avoid adding so many 
hwprobe keys for each vendor in the future.

I proposed a commit here: 
https://github.com/cyyself/linux/commit/36390645d85d1ac75dd71172f167719df4297f59

> This new key will allow userspace code to probe for which thead vendor
> extensions are supported. This API is modeled to be consistent with
> RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
> corresponding to a supported thead vendor extension of the cpumask set.
> Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
> to determine all of the supported thead vendor extensions in one call.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> ---
>   arch/riscv/include/asm/hwprobe.h                   |  3 +-
>   .../include/asm/vendor_extensions/thead_hwprobe.h  | 19 +++++++++++
>   .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
>   arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
>   arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
>   arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
>   arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
>   .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
>   8 files changed, 88 insertions(+), 2 deletions(-)
> 


