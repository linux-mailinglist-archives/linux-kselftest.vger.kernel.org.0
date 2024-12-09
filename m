Return-Path: <linux-kselftest+bounces-23005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7B9E8F41
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B881886B53
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B003217739;
	Mon,  9 Dec 2024 09:50:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED380217676;
	Mon,  9 Dec 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737857; cv=none; b=qtxjXyBDLyDxUTtqD2GWBP2FI0JoIj31bx0ch1pzJ4aR/rBA4MMG516HdKzDtf5u6ECVXhcRV6m6xNwN5URrv2jj67JKlaACwM3up2IS+O3JljoLaM0ziPAHGFDRc2EV5jVcu4g5OhLM7c7t9WH8IMCU6mqaYz1I5UTTtTBZX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737857; c=relaxed/simple;
	bh=ClSJGmoHG7IdkzK7EBt7wLnsm+d7AJiHANoM04tn9Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMAKjEehCrX57v70P8wnQ6YshmfRacNfXqKX1uANl2dCUj1XSam0xadYWhnmJRskZBcvAwk5ddH1J2QdsJwV3/j1d08qCSXf/wQl9k0xdloCcqrcXKzacE++B/5+zSkAD/65FMcIRIUG2Xo7wfRKYo5rtSrpADUkv//7FkAGciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 664AB113E;
	Mon,  9 Dec 2024 01:51:23 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC003F720;
	Mon,  9 Dec 2024 01:50:53 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 07/14] selftests/mm: Define types using typedef in pkey-helpers.h
Date: Mon,  9 Dec 2024 09:50:12 +0000
Message-ID: <20241209095019.1732120-8-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using #define to define types should be avoided. Use typedef
instead. Also ensure that __u* types are actually defined by
including <linux/types.h>.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-helpers.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 472febd992eb..84376ab09545 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -13,13 +13,15 @@
 #include <ucontext.h>
 #include <sys/mman.h>
 
+#include <linux/types.h>
+
 #include "../kselftest.h"
 
 /* Define some kernel-like types */
-#define  u8 __u8
-#define u16 __u16
-#define u32 __u32
-#define u64 __u64
+typedef __u8	u8;
+typedef __u16	u16;
+typedef __u32	u32;
+typedef __u64	u64;
 
 #define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
 
-- 
2.47.0


