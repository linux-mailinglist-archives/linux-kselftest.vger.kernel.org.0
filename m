Return-Path: <linux-kselftest+bounces-7805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE58A3040
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41F11F23E5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7F127E00;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nunpo8eT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD31272C9;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931283; cv=none; b=dxL+qRHUFeQQD5Dv1Svt65Zf8/V05kTyfdXiF/xmm4cuHKhUXZPykKj4AamSD1Ju44NCv9o2Q9N8ivX9eWZpHWGn0/mWs9AnEsGr86bsyAQrhfWG/iBvjrph7Gg1DR5Fa9zO7UmnxCCkmYQXPmyTQygJ64l5uUp0fYYKNrNtsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931283; c=relaxed/simple;
	bh=0MWRd4EmeqVTRPzqiaWIWceaTlo+U4X9A0S+WknwrN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCGAVc61+POGrYtLMm9/VVnPOWxIgezJ2v3jJGUmTVVOQCdN+SWtZJiVbE2/LU2gNvZ3NgfuijJhdNF6QQv7/08/XwC1EpfrbTeOtnWPX9oxEMWF9uTWh4HQc4nh8Q0YdMz8aSO4bGNMIbMuRoHe23aN/NqotIsMEZhFUUL7l+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nunpo8eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABAFC2BD10;
	Fri, 12 Apr 2024 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931282;
	bh=0MWRd4EmeqVTRPzqiaWIWceaTlo+U4X9A0S+WknwrN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nunpo8eTnvGh5k74JHkzjc3g/coowjGKfESETpvOpdSpMXoovfr4UP+W8GFiPesym
	 T1fM+lxsEeOxJS5WCiyWOcRygUi1e8Oo7n6bHAmcdPp2EbeB7GGUYZJNLD4mOJSb26
	 IXgRHH2ioK7ttgb+Vxm65l4vs0B6jCukJ9rLjcdIZkq9T+tuanElNR9qDZgeYhrRQz
	 kuLSiruvxWM6ld1+tjDbJQ31pAsmZuW+QJot9ux7m/aVx2XQwbKrJvKZZr8bdwOs56
	 LeGbEy9kLOanqstFG3P1cOSVs9WG4TiirKCg13sTlTGPhHKX4X3mXqj2VuFr3Duz31
	 kXUvrihdr87TQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/6] selftests: net: print full exception on failure
Date: Fri, 12 Apr 2024 07:14:34 -0700
Message-ID: <20240412141436.828666-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412141436.828666-1-kuba@kernel.org>
References: <20240412141436.828666-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of a summary line print the full exception.
This makes debugging Python tests much easier.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index b4b0bfff68b0..793e4761645e 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -2,6 +2,7 @@
 
 import builtins
 import inspect
+import traceback
 from .consts import KSFT_MAIN_NAME
 
 KSFT_RESULT = None
@@ -85,7 +86,8 @@ KSFT_RESULT = None
             totals['xfail'] += 1
             continue
         except Exception as e:
-            for line in str(e).split('\n'):
+            tb = traceback.format_exc()
+            for line in tb.strip().split('\n'):
                 ksft_pr("Exception|", line)
             ktap_result(False, cnt, case)
             totals['fail'] += 1
-- 
2.44.0


