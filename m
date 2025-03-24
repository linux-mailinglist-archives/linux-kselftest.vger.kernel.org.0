Return-Path: <linux-kselftest+bounces-29686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31247A6E147
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6967B7A7A0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729F26E147;
	Mon, 24 Mar 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZF5LSGU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CD264F93;
	Mon, 24 Mar 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837630; cv=none; b=fVxlmbWhe++jGYnZqLOZ7oFSN1EmSW7Mb+YTwk9PtjpLfgbWKTrpKITSSakiqdC1qdRo3dwOAiuDktB/7cEd0vOjsaCynUchwcXhfvOEO/oPBYzvXQok4jpx3se0y3gFDSG8nbnZPR3VYoTmX2DsyK++0ZNlyAYZ3j7qVSSGjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837630; c=relaxed/simple;
	bh=fktGd1FU7Wylsgcp/W/FoFHGov9UsZagCPsbOuIH+NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6cDsvmzXhSUIiv3Zu+it+Pt7niSixnhGU2ezvSdeTSk5r5robOqMPVa4JunOpP6Ayoh3W7D4/L/tuLzCp4E/1blZdk/UMqzWLeTBdBQ03/h948ex5saoy4ZiI5LgKuq5KbOm7bfMUFagh2Wfiuo7P0CuGaOLZV/Kj1SwpxZSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZF5LSGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E78C4CEEA;
	Mon, 24 Mar 2025 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742837629;
	bh=fktGd1FU7Wylsgcp/W/FoFHGov9UsZagCPsbOuIH+NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZF5LSGUVGVxQMF/re+JxpvzEqbFoLgIs+eTvogiXxmlgzQ/DC5o+F7WJg6ka7vJ6
	 F+3Zjb23JzKFM2H3Dn/CDMP6SUi01+IlqcoHhu5Unn0H4zRGHBxXp/0zlx076qTM/l
	 qK9xAai7bFUJKHU7P+ojY47J5PiZXWfwK2JO9iZw5TkTsP5qFNnuktzZyKit5A2t16
	 8wo5RGHDh/bd0bhvxAPFkTfxQhiqzF3Cr8IUNTn0e2iL1eQKiXL/tIw+jZUJyCkaV2
	 eG+0XIUfmmzJ4e4yf1DLhw/dmhYfIsq8I6t0FUcZ9YY2oksF7T4gK8X0SbzfTqdCb5
	 kMFDcmu8IZQ8A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Kees Cook <kees@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] kunit: add module description for backtrace suppression test
Date: Mon, 24 Mar 2025 18:32:33 +0100
Message-Id: <20250324173242.1501003-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324173242.1501003-1-arnd@kernel.org>
References: <20250324173242.1501003-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The module was added but has no description:

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/backtrace-suppression-test.o

Fixes: ebf1c420422a ("kunit: add test cases for backtrace warning suppression")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/kunit/backtrace-suppression-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
index 8b4125af2481..1ceb30c736d7 100644
--- a/lib/kunit/backtrace-suppression-test.c
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -102,3 +102,4 @@ static struct kunit_suite backtrace_suppression_test_suite = {
 kunit_test_suites(&backtrace_suppression_test_suite);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for suppressing warning tracebacks");
-- 
2.39.5


