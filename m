Return-Path: <linux-kselftest+bounces-22999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E09E8F33
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A427D281426
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209A2163A4;
	Mon,  9 Dec 2024 09:50:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56E2165E9;
	Mon,  9 Dec 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737843; cv=none; b=RSZYClSjNOSUvS4CJqtIk6nfTzrnyy8LY7B2AHqo5ATZQV0acE1/2H5GiHEmoT3XGiuYAZmbY5jp1WXpQro4hC886bdLGQNWma4kNiDw7Gasm+UBpFyA3SxsBg42HZbPQ2vZSHh2BpEcgZWV8h7eXiJY5a2a5trty69vAhfP4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737843; c=relaxed/simple;
	bh=cOAs/UrW9LVQ7szAiX1QKx0fcLLCusGWa1B+jBenR/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2NBXtOOtqT5htIY1GFiwuPIeqleKCM2x96LoOnks1AGGbT4zAA07Y4Fd7eD5C9nFpsqsFqjOP7fObOEign6lGGewcxYstseq2Ug7gaTrMciXZOYiEqm3o3jMIPa+wgw1ecTOwELZyZerwK+cjpzH6rltRivgMLvmM83R9t5+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5D0143D;
	Mon,  9 Dec 2024 01:51:09 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4ABF3F720;
	Mon,  9 Dec 2024 01:50:39 -0800 (PST)
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
Subject: [PATCH 01/14] selftests/mm: Fix condition in uffd_move_test_common()
Date: Mon,  9 Dec 2024 09:50:06 +0000
Message-ID: <20241209095019.1732120-2-kevin.brodsky@arm.com>
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

area_src and area_dst are saved at the beginning of the function if
chunk_size > page_size. The intention is quite clearly to restore
them at the end based on the same condition, but step_size is
considered instead of chunk_size. Considering that step_size is a
number of pages, the condition is likely to be false.

Use the same condition as when saving so that the globals are
restored as intended.

Fixes: a2bf6a9ca805 ("selftests/mm: add UFFDIO_MOVE ioctl test")
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index a2e71b1636e7..74c884713bf7 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1190,7 +1190,7 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 				    nr, count, count_verify[src_offs + nr + i]);
 		}
 	}
-	if (step_size > page_size) {
+	if (chunk_size > page_size) {
 		area_src = orig_area_src;
 		area_dst = orig_area_dst;
 	}
-- 
2.47.0


