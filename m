Return-Path: <linux-kselftest+bounces-11741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1095904CD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ECB1F259AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD716C69E;
	Wed, 12 Jun 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MkGtJ0sD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816845948;
	Wed, 12 Jun 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177214; cv=none; b=ufp5crxxu9tnopAu5qHEZY+NRh4vtgrtLYTBKkpDZVEofjaYnPDr0YPui0wurj01L0LkEur5pkEQcDqd3zySlcerPRxLRgYlIF1xCxZqFc7f1pCUSPHpGEAjDWu8jwko0FJktlNYneyOus40VhlurKUAYA1htBOO4eHebRLRKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177214; c=relaxed/simple;
	bh=ThVc3Kcb94KGiefhslXFeJ1mJHzv8+sc5d1DSQ7YMek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R72Wa8aTZByya2Q4z80a8gYSjodhWz0+7xy80qk3lFAV6FNFkRcbVQQTdAa+jRiiFM32Dq7QldHJu0IBX3QaO+m8oAt6lShLaXoovBx58sIGaeE3e9NNPVGR/wxq1iXFGvPI/ukmn61rqEsKVt7ZdqXkkWmPl3Mf2dwnmMtr/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MkGtJ0sD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718177211;
	bh=ThVc3Kcb94KGiefhslXFeJ1mJHzv8+sc5d1DSQ7YMek=;
	h=From:To:Cc:Subject:Date:From;
	b=MkGtJ0sDzDTkbpC9gw+IAYvsTc3PFbOoSZSoYQOIY/pp9oLv2Z9LCSzyTi4Ds4FpG
	 Xd9KKPWWMdPfAuSR36phaQ3DX994pxmC+flK9fiNoDrZkoYQKsBMy/2mX4bxiaTmCg
	 D3TKlq/T3DKAO0W8PrqyahkDxMyDTwg4zdGX+eRAgOzwkvkh7d0abDphN07CpiJes1
	 SS4Xadlf6DxXjOUw6ZKCTN8fh4MeL77EWYcaLWx1u1H67dyYjfm67YctjWxAxDHzSX
	 s/dpKLe14Yt7uDV29e0fd1FobPnHIGBeAHBq2bOieX0jhgo4+rprR9YtnQp/SWDed3
	 YGvfsAe0i/NhQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 273113781188;
	Wed, 12 Jun 2024 07:26:48 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: Add information about TAP conformance in tests
Date: Wed, 12 Jun 2024 12:27:23 +0500
Message-Id: <20240612072723.4146613-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although "TAP" word is being used already in documentation, but it hasn't
been defined in informative way for developers that how to write TAP
conformant tests and what are the benefits. Write a short brief about it.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Update documentation by modifying and removing sentences
---
 Documentation/dev-tools/kselftest.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index dcf634e411bd9..f3766e326d1e3 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -228,6 +228,13 @@ In general, the rules for selftests are
  * Don't cause the top-level "make run_tests" to fail if your feature is
    unconfigured.
 
+ * The output of tests must conform to the TAP standard to ensure high
+   testing quality and to capture failures/errors with specific details.
+   The kselftest.h and kselftest_harness.h headers provide wrappers for
+   outputting test results. These wrappers should be used for pass,
+   fail, exit, and skip messages. CI systems can easily parse TAP output
+   messages to detect test results.
+
 Contributing new tests (details)
 ================================
 
-- 
2.39.2


