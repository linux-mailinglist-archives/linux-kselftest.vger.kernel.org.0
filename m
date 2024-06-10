Return-Path: <linux-kselftest+bounces-11542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69278901A4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E61D1C20F3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126B12B72;
	Mon, 10 Jun 2024 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q76RmGfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97A1CD15;
	Mon, 10 Jun 2024 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998067; cv=none; b=XpQuk42dmsM9fPIDPOXdw07fwSuNO98SR8VgFG5mjQZJn3hgBXxQ0DDoXZr0OAdI/sJ0bgZV2UYNN6STWdQyQ8f1NFtaA5S5pCn7yEyogmh4NkOiBFxy51DepIUk5hQhTZZtsiYwtGzbgiHKXcl6LUH6wz4hKSVLJmhlrAnroII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998067; c=relaxed/simple;
	bh=Vry0QvqeeNdr1PQL4qhBb23PCn3qOnl455a/3LEzC80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OI44NQtSLmB3vqw5nXYKy+zx4tkPbovladG9Tz2ZCZt/FWJwp+5VsTSohii9NNZNjNFHrf5tBjyASw+dQ9tA6U13X2bAORKafx1yeGWwUXbn5ei5cvDX/1ivfgZJ1+JJw5UG/ojss0qGG62pgehzHglFpMcPrYyqtRzY9bv0Wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q76RmGfK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717998065;
	bh=Vry0QvqeeNdr1PQL4qhBb23PCn3qOnl455a/3LEzC80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q76RmGfK4nUxZqenLYS+bbg2mdYx6ByMcvR4NvhdTniTg4zilfNXkVAuUld/3j+SC
	 dMNrC1v+nHOu56GpwE7v8GFgATKElKeKr4+GJzMLyAZfEhzpMQfDJd835z5cfHY+/8
	 8ceAYvn8CNynavxfikix3agiFWpeisSxCp/IYAwo8Hol/HZvBCM0FYzZxt2qbTr5k3
	 ZHNT5EL9iWvFaMwBkhgP/aqybMUH80kNpXCvlFzQkVZlWs1t2xP24M/LE8yW1N9uMV
	 CHIsuS+edyTtQrGDgExKJRmh8x45Wunf0qHTxwNoPpKjBEzMUI8HE6lwGyiOghbPPf
	 Z31JLNt/oblRA==
Received: from deb.www.tendawifi.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DE0783782009;
	Mon, 10 Jun 2024 05:41:02 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH v2 3/4] kselftests: vdso: vdso_test_getcpu: conform test to TAP output
Date: Mon, 10 Jun 2024 10:41:28 +0500
Message-Id: <20240610054129.1527389-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610054129.1527389-1-usama.anjum@collabora.com>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
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


