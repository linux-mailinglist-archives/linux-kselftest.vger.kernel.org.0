Return-Path: <linux-kselftest+bounces-2106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E92815E5D
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003EF1F22115
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E91FB4;
	Sun, 17 Dec 2023 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="im/LOs+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9681FAD;
	Sun, 17 Dec 2023 09:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DDFCC433C7;
	Sun, 17 Dec 2023 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1702806079; bh=ttNmycxoIsxpfo5cJyI5DIRC9I7Q/DzKLZF2oY4kEPY=;
	h=From:Date:Subject:To:Cc:From;
	b=im/LOs+Ij/fO+NjLt+rx0S2r95Ijcyn/AaSA/b1uyE6K3fqAVc58s2CJHOo14+lS/
	 Nu2ljIUGbYBrAClmbPuL8PHz+4Ga6Fzd4XfiCpHk505BSOx3zf8g/uMZner1XV/1EN
	 WNgMe1LZCdjHFul20tPdn8Fkj6fWrsl+ncCccFAg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37879C3DA6E;
	Sun, 17 Dec 2023 09:41:19 +0000 (UTC)
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Date: Sun, 17 Dec 2023 18:41:08 +0900
Subject: [PATCH] selftest: kvm: kvm_page_table_test: change default guest
 memory down to 128MB
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-selftest-dev-v1-1-52c338212fe8@linux.dev>
X-B4-Tracking: v=1; b=H4sIADPCfmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0Nz3eLUnLSS1OIS3ZTUMt1kczNLUxOTZGMD4xQloJaCotS0zAqwcdG
 xtbUA5dOiBl4AAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702806078; l=1446;
 i=itaru.kitayama@linux.dev; s=20231030; h=from:subject:message-id;
 bh=ttNmycxoIsxpfo5cJyI5DIRC9I7Q/DzKLZF2oY4kEPY=;
 b=Tl6tdow/g8DRgFi3LNlauLgWhsynG/FUxZ4kNF1wGlL5MOvLo9U2azQiYxC6/tTKqycnXHX7t
 BoJADq8yESEA9RLlYg77m2B/A+FY7MbcGmLMeOQNaTkgO6M/USLasTg
X-Developer-Key: i=itaru.kitayama@linux.dev; a=ed25519;
 pk=4yYhz2CbKL7F2qR5IzP7QvqM9B6c+dfWJRHWez+rMDw=
X-Endpoint-Received:
 by B4 Relay for itaru.kitayama@linux.dev/20231030 with auth_id=92

kvm_page_table_test's current default guest memory is set to 1GB,
however on a 4GB of system memory this setting causes an OOM event.
While it is able to control the test program arguments using an
environment variable, KSELFTEST_KVM_PAGE_TABLE_TEST_ARGS, it is not
intuitively clear for a selftest users the above variable exists, change
the default guest memory down to 128MB so that small systems can run
this test without seeing an OOM.

---


Signed-off-by: Itaru Kitayama <itaru.kitayama@linux.dev>
---
 tools/testing/selftests/kvm/kvm_page_table_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index 69f26d80c821..3cef22642bcb 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -24,8 +24,8 @@
 
 #define TEST_MEM_SLOT_INDEX             1
 
-/* Default size(1GB) of the memory for testing */
-#define DEFAULT_TEST_MEM_SIZE		(1 << 30)
+/* Default size(128MB) of the memory for testing */
+#define DEFAULT_TEST_MEM_SIZE          (1 << 27)
 
 /* Default guest test virtual memory offset */
 #define DEFAULT_GUEST_TEST_MEM		0xc0000000

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231217-selftest-dev-c769544c303d

Best regards,
-- 
Itaru Kitayama <itaru.kitayama@linux.dev>


