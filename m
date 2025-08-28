Return-Path: <linux-kselftest+bounces-40188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08FEB3A478
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7260C7B11C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C1233140;
	Thu, 28 Aug 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="V63mTV3I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A921FF3F;
	Thu, 28 Aug 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395064; cv=none; b=aas80FxeXD0XkWcdRLsbhz6gz45lr2DurH2o2QleiArv/+GKkVlfxNHjNtVBuI8zBHXTMTJaCD7kekAXG1Vies7AZAeZHE72zDeXfxQmpavjQz06jtD+Uj7NhQiiGNiv22yNSljFosqOI9YgkcSEMdN+EwFg/gy9dgQjmMFf6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395064; c=relaxed/simple;
	bh=pps4WRQh5Bswqj7mab00Wu9TY9raPg2pFOhzR6q8FlY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NslEP3cxQbjmNcR/iLPpi2H7g5Bki4xhnfrhto3c7ib7HKm+vjRWhaYV50LlwHOJWoKVq3yuU4NRDPS5RK70YHnjqL9gQ21HhcNO2L0Fs7lmoLyqr6Lg+myV/28CflRCPKo70liSm5ZF7dlwYUPjekmlrJY89TX7Uf+5i1l2zJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=V63mTV3I; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1756395062; x=1787931062;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xNtMEQZsqb3Yx8EkQoN5MB7RV1Kf0nTEyTqoMwlAeNw=;
  b=V63mTV3IPL8n2N0f67B/YB4C+BaZCFV/Q4VCHJoUmZiKBf77EBKCq9In
   JwzAw7K5T6jl2FD2P9Wo0bzQtPR/Nsj2OjuWRT/Iw4YFXrccaHVb34R57
   JfgtLhK4v79CKcrZulBptG3j50T9eHzvllquDKmoBWS82RoatkyAxN4p7
   uaaCPmOhylVOrY5nois7mbKzIEJq4JvNEOljm+NJn5Gt5DngRveSMI+kv
   Us6Cxr9FS4de05LGvtsSw7eRfXIiyTEdP6Fj3MbYrLLPjdwqoyhRFGnst
   K7g5f88mPx2ymvnJlrSBkD28X16ry3dwhIwOoNiyd8eCL55T+KYzLKAaL
   A==;
X-CSE-ConnectionGUID: kanVlPdYQVeNY1A1HzoJNQ==
X-CSE-MsgGUID: SAWkWVE1Ru+ssn/EfMrgFw==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1221059"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:30:51 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:22763]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.1:2525] with esmtp (Farcaster)
 id cec2b93f-1649-48b4-b76a-f1914e2e471b; Thu, 28 Aug 2025 15:30:51 +0000 (UTC)
X-Farcaster-Flow-ID: cec2b93f-1649-48b4-b76a-f1914e2e471b
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 28 Aug 2025 15:30:50 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 28 Aug 2025 15:30:50 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.017; Thu, 28 Aug 2025 15:30:50 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "david@redhat.com"
	<david@redhat.com>, "jthoughton@google.com" <jthoughton@google.com>, "Roy,
 Patrick" <roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v4 0/2] KVM: guest_memfd: use write for population
Thread-Topic: [PATCH v4 0/2] KVM: guest_memfd: use write for population
Thread-Index: AQHcGDC70DbxFr6MFESkDXTHRODToQ==
Date: Thu, 28 Aug 2025 15:30:50 +0000
Message-ID: <20250828153049.3922-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[ based on kvm/next ]=0A=
=0A=
Implement guest_memfd allocation and population via the write syscall.=0A=
This is useful in non-CoCo use cases where the host can access guest=0A=
memory.  Even though the same can also be achieved via userspace mapping=0A=
and memcpying from userspace, write provides a more performant option=0A=
because it does not need to set page tables and it does not cause a page=0A=
fault for every page like memcpy would.  Note that memcpy cannot be=0A=
accelerated via MADV_POPULATE_WRITE as it is not supported by=0A=
guest_memfd and relies on GUP.=0A=
=0A=
Populating 512MiB of guest_memfd on a x86 machine:=0A=
 - via memcpy: 436 ms=0A=
 - via write:  202 ms (-54%)=0A=
=0A=
v4:=0A=
 - Switch from implementing the write callback to write_iter=0A=
 - Remove conditional compilation=0A=
 - Rebase to kvm/next=0A=
=0A=
v3:=0A=
 - https://lore.kernel.org/kvm/20250303130838.28812-1-kalyazin@amazon.com=
=0A=
 - David/Mike D: Only compile support for the write syscall if=0A=
   CONFIG_KVM_GMEM_SHARED_MEM (now gone) is enabled.=0A=
v2: =0A=
 - https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com=
=0A=
 - Switch from an ioctl to the write syscall to implement population=0A=
=0A=
v1:=0A=
 - https://lore.kernel.org/kvm/20241024095429.54052-1-kalyazin@amazon.com=
=0A=
=0A=
Nikita Kalyazin (2):=0A=
  KVM: guest_memfd: add generic population via write=0A=
  KVM: selftests: update guest_memfd write tests=0A=
=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  | 85 +++++++++++++++++--=0A=
 virt/kvm/guest_memfd.c                        | 64 +++++++++++++-=0A=
 2 files changed, 142 insertions(+), 7 deletions(-)=0A=
=0A=
=0A=
base-commit: a6ad54137af92535cfe32e19e5f3bc1bb7dbd383=0A=
-- =0A=
2.50.1=0A=
=0A=

