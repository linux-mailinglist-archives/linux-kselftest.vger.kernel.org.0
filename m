Return-Path: <linux-kselftest+bounces-8278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953E8A8F26
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CE32829D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360685620;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WABhcSK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807A84E00;
	Wed, 17 Apr 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395517; cv=none; b=elgeOlji8KoZdY9nYC4DtTaDTVQy5uS+Kv9dwMD0EDE7S/ItyfqNt4qnElWogMFRkNnQldZzM1m5RdDMyimq4YSBVYtQToDxiRiGZBeCUhTB08jmc5dp4xuiaRXY9KT2QWM8XCd97WmEr/ubnFgXwOl0NsvSP1+DHNigkHYvtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395517; c=relaxed/simple;
	bh=a0FWCf/G0SKI1ff7SEpyzUbSU6RQSFSCIjUKT97X3eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHUqFLWN34ZoIEGnP1EFx2n6nfdBJf1AganGMeHEg2Ba3POklO++NGCNc+Obk83NmY9FdJl2UX8HA6GSVErZIpk8nZpJBWnrabSOuSAshs2hpYgp8Du2Ko6zsPEq8oi6pKCbOhe4MYAqLYKLDeYSox/akZFwutzpDNkGZ39PGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WABhcSK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775D0C116B1;
	Wed, 17 Apr 2024 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395516;
	bh=a0FWCf/G0SKI1ff7SEpyzUbSU6RQSFSCIjUKT97X3eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WABhcSK++zhjv/nkb2/c89gFmhaKDOLFJm0T+O9urpoRdMELR8dTyLkGdCnb9UoiA
	 SK3OovIJ/Fk6WImfV0L9Q8/7VDq4nbs2Qu1CcvnBmKPLpYju77D503flxOTylv/GJE
	 yhsvj24iZWBed80bCitn7dwmPHZL7taDCoy5TpoCOjt0aOtsgLxSY/2Hqi6mMKGkh8
	 iBS5+hWVXfwSzotj1c30ObWvjQ+5or67z09VKK/s3AWNdlZ00b/nqc4Pgxwm+5J/iO
	 aZhKRTnwVAlJbLMTzblbfFUNTgjSd8UFLFfLuaaPx/TnORnHvWHkDugTvdIAQJcrcT
	 9GgYoDimY7Swg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/8] selftests: net: fix counting totals when some checks fail
Date: Wed, 17 Apr 2024 16:11:39 -0700
Message-ID: <20240417231146.2435572-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417231146.2435572-1-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Totals currently only pay attention to exceptions, if check fails
(say ksft_eq()) the test case will be counted as pass:

  # At /ksft/drivers/net/./ping.py line 18:
  # Check failed 1 != 2
  not ok 1 ping.test_v4
  ok 2 ping.test_v6
  ok 3 ping.test_tcp
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
            ^^^^^^^^^^^^^

Pay attention to the result.

Fixes: b86761ff6374 ("selftests: net: add scaffolding for Netlink tests in Python")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 3769b9197213..640dfbf47702 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -106,7 +106,10 @@ KSFT_RESULT = None
             continue
 
         ktap_result(KSFT_RESULT, cnt, case)
-        totals['pass'] += 1
+        if KSFT_RESULT:
+            totals['pass'] += 1
+        else:
+            totals['fail'] += 1
 
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
-- 
2.44.0


