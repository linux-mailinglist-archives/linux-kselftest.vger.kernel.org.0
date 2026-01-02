Return-Path: <linux-kselftest+bounces-48073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54960CEECAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63A093011EF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910A231A23;
	Fri,  2 Jan 2026 14:45:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814A22ACEF;
	Fri,  2 Jan 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365110; cv=none; b=o0JRf/VeUuSidLjiZrshmLkt1QfwM29fXACJsJkLW0cUDZgv3velgKLdWkkPk/tTUM4zKFxp111938tpmnhBJRQKlqWF3E5xj4srSQx+vE6Qx9zhYqOuJUddD0hgZBoZhUhLtnwR3K7w+SfQ6wf86ored1/kBekytFXbZLru16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365110; c=relaxed/simple;
	bh=uvh5CMuL1qjDeAkfbKton4beIpNhvv8kthzSLHp0lSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6+ysnHY6apbutTdpPPJ4EcAIiSAB9vgTtQXovFOXPgrcZpT55vhiFbU/IyWm1nPzTt95gWfG+i7FR3ZK2jTdNtjduFsOoNrnOKyNS+mkUs8zIwBPpgjY/WmvaDwIshBCDEahAUa9agcKTIN8eLb1UeEQ67FW+qPdIZYCXyVWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14127497;
	Fri,  2 Jan 2026 06:45:01 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C4383F63F;
	Fri,  2 Jan 2026 06:45:05 -0800 (PST)
Message-ID: <89fd9661-731c-4335-bee8-575a7c221390@arm.com>
Date: Fri, 2 Jan 2026 14:45:04 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: selftests: arm64: Make set_id_regs bitfield
 validatity checks non-fatal
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-3-bfa474ec3218@kernel.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251219-kvm-arm64-set-id-regs-aarch64-v3-3-bfa474ec3218@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/19/25 19:28, Mark Brown wrote:
> Currently when set_id_regs encounters a problem checking validation of
> writes to feature registers it uses an immediately fatal assert to report
> the problem. This is not idiomatic for kselftest, and it is also not great
> for usability. The affected bitfield is not clearly reported and further
> tests do not have their results reported.
> 
> Switch to using standard kselftest result reporting for the two asserts
> we do, these are non-fatal asserts so allow the program to continue and the
> test names include the affected field.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/arm64/set_id_regs.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

This one also looks good to me. I'm not aware of why the asserts have
been favoured previously though.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


