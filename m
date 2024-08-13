Return-Path: <linux-kselftest+bounces-15206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B89502C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE281286255
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DB197531;
	Tue, 13 Aug 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcLpu6po"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB8170A0E;
	Tue, 13 Aug 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545950; cv=none; b=P9WapAxa0XsQxuR+pZzxCotDFvzjZ3t0O/zjRzzG04Uvj20mwfW0LeZUa1StMVqZihKYSX7ClCJ+uxxXi9hoh1/Epw+zZGtQHLGRwDPSCwe5SDQSab36Sw88E9us/Gj3+c9t1Dd+Hr9E1yegQNUgYX/IFKEKgypY3b67Zo9Va8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545950; c=relaxed/simple;
	bh=Ym9owthrbjXls/1zHUYjwSlYFNOdKvhxf1RaVgaxXY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZRPvX2eBjR9O9P0dAllo+wgqQCEYCBi22XkBEFvS24ltziF3k4IRrKyZvflExH/D8KAdzYr7voXAJOqpurSVfn4j/u8aiZHwlVI45O5DseKVUmps9vPvSOXKpXkFebMNxXhp1d9OUpHOFUILEigNOP0AInwKZ+P1I8fTyhanHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcLpu6po; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723545949; x=1755081949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ym9owthrbjXls/1zHUYjwSlYFNOdKvhxf1RaVgaxXY0=;
  b=mcLpu6poCTQQAawhZyagZIaAURGb01Zr2zdSOde45A3uAZo2NRiZh1QM
   YlyeoAIKxvUToR+F3ifSefObNJZG5yWG3nm97FmdqcparOhKwBUNxlmxU
   nAw/YTjLPtbs/y8zPwmIrX4uGgrVDiKg5huoNxrdV6Aosee1jEGHogxLW
   DxJeoB3WgzPVeDj6yfcaY6ATUhYIbrpR0AOg6ijmEQmyNffy1aJweS9Uv
   CrzE5LQRFkQW7aedWTPGUdt62B3wU5OL3nhdBiGZPnK2DNHTPb8od9gI7
   Ot5lgj7M8ZTp2E772apEvQb+MyaBy4/+hm69q0n8wAHmZSkkexSdL4B0j
   Q==;
X-CSE-ConnectionGUID: OaOoKwg2QRmy9AZsjVX3ag==
X-CSE-MsgGUID: yxj9Wg7oQhKP2vHB2HKc8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39148393"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39148393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:45 -0700
X-CSE-ConnectionGUID: FdeGQ1LdS8Og/1oLeWS0Kw==
X-CSE-MsgGUID: Qk/6pKXRRLi34EwGbC/pKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62786970"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] selftests/resctrl: Always initialize ecx to avoid build warnings
Date: Tue, 13 Aug 2024 13:45:14 +0300
Message-Id: <20240813104515.19152-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To avoid warnings when __cpuid_count() is an empty stub, always
initialize ecx because it is used in the return statement.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 51a1cb6aac34..9882c5d19408 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -290,7 +290,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax, ebx, ecx = 0, edx;
 
 	switch (get_vendor()) {
 	case ARCH_AMD:
-- 
2.39.2


