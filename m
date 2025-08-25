Return-Path: <linux-kselftest+bounces-39853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4BB345B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12A83AEBBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB252FC01F;
	Mon, 25 Aug 2025 15:26:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150482F3627;
	Mon, 25 Aug 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135601; cv=none; b=gABUvWdQlQYBOO2L1R66fCLNKwKrIPrOKg7rMSYmvTru/SVT1tWbRy7Pl3YQc7ocRQ8gUfkevlTsbNg+AzsQAmvJxANp4i1oko2fjhz43ZlrRvQUAI5N4ESc1KidQeq1kLroIUtD4mjWBGVXZaxoQwJW+rQ1JCeMV1fdxaFjj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135601; c=relaxed/simple;
	bh=KhMo0SpotGb/z4U7wZvB4jdhQVQqAkWRO5ZRQrh/7+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AE63sXjL+pTNLsEl9snY2VQeqOQWIcZJ8Ld0d0Gg73ah1XE7CW3oqWJV7wR9m96FZByrxKQP2mKUH+RKy1LRJv/QW6hvuexTeQkN4uQwugfyI+Z0HcCdqhws/h+6rDRA6sEf0mD3/PwegmgLesQeyj4mG81UtglbxSe0WlTqBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from [192.168.110.25] (unknown [118.251.178.216])
	by APP-05 (Coremail) with SMTP id zQCowACXLF2WgKxok2QfDw--.14476S2;
	Mon, 25 Aug 2025 23:26:15 +0800 (CST)
Message-ID: <a2cc4cbe-82ca-4a89-b623-73721a1f3baf@isrc.iscas.ac.cn>
Date: Mon, 25 Aug 2025 23:26:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd
 extension descriptions
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 anup@brainfault.org, pbonzini@redhat.com, shuah@kernel.org,
 cyan.yang@sifive.com, cleger@rivosinc.com, charlie@rivosinc.com,
 cuiyunhui@bytedance.com, samuel.holland@sifive.com, namcao@linutronix.de,
 jesse@rivosinc.com, inochiama@gmail.com, yongxuan.wang@sifive.com,
 ajones@ventanamicro.com, parri.andrea@gmail.com, mikisabate@gmail.com,
 yikming2222@gmail.com, thomas.weissschuh@linutronix.de,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
 <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>
 <20250822-purge-doubling-f38988284db1@spud>
From: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
In-Reply-To: <20250822-purge-doubling-f38988284db1@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowACXLF2WgKxok2QfDw--.14476S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr47Ww18Kw47Xr4xKrW3Jrb_yoW5Kr43pF
	Z3GF4kKa90qw13u3s2y3W0vw45AF4kKw13AFnrt34fKa98Zr10gF4ak3Z0qF1rCF48CF4j
	vw4Ygr15ZrsrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYsyCtUUUUU==
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

On 2025/8/23 0:33, Conor Dooley wrote:
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
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index ede6a58ccf53..d72ffe8f6fa7 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -366,6 +366,20 @@ properties:
>>               guarantee on LR/SC sequences, as ratified in commit b1d806605f87
>>               ("Updated to ratified state.") of the riscv profiles specification.
>>   
>> +        - const: zilsd
>> +          description:
>> +            The standard Zilsd extension which provides support for aligned
>> +            register-pair load and store operations in 32-bit instruction
>> +            encodings, as ratified in commit f88abf1 ("Integrating
>> +            load/store pair for RV32 with the main manual") of riscv-isa-manual.
>> +
>> +        - const: zclsd
>> +          description:
>> +            The Zclsd extension implements the compressed (16-bit) version of the
>> +            Load/Store Pair for RV32. As with Zilsd, this extension was ratified
>> +            in commit f88abf1 ("Integrating load/store pair for RV32 with the
>> +            main manual") of riscv-isa-manual.
>> +
>>           - const: zk
>>             description:
>>               The standard Zk Standard Scalar cryptography extension as ratified
>> @@ -847,6 +861,16 @@ properties:
>>               anyOf:
>>                 - const: v
>>                 - const: zve32x
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
>>   allOf:
>>     # Zcf extension does not exist on rv64
>> @@ -864,6 +888,21 @@ allOf:
>>             not:
>>               contains:
>>                 const: zcf
>> +  # Zilsd extension does not exist on rv64
>> +  - if:
>> +      properties:
> 
>> +        riscv,isa-extensions:
>> +          contains:
>> +            const: zilsd
> 
> This syntax is odd, it shouldn't be required to have zilsd in here and
> in the then. Did you copy this from Zcf or come up with it yourself
> because it didn't work otherwise?
> 

Yes, I did model this after the existing Zcf constraint in the same 
file. The structure is nearly identical: cheking for presence of the 
extension and rv64i, then forbidding it in the "then" branch.

I've tested confirmed that removing the "contains: const: zilsd" from 
the "if" condition still correctly enforces that zilsd must not appear 
when rv64i is present. The "then" clause with "not: contains" is sufficient.

Given that the validation behavior is equivalent, but the logic is 
cleaner and less redundant without the extra "contains", would you 
recommend updating it to the simpler form:

     - if:
         properties:
           riscv,isa-base:
             contains:
               const: rv64i
       then:
         properties:
           riscv,isa-extensions:
             not:
               contains:
                 const: zilsd

If so, I'll update it in the next revision.

Thanks for the review!

Best regards,
Pincheng Wang

>> +        riscv,isa-base:
>> +          contains:
>> +            const: rv64i
>> +    then:
>> +      properties:
>> +        riscv,isa-extensions:
>> +          not:
>> +            contains:
>> +              const: zilsd
>>   
>>   additionalProperties: true
>>   ...
>> -- 
>> 2.39.5
>>


