Return-Path: <linux-kselftest+bounces-22578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC779DAC8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA2C165755
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9120103D;
	Wed, 27 Nov 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om+wtm7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E4201028;
	Wed, 27 Nov 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728962; cv=none; b=dJy5IP/Fg428vASROXaD4KTZn8az5JA2odMxFHkg48I0aPa7XoByu6CmSCkb20MdhdAaWp/4TeDFKZMp2TJO2TzMqyIPGCavc1ox7+w2WXb+qOS+USqpKFNWKImDmuQ0sqiwaDldq79lRMHVjO8Bb+u+B7+F4q+XKs+pIa2p4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728962; c=relaxed/simple;
	bh=Sbl14Xzfp6nN0p/UKfe6EiU0QQWGiojbB1fSn6/9LWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwTlmfhZCjrtPldRZdmMqmUqB1rx26drQI4eGlyKAlGo4+Brf/XzHVTIXZN5MGYUmsFy2D75PfgQR+++fkfaWQozhDJbtqhyGRIhfXH6Oqn0NLaxp8ah6pcfObN9Izk5W4VNeU9kJaM60Uy2YB1Bk9+gEmVNm/Xm//DQpT0f10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om+wtm7U; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732728961; x=1764264961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sbl14Xzfp6nN0p/UKfe6EiU0QQWGiojbB1fSn6/9LWs=;
  b=Om+wtm7UsjdK8Bpc9NddPhTzPlZIXDgvkM30e85XTeMqofwwtosfWgCt
   KrL+Dq7bkM+XoKsCJdO91nWiQ1+QeNnn0VGLQsgdjFFW4FgvoowpOdTSo
   zf/oAKBshRdzFmyAMJLK7wno3FKhfufzsgA/Rwzqk3eLK80N974e8U1uE
   lw/suzdt1Dl9klZIP3QJle03I8+YFdn11SkZCH7lBGlgPDYDylQ+co3HS
   2t9/7YoK1PdlqGYxfT5P6SzAvPop8eoKQFBZbSXPWAvfJYxv87/lk/qlj
   HJ7n4spO9I/fdhLKRqkaLt0jlfJQ6rNq39ZX0pdTAmKyRhUIq4p75kIY7
   Q==;
X-CSE-ConnectionGUID: 3eak5DefSoyzQWgjyvrsKg==
X-CSE-MsgGUID: bZgGk8RuRQ+TnkUEgVArig==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43607496"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43607496"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:36:00 -0800
X-CSE-ConnectionGUID: Y1klalnhTLydkm4reomGLA==
X-CSE-MsgGUID: /d3WfWRmTCqU6/Osh454iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91626331"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.193])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:35:57 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kirill@shutemov.name,
	maciej.wieczor-retman@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo flag
Date: Wed, 27 Nov 2024 18:35:29 +0100
Message-ID: <63f8fa8ac016f9f294230657e9069a616bce6141.1732728879.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In current form cpu_has_la57() reports platform's support for LA57
through reading the output of cpuid. A much more useful information is
whether 5-level paging is actually enabled on the running system.

Presence of the la57 flag in /proc/cpuinfo signifies that 5-level paging
was compiled into the kernel, is supported by the platform and wasn't
disabled by kernel command line argument.

Use system() with cat and grep to figure out if la57 is enabled on the
running system.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changelog v5:
- Remove "cat" from system() call and use only "grep".

Changelog v4:
- Add this patch to the series.

 tools/testing/selftests/x86/lam.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..93f2f762d6b5 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -124,14 +124,9 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
-/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
 static inline int cpu_has_la57(void)
 {
-	unsigned int cpuinfo[4];
-
-	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
-
-	return (cpuinfo[2] & (1 << 16));
+	return !system("grep -wq la57 /proc/cpuinfo");
 }
 
 /*
-- 
2.47.1


