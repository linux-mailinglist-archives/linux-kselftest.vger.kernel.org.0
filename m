Return-Path: <linux-kselftest+bounces-47532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 252F3CB9D87
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB85B3055BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352F30BBB6;
	Fri, 12 Dec 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXZufRKP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761E2DC320
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573616; cv=none; b=HjpAIM04hYbsn8UKrmM/Cf68z/N64WTw256TCv41GfxSL/F434XTbtgCkecrpnVnDZDaVcXMZBD86Bj7mhiKH5SpiWV+H6VeV3HtN3s2Kk7UsgxSs23SEk3gLuLbg7b9tkmG8tdABzgbiuIT8QluizgV9qYrv0VXGCjwL7Y1VFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573616; c=relaxed/simple;
	bh=j4zmNXaHcAhBlyQ7iWB1i9Dwg1d4I/P9T1rUCk2IZys=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XvRdCW6K86rGwL1Xf5SBi7CTSfZplRFP+XglOvxdj+UIcaxG4uhbbbVtx+Cs5Nn2i63xj5M3f63tpcOOxoAl/2ZDmd62tg8qEfBzLS020o9/z9m69+aUwh12Ov/04/R860tLm9zgCkPsm5Z2S14PpsCvABGYM9f6qrbFot7M45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXZufRKP; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-656ceb0c967so1352343eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765573614; x=1766178414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NvEO8IWge7rjEvmTvBLfyyCkg8YrPNESaGlmNB9KmuA=;
        b=xXZufRKPOQzTfWsec9kSDdM68oqhKd2xDq60GuwK3/inDt1V9S2RICZNs9jdGhwtxK
         sQorhvr6euqALbpaIyr9na0o4UPHp9tJhT2ORaJAWXT90TEBOkYfcRFBrwMQZJbbISWu
         IkU+lAZ4DNUNpthQbuVm/YKsvUvjCDtkQjyhGA5LOs6ccDdKFYZESyqhKpYwDDkfsoI8
         Ix/+ldNwisX+5tv3FVXll/u1ZMq94E+xJtLie/zehhsf3/31+h4vWL8IRmxLPtLDhgXG
         JJy6EDBLEEFtJfhtoxjq8eIxZFWXLJzrDAJ0ffFIqdOWTMAJ1lLWpLH2A5K9Qy/SuCN0
         gg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765573614; x=1766178414;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvEO8IWge7rjEvmTvBLfyyCkg8YrPNESaGlmNB9KmuA=;
        b=pu+/FvlIZvy02lNXTggBITBvKdOiyl9sdsqi85Hs7AZDe+PlaMHRrlpm/LK/pgSid7
         EaTRjDhEjpd0pJZQLfAltt0aXRrWlu35nRc/lJOX0yxjN64ubS3PFTrPYRe+yymvRdza
         iAUJDixqHJONGnLKYlRy8mZwicUfip8QODQ+GDOt1fmTfesWfqFvOwnN6RFPJIpY0OFi
         qsrUzNw9WJTDCjO6fAlPWvxxLJJe+CPMhmpeEgRi4ZlEOeS8E1ZeKWygfUZVSX0DwcB3
         spw9MwwWTuQfiR8lEidH/kVzD562lZbxkieJaBhx8yyGT20qqbXaUK7DBsdqK/4IopsY
         cP2w==
X-Forwarded-Encrypted: i=1; AJvYcCWMonX+Sf7Ebab+p+WGX3ZgF3/mmk+hcofwwLKRXLOIV83irSxAWIOjln6aN3yxGn7dPe63GB2auUWncY+K5rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwQ3VY4rVgj9RizfU8dL2aaTirrgtPQ5nfvdhhK0yC8vV1c5J
	hzZjCyZ82RZ5k8Q5jlAlM9R/R+PRDDTIlEWKdBgjkSGRbGAfyEWePO5mBlFTzMLP7BcPapZh27Y
	/ZFlr+hdVNfZnDKejaG34ZS+c4Q==
X-Google-Smtp-Source: AGHT+IGLtIUbFameZTVObRWcG+lq04RJyrGiyVy+qxibJohcLHDXgLx6kR5HPWzG4MF6bmkp/GMqRXiYMN5HlbpHeg==
X-Received: from ilbcb7.prod.google.com ([2002:a05:6e02:3187:b0:430:c30d:ac37])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1899:b0:659:9a49:8dde with SMTP id 006d021491bc7-65b45172277mr1612721eaf.32.1765573614348;
 Fri, 12 Dec 2025 13:06:54 -0800 (PST)
Date: Fri, 12 Dec 2025 21:06:53 +0000
In-Reply-To: <aTiSTODjzaLzwAPN@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 13:19:08 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntsedf2yvm.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 13/24] KVM: arm64: Writethrough trapped PMOVS register
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Tue, Dec 09, 2025 at 08:51:10PM +0000, Colton Lewis wrote:
>> Because PMOVS remains trapped, it needs to be written through when
>> partitioned to affect PMU hardware when expected.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/arm_pmuv3.h | 10 ++++++++++
>>   arch/arm64/kvm/sys_regs.c          | 17 ++++++++++++++++-
>>   2 files changed, 26 insertions(+), 1 deletion(-)

>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h  
>> b/arch/arm64/include/asm/arm_pmuv3.h
>> index 60600f04b5902..3e25c0313263c 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -140,6 +140,16 @@ static inline u64 read_pmicfiltr(void)
>>   	return read_sysreg_s(SYS_PMICFILTR_EL0);
>>   }

>> +static inline void write_pmovsset(u64 val)
>> +{
>> +	write_sysreg(val, pmovsset_el0);
>> +}
>> +
>> +static inline u64 read_pmovsset(void)
>> +{
>> +	return read_sysreg(pmovsset_el0);
>> +}
>> +
>>   static inline void write_pmovsclr(u64 val)
>>   {
>>   	write_sysreg(val, pmovsclr_el0);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 2e6d907fa8af2..bee892db9ca8b 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1307,6 +1307,19 @@ static bool access_pminten(struct kvm_vcpu *vcpu,  
>> struct sys_reg_params *p,
>>   	return true;
>>   }

>> +static void writethrough_pmovs(struct kvm_vcpu *vcpu, struct  
>> sys_reg_params *p, bool set)
>> +{
>> +	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
>> +
>> +	if (set) {
>> +		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
>> +		write_pmovsset(p->regval & mask);
>> +	} else {
>> +		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~(p->regval & mask));
>> +		write_pmovsclr(p->regval & mask);
>> +	}

> There's only ever a single canonical guest view of a register. Either it  
> has
> been loaded onto the CPU or it is in memory, writing the value to two
> different locations is odd. What guarantees the guest context is on the
> CPU currently? And what about preemption?

My thinking here was pmovs is trapped so the "canonical" view is in
memory, but the guest still expects it to have an effect immediately.

Otherwise we would have to wait until the next load before the value
makes it to hardware. Are you okay with that latency? I'm not sure
how well that's going to work. Consider PMEVTYPER as an example. If I
don't write it to hardware immediately, a guest may expect a counter to
start counting as soon as it is written, but if it's only in memory the
counter won't start until the next load.

Echoing discussion on the previous patch, I wasn't aware preemption was
possible while servicing these register writes. I'll figure out how to
account for that.

