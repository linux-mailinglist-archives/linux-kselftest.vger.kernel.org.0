Return-Path: <linux-kselftest+bounces-36013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E3AEC163
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E916176AD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34F25A2AA;
	Fri, 27 Jun 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPPSekE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54123CF12
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057155; cv=none; b=dQZalvQhPKpN6dD16bxSYb2gspfTUPwc1P8WGXlvd2HAZn+7yOGEAdS5s2jqWsDykhPVPlXTs+mbLoQ/8EFrDQzggVHsHJsV68Ap9AWtnW/NuMpGL0ecd1aS/YhDhIjqDLElKMcKBXZj3h+NEUOJMPncAn3Xu5AxEfpucsnpaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057155; c=relaxed/simple;
	bh=31Dp+CMBRMQ8uN0vaou9SdCDYjiC6hdV62l5ML46Uno=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=tgcI3xgJbs1oXL0ioq1UxXgSZjnVy4x0YdNgaZAcMZAT3dvsJdJAQXrqe0IeyBmDDstWFAUWTVdbVKnlXsVeEWJiC+qbk3fdzyOppYqmefMUw+5dfiVwFuX3ixsLMOKpvGYcuVmvmWjYzV+l55ldGhEuhdVoFq1Cb521Crf5wRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPPSekE1; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3df3b71b987so2774785ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751057153; x=1751661953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQtNA0hS1YdwM8TLVBpaF+KBYsznLZdF9AooNXo/LEo=;
        b=GPPSekE1vDPGi2XJnCTME4l2gNLn7mqvF+JNHh9jVDAvjMs/kO158C4pOpMOfwj3tp
         nXVZ9nYNEfMkCajpywJLld7Nmf4/YWaq7cmtW5NJBF3QQAgOiXZ7XGr1ZkqDKjuNNVr6
         bfIchAca0ucovoWjV1CiA2zMhCX1NbtQKZOWMfUitX3tM0hZCW18E6tRDjQgyUEm/y9q
         ZXvmGwmW0ptfgmcN/SQ53FgH9ooQgUcNeBjgAsE6e2WTQwXYe9f4WTxOakQnWTT7jkzG
         byx6hzUh1hzKomegznDcDeeWWrQdJ7g7i19rrxZR/DDwC9mRInlxXjyluqTdaqHdG0il
         LIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057153; x=1751661953;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQtNA0hS1YdwM8TLVBpaF+KBYsznLZdF9AooNXo/LEo=;
        b=WDOokqDvKeqQ2VazPG4DOlFtJfr59Eph/1/ONAdPUUurK4AWKi4JhLcLdVYPaky27G
         oUq3qXB89EyeKdg1R5zFqMmK79AjcEPJgCcxe8v9AlB/WtOz5Fm05FuOL0aPmGUf5QyC
         iYV7w8vOEWhuDeV02kWO7LfK0TIljyXw9zrxz0NQmukk9+zVXmdrOT7J3A94oB5JPVzH
         QTWmQ3nB/x+VZQZpf9vQ0CbGvnMdM731mL/oy/SWGECs9Cz5XPe0B01XYgcbr78CrX+X
         siTWks3LWhfVZF/bZ9ldgFg2iZlYXwftmp9jLcgVnxC6WKxaSjUe512m+UT77kKpi+Kt
         4hVw==
X-Forwarded-Encrypted: i=1; AJvYcCWzkoNTaYu2CKweidfYPqgcy3+jWeTbnGqUoMsYh3fznmqL4f/c21sIMa/3qf2cXB1tJK56HSmJ3ShaW3PBfks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE48uln9r2lPHk2zCk9Cp39zpTmwJrVKMCMepISSrGYGMgx723
	DBVewueRZ0uv1fKqlC2bshkLDNz36OB7y7b18MWfLZ3FTntFcPlW2KbojEWj3AWZ8dazdGWJiyQ
	h310TwIr4Ah1/BVzQnPTdyAFQaA==
X-Google-Smtp-Source: AGHT+IG8ubvH3kPztAj1ao94LgGUW1XY/gBYCn7CffcpcGKKkMXZJW+TsDn1nh7iOVmLnOgs9jfVsOn7IAe78nE95w==
X-Received: from ilbec16.prod.google.com ([2002:a05:6e02:4710:b0:3dd:77db:e2f7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:12e8:b0:3df:154d:aa60 with SMTP id e9e14a558f8ab-3df4acf7b61mr59890785ab.22.1751057152711;
 Fri, 27 Jun 2025 13:45:52 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:45:51 +0000
In-Reply-To: <86sejlb9ba.wl-maz@kernel.org> (message from Marc Zyngier on Fri,
 27 Jun 2025 14:31:05 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntcyao9am8.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 03/22] KVM: arm64: Define PMI{CNTR,FILTR}_EL0 as undef_access
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	oliver.upton@linux.dev, mizhang@google.com, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Marc. Thanks for the review.

Marc Zyngier <maz@kernel.org> writes:

> On Thu, 26 Jun 2025 21:04:39 +0100,
> Colton Lewis <coltonlewis@google.com> wrote:

>> Because KVM isn't fully prepared to support these yet even though the
>> host PMUv3 driver does, define them as undef_access for now.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kvm/sys_regs.c | 3 +++
>>   1 file changed, 3 insertions(+)

>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 76c2f0da821f..99fdbe174202 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -3092,6 +3092,9 @@ static const struct sys_reg_desc sys_reg_descs[] =  
>> {
>>   	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility =  
>> sme_visibility  },
>>   	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility =  
>> fp8_visibility },

>> +	{ SYS_DESC(SYS_PMICNTR_EL0), undef_access },

> $ jq -r --arg FEAT "FEAT_PMUv3_ICNTR" -f ./dumpfeat.jq Features.json
> (FEAT_PMUv3_ICNTR --> v8Ap8)
> (FEAT_PMUv3_ICNTR --> FEAT_PMUv3p9)
> ((FEAT_PMUv3_ICNTR && FEAT_AA64EL2) --> FEAT_FGT2)

> If you have FEAT_PMUv3_ICNTR, then you have FEAT_FGT2. If you have
> FEAT_FGT2, then we already trap and UNDEF PMICNTR_EL0 without any
> further handling since 4bc0fe0898406 ("KVM: arm64: Add sanitisation
> for FEAT_FGT2 registers").

>> +	{ SYS_DESC(SYS_PMICFILTR_EL0), undef_access },

> Same thing.
>> +
>>   	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
>>   	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },
>>   	{ PMU_SYS_REG(PMCNTENSET_EL0),

> So none of this is actually required.

Thanks for the context. I'll take this patch out.

