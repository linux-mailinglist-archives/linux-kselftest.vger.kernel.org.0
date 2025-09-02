Return-Path: <linux-kselftest+bounces-40637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672BB40B92
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA740208538
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F332ED4E;
	Tue,  2 Sep 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VPVbG860"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B32DE1E3;
	Tue,  2 Sep 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832724; cv=none; b=SSP5CS3aGpVWZ526fE/vdpKNra6b58+j8LeARNsQ8ED/AjD8aGU+hrSI98HAzBznbddQrx7wfqtjt4x0JF22D3zlIxRzQwTGuDaOHOn/FZwGSAt7sxlK93NVcglSyA1wkNJP3cSiU0DmXEzttS5iinF1N6shEY/did6U6edCoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832724; c=relaxed/simple;
	bh=QobdhLlZNjl3QjlIX3rgbdoxLs2+ODRJC7JZyFR/2jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0CyJzSuftzLEgVwYCQrnwK5UQHLJdCqbYrOSX03ZdGmh8tkcTIYTiIGnMdSPTxpwsdbukpq4rP7V78YvZro33SeigTbylNix+VGE7yX/oBAX+OMcoYeBg7hOiSZ0Z/oE136adlKZHFb18Nkked09KdFxY21TiyYFeVMOuQnbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VPVbG860; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832722; x=1788368722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5jwovR6cUtAAK5RNs9kUpvz4Sb+WrBMm5wfVaSNJno=;
  b=VPVbG860vnMmyiCmjLjrOZq87cuNHsrpdiIQhMOJ62X/GB3Dnob42xOe
   DW3u6J6jI4r5HirDj9vxbQgU9k1+HL2HOI4moLetA9Y1IHE2TJAO+zoEc
   uOmASGyqQT3zb5TebVUYkvHqgkCUusxPLzQZ1S+m300P+jcCh7G8Mwcud
   D5s7ckASVQXb+sYWFnVRG1xY0Pj0RAraNWDb3CRbVHdZ0yY53yJWyqhrE
   gS1gr8UxzSObZ1SIgQf2xISJh978MwUvUeApRtUbTyYZ+A8MkGESqnxQW
   OtMD9hM3aGztdTBkwaNwXEwjgYLDhNj6/Hdsnt1RY8IBLX1t1DOj2q2qH
   w==;
X-CSE-ConnectionGUID: pnDePsbvSK6OC0I0WSEpxw==
X-CSE-MsgGUID: NLYW+MRJTMug8FKYZzA/bQ==
X-IronPort-AV: E=Sophos;i="6.16,315,1744070400"; 
   d="scan'208";a="2115095"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:05:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:28339]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id 9c41e06e-3703-4d71-a932-d8327fe12c9c; Tue, 2 Sep 2025 17:05:20 +0000 (UTC)
X-Farcaster-Flow-ID: 9c41e06e-3703-4d71-a932-d8327fe12c9c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:05:18 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:05:17 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 7/7] selftests: kselftest: Add ulong typedef for non-glibc compatibility
Date: Tue, 2 Sep 2025 17:01:44 +0000
Message-ID: <20250902170147.55583-8-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250902170147.55583-1-aqibaf@amazon.com>
References: <20250902170147.55583-1-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Some C libraries may not define the ulong typedef that is commonly
available as a BSD/GNU extension. Add a fallback typedef to ensure ulong
is available across all selftest environments.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kselftest.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index f362c6766..a1088a2af 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -58,6 +58,11 @@
 #include <stdio.h>
 #include <sys/utsname.h>
 #include <sys/syscall.h>
+#include <sys/types.h>
+#endif
+
+#ifndef ulong
+typedef unsigned long ulong;
 #endif
 
 #ifndef ARRAY_SIZE
-- 
2.47.3


