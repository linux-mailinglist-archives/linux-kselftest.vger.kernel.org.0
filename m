Return-Path: <linux-kselftest+bounces-13446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5A92CCA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD281C214B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DF127E37;
	Wed, 10 Jul 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KkUVxkhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792B2B9DD;
	Wed, 10 Jul 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599355; cv=none; b=Fc5ktWOEHJIHwKkwMq2+4DgE/MLXD2Rl3b7frGPav/gWDmEYyAmROuIkn89H5YziRxscd3pdnuwBF6i1hwc3F0qCZVGSqwAwNQ3WBVLcvLvs0LWugf3kD+Yc3Cc6Ruk7dhpXdDPaJq/x+Hm3l2T1aG52F3pjh3gj0pXFK3Tj45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599355; c=relaxed/simple;
	bh=OHIUy3u3oy95ySPW7WYa2vl3iIl1PY3OMda975F/CZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n0HTnpYXBf+/A0a/Fe80luEJnTatMbT7Eepa3kKDrKoJQ/ziTTum709fMif2RuciAYbPr+8Jlw89XfkTu/HJTFoTAgIkNI6e+ajaDpOkNLyX24OArLy6VLIA9b0MGsZ31qwZyzXElSKbPL/lP/dYkytCj0torWUayPr/IhsFKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KkUVxkhS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720599352;
	bh=OHIUy3u3oy95ySPW7WYa2vl3iIl1PY3OMda975F/CZw=;
	h=From:To:Cc:Subject:Date:From;
	b=KkUVxkhSuGoYpMwG/UO/yXGn1te9B3lQ/z7JBxZ3wTM8uFIj7J+d2fHdGCi7Vyv3K
	 xEZlJFoSJwY8hqVxr9vxpXNG3RJLbwage1dnPI9gETCs0FJXPO3Ftrogo7fQKrH36u
	 1q7JDA/B+E9ISusnwHDLbvyn2kC2gUPDGWvD05Y9UPq4QskADIIwCSBzyMoWGBoT6O
	 iVd5f4pV6SrzutepllMc0UJxNlS9aht+p/oMZnK4KZKw/HbzP4KeQzj/RvnrCHvPxh
	 BqLFlFOhSNEPlmYhBUo5FP4iHOJzxOCRIsro9/eOM/TrOnkAHvxsbt8/+iI+9Mu0ah
	 aWhguUcYJvp5g==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27BB03782109;
	Wed, 10 Jul 2024 08:15:49 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: tpm2: redirect python unittest logs to stdout
Date: Wed, 10 Jul 2024 13:15:34 +0500
Message-Id: <20240710081539.1741132-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The python unittest module writes all its output to stderr, even when
the run is clean. Redirect its output logs to stdout.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/tpm2/test_async.sh | 2 +-
 tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
 tools/testing/selftests/tpm2/test_space.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
index 43bf5bd772fd4..cf5a9c826097b 100755
--- a/tools/testing/selftests/tpm2/test_async.sh
+++ b/tools/testing/selftests/tpm2/test_async.sh
@@ -7,4 +7,4 @@ ksft_skip=4
 [ -e /dev/tpm0 ] || exit $ksft_skip
 [ -e /dev/tpmrm0 ] || exit $ksft_skip
 
-python3 -m unittest -v tpm2_tests.AsyncTest
+python3 -m unittest -v tpm2_tests.AsyncTest 2>&1
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 58af963e5b55a..20fa70f970a9a 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -6,4 +6,4 @@ ksft_skip=4
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
 
-python3 -m unittest -v tpm2_tests.SmokeTest
+python3 -m unittest -v tpm2_tests.SmokeTest 2>&1
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 04c47b13fe8ac..93894cbc89a80 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -6,4 +6,4 @@ ksft_skip=4
 
 [ -e /dev/tpmrm0 ] || exit $ksft_skip
 
-python3 -m unittest -v tpm2_tests.SpaceTest
+python3 -m unittest -v tpm2_tests.SpaceTest 2>&1
-- 
2.39.2


