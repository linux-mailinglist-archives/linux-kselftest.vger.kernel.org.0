Return-Path: <linux-kselftest+bounces-14463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AD940F7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 12:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF18289F7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6F1A070F;
	Tue, 30 Jul 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b2SYuI/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B91A0714;
	Tue, 30 Jul 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335376; cv=none; b=WNbkzCad+f671OBjBjRo8d2VYBiGa6hBTHhHSEOtOefxLFm49h6CPeNNDKhH9Hpu1qKrkPq2Fl0rHSiTtRGZrj36DEJz8A/46s6bFfohcyvEd5H7AHJPcNFSDP7M3I6KknFSS68Y4dSfHzcjoZoyNSX+CQN7ZZXjx8roUT1fKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335376; c=relaxed/simple;
	bh=0DaKkFeF0sPPzz/ypFknhiD/bWgWmC4UDgSB0SdNoYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=po0zXF/C2s0GCy1J8RhuiNnQx3yLdM8zqIItUXFNRkcxoKlfqln/U8+1U4VAbfQuMXdRVwXh1XhYMb8AbkIlKEAhCS0cl8ZEh8wwmiZuZIgcYBW4C+hPJ32wNLa4toy/aIi8NyWupCT2SnJUQDS/TdfekU3aUs5Y/THfAJfWgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b2SYuI/x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722335372;
	bh=0DaKkFeF0sPPzz/ypFknhiD/bWgWmC4UDgSB0SdNoYs=;
	h=From:To:Cc:Subject:Date:From;
	b=b2SYuI/xTR39uJ4oTU5U3oGEooMeNxvuc/Vin6TTulx2yGafKHOZHD/WJJ8a3iZWk
	 e4bg4Q3IQfkTnrPzGnQl5XaK+teNz8utlq5XAKRfjIjG/7yQJBtinfDksTTulC/MIh
	 xmXQNERArKK0FgHMOfdBxPMLHFJ+GQCyiygy0mfCikUv90mxgcDJJI+s/GV2xjVnsf
	 W6letLpdX/MNeNTmEM3SANARgL/WQfMIso2pTAgLQfKFuEbObC8qzbOF9LPO1Bo9sa
	 cGLFj/DCY6eyMkORQlggcCnTLtbRsc3hF6f+l3Kbwp+byUGokDGt09FS7OvDFkR0Vx
	 BVO6qy8Ro4qiw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 09D903780B50;
	Tue, 30 Jul 2024 10:29:31 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: gregkh@linuxfoundation.org,
	nfraprado@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2] selftests: ksft: Fix finished() helper exit code on skipped tests
Date: Tue, 30 Jul 2024 12:29:28 +0200
Message-Id: <20240730102928.33182-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Python finished() helper currently exits with KSFT_FAIL when there
are only passed and skipped tests. Fix the logic to exit with KSFT_PASS
instead, making it consistent with its C and bash counterparts
(ksft_finished() and ktap_finished() respectively).

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
This is a revised version of the patch initially submitted as "[PATCH]
selftests: ksft: Track skipped tests when finishing the test suite":
https://lore.kernel.org/all/20240722154319.619944-1-laura.nao@collabora.com/

Depends on "[PATCH v2 2/3] kselftest: Move ksft helper module to common
directory":
https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
(picked through the usb tree, queued for 6.11-rc1)

Changes in v2:
- Reworded the commit title and message to more accurately describe the
incorrect behavior of the finished() helper addressed by the patch.
---
 tools/testing/selftests/kselftest/ksft.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
index cd89fb2bc10e..bf215790a89d 100644
--- a/tools/testing/selftests/kselftest/ksft.py
+++ b/tools/testing/selftests/kselftest/ksft.py
@@ -70,7 +70,7 @@ def test_result(condition, description=""):
 
 
 def finished():
-    if ksft_cnt["pass"] == ksft_num_tests:
+    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
         exit_code = KSFT_PASS
     else:
         exit_code = KSFT_FAIL
-- 
2.30.2


