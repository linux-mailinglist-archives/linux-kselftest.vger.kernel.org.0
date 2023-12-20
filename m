Return-Path: <linux-kselftest+bounces-2266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD7F81A23C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA171C237C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608946525;
	Wed, 20 Dec 2023 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YTqUxHtN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897040BE6;
	Wed, 20 Dec 2023 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W5hxP9oFdtDFqqJO1sVaS6MGFtxN/uLe2GvjEDxA++M=;
	t=1703085601; x=1704295201; b=YTqUxHtN/cc5Qi1Oek2U9vitn7bk4MGRWlROCKkSRxaHlZH
	UgbrKWoTvXVJT4wZZx/vqF3LkukbnY2kTJmCQYdIneUtykwjbJT3QSSjXiuDI2ZRpLrednXz1g/Eo
	1di9FBEfP2zeSN6v7XCuTCtownKoixB/TLGmMcIdsdokZDpppD4vsAjKvQFO3/z7PVRe3X04vXjLn
	S4XNxFbY2JNGqrpkFdj4Ao4870YDmsprbIME31d5HzIBfXoa4WWlgPAnBHZLwHweac+yODhsomyby
	Aek/yjwbwlC/IQFgqVJKZoNIFInVKPAGqfzV1skBgFLPN/C5Xhj6Rtlzdo4RPfjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMY-00000001WFz-1Fmg;
	Wed, 20 Dec 2023 16:19:58 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/6] kunit: add parameter generation macro using description from array
Date: Wed, 20 Dec 2023 16:19:47 +0100
Message-ID: <20231220151952.415232-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220151952.415232-1-benjamin@sipsolutions.net>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The existing KUNIT_ARRAY_PARAM macro requires a separate function to
get the description. However, in a lot of cases the description can
just be copied directly from the array. Add a second macro that
avoids having to write a static function just for a single strscpy.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 Documentation/dev-tools/kunit/usage.rst | 12 ++++--------
 include/kunit/test.h                    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c27e1646ecd9..b959e5befcbe 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -566,13 +566,9 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		},
 	};
 
-	// Need a helper function to generate a name for each test case.
-	static void case_to_desc(const struct sha1_test_case *t, char *desc)
-	{
-		strcpy(desc, t->str);
-	}
-	// Creates `sha1_gen_params()` to iterate over `cases`.
-	KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
+	// Creates `sha1_gen_params()` to iterate over `cases` while using
+	// the struct member `str` for the case description.
+	KUNIT_ARRAY_PARAM_DESC(sha1, cases, str);
 
 	// Looks no different from a normal test.
 	static void sha1_test(struct kunit *test)
@@ -588,7 +584,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 	}
 
 	// Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
-	// function declared by KUNIT_ARRAY_PARAM.
+	// function declared by KUNIT_ARRAY_PARAM or KUNIT_ARRAY_PARAM_DESC.
 	static struct kunit_case sha1_test_cases[] = {
 		KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
 		{}
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 20ed9f9275c9..2dfa851e1f88 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1514,6 +1514,25 @@ do {									       \
 		return NULL;									\
 	}
 
+/**
+ * KUNIT_ARRAY_PARAM_DESC() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ * @desc_member: structure member from array element to use as description
+ *
+ * Define function @name_gen_params which uses @array to generate parameters.
+ */
+#define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
+	static const void *name##_gen_params(const void *prev, char *desc)			\
+	{											\
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		if (__next - (array) < ARRAY_SIZE((array))) {					\
+			strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);		\
+			return __next;								\
+		}										\
+		return NULL;									\
+	}
+
 // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
-- 
2.43.0


