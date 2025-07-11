Return-Path: <linux-kselftest+bounces-37137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B3B0229D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B365452EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91152F0C67;
	Fri, 11 Jul 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik6Ttd4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3D2F5E;
	Fri, 11 Jul 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254966; cv=none; b=oCeYpRbuFoTDR/kDpKNaJmZYpcqJd/E71oNubeSqSPi7jabec47dRCwut3v1769L9hQSNsvDhTG9cJNn8V2Oh7ejjdCl5j+8S1oaXE3tji0dvJ/zg3YaKo55QVRhthdFD9cYO+E/cX1wTsyFdUVQDywVkIafYu1mDgeJ7qZbfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254966; c=relaxed/simple;
	bh=I9AmB9XmUUGLZ7GB6cag1vt2ptSp1o/063OOfNCRYZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEW+s1gVVTB4IBWm1UX26OMstLv7yLnWBVxKhBrD4NjfDDdLPOk+pMGQCqUITCFmf8F8OmmeI2wQ2YIqgKxpmD8d5a1eG8UbEMQZRLRm+cGhL0N3ECpEXhs3eWzWVRYbJYtZcnT17icoad3ER3ZA5jNqIdO5n4h2ioj/sQXCV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik6Ttd4/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2058530b3a.1;
        Fri, 11 Jul 2025 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752254964; x=1752859764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyqR9czgqmlQsWz3x2F48FXTqADO6sc8GMIlnOWwsc4=;
        b=ik6Ttd4/26YMf3lGp2fhmsSlNMublG/mLHerLFsWMnQsdMvAfLQ3go/n8h1C2p+Wb8
         M3og69+den6jgUM8mD1cKQDItz4KfptHOo+YwbG1k4pV6xlq0T0s03iabYGPWIzpJPec
         qczGDysvN0fK2zV802OHwLRPO5+DG/6KPfSTLJrTusWFiefLzKq3vCsitsR8mEMSEciq
         tJhRO7zIduJ+9SSX/QntSkuWOwwq/FuNXoXdmXEgY+DtETi0eY/ZA5UKcFYZuxzyYpD0
         Gh+ql4qfNBO1jMVreSkTLoD9omkkCsH9iAzJwufLf5147Cur5XuCMwFqitTcETg3PdW1
         C93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254964; x=1752859764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyqR9czgqmlQsWz3x2F48FXTqADO6sc8GMIlnOWwsc4=;
        b=ONfuCkBfv7cD468YYVfi8FWFcBv66aXaMWpkwn9P+6UGBA65QWp27zUdQLbt5AxJxQ
         eEBloJ3Xjw4xKQZbnZXvCAklgFoHu0AE7mXfOa8pebSwxK8z3aYi7S4wwh+sWLB0e3IJ
         a+HwlZeck6LD+TsDicXNICTBa/peqborSZ8grdQ5qOvpC7muNk45HCdR9LArsgiW7o2s
         uMkfYs5PIV97rS7XwdoSjnOmFyD/JECdltwqBFrN560Y1r4r1IUhCFfeoICr4+yAkHvW
         wMt+L20RHPIHJzfbnGvtCIqQwawbGw2XZil8FURuBKc23zdii/+7iZC0HpmIPxviF2tM
         w6pw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/3khcVXTFmHomoyPHPgMwCK9x/vhrU7gcrhnexB+6X0jKxoU+OelXv2LWaPwVmd6lFY=@vger.kernel.org, AJvYcCXftOZnV6uACehNvL6ZW+E2BxR+RyowXaGExpjNIjc9REWPyxE66cBwNuhuwfpjCltDb1LfNJS+DNtTdoD4kqRW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2ZEQGWOElUDKLbDG/cvO217tiEMPNrCXR/7egEfMpcqTCpFF
	ScHkw42rP/T+YHubwoAEyVhuKGQs7npXe7kru2n3/WZV1eChcEPMD+oM
X-Gm-Gg: ASbGnctzI/YpaDb0Wate/udp5Z+qF6ESgNWimpvsSZUMmpIryEdgh6UdjdZIYK2zJW3
	H1VQ5IjouB8sogVhlajTTjqxyNe9rhfui2NkXZDbHja7ifj9Jw6tMoNc5S1s0TsGd6EItUEm8nn
	AlZWrGro9ZiW6U0aJ84O+gK4qR3fHzTcacpHQRbuhf8KM8noUIIf18gWPMbJ5XdADM54Nw9r6Ga
	G5cdgf549faZGcWNT0CODubcER76JC0hUcJv2UNEumKux/oEPhRT5vUPg0Ydaaqh7D26baWmRHI
	JYoPOmSu6c6ORf+Qv//I6SsMqBnEtp2Q7+3oFLm/jHDudOdArUt9P0ItperUZqwIyQbXbWguev1
	AkmtM1GonNDTM8IfUP4Vb8kkHQOf3s7lIBGHe3YU96OuiXqedGipnhoqACJwLktEk86qdn2Y7
X-Google-Smtp-Source: AGHT+IFk4CWCbWi4jW7/X/xlKpDtGqqmxQa5+vZch2160RBWHqC2c09IQS6El+JA9G7/mL1Q9KlR8Q==
X-Received: by 2002:a05:6a21:69c:b0:21f:4ecc:119d with SMTP id adf61e73a8af0-2312551f273mr6513433637.7.1752254964331;
        Fri, 11 Jul 2025 10:29:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:14ea:ab53:89df:693b? ([2620:10d:c090:500::6:b0c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eba428161sm5952372b3a.42.2025.07.11.10.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:29:23 -0700 (PDT)
Message-ID: <1e5b7812-a544-40b8-98df-0e87b3f33eb5@gmail.com>
Date: Fri, 11 Jul 2025 10:29:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/5] selftests: drv-net: Test XDP native
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
 <20250711063917.7aad27f7@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20250711063917.7aad27f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> The program does not load in the CI :(
> 
> 509: (15) if r1 == 0x0 goto pc+142    ; frame1: R1=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> 510: (25) if r1 > 0x100 goto pc+141   ; frame1: R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=256,var_off=(0x0; 0x1ff))
> 511: (bf) r3 = r10                    ; frame1: R3_w=fp0 R10=fp0\n; if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, hdr_len) < 0) @ xdp_native.bpf.c:377
> 512: (07) r3 += -256                  ; frame1: R3_w=fp-256
> 513: (bf) r1 = r7                     ; frame1: R1_w=ctx() R7=ctx()
> 514: (b7) r2 = 0                      ; frame1: R2_w=0
> 515: (bf) r4 = r8                     ; frame1: R4_w=scalar(id=3) R8=scalar(id=3)
> 516: (7b) *(u64 *)(r10 -280) = r5     ; frame1: R5=32 R10=fp0 fp-280_w=32
> 517: (85) call bpf_xdp_load_bytes#189
> R4 min value is negative, either use unsigned or 'var &= const'
> processed 262 insns (limit 1000000) max_states_per_insn 1 total_states 26 peak_states 26 mark_read 7
> -- END PROG LOAD LOG
> 
> I suppose it may be due to compiler version:
> $ clang --version
> clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4)
Perhaps

> 
> LMK if you need more info / can't repro, but I think the suggestion
> makes sense?
Let me try to repro and fix at my end. Complain seems valid.

