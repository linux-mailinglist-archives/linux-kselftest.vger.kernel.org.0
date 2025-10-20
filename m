Return-Path: <linux-kselftest+bounces-43546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE2BF109C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E06A3BE2B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75431280D;
	Mon, 20 Oct 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RcHeUbw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B230FC35;
	Mon, 20 Oct 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962381; cv=none; b=V5K3rLg1PuVdy2e5opjLgKVHrPIDl4xIgVgO2U1fwIKEl0RYxpsmuNwKPIlMbctJRDMAHllTaKDdSzycUZGYw7WpKEYyzEI8HGipQgBMSrkHeKk20UgSW7pv2H/i7DGyW4VAwtP81xUFJ66901JWjOzxvhLncUID9L2LfZQlLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962381; c=relaxed/simple;
	bh=dahik2fjbYeAuSQncBFoEVv2d4q4dFGjf2TdTtpUg/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujzhZHfs1ya8YeNP9Z9lAmQhyoUhqL8jwca2bnNc3/q/6Hhxm3EdDkOk3EPnugb3NFx9rf+rrHDtCtMx8B2dDGfuVmtUFCN6FBJeDOT96pZrq9fVN7yF9tnSAVJ0/1JvKnP+6FROadK60xJOHw9qeYwCsgVX8Sv+cvraXKa9qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RcHeUbw8; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1760962379; x=1792498379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gT4c4sJrY+uRE80dfQnZ0+JjbvKqCsCY5BuNFNs0hp4=;
  b=RcHeUbw8cb3QpJzWDkDwBmSVtRUt2T28lfvwcIU3vQYxQK+UXlr+Ax2J
   xybaXsivVK8JlfltwhwLcvaY5ov3XxAhlUrWgGKPnrf7409zX0XwnaOfs
   9/C6GJU+i0B+qw8Fb1r6PJRfhKoKnh5mvPaGFHQbAGCLmVvPBgFeOo1Xj
   XYuLOVhTgn/jVfJGvMXMuExblUJjKwcKxCgwJIKW47TojH7t/9AVzqSio
   W6f71eaktYYc8t99iM76NdYLq+GHCxu9ovJI771Bt/UkSRa6K6P9tu1T7
   E1cs0PPQT6JEsz7J+6C+khmpRvyOcxAa9ZVwf8iciiHQdmBSOeAxpDvd4
   A==;
X-CSE-ConnectionGUID: paAvEk0fQZycm0Z2Ouoe9w==
X-CSE-MsgGUID: urA571EoRWOh9u8FI1m1cw==
X-IronPort-AV: E=Sophos;i="6.19,242,1754956800"; 
   d="scan'208";a="3869976"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:12:48 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:17685]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.169:2525] with esmtp (Farcaster)
 id d81a3bf9-5a3a-4933-b9f8-3d78ac7eca0f; Mon, 20 Oct 2025 12:12:48 +0000 (UTC)
X-Farcaster-Flow-ID: d81a3bf9-5a3a-4933-b9f8-3d78ac7eca0f
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 12:12:34 +0000
Received: from amazon.com (10.1.213.26) by EX19D016EUA001.ant.amazon.com
 (10.252.50.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 20 Oct 2025
 12:12:30 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>
CC: <epetron@amazon.de>, <kvm@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<mdittgen@amazon.com>, <mdittgen@amazon.de>, <nh-open-source@amazon.com>,
	<oliver.upton@linux.dev>, <pbonzini@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH] KVM: selftests: fix ITS collection target addresses in vgic_lpi_stress
Date: Mon, 20 Oct 2025 14:12:20 +0200
Message-ID: <20251020121220.83972-1-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <86v7kdwj8u.wl-maz@kernel.org>
References: <20251017161918.40711-1-mdittgen@amazon.de> <86v7kdwj8u.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D016EUA001.ant.amazon.com (10.252.50.245)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 19:06:25 +0200,
Marc Zyngier <maz@kernel.org> wrote:
>
>	  * We use linear CPU numbers for redistributor addressing,
>	  * so GITS_TYPER.PTA is 0.
>
> It is not an address.

The issue is that its_encode_target in selftests is designed for
physical redistriubtor addresses (GITS_TYPER.PTA = 1) and thus
performs a right shift by 16 bits:

		its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 51, 16);

When the vgic_lpi_stress selftest passes in a linear vCPU id as
the redistributor address (GITS_TYPER.PTA = 0 behavior),
The its_encode_target function shifts the CPU numbers 16 bits right,
functionally zeroing them.

We need to either:
- Align this specific selftest with GITS_TYPER.PTA = 0 and not use
    its_encode_target to encode the target vCPU id. Instead have a
    dedicated encode function for the use case without a bit shift.
- Align all selftests with GITS_TYPER.PTA = 0 and refactor
    its_encode_target to skip the bit shift altogether.
- Align selftests with GITS_TYPER.PTA = 1 and pass a redistributor
    address, not a vCPU id, into its_send_mapc_cmd().

Otherwise, the selftest's current behavior incorrectly maps all
collections to target vCPU 0.

Thanks,
Maximilian



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


