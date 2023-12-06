Return-Path: <linux-kselftest+bounces-1227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3C80657F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 04:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6DF1F21416
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3353A5;
	Wed,  6 Dec 2023 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Xig0qw2G"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 919 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 19:14:24 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14BB1B9;
	Tue,  5 Dec 2023 19:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4cyJT
	NE05UvgghucLXLFvRY9ulNptDOc09IkUZJomN4=; b=Xig0qw2GzP1Hr3qbz6AxU
	YHdUgtYuPTvKNcfZxHpKzraLPPlHZY/AD1V+Swhy0JYSymTUSwuK6pGwSFehm5Ph
	SZ6hedVyzO1F3LU46GfOhOGT4NPEPxSsQ/DyhLeiSlvewxn4z+xTjxAip2rV22/j
	rCdEU5+W7t83TvYoQqdIUg=
Received: from fedora.. (unknown [123.52.27.102])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wA33z3I4m9lB271DQ--.6743S2;
	Wed, 06 Dec 2023 10:56:08 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	jethro@fortanix.com,
	bp@suse.de
Cc: linux-sgx@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: [PATCH v1] selftests/sgx: Skip non X86_64 platform
Date: Tue,  5 Dec 2023 21:56:05 -0500
Message-Id: <20231206025605.3965302-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA33z3I4m9lB271DQ--.6743S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1rZry8ZrW7AF45ZF13Arb_yoW8XF1Dpa
	18Jw1qkFyrGF4UZr18urWYqay0yFs3tF4jqr4j934ayr4xJrZ2qFn7tFW8WasrK3yfZ3y3
	Zw4xGr93Ca4kX37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j56pPUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimgo+d2VLYuSLxAAAs+

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

When building whole selftests on arm64, rsync gives an erorr about sgx:

rsync: [sender] link_stat "/root/linux-next/tools/testing/selftests/sgx/test_encl.elf" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1327) [sender=3.2.5]

The root casue is sgx only used on X86_64, and shall be skipped on other
platforms.

Fix this by moving TEST_CUSTOM_PROGS and TEST_FILES inside the if check,
then the build result will be "Skipping non-existent dir: sgx".

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b57da3..01abe4969b0f 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -16,10 +16,10 @@ HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
 ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 
+ifeq ($(CAN_BUILD_X86_64), 1)
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
 TEST_FILES := $(OUTPUT)/test_encl.elf
 
-ifeq ($(CAN_BUILD_X86_64), 1)
 all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
 endif
 
-- 
2.38.1


