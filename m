Return-Path: <linux-kselftest+bounces-47960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA3CDDA43
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15FCE30155F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F58318140;
	Thu, 25 Dec 2025 10:15:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE330B50D;
	Thu, 25 Dec 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657711; cv=none; b=EQQYyRlahDkNQr3Yc/+3EK1YV79NIsyqDW/b/l5XcGPZS5io16tduv07R5Tl3Uq9baMzh4rXWB5A8IHfnfnsyvfin4a9R/NdY/+F9IuBd4pbeUVNaRP5Yx5ktnu31D41sV1Z8qRjp7q1f8uJlUt3xgtCiu+HF/rCi089o1GORJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657711; c=relaxed/simple;
	bh=quMzQLJ3gvgceF6EgP0zuFXasglHAAekjNTPMHmaPmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gzmor7VYhB6M5EWfSX1wQhZVoOvklMtm6pUn6Uqp5Kaj+Bl127WwO94BuEQRMbCBdKsUSiWak0Gh2TeQF2HRB69wA4yikxNG3UL9jbKYpkJhwldsgkKld9IrG0BijQuZ5uhpGP2Ljs/DpnqN6wZlHyWCpNLhc0nJJ5j1D2zUdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.82.59])
	by APP-01 (Coremail) with SMTP id qwCowACH826RDk1pT2zJAQ--.26576S2;
	Thu, 25 Dec 2025 18:14:42 +0800 (CST)
Message-ID: <38ce44c1-08cf-4e3f-8ade-20da224f529c@iscas.ac.cn>
Date: Thu, 25 Dec 2025 18:14:41 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/14] riscv: misaligned: request misaligned exception
 from SBI
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-7-cleger@rivosinc.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250523101932.1594077-7-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACH826RDk1pT2zJAQ--.26576S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4UuF4kAF45WFy8Kw13CFg_yoW8Xr48pF
	s5Gr4akrW5CrnFq3W3uwnFqF4Yvw4rGr4xJrsrJ343urs8Zr4FvF4ktF1DXa47JrWkuw10
	gFy3Kr1rua4DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jDsqXUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Clément and riscv maintainers:

On 5/23/25 18:19, Clément Léger wrote:
> Now that the kernel can handle misaligned accesses in S-mode, request
> misaligned access exception delegation from SBI. This uses the FWFT SBI
> extension defined in SBI version 3.0.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/cpufeature.h        |  3 +-
>  arch/riscv/kernel/traps_misaligned.c       | 71 +++++++++++++++++++++-
>  arch/riscv/kernel/unaligned_access_speed.c |  8 ++-
>  3 files changed, 77 insertions(+), 5 deletions(-)

This causes a regression on platforms where vector misaligned access can
be emulated with OpenSBI (since OpenSBI commit c2acc5e ("lib:
sbi_misaligned_ldst: Add handling of vector load/store"), because this
disables that with FWFT. This means that vector misaligned loads and
stores that were emulated instead get a SIGBUS.

This happens on Sophgo SG2044 and SpacemiT K1. Notably this causes these
platforms to fail Zicclsm which stipulates that misaligned vector memory
accesses succeed if vector instructions are available at all [1].

I'm not very certain why vector emulation support was omitted in this
series. Should we perhaps add the same emulation support to Linux as
well for the sake of these kind of platforms?

Thanks,
Vivian "dramforever" Wang

[1]: https://github.com/riscv/riscv-profiles/issues/58


