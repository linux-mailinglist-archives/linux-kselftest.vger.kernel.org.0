Return-Path: <linux-kselftest+bounces-39805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6DB32E09
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2207D16B274
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D624679C;
	Sun, 24 Aug 2025 07:51:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78D25392B;
	Sun, 24 Aug 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756021863; cv=none; b=lIO6uNQJsjU8rkJwLp7Vl/5Ynlao+BvPlLo5Hb1YdBs0PnC493PBf8V0Fq2IYl+GOfn24tYXtWJh4SZXEhxrloXw099B/jTJxkFBrcw38xQcDa//fi/Nx5Ye+vM3+3BAPRwHc2ZgkEQ2KyzzSwmotPZXMTVM10DPrPpM4XxcwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756021863; c=relaxed/simple;
	bh=eBL/jRq6hmTb5src1xQr+TiNvhAl+OPf9pY9x9uIFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyAWGmRZ8j+Sz6657pFgs8LtDoqBd1S0L70/kWC5jCa5Hj0Npv7ZZfOHGNl+ATVB7koUI0QKF44xkq/6+rdoRLN+e3xjxwuVVHwOl9x5A3ngzxPd+m7nZN7wr3FaFb6ijJJFeJfaa5x63Wua0OJgoK//PAl7/NpUoCWtjc+d3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH 1/1] docs: kselftest: remove link to obsolete wiki
Date: Sun, 24 Aug 2025 07:48:47 +0000
Message-ID: <20250824075007.13901-5-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250824075007.13901-2-bacs@librecast.net>
References: <20250824075007.13901-2-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the reference to the obsolete kselftest wiki.

The kselftest wiki is marked obsolete and is no longer updated. The last
edit was in 2019, and the information is outdated, referring readers for
support to IRC networks that have not been used for years, and to kernel
versions that are no longer supported.

If there is any relevant information left in the wiki it needs to be
cleaned up and moved into the canonical kselftest documentation here.

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 Documentation/dev-tools/kselftest.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 18c2da67fae4..e13aff7a80b5 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -15,11 +15,6 @@ able to run that test on an older kernel. Hence, it is important to keep
 code that can still test an older kernel and make sure it skips the test
 gracefully on newer releases.
 
-You can find additional information on Kselftest framework, how to
-write new tests using the framework on Kselftest wiki:
-
-https://kselftest.wiki.kernel.org/
-
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
 to run the full range of hot-plug tests. In default mode, hot-plug tests run
-- 
2.49.1


