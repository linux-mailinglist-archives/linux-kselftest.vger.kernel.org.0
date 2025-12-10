Return-Path: <linux-kselftest+bounces-47368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A7CB2BF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 11:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2849B300194D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81331AAB6;
	Wed, 10 Dec 2025 10:54:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211F2DF153;
	Wed, 10 Dec 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364074; cv=none; b=jdTJQC2Lb4+mr/02dQW6GAFk3wZ0wAhG8fQNiPRXtENeWP+auZ3NvOiLH2Uc+liNiGuwu2LNxKUtwicJELshvbnVE59Mt+bLLTOpDySbKWkT2EhKk0NxpOhAopCSj5B17Wpkni2iZ/ilcuhA3bvcNl0c3vqDVqBNR7NISJC336g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364074; c=relaxed/simple;
	bh=n8M0HoGzo+wsLFHfwfb/GaFH8TCe+R9gjGJUfRXPN+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtFREnDzCSCzf4bydgkYp57f53RcQm+Ck1NMHvMO97HSxPdfEiJ+f3qsybow+bPZalXu4pnDks3iYkVFJi3vR4bTgVYZ4Q7CUlNkvoRkM6ARkhx1wOBzRR26xpHLhG4t94mWnrXamg0ullFAZ6VUxy/T/l+KR/BY31keifUHIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B75153B;
	Wed, 10 Dec 2025 02:54:07 -0800 (PST)
Received: from [10.57.76.190] (unknown [10.57.76.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04893F762;
	Wed, 10 Dec 2025 02:54:11 -0800 (PST)
Message-ID: <d3e946ec-787a-424a-9a7a-f04aeb490ba6@arm.com>
Date: Wed, 10 Dec 2025 10:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/24] arm64: cpufeature: Add cpucap for HPMN0
Content-Language: en-GB
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-2-coltonlewis@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251209205121.1871534-2-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2025 20:50, Colton Lewis wrote:
> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
> counters reserved for the guest.
> 
> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
> because otherwise not all the appropriate macros are generated to add
> it to arm64_cpu_capabilities_arm64_features.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


