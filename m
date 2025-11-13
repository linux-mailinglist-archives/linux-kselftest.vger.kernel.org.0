Return-Path: <linux-kselftest+bounces-45588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D677CC5A0EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 22:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 124794E6295
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70062D0C7D;
	Thu, 13 Nov 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjYnTKJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B828506C;
	Thu, 13 Nov 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068006; cv=none; b=NjZPY+yeaFI8KJs1epqmvCCiWfDwnHK6T2XYq0aU7hCoL1tjolpJ8oAfugMd8f30XUahBwP7EpspXIjraglAtSTnU2FxMsPde2i0zTwdwvUeIuyt1Ah5Fs7Fente6V0ZRRf8LlcCdSRX7MYbgjk2WIXxtv7499DCL/Pk8nHvxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068006; c=relaxed/simple;
	bh=IC4VpM6ZN4n39UtKfc2C/9ZDlOpdPQkYd/6hCrS82gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+WLzgQM5vexxe72Mipddn1snRlk9JloMXiCX4vekh6K4KmAZuAizBWff9JABY07VUHOzCyzF/Drj/O02Dvioqpqx79TstOuQ3bHFL6yd8OalQz7UD/HGH2jTaw6K1qy3Xy/LyyTccuM7FdYDl+TIHAOugcconl/9hEbVjx12d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjYnTKJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D99C16AAE;
	Thu, 13 Nov 2025 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763068006;
	bh=IC4VpM6ZN4n39UtKfc2C/9ZDlOpdPQkYd/6hCrS82gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OjYnTKJ/stoU+JDIoC3n2v+tPgNx/vKxfRWf/HLoAlV5nbyLzTu3Ft8Fvny0t11N6
	 QMA8MUkfHE+tj4p6jJ7b633oqS+hKmhvAFLG3eeT++DIUO73t7L8dCzgIitVFGXwPx
	 vKgeQKWtb+KRhIFIRnPtm2OSNHPsq6HhaSnbDz9d921vntsZAJo/H+LncPIkgF2weV
	 uy73KnJRVrKK02jSnG8GQYTr7ugY8LNqcFVOCrzY0BCSN3QTF9vi2wTgxEYMl/Fx8z
	 jMbYJcK3VZ/574J8jMi1QZrcEHBIeMWLfcLIVztc/DQqN83+i6/LjyEV2cR5bm6/E0
	 e9Xsi8eezp0qw==
From: Oliver Upton <oupton@kernel.org>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	Jiaqi Yan <jiaqiyan@google.com>
Cc: Oliver Upton <oupton@kernel.org>,
	duenwen@google.com,
	rananta@google.com,
	jthoughton@google.com,
	vsethi@nvidia.com,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	pbonzini@redhat.com,
	corbet@lwn.net,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
Date: Thu, 13 Nov 2025 13:06:42 -0800
Message-ID: <176305834766.2137300.8747261213603076982.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013185903.1372553-1-jiaqiyan@google.com>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 13 Oct 2025 18:59:00 +0000, Jiaqi Yan wrote:
> Problem
> =======
> 
> When host APEI is unable to claim a synchronous external abort (SEA)
> during guest abort, today KVM directly injects an asynchronous SError
> into the VCPU then resumes it. The injected SError usually results in
> unpleasant guest kernel panic.
> 
> [...]

I've gone ahead and done some cleanups, especially around documentation.

Applied to next, thanks!

[1/3] KVM: arm64: VM exit to userspace to handle SEA
      https://git.kernel.org/kvmarm/kvmarm/c/ad9c62bd8946
[2/3] KVM: selftests: Test for KVM_EXIT_ARM_SEA
      https://git.kernel.org/kvmarm/kvmarm/c/feee9ef7ac16
[3/3] Documentation: kvm: new UAPI for handling SEA
      https://git.kernel.org/kvmarm/kvmarm/c/4debb5e8952e

--
Best,
Oliver

