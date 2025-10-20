Return-Path: <linux-kselftest+bounces-43561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15190BF2560
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1923AA8C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA3283FC3;
	Mon, 20 Oct 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="dDcW1ZLV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E56284671;
	Mon, 20 Oct 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976852; cv=none; b=GWbYLRViCFTzIMmEgjIvltkkJ4VzCOZ3uApot/bEM8hf6eD6cOzAHNobqSbcJXQkZZCDC4kTY1Mv9UZiW28/zxZA2wrh4glgpb+PmGRERN/jtqpZtv0leEnkg4H+srJ6aMRDZDCyijzBK9X1qfnoeE7/HOpcBxrq/Ni18xt/QrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976852; c=relaxed/simple;
	bh=hmRUpvq6oKab7SIEbBOTBG/CLfaTLJnPXRYcRfhSvgI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dW+Qx1tsyDurIniWEWJahdKigklm+wxJ1sxrcDaQS00I3aSawePOQTixZRwVc4qDf9OvdiSVWuEW+AU5FR0+SoIc/7uX3pf7aT08BuiHo7CTJfMNZGWInRFHpQL+GfFEiUXozo5UXFqJ66rKQO7DSBu+hFUZzFksI7+jU98ZqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=dDcW1ZLV; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1760976850; x=1792512850;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HM0NkRavqS3GtFDYxSJm+SUrc6wWDF1RA7kInLRp/Zw=;
  b=dDcW1ZLVcpaHzcBKSci4blqVk97fDoCeXcaOFZ4PnO++Tx5FX8NrCscD
   p8Ry5SWVN3onoC+lJIGqKhDfzyhgnyouVSE+GcvoL6SoffTB7pKaWttwl
   3nQ4T9oqjnTyY8cDkFtXacBQJu4BIVu64SDut7c6H0iq9uzVbLPeBVlgZ
   ISlDHKsdGSXFDSrinzUYxT/fjxFli6yHtVlBS82uSUogpUfPTSIg0gdc5
   63BNBEbENB7l/ueY3dmWpQYHO3lX3R/4xrGVzdF5Ba1qn2bxmkuOB+8Gd
   Eh7Rv12CjGpIvq0S7sLbmlV3GDJmhCBRQbfdxnw/fRJsH1I2dNEYYuy6N
   Q==;
X-CSE-ConnectionGUID: UNolPS1lTKOnTkRjXUIRTg==
X-CSE-MsgGUID: 9qmkCWiCRICjSmYu436ONQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754956800"; 
   d="scan'208";a="3888531"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 16:13:54 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:12066]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.7:2525] with esmtp (Farcaster)
 id 2db2d1d5-772f-4146-99d0-99fd383e1498; Mon, 20 Oct 2025 16:13:54 +0000 (UTC)
X-Farcaster-Flow-ID: 2db2d1d5-772f-4146-99d0-99fd383e1498
Received: from EX19D022EUC004.ant.amazon.com (10.252.51.159) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 16:13:54 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC004.ant.amazon.com (10.252.51.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 16:13:53 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Mon, 20 Oct 2025 16:13:53 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "david@redhat.com"
	<david@redhat.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v6 0/2] KVM: guest_memfd: use write for population
Thread-Topic: [PATCH v6 0/2] KVM: guest_memfd: use write for population
Thread-Index: AQHcQdyH4uB/imgOM0uSjxjsVl8ABA==
Date: Mon, 20 Oct 2025 16:13:53 +0000
Message-ID: <20251020161352.69257-1-kalyazin@amazon.com>
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
Implement guest_memfd population via the write syscall.=0A=
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
The write syscall support is conditional on kvm_gmem_supports_mmap.=0A=
When in-place shared/private conversion is supported, write should only=0A=
be allowed on shared pages.=0A=
=0A=
v6:=0A=
 - Make write support conditional on mmap support instead of relying on=0A=
   the up-to-date flag to decide whether writing to a page is allowed=0A=
 - James: Remove depenendencies on folio_test_large=0A=
 - James: Remove page alignment restriction=0A=
 - James: Formatting fixes=0A=
=0A=
v5:=0A=
 - https://lore.kernel.org/kvm/20250902111951.58315-1-kalyazin@amazon.com/=
=0A=
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
 .../testing/selftests/kvm/guest_memfd_test.c  | 51 ++++++++++++++++---=0A=
 virt/kvm/guest_memfd.c                        | 49 ++++++++++++++++++=0A=
 2 files changed, 94 insertions(+), 6 deletions(-)=0A=
=0A=
=0A=
base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac=0A=
-- =0A=
2.50.1=0A=
=0A=

