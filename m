Return-Path: <linux-kselftest+bounces-13995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F09391F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAAE28209D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468716E868;
	Mon, 22 Jul 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z24rXTCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18681C2FD;
	Mon, 22 Jul 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662993; cv=none; b=HFuYlXrA7HDDY0TCY5GdyJuN12hjA2W4LOoi6Oge1xWoeggzU5oDJ44CxsHw1zaQAHMk6W0S1V4z6a1SAwtUOkS9ucA1G3/Dk6DwcXTpujTWs6hhoP2Z6HHHUX/hXJSVnGRbQOhA3rBdNSegA/gOCxzg3E+Eg0pIEGxyAgzIqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662993; c=relaxed/simple;
	bh=h5POLGJfSGRMecB42sEXFpKK5KqVX/3/GyAAIx32zhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehKbX+j9JgjfsSGiKS0do7FiymXgYWePsV9LG7RbJsHvRv1VGNnWlRGoYnicRn6gLCHePX6NpT17M1r3pD17BuYq/35cD1vElQQhWqqkPzeTY0QS+MwiKiB/1HNloyFSj1J1xZS/5n40PqEMiOXek6uKrRxvzB4Jmo4KI6Ae15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z24rXTCn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721662990;
	bh=h5POLGJfSGRMecB42sEXFpKK5KqVX/3/GyAAIx32zhg=;
	h=From:To:Cc:Subject:Date:From;
	b=Z24rXTCnL95yb0j2+DFd4hiUatl+PAK16iy0+4EawqMklI4tYiMBiPEltxyfOJBBC
	 ooQsQ9Nk+HdyXx4GNn/EMh142yVLrLO3y5vDW7WOA+CtcGxtCiJP+Z2hZmH7boFBqA
	 uQ370pHT6kjYS52q24yVr7gci0Cm5Nu1CmLF5KyKqiqfmCU1ZinCPC6/GCPNx9rcKN
	 rEgPbDrYLNarZHeS5wsw52r1RGP3sGRgOJlniCm1qe1PDzJLEbvhn1N+cGQKx/fnQX
	 B7zJutzLNQNIsv9uRXgeYa9pTwBQyRxnhM1iGV6SdlOZJ1qunE7Q9fcWBwh5KKUHSP
	 DIQfGxsJMh3rQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 48B2B37800DE;
	Mon, 22 Jul 2024 15:43:09 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: gregkh@linuxfoundation.org,
	nfraprado@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH] selftests: ksft: Track skipped tests when finishing the test suite
Date: Mon, 22 Jul 2024 17:43:19 +0200
Message-Id: <20240722154319.619944-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider skipped tests in addition to passed tests when evaluating the
overall result of the test suite in the finished() helper.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
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


