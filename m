Return-Path: <linux-kselftest+bounces-2902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597B82BBAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2DD1F2342C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34955D912;
	Fri, 12 Jan 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Er+Z95A4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C15D905;
	Fri, 12 Jan 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705044114;
	bh=QBJld2GpTQR5BTBjcyDUEA5vStcxynZ+NNL+dIDUE1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Er+Z95A4+cQQLCKnefhakDIXVkXWbOi70sl6PINU+hcHa/DqHFRnWxcOAAdofYpW+
	 YSvC1IK6PPwZDQGmxvuKMC0uG6fo2sfaNsnJgan7GAQzJ/R7ZL4zJzrUnwrWDmnkQZ
	 GzoWEe9yo2+1CNQM8bLUquRy+ImTi8AYngJh8rMApCUtyX8oCOlUTKiRlTsub6egnH
	 YED6pRy0s7EXglqhqhdO9lNwZK2Igh1J1XWy5gpKEBYQCyLU5+oPnchv/lxOuVfrxN
	 2c23j+7OIPvEk2ihFSp8XWMCtwM8X8yL1Hbbh/B1/bHtZPpPno9Ha9PkWL2kPwW1Bj
	 Ucz99YQdLGKOg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4742B3780894;
	Fri, 12 Jan 2024 07:21:53 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] selftests/mm: config: add missing configs
Date: Fri, 12 Jan 2024 12:21:40 +0500
Message-ID: <20240112072144.620098-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240112072144.620098-1-usama.anjum@collabora.com>
References: <20240112072144.620098-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add configurations which are needed for
- hugetlb-read-hwpoison
- ksm_functional_test and ksm_test

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 4309916f629e..d16a72036eb7 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -7,3 +7,6 @@ CONFIG_TEST_HMM=m
 CONFIG_GUP_TEST=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_MEM_SOFT_DIRTY=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_HWPOISON_INJECT=y
+CONFIG_KSM=y
-- 
2.42.0


