Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A282D6B9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 00:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgLJXLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 18:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733150AbgLJXKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 18:10:55 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA224C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 15:10:14 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n142so6764703qkn.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXNvDug05+aqIQUhCBBkkdcljepd619NYC6D67mJKng=;
        b=KY8q1LTJ9v4+Mxdwf+O4dytJtldFCx/0lto4hGIoiFXYqFsj4/CY1XHGA1zAmQF79o
         1WaHTHtpewLuZd7KKxgJ31nLTyBbJPaxmOR9/tBQ2WWe/iSfjdccrfudPDJyFNChMy9R
         rYE711+SUPb2aGfyiJOvdK9YbrPFosBRQ6+CAr46RmnVdB0fhGWSv6R4dM00oSkRiStX
         NsWy3TRqrgEH1Mx7ZoQr9YdPEPbcLbfWnTRsxfEjgRKdnLGkxjop97FkakXnNSKGVla4
         EIA3XQbXd8m1NX8xmwZmVoNYiYPjgYdfT/CwxDcO4o9piUpE2KOXNFx5I9yC4Fvtw+uk
         mowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXNvDug05+aqIQUhCBBkkdcljepd619NYC6D67mJKng=;
        b=SNeFRP9se+RfBT5kiiud4NCuLcXjisi+uCpKMTF3mVFoSlyiUgFrDzRcDPPAXuQ/qg
         DAfEwi82jIpa0TQO9zp06jDWsdLFbvI5cr/jfDNy2btuNPjlSGKCQvQmnB9ifmuAzYNu
         lqxp3JkG7wQsbCmkUOh2cOqOxLOPtf9xSU5uBfSy+3RkBx0TcM1LPSHKwpYB+1mWZd8j
         KbMk7f5fTbvckqE1alwb4J6A8Q2zGyCushf4E0ErKY6oWQPWuhHhr7AAn8Img5ffvjfL
         QyXGKOYkdgnKOFNMq+mI3xbYsZxIWLqmy9ohQnr755vR08ioY00nQWnk2BulqVk6wJct
         iH/w==
X-Gm-Message-State: AOAM532Ye49OqjhtLTsHyUw1oSynEVlGRVdHfT3I0dwjLCT196YIrn06
        XiTLVrEJYm1S9sbDVB962dTbL54o7IrBvw==
X-Google-Smtp-Source: ABdhPJzkoueWD0AlxcjmFjs2RtuEeMZedVeaGvMk46SwGtDhKkyjijfQA0BNCJhJt73MRLy1+HnARQ==
X-Received: by 2002:a05:620a:805:: with SMTP id s5mr12513205qks.80.1607641813528;
        Thu, 10 Dec 2020 15:10:13 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id c68sm5033671qkb.17.2020.12.10.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:10:12 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, kuba@kernel.org, keescook@chromium.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH] selftests/harness: pass variant to teardown
Date:   Thu, 10 Dec 2020 18:10:10 -0500
Message-Id: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as variant.

In some cases, the variant will change the setup, such that expections
also change on teardown. Also pass variant to FIXTURE_TEARDOWN.

The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
right above.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

For one use of this see tentative
tools/testing/selftests/filesystems/selectpoll.c kselftest at
https://github.com/wdebruij/linux-next-mirror/commit/12b4d183ac9140c13606376bb5c6714673daf754
---
 tools/testing/selftests/kselftest_harness.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index f19804df244c..6a27e79278e8 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -283,7 +283,9 @@
 #define FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		const FIXTURE_VARIANT(fixture_name) \
+			__attribute__((unused)) *variant)
 
 /**
  * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
@@ -298,9 +300,9 @@
  *       ...
  *     };
  *
- * Defines type of constant parameters provided to FIXTURE_SETUP() and TEST_F()
- * as *variant*. Variants allow the same tests to be run with different
- * arguments.
+ * Defines type of constant parameters provided to FIXTURE_SETUP(), TEST_F() and
+ * FIXTURE_TEARDOWN as *variant*. Variants allow the same tests to be run with
+ * different arguments.
  */
 #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
 
@@ -382,7 +384,7 @@
 		if (!_metadata->passed) \
 			return; \
 		fixture_name##_##test_name(_metadata, &self, variant->data); \
-		fixture_name##_teardown(_metadata, &self); \
+		fixture_name##_teardown(_metadata, &self, variant->data); \
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
-- 
2.29.2.576.ga3fc446d84-goog

