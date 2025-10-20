Return-Path: <linux-kselftest+bounces-43557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6FBF208C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4882234D8EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3B239E6F;
	Mon, 20 Oct 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qtEeMGP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024924501B;
	Mon, 20 Oct 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973257; cv=none; b=nzBrvSSmgEIGQAJhpcBpqzcumLu6c5TdXggLzSXWbD0VEn8hzeXot4JOH6h14LWcVnaBuKvvJ54VPFOBFgXxnfiUvKg35l4vFBGSwsd966E4gc9deVXWmcTXC9CYujsrfxt3OzpqYsAC0+9o4P37W5s5DGA2gyr1Mg0xMeasRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973257; c=relaxed/simple;
	bh=D6CPnFonO5sKCS7bceN3KCTd/W/tZnWxyXeYaG8/twM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0qXlFrp8LconqrWBUv1nGGQaNm44WquXXY0+1VSBlJ15UMgJbBEutPFowr6o0ApUV7I7Y14u2/rtuEWs4ZRR6r0w5UHJ8nSdJRJOkYQbKEaYdIXMHH+p/M3fSYyi8d7a9EWi5Yq/GFXBwFhGikR3x7KIHS3bwFbmkT1usMgK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qtEeMGP6; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1760973255; x=1792509255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D6CPnFonO5sKCS7bceN3KCTd/W/tZnWxyXeYaG8/twM=;
  b=qtEeMGP6IoC20XYyskKhYoQdfnXFN+kRmfPP91UbyH+yxQisYTgnm64n
   kFY/v2WS6/O+H4LhptXC/zTzCWfAqyicHAuhCCthg9tgCXQMQL7wu89Np
   fz5Fu08dKkG4UcGbYsOg5BVweXIJucdfPIvvh4WkmZhlck3RnBNGtYgEJ
   u7FmfpGl5vOULFH0aoBQMNX2cvV2BhtxK4vjqAb/7dPBuak6SPhQUp39K
   nDHewSOB6LdpwJFxlwI94K4dxcexTbrfFXSO021mIVThnyUCkv8Ns8cU+
   OU71840SjaP3AbQGRarRibLCklMlPxjFt+tkwGQ9ZXPgTJxSgkfSNS33S
   w==;
X-CSE-ConnectionGUID: n3NccE7KSW2YT45fxLv/oA==
X-CSE-MsgGUID: rbGIbQvaRRWjTbKBN5HbyA==
X-IronPort-AV: E=Sophos;i="6.19,242,1754956800"; 
   d="scan'208";a="3778757"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 15:14:05 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:4499]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.58:2525] with esmtp (Farcaster)
 id b59244ba-5e60-4163-a3ec-cd524499c9d1; Mon, 20 Oct 2025 15:14:05 +0000 (UTC)
X-Farcaster-Flow-ID: b59244ba-5e60-4163-a3ec-cd524499c9d1
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 15:14:04 +0000
Received: from amazon.com (10.1.213.24) by EX19D016EUA001.ant.amazon.com
 (10.252.50.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 20 Oct 2025
 15:14:00 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>
CC: <epetron@amazon.de>, <kvm@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<mdittgen@amazon.com>, <mdittgen@amazon.de>, <nh-open-source@amazon.com>,
	<oliver.upton@linux.dev>, <pbonzini@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH] KVM: selftests: fix ITS collection target addresses in vgic_lpi_stress
Date: Mon, 20 Oct 2025 17:13:50 +0200
Message-ID: <20251020151350.54383-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <86ms5lwwv8.wl-maz@kernel.org>
References: <86ms5lwwv8.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D016EUA001.ant.amazon.com (10.252.50.245)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 15:01:15 +0200,
Marc Zyngier <maz@kernel.org> wrote:
>
> To be clear: I don't object to the patch. I object to the nonsensical
> commit message.
>
> And yes, what you have is the correct fix. Just wrap it as a helper
> I'd suggest procnum_to_rdbase(), if you need a name for it).

Thank you for the feedback, I've created a PATCH v2 with revised commit
message and a procnum_to_rdbase() helper.

>
> This test also violate the architecture by not performing a SYNC after
> any command, which would also require the use of a properly formatted
> target field. But hey, correctness is overrated.

I am currently working on a RFC patchset for per-vCPU vLPI enablement
that extends this selftest to test the feature. I will package in SYNCs
as a patch on the RFC.

Thanks,
Maximilian



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


