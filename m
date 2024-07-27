Return-Path: <linux-kselftest+bounces-14311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4B93DFBF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 16:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66291B2187B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730917E91F;
	Sat, 27 Jul 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+O0csl3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F017E90E;
	Sat, 27 Jul 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722091111; cv=none; b=sz2UjvD0HHk9eofp1xagA608/WwapD0fT8MGVMssBXnMjyiOQxK0TWHPhx/kTIf0k70bnLRsh+wW5sZRg1uMRAwev7fp8t+SEO4KZUqI9nYRrG/eUadi9XIE0GVh3wS+eKfyYBDMmpnJnWofNLNtxwYTeLBBjPBRNAURJPFDt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722091111; c=relaxed/simple;
	bh=OORvz1p6c5sw+iASbygPZWG8lUlzKGxuAMKBsz9Ee0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpGYKIhZVjPq1jP6Dow2P6gsVPMpeDGD4Vi5V/tFeAeIRCHkla7E5eZCF2iOmDUScEKx7n9wKBLj1NsDrH8CyNarAy4AkQFijOQJIzXWza9pdHRvzpQG4VSBMH1ha3oObk34JVeOC91yzidttFqISTI41dMZwTIXzzgHM10Dnrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+O0csl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43E1C32781;
	Sat, 27 Jul 2024 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722091111;
	bh=OORvz1p6c5sw+iASbygPZWG8lUlzKGxuAMKBsz9Ee0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+O0csl3ADdcbuH6DGczsDr8AmpFty5TaD6DN9rdtptjp3r5ewhmsV+FVkQIvq7Jx
	 0882aa09i6r8wVcSTM8OJllfTIZgb0wioAyabrFbkmQIxN9ctDpYCd9ReGd3q5UNpQ
	 VejMhjLp0WcbjsIKbtotXM1awtkev5UdwxHQsCJ4ynF4mI8Rn0M/xWqQQ/PINaqFnk
	 Ugb8JUrG581z/v7WAtj0LjbeOFHeRKZb+5dsquRxnmKOZUvhWjNHd4+Q8KoEee4cXW
	 YIz1FzWmoED9C10N0LLjyxX+NeDTSGkr+MlJOjF3dVEMeqjRMba6oGIHu18DDBDs1b
	 tbtEdCIWQ0PWQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 1/2] selftests: harness: remove unneeded __constructor_order_last()
Date: Sat, 27 Jul 2024 23:37:36 +0900
Message-ID: <20240727143816.1808657-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727143816.1808657-1-masahiroy@kernel.org>
References: <20240727143816.1808657-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__constructor_order_last() is unneeded.

If __constructor_order_last() is not called on backward-order systems,
__constructor_order will remain 0 instead of being set to
_CONSTRUCTOR_ORDER_BACKWARD (= -1).

__LIST_APPEND() will still take the 'else' branch, so there is no
difference in the behavior.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - reword "reverse-order" to "backward-order" in commit description

 .../selftests/drivers/s390x/uvdevice/test_uvdevice.c   |  6 ------
 tools/testing/selftests/hid/hid_bpf.c                  |  6 ------
 tools/testing/selftests/kselftest_harness.h            | 10 +---------
 tools/testing/selftests/rtc/rtctest.c                  |  7 -------
 4 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
index ea0cdc37b44f..7ee7492138c6 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
@@ -257,12 +257,6 @@ TEST_F(attest_fixture, att_inval_addr)
 	att_inval_addr_test(&self->uvio_attest.meas_addr, _metadata, self);
 }
 
-static void __attribute__((constructor)) __constructor_order_last(void)
-{
-	if (!__constructor_order)
-		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
-}
-
 int main(int argc, char **argv)
 {
 	int fd = open(UV_PATH, O_ACCMODE);
diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index dc0408a831d0..f2bd20ca88bb 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -1331,12 +1331,6 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 	return 0;
 }
 
-static void __attribute__((constructor)) __constructor_order_last(void)
-{
-	if (!__constructor_order)
-		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
-}
-
 int main(int argc, char **argv)
 {
 	/* Use libbpf 1.0 API mode */
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 40723a6a083f..71648d2102cb 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -488,12 +488,6 @@
  * Use once to append a main() to the test file.
  */
 #define TEST_HARNESS_MAIN \
-	static void __attribute__((constructor)) \
-	__constructor_order_last(void) \
-	{ \
-		if (!__constructor_order) \
-			__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD; \
-	} \
 	int main(int argc, char **argv) { \
 		return test_harness_run(argc, argv); \
 	}
@@ -891,7 +885,6 @@ static struct __fixture_metadata *__fixture_list = &_fixture_global;
 static int __constructor_order;
 
 #define _CONSTRUCTOR_ORDER_FORWARD   1
-#define _CONSTRUCTOR_ORDER_BACKWARD -1
 
 static inline void __register_fixture(struct __fixture_metadata *f)
 {
@@ -1337,8 +1330,7 @@ static int test_harness_run(int argc, char **argv)
 
 static void __attribute__((constructor)) __constructor_order_first(void)
 {
-	if (!__constructor_order)
-		__constructor_order = _CONSTRUCTOR_ORDER_FORWARD;
+	__constructor_order = _CONSTRUCTOR_ORDER_FORWARD;
 }
 
 #endif  /* __KSELFTEST_HARNESS_H */
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 63ce02d1d5cc..9647b14b47c5 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -410,13 +410,6 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	ASSERT_EQ(new, secs);
 }
 
-static void __attribute__((constructor))
-__constructor_order_last(void)
-{
-	if (!__constructor_order)
-		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
-}
-
 int main(int argc, char **argv)
 {
 	switch (argc) {
-- 
2.43.0


