Return-Path: <linux-kselftest+bounces-7665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0358A0587
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94223287BC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D100176034;
	Thu, 11 Apr 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO4KNTz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764D74BF4;
	Thu, 11 Apr 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798922; cv=none; b=I7Runz0F0jsYzFpAfCfv/gn5/qK+HV1n4svxdnj+6rNUK9zzKavAgD4QVoO7q7cXPKxXfwuAAVAJVigUv7JtPIVmDYHnszpdw8iIA9fYZTT1sYPbuKPrLw1Uan6tx7RqYtMm3jAjfzZIlAUrr+0/kaUWHpwHrwYThb1d0BasIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798922; c=relaxed/simple;
	bh=q5ZxAEbUk4C1HZCRmIzc2uhxryfpIrMHKHvTDR9QIKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqdMzPZsxR+lOU8/hTxBnx01AJNDB5OCGgEKbsvL1fdZEOHT2zTEOsET4wIXHPmA0GzD6Gr1sYEHj+UxKqMEN+GgQZJu44hMizYwaA919tXneUlHB/qlxSA72INHbzLN7LuD4isF+sYW3Xdw4MQAVm68cmqOJPip+jZd6nBuoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO4KNTz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDADC43399;
	Thu, 11 Apr 2024 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798922;
	bh=q5ZxAEbUk4C1HZCRmIzc2uhxryfpIrMHKHvTDR9QIKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JO4KNTz2UCOau7bGpUAGulsPluWCqfpim1erlvGqfVNRFl5/y8xZ03yMAm38BFqaA
	 S1C3UOzOTShZGk8rnX8XlzAr/W5RYz8Is/1uEfAGWgDgHYRS+g9UEaXt/spRN/1Mfg
	 82Lc/Ge47LoF+Hy+1Uu18kFh0V73djZR265uRGhMakIZ0faVLpEaxAMQSTw4TUxGdb
	 Xw0N8EtP9HWjrn/StZZl5AdO8GRXbtnclOV2hsmf30Ma0qP6TEH1Bmmplj0D4uvewg
	 9sN5W275R+mZqRh9lq2bHpjShif2GIEPAeQoNsrvoMSJGFtLWa82/MIbrgBQErtd1m
	 +IozHT5RJCcgw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/6] selftests: net: print full exception on failure
Date: Wed, 10 Apr 2024 18:28:13 -0700
Message-ID: <20240411012815.174400-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411012815.174400-1-kuba@kernel.org>
References: <20240411012815.174400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of a summary line print the full exception.
This makes debugging Python tests much easier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 5838aadd95a7..6e1f4685669c 100644
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


