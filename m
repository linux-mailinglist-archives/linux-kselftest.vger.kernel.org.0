Return-Path: <linux-kselftest+bounces-47541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0CCBA00C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 23:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50955306385F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2730BF62;
	Fri, 12 Dec 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVYH8cYG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF32F28F5
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765580346; cv=none; b=R226Qolt3PSs/qmj63e0Hn5NH+Mcm3lFXGbjuraERX6V+wp06GmSBcAjR3xuZKGHZyyJSLOeDj8s7a+K//F0Ytacd2JOkTFYKsMHrRdgUq/OWqh6Ezq4GnXQ8+Yx4/ZL4EkIzOfT3T7iukV8fd2O2DHJbtOrbN59Ax9zY78FLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765580346; c=relaxed/simple;
	bh=7bslInIBLJIoLn/9TutWUpr69eWhQhXaLvHEGWAesY0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KBGIxPM7pd0jrnp2FOgfqfYC0f97laLgaV6Gpx3Sjb87oSM8fMZFcyimaTzvHJtCbHVUdPZA4HAuBI0MUjEWdj+4ZZKgSA58dd6OCAScgZVrUCYoh1fdUzL1vo4zuZ2lCyc/7JXNcEuYzIjTZfw7DLELHRJ9+Yc2tqrBP0ZeRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVYH8cYG; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-65744e10b91so1391711eaf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765580343; x=1766185143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBFcNzGChK01MBl7aRFxeqVQzmaQvoTyGJMrwZXP/1Q=;
        b=jVYH8cYGDRhUhxifgajdZOsToCsIevvKQcPuHJqgeqiyM6J4bSKk0BbDSMvTeavxYF
         46v35BE3mzyUckBVDyX+t6bFc8DQNE8G+5vaX9HSWEXgmXpuLsMilxVI5KQw7r1PUo0p
         4+LO92YfEjdn8YqVDLcsrUATartyXsX/jv/3ZD6lOzAevAUxCE+EVLg7QWkenEan6MqD
         9t4HbQyC7yg2YTsc7Kx2uww4W4M1PUdkSL33bN6hRwFbPnAzU5dNB3wCeu+7UftOKj4A
         /YGInhe8GfSUS4xpKoTEb36c4TvW1doFr4iEHeC3nMEiTR0zqs7zcsAXaYloao3f7CPH
         W6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580343; x=1766185143;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBFcNzGChK01MBl7aRFxeqVQzmaQvoTyGJMrwZXP/1Q=;
        b=p+gpXVtAMTGoG6aKkahjsmzIOtJW2q8YBB49w6ChfflSDypCclbtK7hsyAVUD5eyW4
         //4l5ZXbEl7sNgFpS9zYvVjBkpfRSF5mZYTn2M5Jig+qCp3Hn48ORzVKCgUO85pHVR4b
         AFZx/g8JsWSLEx74+rAETqP99dqw6gZAUx14qFQBpy3xcxDNyqaSd7/D6kdOFsQ/oj4y
         EsJ8KKQ1J9UKkllzdNWMdmbyeeHrGHuKVYj7RmZ4e1xWkwWi2AFpf3lBUmfIYVBg1XFa
         KYn777BONgb086If/6GmtvRNzwSsBTjIkvua3AZGIooLhrf0lvncDnh6y5iBZPXMVjBJ
         nvtw==
X-Forwarded-Encrypted: i=1; AJvYcCV/p7LXZ6gp3jjAlV8PNNRG2tvyPVXPgmqWpTMIJRV+s97nGUMaPYmX9j/i7+3gqC4oQPRVNxE1CGZrAZ9AD6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhAoappy6gwg9gZukXI57nWIcxrt5JSgt219m1D5zqt0JVqq3
	ZfOE5kEhbj4f9BVctpXYcB08ln201Z5Zhn73/SOSQV0QFekZUYxb6AOCdwsotMBzpyuGNc4xT5M
	tU+s2WUQrl2WGH+vvX6XmNROygg==
X-Google-Smtp-Source: AGHT+IErW9ttpylPAKTVb6sUEZwG4YGY35EKiSdiqsCWGntNWnLEEqDhx+071F1DfXt8IYeJCob+cCIIDVfcvHekjQ==
X-Received: from ilbbc25.prod.google.com ([2002:a05:6e02:99:b0:434:972f:bf92])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1886:b0:65b:35a2:7a8b with SMTP id 006d021491bc7-65b4523911emr1339446eaf.82.1765580342788;
 Fri, 12 Dec 2025 14:59:02 -0800 (PST)
Date: Fri, 12 Dec 2025 22:59:01 +0000
In-Reply-To: <aTipeb2fAmUtSzzX@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 14:58:01 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt5xab2toq.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 22/24] KVM: arm64: Add KVM_CAP to partition the PMU
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

> On Tue, Dec 09, 2025 at 08:51:19PM +0000, Colton Lewis wrote:
>> +
>> +7.245 KVM_CAP_ARM_PARTITION_PMU
>> +-------------------------------------
>> +

> Why can't this be a vCPU attribute similar to the other vPMU controls?
> Making the UAPI consistent will make it easier for userspace to reason
> about it.

I'm confused by the inconsistency of using a vCPU attribute for
something we want to affect the whole VM.

But I'll do a vCPU attribute if you want.

> Better yet, we could make the UAPI such that userspace selects a PMU
> implementation and the partitioned-ness of the PMU at the same time.

Sounds good.

>> @@ -132,6 +134,16 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>   		}
>>   		mutex_unlock(&kvm->lock);
>>   		break;
>> +	case KVM_CAP_ARM_PARTITION_PMU:
>> +		if (kvm->created_vcpus) {
>> +			r = -EBUSY;
>> +		} else if (!kvm_pmu_partition_ready()) {
>> +			r = -EPERM;
>> +		} else {
>> +			r = 0;
>> +			kvm_pmu_partition_enable(kvm, cap->args[0]);
>> +		}
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -388,6 +400,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,  
>> long ext)
>>   	case KVM_CAP_ARM_PMU_V3:
>>   		r = kvm_supports_guest_pmuv3();
>>   		break;
>> +	case KVM_CAP_ARM_PARTITION_PMU:
>> +		r = kvm_pmu_partition_ready();

> "ready" is very confusing in this context, as KVM will never be ready to
> support the feature on a system w/o the prerequisites.

That was a last minute addition. I'll change the name to something
better.

> Thanks,
> Oliver

