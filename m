Return-Path: <linux-kselftest+bounces-48221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447CCF4DFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29EEF3023D2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F32F744C;
	Mon,  5 Jan 2026 17:01:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15E86348;
	Mon,  5 Jan 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632460; cv=none; b=GVHOE9XvSczvGPGGx3n7Q3nXkmMelGbyVuArBwgXvv5LYNzS7vDmAFut7lZRT+3NAPKN0pPcz0FA/MRvxRPFd3ij8KQBmm+BC5jaN3OytrdGHGnSp5EwdXw+RH4O6GBQtAShkHQO8Mfw9dCCt0l/AetX4sY7tczR0ykTuh/ITsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632460; c=relaxed/simple;
	bh=0cvCkZgkv3byI4MB7bl4Jg6Ok6oN4muj8yQqNgsTa4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnCscqI+Vr6z1QaaZgmUuTaWhrsy36ADDHMvpzedTcV/pJWaDXcggVILGEiqGRZUH8VDUZLmxu76E6i1+ql3+McMQA+GnWyHpCUMY8RlYuC1QFyhW8z7pqP/9QQP3aPeAlTSamf9tqAcf2AqB38VW0nCeZ4bDnIsSgxtGPSyc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC344339;
	Mon,  5 Jan 2026 09:00:51 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06A03F5A1;
	Mon,  5 Jan 2026 09:00:56 -0800 (PST)
Message-ID: <819a6bf5-438d-44ae-a730-77252e92080b@arm.com>
Date: Mon, 5 Jan 2026 17:00:55 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: selftests: arm64: Skip all 32 bit IDs when
 set_id_regs is aarch64 only
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-4-bfa474ec3218@kernel.org>
 <363e440d-4e29-4286-ade4-b4be2f856859@arm.com>
 <90fb25bd-fa79-4980-902b-497346a3e6d5@sirena.org.uk>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <90fb25bd-fa79-4980-902b-497346a3e6d5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 1/5/26 16:45, Mark Brown wrote:
> On Fri, Jan 02, 2026 at 02:50:07PM +0000, Ben Horgan wrote:
>> On 12/19/25 19:28, Mark Brown wrote:
> 
>>> +			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
>>> +				ksft_test_result_skip("%s value seen in guest\n",
>>> +						      get_reg_name(reg_id));
>>> +				break;
>>> +			}
>>> +
> 
>> Unnecessary? The decision for which regs are testing is made in
>> guest_code().
> 
> The guest code has a fixed list of registers it reads blindly and we
> skip the write for these so our expected value won't be something we
> explicitly set.  The actual test is done here in the host code and it
> seems both more maintainable to keep the skip adjacent to the live test
> and clearer to be more explicit about nothing actually being tested.

Thanks for the explanation, it seems like a sensible decision.

Ben


