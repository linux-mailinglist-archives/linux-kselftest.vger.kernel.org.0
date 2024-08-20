Return-Path: <linux-kselftest+bounces-15769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F002B957F8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9394283DC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9896186E2E;
	Tue, 20 Aug 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="FXsfGJ90"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F9132124;
	Tue, 20 Aug 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138825; cv=pass; b=O7w7XL5VeJTIwroCZy56ShIn9hTC5x4GHNhfmYZeBMl/JEHURPenLVDP+AsR2U2UqmyTe/XM7d0zA3hbGIDdx5GqMT6ypuRC0ellLhcqBSe/IyLEct72LTfVg230YPVYMPSqL5F0wnO0UrsWFppA/s5QyVUe+8bc58fojCE1ua4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138825; c=relaxed/simple;
	bh=OAb3vC/Zkyg/SdJ1TD//avWUs8En4MbQVlb8+2cI4Ik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zb7nHTqanV+ttPYz5118Q9BYyY67CDpTqX+9Qtag6+xPJ3P6vCJEypy63bRR0d0P6R7vo4rd06Oha/nBeMM+wrAd1TRGyCV2v1ohQ12FRaUKUIjMp0Bh7k1nVQp2fe1O8aNygvSBGAAxcTHxOQESduJ5ZEU1jqnVsCtusYwHwVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=FXsfGJ90; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724138796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EXzAsN4bP2BCe2iQJANEH2sdLh3DN0xIyP/X76hyuuO1IhRNgdetegrZyYZ8ujk8c0PyyBRKFCnnQ+TBBEIwC1B2iy0rFvfNK3wFgZs/kBqjlbT8v4T+OpSmHZmwqiMMqmM3taEhk824PwIKbw9PhoVaVTXa/4UwU1WfguiYfBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724138796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M8D0uEeC8XYss0szLPUlb5Lps9IGtnYOrv/FK6gxMhI=; 
	b=QuVLpv+XsnQUm+asJhqoBfNbgJmpn29JUQjPW4g8QeAA1q04zjkw3phmU6xX26DKIX3HTmd16yzcyQHMSeDDBS7VmdK476SgW6cGplRtkUqJ84Bz3DFSpLcAny6wtHGHSNdpvOzfDxrZcCHqn4JA81M/1fU/ThxdpMW9uPkr1PE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724138796;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=M8D0uEeC8XYss0szLPUlb5Lps9IGtnYOrv/FK6gxMhI=;
	b=FXsfGJ90DaxKUyBr/7kjy5Vz6cA1IyTmA9Y8dR4dXL0JaUNqf3dGc7HYCcyGwZYC
	eHbZGA98tPFCgfJUUwGdq/VzamRhzm1ew0bPhrYlBEcRg+AXIjMJ4gYDhfNkGrU0M2z
	NOR4Qa10gQVAgX+tP2ZhVBHtX9Oj6F8huDjedKbo=
Received: by mx.zohomail.com with SMTPS id 1724138794399675.3975600570174;
	Tue, 20 Aug 2024 00:26:34 -0700 (PDT)
Message-ID: <379673da-9f2f-484a-be04-a62d916fa25e@collabora.com>
Date: Tue, 20 Aug 2024 12:26:23 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, kernel@collabora.com, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v2] selftests: kvm: fix mkdir error when building for
 unsupported arch
To: Sean Christopherson <seanjc@google.com>
References: <20240819093030.2864163-1-usama.anjum@collabora.com>
 <ZsNzzajqBkmuu5Xm@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <ZsNzzajqBkmuu5Xm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/19/24 9:33 PM, Sean Christopherson wrote:
> +KVM arch maintainers
> 
> On Mon, Aug 19, 2024, Muhammad Usama Anjum wrote:
>> The tests are built on per architecture basis. When unsupported
>> architecture is specified, it has no tests and TEST_GEN_PROGS is empty.
>> The lib.mk has support for not building anything for such case. But KVM
>> makefile doesn't handle such case correctly. It doesn't check if
>> TEST_GEN_PROGS is empty or not and try to create directory by mkdir.
>> Hence mkdir generates the error.
>>
>> mkdir: missing operand
>> Try 'mkdir --help' for more information.
>>
>> This can be easily fixed by checking if TEST_GEN_PROGS isn't empty
>> before calling mkdir.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Instead of ignoring error, check TEST_GEN_PROGS's validity first
>> ---
>>  tools/testing/selftests/kvm/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 48d32c5aa3eb7..9f8ed82ff1d65 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -317,7 +317,9 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>>  $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>>  
>> +ifneq ($(strip $(TEST_GEN_PROGS)),)
>>  $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>> +endif
> This just suppresses an error, it doesn't fix the underlying problem.  E.g. there
> are other weird side effects, such as an above mkdir creating the $(ARCH) directory
> even though it shouldn't exist in the end.
> 
> It's also very opaque, e.g. without a comment or the context of the changelog,
> I'd have no idea what purpose the above serves.
> 
> Rather than bury the effective "is this arch supported" check in the middle of
> the Makefile, what if we wrap the "real" makefile and include it only for
> supported architectures, and provide dummy targets for everything else?
> 
> E.g.
> 
> ---
> # SPDX-License-Identifier: GPL-2.0-only
> top_srcdir = ../../../..
> include $(top_srcdir)/scripts/subarch.include
> ARCH            ?= $(SUBARCH)
> 
> ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64))
> ifeq ($(ARCH),x86)
>         ARCH_DIR := x86_64
> else ifeq ($(ARCH),arm64)
>         ARCH_DIR := aarch64
> else ifeq ($(ARCH),s390)
>         ARCH_DIR := s390x
> else
>         ARCH_DIR := $(ARCH)
> endif
> 
> include Makefile.kvm
> else
> all:
> clean:
> endif
> ---
> 
> And other KVM maintainers, the big question is: if we do the above, would now be
> a decent time to bite the bullet and switch to the kernel's canonical arch paths,
> i.e. arm64, s390, and x86?  I feel like if we're ever going to get away from
> using aarch64, x86_64, and s390x, this is as about a good of an opportunity as
> we're going to get.
> 
> The annoying x86_64=>x86 alias still needs to be handled to avoid breaking explicit
> ARCH=x86_64 builds (which apparently are allowed, *sigh*), but we can ditch ARCH_DIR
> and the KVM selftests dirs match tools' include paths.
> 
> ---
> # SPDX-License-Identifier: GPL-2.0-only
> top_srcdir = ../../../..
> include $(top_srcdir)/scripts/subarch.include
> ARCH            ?= $(SUBARCH)
> 
> ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64))
> # Top-level selftests allows ARCH=x86_64 🙁
> ifeq ($(ARCH),x86_64)
> 	ARCH := x86
> endif
> include Makefile.kvm
> else
> all:
> clean:
> endif
> ---
> 
> If no one objects or has a better idea, I'll post a series to do the above.
I didn't had enough knowledge to attempt a better fix. Thank you.

-- 
BR,
Muhammad Usama Anjum


