Return-Path: <linux-kselftest+bounces-40557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F0B3FD9E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCBB2C3498
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E844E2DEA7E;
	Tue,  2 Sep 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="jgAFFVgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D6274FCB;
	Tue,  2 Sep 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812006; cv=none; b=pDQoJhSYc6z57EXRsDfcSXEZXGzH+udhe47kgGI/0xzFwSQiqwu32BfiyG9AHkdwL9l2FvqmPiQvgHMl1OFrN6hiO6529P0/T04ZTU9eKFpvDzNvoTNLBpYyZqOJJ4Jai9BblJyr3J2swgeEOhfwYKU1BoYhrq338dqsX6HO8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812006; c=relaxed/simple;
	bh=kLv4/OFnxMoWVNWSaozPg9yvYOEwHWxYW5FDLJoxEPI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ruRuLm8M4SW+iStD1D0h/CKqeZQXSO2caqTIHX+AWWysfxugsztt7YpdKZa/k0+B26vwvyQeD5XJzie8hTGaMN0iJOJ9ZCNkyyf6047L1QWds8jBHq2cz7F7zjMv8XKPGrRdPuODULkw1UrdLZ//NpNFJngtVA+3erpIwz/j+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=jgAFFVgc; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1756812005; x=1788348005;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=T2FNUfhL52Aj3gYjfonLSUXy0y+SrmAkwUY44HuIAUI=;
  b=jgAFFVgcpHolnRIUbaBSm+w8tezjs6RMdaerInZMFhLwHiOvOA+pHf0X
   /dRAGu0OlrvOgTClDi29h6O7CIcbS3YtuAs3uKSEDv9prN1HpBU3F24fc
   nbK07aYb88YvAEOci23KuqCtll0L0ZPhfQ0L/2AX0vYy1DArBshsUry+5
   S43+egCV7E60qqLBH1T+dt3VxViPO7xyzhlOsfXO66MZNeIgEOw5LbEIC
   6S9+usrtpgm1G04HyZEAJYW4OvY1fplad6TxMOZiH/s1kZnaxORwzUqmW
   MvlPorYpk/CfirY2/0CH3+oEbaUFv6z3xTAKjlhEAED6uOE41ylKMiMYU
   A==;
X-CSE-ConnectionGUID: zdx8S7qKRge5hrOr7ylQ5Q==
X-CSE-MsgGUID: Q5o+A52gTmuo3o5PMcPuwA==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1514564"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 11:19:54 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:27891]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.42.3:2525] with esmtp (Farcaster)
 id e1a424b6-12be-486e-98a1-6ed3976288e5; Tue, 2 Sep 2025 11:19:53 +0000 (UTC)
X-Farcaster-Flow-ID: e1a424b6-12be-486e-98a1-6ed3976288e5
Received: from EX19D022EUC004.ant.amazon.com (10.252.51.159) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 11:19:53 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC004.ant.amazon.com (10.252.51.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 11:19:53 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Tue, 2 Sep 2025 11:19:53 +0000
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
Subject: [PATCH v5 0/2] KVM: guest_memfd: use write for population
Thread-Topic: [PATCH v5 0/2] KVM: guest_memfd: use write for population
Thread-Index: AQHcG/uAwYfJViZqa06rri0E+cpusg==
Date: Tue, 2 Sep 2025 11:19:52 +0000
Message-ID: <20250902111951.58315-1-kalyazin@amazon.com>
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
accelerated via MADV_POPULATE_WRITE as it is  not supported by=0A=
guest_memfd and relies on GUP.=0A=
=0A=
Populating 512MiB of guest_memfd on a x86 machine:=0A=
 - via memcpy: 436 ms=0A=
 - via write:  202 ms (-54%)=0A=
=0A=
v5:=0A=
 - Replace the call to the unexported filemap_remove_folio with=0A=
   zeroing the bytes that could not be copied=0A=
 - Fix checkpatch findings=0A=
=0A=
v4:=0A=
 - https://lore.kernel.org/kvm/20250828153049.3922-1-kalyazin@amazon.com=0A=
 - Switch from implementing the write callback to write_iter=0A=
 - Remove conditional compilation=0A=
=0A=
v3:=0A=
 - https://lore.kernel.org/kvm/20250303130838.28812-1-kalyazin@amazon.com=
=0A=
 - David/Mike D: Only compile support for the write syscall if=0A=
   CONFIG_KVM_GMEM_SHARED_MEM (now gone) is enabled.=0A=
v2:=0A=
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
 .../testing/selftests/kvm/guest_memfd_test.c  | 86 +++++++++++++++++--=0A=
 virt/kvm/guest_memfd.c                        | 62 ++++++++++++-=0A=
 2 files changed, 141 insertions(+), 7 deletions(-)=0A=
=0A=
=0A=
base-commit: a6ad54137af92535cfe32e19e5f3bc1bb7dbd383=0A=
-- =0A=
2.50.1=0A=
=0A=

