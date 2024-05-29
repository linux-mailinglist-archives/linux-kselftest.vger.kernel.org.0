Return-Path: <linux-kselftest+bounces-10824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49F8D2E22
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5771F28303
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603416727E;
	Wed, 29 May 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iH64bjMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EE169385;
	Wed, 29 May 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967570; cv=none; b=J73JnzGqjQ4yyHcH8w9dtzn8jWtwwqjmv8ppue0l6pQ51OGlVXKG1UXpus8/9NEUtxjQujy/9z75B7w5q3zHr21HrhJj06+wcfhysKX3L3LMm8aI29nP/TYdqTgwMxd6AbH8kqQkkRt5znXYhglrLCBI0wmRp2owNE3dDFt8Fcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967570; c=relaxed/simple;
	bh=Vry0QvqeeNdr1PQL4qhBb23PCn3qOnl455a/3LEzC80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btYFLlYx/kLf14snfCMWRS2AiYsgmX9YHYxQzU8z74UbZ3baLx3kVPIKDYR0JKrI/GnWmoyzTOWyRxrDcli2E9wfnaBf/1+6NhAPP1Ps6gMaxGQPASIv1FRCB9hjt4Gjgqu/HULVomigqi8F2y3s/LCC4ajzvSDBRHuIH1b+Zs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iH64bjMA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716967567;
	bh=Vry0QvqeeNdr1PQL4qhBb23PCn3qOnl455a/3LEzC80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iH64bjMAlY7fkjLOqOS3VP3MKegPc03JzkXaLLcfcajAsetlV0lBchPe7YbW0Skv8
	 F/HJXQBmQkejWV7Mmj6G3oo2LYFcz7VJSimweGqnMJr4vAm08XROrJwmO9rBJ38ZBe
	 q6iWkycEN6MiQ8023BSV8IAN1AbaBgcnKefZWn3YnW3xvPxrHyIsT63BOiMeDp3UCo
	 02lg191UlyQz0W+0CP6IL4gsF2zAoPY7kNCyKtVXL4oYihiovhqU0M2lDOVr3rM/qV
	 1zro/J1F4cfF5FDAOeSgoDUtU7+ttypLuhjxAIXiFw4jkECil2xgUlORpiluq5FNEF
	 HuofpZDGN58+w==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2EAAE3780627;
	Wed, 29 May 2024 07:25:59 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 3/4] kselftests: vdso: vdso_test_getcpu: conform test to TAP output
Date: Wed, 29 May 2024 12:24:53 +0500
Message-Id: <20240529072454.2522495-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529072454.2522495-1-usama.anjum@collabora.com>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index b758f68c6c9c2..d8e247783057a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -28,9 +28,12 @@ int main(int argc, char **argv)
 	getcpu_t get_cpu;
 	long ret;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
+		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
 		return KSFT_SKIP;
 	}
 
@@ -38,17 +41,12 @@ int main(int argc, char **argv)
 
 	get_cpu = (getcpu_t)vdso_sym(version, name[4]);
 	if (!get_cpu) {
-		printf("Could not find %s\n", name[4]);
+		ksft_print_msg("Could not find %s\n", name[4]);
 		return KSFT_SKIP;
 	}
 
 	ret = get_cpu(&cpu, &node, 0);
-	if (ret == 0) {
-		printf("Running on CPU %u node %u\n", cpu, node);
-	} else {
-		printf("%s failed\n", name[4]);
-		return KSFT_FAIL;
-	}
+	ksft_test_result(ret == 0, "Running on CPU %u node %u\n", cpu, node);
 
-	return 0;
+	ksft_finished();
 }
-- 
2.39.2


