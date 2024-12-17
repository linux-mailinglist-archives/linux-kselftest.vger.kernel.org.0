Return-Path: <linux-kselftest+bounces-23445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322659F4763
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EF61889380
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD01DF975;
	Tue, 17 Dec 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WHpy04qa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512301DD87D
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427166; cv=none; b=Epze0T+T2cZbuGMwNZPvrZRZfNw6fBvHzLfUgDJdc38Dp04evw0O4eoZZR7UGtCSNJhVjg2Tk+3m5zEETu2VFrtsqs/AL4TJzPLywxq9pa06DrKx/o+TwXr+xThzcJOCf3uDtZSPkGYM31BTFtutF3bqkCzxSZGc8zgeV2AV4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427166; c=relaxed/simple;
	bh=DC965Tfa4EF7QPuS6rd27SkC6ALTk0aHBhziZdPRNNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVWs6gnT/IQ21O2gAKOzG7+HWWOPNRPaNsuYP/W+BtL12xmhdH1SUJ+/qrY1kjQIDAZaweZvbhKxF58Be2Bgbnpw0A9k+jgmpiPr2y3ehJOPMGpb8E/Lnso5AhnRosxOWCKtggiYhKecfvxsPcSo3q4TMTACPsimxC9XmjABQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WHpy04qa; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734427161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZKUG8/7+vJ4CurxMusMNyHDShZvXwj62eE8NC9Ca7Q=;
	b=WHpy04qaYGREjmB9I2/bNT8q0m7Itc52aKyA9xJajoh+1emO/0eQkVG6ByQGwbulu5cX95
	DT4W/0kqJw0uaQLyYojOEXXIluGm1OcG12N90rW77922WcYJ2cwf+/t67g4GhM0+N+BsBl
	1zlMqLY42kC+0W/KVjLCPuXFNif6dKA=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix set_id_regs selftest for ASIDBITS becoming unwritable
Date: Tue, 17 Dec 2024 01:19:08 -0800
Message-Id: <173442713502.3654654.5293442477717772457.b4-ty@linux.dev>
In-Reply-To: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
References: <20241216-kvm-arm64-fix-set-id-asidbits-v1-1-8b105b888fc3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 16 Dec 2024 19:28:24 +0000, Mark Brown wrote:
> In commit 03c7527e97f7 ("KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits
> to be overridden") we made that bitfield in the ID registers unwritable
> however the change neglected to make the corresponding update to set_id_regs
> resulting in it failing:
> 
> # ok 56 ID_AA64MMFR0_EL1_BIGEND
> # ==== Test Assertion Failure ====
> #   aarch64/set_id_regs.c:434: masks[idx] & ftr_bits[j].mask == ftr_bits[j].mask
> #   pid=5566 tid=5566 errno=22 - Invalid argument
> #      1	0x00000000004034a7: test_vm_ftr_id_regs at set_id_regs.c:434
> #      2	0x0000000000401b53: main at set_id_regs.c:684
> #      3	0x0000ffff8e6b7543: ?? ??:0
> #      4	0x0000ffff8e6b7617: ?? ??:0
> #      5	0x0000000000401e6f: _start at ??:?
> #   0 != 0xf0 (masks[idx] & ftr_bits[j].mask != ftr_bits[j].mask)
> not ok 8 selftests: kvm: set_id_regs # exit=254
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Fix set_id_regs selftest for ASIDBITS becoming unwritable
      https://git.kernel.org/kvmarm/kvmarm/c/212fbabe1dfe

--
Best,
Oliver

