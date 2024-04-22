Return-Path: <linux-kselftest+bounces-8600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A78AC81C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708C52818BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3F54919;
	Mon, 22 Apr 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zq86nSpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859453E27
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775991; cv=none; b=oiAlc3IxzdzuYzC1DccJlxy6zUYSJX4Wu4Zwc9iCVei2y55qqGpRLDhs9LOGMk+IuFPANIQdFGbU1rMJoGl+L3NwQV24biUqXlT4igS69BONpwH/Dl80dZOVX+dsFvL2ovxJQdlscK666OiYRi/2Dmu2BBb4UIwdX5phUhUVQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775991; c=relaxed/simple;
	bh=nleU09vurZd5AuLxgNnsP+QcvquS4B0Ob3oAXLFJzZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2lTQuWtG2aeYiOV/yYHIsKGWSNpkWMAshfxSZqafbSSGvg0EOSZu5RB6eD/4LfdXz7ZcJUCUiWgg6R6g0xkLJNUx/Pw62IYzgceDVfvkZ1EKHXCW4mQ0Jv/KTH7lxeZdzVQEYIHe0XZ2gcFkTf5JtxIrAb/ecueH2korqqXpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zq86nSpI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349fd1d3723so858705f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713775986; x=1714380786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/fvR+HwOJPjnOfbOHG69UP92YiSjqkbM928Puj2/Go=;
        b=Zq86nSpI55jjwJBRIYNddD+VzEJWuOhqk1Rm2LOKURki/miaj2WjRcgZrFyL/IRSAj
         JfGEWF4V33MWATfv/PFv+mv9F8CjDCj+EfC4w2BxLGxkWh8+ZgDoA/o4OnEuSEG2fVWV
         Id18sPk7FGHd1NQLtaQ8DJsUR5s/MLRNMTLBM5qyPf9UuKihYqJvT3UFBNoGmRWttFl1
         POrkx1e2leTn1ELL6x0Jf8KNS5Mo8LWcar9E5RpqCv+V1ZbDJH6ngspMixoTYJClZsNa
         OgZ3e23QXU7NipSQJ9HpWkIP85vMu22LTRo1VpzATES+Z7nmA8uCdbQKx765d/ZZhIH1
         xjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775986; x=1714380786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/fvR+HwOJPjnOfbOHG69UP92YiSjqkbM928Puj2/Go=;
        b=H+BLGEsWA3c0y+EyFSTrnKlT66adz+104h6CJ5uRRXrqeFcSd48IVay3scP9ijpe7E
         T7S+7jrYu8scyFwMWGVSaf0HjpKru3oHIoupfYlFpnvcQZ3PoDy3LHs+lF0KnfVOSPGV
         GPYwzCtCOqMTSc03ZOZcXIeTc3XY026SsnlVhJZ8WljLJ83VFfO2K8rri1ISGD/aJl/0
         SgFxfKoaxjTw23vMwy50ESKeJIaWjQ4MqJ0KfL376iHirK9yVFKrcSh0fiwpeqNKcsfN
         /54ct/PkI0BOLt+88yurAcZcSSCk4tWNIWnxJ2+tBUgwYi86umP4D9uLZb5r4KWkJ+2t
         SbTA==
X-Forwarded-Encrypted: i=1; AJvYcCVr/6bcAA9pjyzL9vpNYmapx7j6RmawtKur/Cpo1jkcIJq6xArSszoPdZ4ZW9yuJUIMNVrYv165pKbbqPuC6Ri4TL+f4NNrsZwMdMW/5bl9
X-Gm-Message-State: AOJu0YygvHLeDHpu7dM9SAMO+fFb7JPxr0Fu6JplvAa5w5O0Hv5YNmnQ
	oQfhzRopbcqBEt4c/CxZGMFiObK17tiQwMwSXvC6cNVgJASAVVLwf2PE408Z+Ps=
X-Google-Smtp-Source: AGHT+IFE4R9zCUkzHMX1ToR2kyTpvZV9gQXHpyVa4BPp1ldGkiKbLmpz+4IIFAyNc6nOuO6PT/9Ayg==
X-Received: by 2002:a05:600c:3baa:b0:418:1303:c3d1 with SMTP id n42-20020a05600c3baa00b004181303c3d1mr7145059wms.3.1713775986113;
        Mon, 22 Apr 2024 01:53:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:dc65:11af:998:225e? ([2a01:e0a:999:a3a0:dc65:11af:998:225e])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b0041a92bb0c10sm25826wmo.2.2024.04.22.01.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:53:05 -0700 (PDT)
Message-ID: <f89c79f7-a09e-4fcf-8e16-0875202ade4a@rivosinc.com>
Date: Mon, 22 Apr 2024 10:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] dt-bindings: riscv: add Zc* extension rules
 implied by C extension
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-4-cleger@rivosinc.com>
 <20240419-blinked-timid-da722ec6ddc4@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240419-blinked-timid-da722ec6ddc4@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/04/2024 17:49, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 02:42:26PM +0200, Clément Léger wrote:
>> As stated by Zc* spec:
>>
>> "As C defines the same instructions as Zca, Zcf and Zcd, the rule is that:
>>  - C always implies Zca
>>  - C+F implies Zcf (RV32 only)
>>  - C+D implies Zcd"
>>
>> Add additionnal validation rules to enforce this in dts.
> 
> I'll get it out of the way: NAK, and the dts patch is the perfect
> example of why. I don't want us to have to continually update
> devicetrees. If these are implied due to being subsets of other
> extensions, then software should be able to enable them when that
> other extension is present.

Acked.

> 
> My fear is that, and a quick look at the "add probing" commit seemed to
> confirm it, new subsets would require updates to the dts, even though
> the existing extension is perfectly sufficient to determine presence.
> 
> I definitely want to avoid continual updates to the devicetree for churn
> reasons whenever subsets are added, but not turning on the likes of Zca
> when C is present because "the bindings were updated to enforce this"
> is a complete blocker. I do concede that having two parents makes that
> more difficult and will likely require some changes to how we probe - do
> we need to have a "second round" type thing?

Yeah, I understand. At first, I actually did the modifications in the
ISA probing loop with some dependency probing (ie loop while we don't
have a stable extension state). But I thought that it was not actually
our problem but rather the ISA string provider. For instance, Qemu
provides them.


> Taking Zcf as an example, maybe something like making both of C and F into
> "standard" supersets and adding a case to riscv_isa_extension_check()
> that would mandate that Zca and F are enabled before enabling it, and we
> would ensure that C implies Zca before it implies Zcf?

I'm afraid that riscv_isa_extension_check() will become a rat nest so
rather than going that way, I would be in favor of adding a validation
callback for the extensions if needed.

> 
> Given we'd be relying on ordering, we have to perform the same implication
> for both F and C and make sure that the "implies" struct has Zca before Zcf.
> I don't really like that suggestion, hopefully there's a nicer way of doing
> that, but I don't like the dt stuff here.

I guess the "cleanest" way would be to have some "defered-like"
mechanism in ISA probing which would allow to handle ordering as well as
dependencies/implies for extensions. For Zca, Zcf, we actually do not
have ordering problems but I think it would be a bit broken not to
support that as well.

I can actually revive the work mentioned above to handle that and see if
it works ok.

Clément

> 
> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  .../devicetree/bindings/riscv/cpus.yaml       |  8 +++--
>>  .../devicetree/bindings/riscv/extensions.yaml | 34 +++++++++++++++++++
>>  2 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> index d87dd50f1a4b..c4e2c65437b1 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> @@ -168,7 +168,7 @@ examples:
>>                  i-cache-size = <16384>;
>>                  reg = <0>;
>>                  riscv,isa-base = "rv64i";
>> -                riscv,isa-extensions = "i", "m", "a", "c";
>> +                riscv,isa-extensions = "i", "m", "a", "c", "zca";
>>  
>>                  cpu_intc0: interrupt-controller {
>>                          #interrupt-cells = <1>;
>> @@ -194,7 +194,8 @@ examples:
>>                  reg = <1>;
>>                  tlb-split;
>>                  riscv,isa-base = "rv64i";
>> -                riscv,isa-extensions = "i", "m", "a", "f", "d", "c";
>> +                riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zca",
>> +                                       "zcd";
>>  
>>                  cpu_intc1: interrupt-controller {
>>                          #interrupt-cells = <1>;
>> @@ -215,7 +216,8 @@ examples:
>>                  compatible = "riscv";
>>                  mmu-type = "riscv,sv48";
>>                  riscv,isa-base = "rv64i";
>> -                riscv,isa-extensions = "i", "m", "a", "f", "d", "c";
>> +                riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zca",
>> +                                       "zcd";
>>  
>>                  interrupt-controller {
>>                          #interrupt-cells = <1>;
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index db7daf22b863..0172cbaa13ca 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -549,6 +549,23 @@ properties:
>>                  const: zca
>>              - contains:
>>                  const: f
>> +      # C extension implies Zca
>> +      - if:
>> +          contains:
>> +            const: c
>> +        then:
>> +          contains:
>> +            const: zca
>> +      # C extension implies Zcd if d
>> +      - if:
>> +          allOf:
>> +            - contains:
>> +                const: c
>> +            - contains:
>> +                const: d
>> +        then:
>> +          contains:
>> +            const: zcd
>>  
>>  allOf:
>>    # Zcf extension does not exists on rv64
>> @@ -566,6 +583,23 @@ allOf:
>>            not:
>>              contains:
>>                const: zcf
>> +  # C extension implies Zcf if f on rv32 only
>> +  - if:
>> +      properties:
>> +        riscv,isa-extensions:
>> +          allOf:
>> +            - contains:
>> +                const: c
>> +            - contains:
>> +                const: f
>> +        riscv,isa-base:
>> +          contains:
>> +            const: rv32i
>> +    then:
>> +      properties:
>> +        riscv,isa-extensions:
>> +          contains:
>> +            const: zcf
>>  
>>  additionalProperties: true
>>  ...
>> -- 
>> 2.43.0
>>

