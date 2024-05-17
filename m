Return-Path: <linux-kselftest+bounces-10341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AA8C85D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00D91F21594
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453F42059;
	Fri, 17 May 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWuJnC7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67F41A91;
	Fri, 17 May 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946434; cv=none; b=DZ0BVe1IlWjd/zukW0YqSptfXXIuSKJ9McRtYyoaE7RKGyCI11g4aE/qjRYUhFo96tZWypRKt0d34O3H5ZpR6l74M3hRRYOU3A74iWvuHlRrMojSt9SIKzbIFOJX2nSgsLnDtHrlrxc7F3VJVgsmBrxVueKkrCwVlnNmL/zVoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946434; c=relaxed/simple;
	bh=IZoCG+gnWyPzPIvcxdkZJK9rpMSStUGz9XrJiHOZlhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj4PEuB3JW1smYpzHI44fcWARa92Ws0BozyW7NP8s1ZyIvWArtrooAiRaH+oyJUixBaPfqtGkm3Avhf5xf2a/gxGp3+66iajMhkCBtCgLt53ECz+Os+GJ/d/m4kILR19u45LuKDN57kbsHicCuerPtKzCbMIluKk/b+8fV/WpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWuJnC7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89202C2BD11;
	Fri, 17 May 2024 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715946434;
	bh=IZoCG+gnWyPzPIvcxdkZJK9rpMSStUGz9XrJiHOZlhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWuJnC7jiNv++1D6rN000005VO9+94SQRgIX+HBbnYyi6VUxkNQZGBIIWA+k07T++
	 pTlw4IimeEtA7OOHaVshlGUkLDOuxBP5eoCEfX1YPZKAZQdKRa4rqbW0Bl/a+W/guw
	 7DYwCrWA2bdSZdhfNIgbAOscOlORVqPmRhLktaVvrPZyBMqtsjqT9Op3VlGLKx4rX1
	 ul3dAO4nf5nqyQwQBIAcKfr9bTXAoME8O/+CPZf9uM49zHEdfkjKsNtQuvOSEKRbfW
	 vTQw5GQiUc3fcdhsVwb+rsgF1K+Wq0rdl3YucoyX2XEmYlHgbpJVO7HNJfQULSvjVv
	 BVtAZQH6+8PVA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 1/2] selftests: harness: remove unneeded __constructor_order_last()
Date: Fri, 17 May 2024 20:45:05 +0900
Message-Id: <20240517114506.1259203-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240517114506.1259203-1-masahiroy@kernel.org>
References: <20240517114506.1259203-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__constructor_order_last() is unneeded.

If __constructor_order_last() is not called on reverse-order systems,
__constructor_order will remain 0 instead of being set to
_CONSTRUCTOR_ORDER_BACKWARD (= -1).

__LIST_APPEND() will still take the 'else' branch, so there is no
difference in the behavior.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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
index 2cf96f818f25..f47feef2aced 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -853,12 +853,6 @@ static int libbpf_print_fn(enum libbpf_print_level level,
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
index ba3ddeda24bf..60c1cf5b0f0d 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -444,12 +444,6 @@
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
@@ -846,7 +840,6 @@ static struct __fixture_metadata *__fixture_list = &_fixture_global;
 static int __constructor_order;
 
 #define _CONSTRUCTOR_ORDER_FORWARD   1
-#define _CONSTRUCTOR_ORDER_BACKWARD -1
 
 static inline void __register_fixture(struct __fixture_metadata *f)
 {
@@ -1272,8 +1265,7 @@ static int test_harness_run(int argc, char **argv)
 
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
2.40.1


