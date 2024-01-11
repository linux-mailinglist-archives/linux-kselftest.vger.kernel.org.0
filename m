Return-Path: <linux-kselftest+bounces-2852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE882AE11
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 12:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CACC1F244E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E23156F6;
	Thu, 11 Jan 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HcZQm++z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACE156EF;
	Thu, 11 Jan 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704974275;
	bh=QBJld2GpTQR5BTBjcyDUEA5vStcxynZ+NNL+dIDUE1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcZQm++zxBAqODVkQcQzlRQWtRXmGhe2GZU51NnFX9OC1eg3kH0GlyjwugmTqUPsa
	 4/rqzyX5ysXYXj7JLExPcHTYFM92F40hQat6YSPbufJIhA3pyWMhlrVPuCiH5mZd6J
	 b1WfJUddarkgH8MG0zZZzSJrCwcbOT6Haln+FMYK1d6VsjppnrKYW9xBYFMNqmgTIi
	 dA5/zUFwfT2q5NdvdpRQmszuVLonTC3C2HiTfUAJhnvzCgCGcmcb5ZrUHRairkSsAX
	 Xe3BHVupOc1dOeXEVF2urrLIUa0D5wIAcj2ocq6Wx++dp54UdQ7Uft6Jn381x6jBRW
	 X0aHU0hiO+jWA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CF333781184;
	Thu, 11 Jan 2024 11:57:52 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] selftests/mm: config: add missing configs
Date: Thu, 11 Jan 2024 16:56:36 +0500
Message-ID: <20240111115639.3981970-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111115639.3981970-1-usama.anjum@collabora.com>
References: <20240111115639.3981970-1-usama.anjum@collabora.com>
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


