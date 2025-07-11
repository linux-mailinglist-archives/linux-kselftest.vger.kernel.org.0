Return-Path: <linux-kselftest+bounces-37141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA0B024BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85F51CC1AEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6F2EF2B7;
	Fri, 11 Jul 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Py4slIFZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E51EDA02
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262956; cv=none; b=eRPQ1xc3DS9z2P2k3yLMFNaJtzulgnOZy4iroq9L0D9x1jFm3Pbbk/H0ADnd1LQJUmxlmWNjGsMzSUOGNm0GOpV+9kvtDAKpAsoYP53rN56swai6oDKb7pt+hngAl6zpJ9IRBEmScq7wA9B7Mk/qGRYlKKFHvTQT2Zc2wlG4Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262956; c=relaxed/simple;
	bh=VLbzorY0n6PqqSWUGpUYrnA4fE3O1mRmiCKrT9CyVCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttIiIMl1JHUUtotvexEXR6l04eoPqYFnN0MJ6gk7UumiXNzBaY8zxUEoHLLzahEZGPvpUuM8KO/awelt6EIlwyopiOxCG7aNZ1pV1E9h+XPXcMq76XypS5M8pDNGjrA2tRGyYgZ54WSHhavOPZSggLMTe9sRSOd40epHxf8ibVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Py4slIFZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 11 Jul 2025 12:42:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752262952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwDkA/k4uQ8rJWv4rXBFYD6yrpVbwo5iXFFYCV9jD3M=;
	b=Py4slIFZS4yfmDNfDVrRc6kKPfCrBTpWJhlMdMs8CsgIjAu65Ka3BQErVwzOSzZTSdQ2uW
	O9PfpB0wHuY6xLA0J1gx9Nv5ddly0Z2/QFWP5xCBetO7kDdUIg/hyMpW0WYQPjAD76b7C6
	btUC6rqqZgOgSNxCLk+VCW9zxtrsuJM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 3/6] KVM: arm64: Allow userspace to inject external
 instruction aborts
Message-ID: <aHFpIpIfqVCQZVgG@linux.dev>
References: <20250604050902.3944054-1-jiaqiyan@google.com>
 <20250604050902.3944054-4-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604050902.3944054-4-jiaqiyan@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 04, 2025 at 05:08:58AM +0000, Jiaqi Yan wrote:
> From: Raghavendra Rao Ananta <rananta@google.com>
> 
> When KVM returns to userspace for KVM_EXIT_ARM_SEA, the userspace is
> encouraged to inject the abort into the guest via KVM_SET_VCPU_EVENTS.
> 
> KVM_SET_VCPU_EVENTS currently only allows injecting external data aborts.
> However, the synchronous external abort that caused KVM_EXIT_ARM_SEA
> is possible to be an instruction abort. Userspace is already able to
> tell if an abort is due to data or instruction via kvm_run.arm_sea.esr,
> by checking its Exception Class value.
> 
> Extend the KVM_SET_VCPU_EVENTS ioctl to allow injecting instruction
> abort into the guest.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Hmm. Since we expose an ESR value to userspace I get the feeling that we
should allow the user to supply an ISS for the external abort, similar
to what we already do for SErrors.

Thanks,
Oliver

