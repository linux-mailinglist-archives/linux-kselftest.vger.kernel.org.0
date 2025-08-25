Return-Path: <linux-kselftest+bounces-39861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE6CB34704
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805C43B1D0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99452FDC27;
	Mon, 25 Aug 2025 16:20:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305C271A9D;
	Mon, 25 Aug 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138807; cv=none; b=RjHMAMJJIUr0CXJyPGWpTI4DhMjQm44EFxAZ/gHTlvlGSmq7/LePUrA5NbUcg03VSFjMd93spW9Nu5L/yk4u/6O+cgRNG0GrTTL7Gc8niEhTS/uFIWKYo5Lm0PfS4yH+ZClUzZliE+z/+dzQuBUIrFhN8kaFJz1jSDBikQsGwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138807; c=relaxed/simple;
	bh=jvP/MoODPqxFznKN/LTG9V/r7b3ws9cfp65aCZZR0fg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Xi2kCqe20bFDWEvbLOm525B5gdUxnyljWgr0V67EWtEyN5ARYx24YE5u52nSvYU8aLU5ECeS5aF0jZWG43SWhEvHgrtdjO+cpJI206rlGrYHaEN14PNDRFL+aVAGwSu4evD6zvputSeQ5Pmpte04jtLJbCZl8N15UPQlDyr1OQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from [192.168.110.25] (unknown [118.251.178.216])
	by APP-05 (Coremail) with SMTP id zQCowADXaVocjaxos6UhDw--.6581S2;
	Tue, 26 Aug 2025 00:19:42 +0800 (CST)
Message-ID: <b812bb46-6a26-456a-8210-d02138fb31a6@isrc.iscas.ac.cn>
Date: Tue, 26 Aug 2025 00:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: inochiama@gmail.com
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
 aou@eecs.berkeley.edu, charlie@rivosinc.com, cleger@rivosinc.com,
 conor+dt@kernel.org, cuiyunhui@bytedance.com, cyan.yang@sifive.com,
 devicetree@vger.kernel.org, jesse@rivosinc.com, krzk+dt@kernel.org,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 mikisabate@gmail.com, namcao@linutronix.de, palmer@dabbelt.com,
 parri.andrea@gmail.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
 pincheng.plct@isrc.iscas.ac.cn, robh@kernel.org, samuel.holland@sifive.com,
 shuah@kernel.org, thomas.weissschuh@linutronix.de, yikming2222@gmail.com,
 yongxuan.wang@sifive.com
References: <znik7dcyeipf57xerlm5gwjszcaaeujoukr7g4a7wt7lsfu366@skany6k7agt4>
Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd
 extension descriptions
From: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
In-Reply-To: <znik7dcyeipf57xerlm5gwjszcaaeujoukr7g4a7wt7lsfu366@skany6k7agt4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADXaVocjaxos6UhDw--.6581S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fKrWkurWxZr18AryUtrb_yoW8Kw4Upa
	93CF18KFZ8Xw13u3s7tw18Xw45Jr4kKr15AF47t34xKay5Ar10qFWakw1YvF18GF4xCF4I
	va1Ygw1fZ3ZrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

On 2025/8/23 6:34, Inochi Amaoto wrote:
 > On Thu, Aug 21, 2025 at 10:01:27PM +0800, Pincheng Wang wrote:
 >> Add descriptions for the Zilsd (Load/Store pair instructions) and
 >> Zclsd (Compressed Load/Store pair instructions) ISA extensions
 >> which were ratified in commit f88abf1 ("Integrating load/store
 >> pair for RV32 with the main manual") of the riscv-isa-manual.
 >>
 >> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
 >> ---
 >>   .../devicetree/bindings/riscv/extensions.yaml | 39 +++++++++++++++++++
 >>   1 file changed, 39 insertions(+)
 >>
 >> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml 
b/Documentation/devicetree/bindings/riscv/extensions.yaml
 >> index ede6a58ccf53..d72ffe8f6fa7 100644
 >> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
 >> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
 >> @@ -366,6 +366,20 @@ properties:
 >>               guarantee on LR/SC sequences, as ratified in commit 
b1d806605f87
 >>               ("Updated to ratified state.") of the riscv profiles 
specification.
 >>
 >> +        - const: zilsd
 >> +          description:
 >> +            The standard Zilsd extension which provides support for 
aligned
 >> +            register-pair load and store operations in 32-bit 
instruction
 >> +            encodings, as ratified in commit f88abf1 ("Integrating
 >> +            load/store pair for RV32 with the main manual") of 
riscv-isa-manual.
 >> +
 >> +        - const: zclsd
 >> +          description:
 >> +            The Zclsd extension implements the compressed (16-bit) 
version of the
 >> +            Load/Store Pair for RV32. As with Zilsd, this extension 
was ratified
 >> +            in commit f88abf1 ("Integrating load/store pair for 
RV32 with the
 >> +            main manual") of riscv-isa-manual.
 >> +
 >>           - const: zk
 >>             description:
 >>               The standard Zk Standard Scalar cryptography extension 
as ratified
 >> @@ -847,6 +861,16 @@ properties:
 >>               anyOf:
 >>                 - const: v
 >>                 - const: zve32x
 >
 >> +      # Zclsd depends on Zilsd and Zca
 >> +      - if:
 >> +          contains:
 >> +            anyOf:
 >> +              - const: zclsd
 >> +        then:
 >> +          contains:
 >> +            anyOf:
 >> +              - const: zilsd
 >> +              - const: zca
 >>
 >
 > Should be allOf? I see the comment says "Zclsd" requires both "Zilsd"
 > and "Zca".
 >
 > Regards,
 > Inochi

You're absolutely right, thank you for catching this. Since Zclsd 
depends on both Zilsd and Zca, the condition should use allOf to 
correctly enforce the conjunction. I'll fix this in next revision.

Best regards,
Pincheng Wang


