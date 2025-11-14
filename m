Return-Path: <linux-kselftest+bounces-45647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB8C5E276
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 417C2363A5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882B338596;
	Fri, 14 Nov 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="VOAAd+M9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290932D42B;
	Fri, 14 Nov 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133524; cv=none; b=k7wfR32ssr/Mhae8I72VJPl+apsJL5ynzVUzjgU8d7TDrFZepf9gWNSH636mmceLTg1brjmjt/KFCmRFjClQHW5t27x79L3T+BcvHwn1mHpswK+UvCPK9aXtaYmKzxyI1mQtvA6IsrArnbBKyB9di8rGZs3ALf5ABHk/Zg5zIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133524; c=relaxed/simple;
	bh=DSUWYJGUUNjXdRalbbjGbYEyWnnScyAYHV1QqxDeyG8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uHsHHAHZ1Sn5oNlpuKemvXQx7+eaPnisT/Lz/LbyS53m5KyzSm2jmoQ6yxuH/RgckeBiUA89lltG/CNAUclRUHlVYeM5WDEnFXA3inUPd3Mhk/j+JqLzuLxgXHKUbs737ziX9CtXTdnkTI0Wx1aTAlfzheielPcR+PXbymKngZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=VOAAd+M9; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1763133523; x=1794669523;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wMUNaoJtA1H7CbX5SyG2xiNW33biBKTJrPmMXHMoZo4=;
  b=VOAAd+M9z9JuURJW6ACtQsEzDzJLfAV4jPnBVZ3BigYCIs6B5SRXEFh2
   3IqZCTxWmYv8tRKDkCOHHL9je0wNEOTbenDXkGXXp95EAr0gnFZptx50c
   g5b7moZb7HoYXAL1shTlNfdnytE/5F/eyzZ2NnNYAS2YdQr+SLEUKpJeX
   xjSkXPp6LkT3jyAVSnUqrOJQx8Tasn61QIKCZ7Cyo4UziEMrbKlepFjC6
   3VS3YmTfnS6m5Ferw27hxO65k3psQZ30Wu/e2lfgyzxieqBfe2NlmbpgT
   iHHr37gvsZmDmyw9sHANyvEIUP8U+zy3BRulqWo21GeyXm4dlDttR2nEZ
   A==;
X-CSE-ConnectionGUID: 6DUbQ0RpTtC90LNcg9gTpQ==
X-CSE-MsgGUID: lWzWRNmZTVyz/DHSZfNTQg==
X-IronPort-AV: E=Sophos;i="6.19,305,1754956800"; 
   d="scan'208";a="6932496"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 15:18:40 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:31086]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.6.153:2525] with esmtp (Farcaster)
 id 62e2b2f4-dde3-40a8-b74c-6f060b46590a; Fri, 14 Nov 2025 15:18:38 +0000 (UTC)
X-Farcaster-Flow-ID: 62e2b2f4-dde3-40a8-b74c-6f060b46590a
Received: from EX19D022EUC001.ant.amazon.com (10.252.51.254) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:18:31 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC001.ant.amazon.com (10.252.51.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:18:30 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.029; Fri, 14 Nov 2025 15:18:30 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "david@kernel.org"
	<david@kernel.org>, "jthoughton@google.com" <jthoughton@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v7 0/2] KVM: guest_memfd: use write for population
Thread-Topic: [PATCH v7 0/2] KVM: guest_memfd: use write for population
Thread-Index: AQHcVXnuXonU0nGUBU6wEK3eSXEVmA==
Date: Fri, 14 Nov 2025 15:18:30 +0000
Message-ID: <20251114151828.98165-1-kalyazin@amazon.com>
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

On systems that support shared guest memory, write() is useful, for=0A=
example, for population of the initial image.  Even though the same can=0A=
also be achieved via userspace mapping and memcpying from userspace,=0A=
write() provides a more performant option because it does not need to=0A=
set user page tables and it does not cause a page fault for every page=0A=
like memcpy would.  Note that memcpy cannot be accelerated via=0A=
MADV_POPULATE_WRITE as it is not supported by guest_memfd and relies on=0A=
GUP.=0A=
=0A=
Populating 512MiB of guest_memfd on a x86 machine:=0A=
 - via memcpy: 436 ms=0A=
 - via write:  202 ms (-54%)=0A=
=0A=
Only PAGE_ALIGNED offset and len are allowed.  Even though non-aligned=0A=
writes are technically possible, when in-place conversion support is=0A=
implemented [1], the restriction makes handling of mixed shared/private=0A=
huge pages simpler.  write() will only be allowed to populate shared=0A=
pages.=0A=
=0A=
When direct map removal is implemented [2]=0A=
 - write() will not be allowed to access pages that have already=0A=
   been removed from direct map=0A=
 - on completion, write() will remove the populated pages from=0A=
   direct map=0A=
=0A=
While it is technically possible to implement read() syscall on systems=0A=
with shared guest memory, it is not supported as there is currently no=0A=
use case for it.=0A=
=0A=
[1]=0A=
https://lore.kernel.org/kvm/cover.1760731772.git.ackerleytng@google.com=0A=
[2]=0A=
https://lore.kernel.org/kvm/20250924151101.2225820-1-patrick.roy@campus.lmu=
.de=0A=
=0A=
Nikita Kalyazin (2):=0A=
  KVM: guest_memfd: add generic population via write=0A=
  KVM: selftests: update guest_memfd write tests=0A=
=0A=
 Documentation/virt/kvm/api.rst                |  2 +=0A=
 include/linux/kvm_host.h                      |  2 +-=0A=
 include/uapi/linux/kvm.h                      |  1 +=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  | 58 +++++++++++++++++--=0A=
 virt/kvm/guest_memfd.c                        | 52 +++++++++++++++++=0A=
 5 files changed, 108 insertions(+), 7 deletions(-)=0A=
=0A=
=0A=
base-commit: 8a4821412cf2c1429fffa07c012dd150f2edf78c=0A=
--=0A=
2.50.1=0A=
=0A=

