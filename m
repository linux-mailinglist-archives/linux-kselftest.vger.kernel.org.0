Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D63D9461
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhG1Rf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 13:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhG1Rf5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 13:35:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BBB7600CD;
        Wed, 28 Jul 2021 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627493755;
        bh=JEvBNA2U8qvUaHDE3455hnMOX+FbyT+Xby6r05J7i6c=;
        h=From:To:Cc:Subject:Date:From;
        b=I+2BN8PZeoeOhatPq1MK3ioKfW24JRNw880pu7zCdXpStB0lRl/+4BtE9+rBukO7W
         AVL+kUe+rgoSGuivFbHZlr+Zluuhp/yjaS1f4aZzaoapzYpU7PE4hoCOUS/Sse8F2T
         0wgLI7BA+rYDv/G1kiOIvCY4COjsfM3rIonDJcMLdVLAXNx9uHf/BLu1YtyFoDus6V
         9kwBPlM8nl2T4Qhl5RnQiBpKIM+Fuwu9hEKy6DHFd10ipU+WfjuAWvxiHAEFevsOUH
         Tpjr26B6EPf1X9deC1ejvSd+uEKmZrY63bIK6BuJ3gcf9CjL57v5csqGlXexvYjPVK
         f3112dEHQ++Lw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Ignore check_gcr_el1_cswitch binary
Date:   Wed, 28 Jul 2021 18:35:39 +0100
Message-Id: <20210728173539.6231-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We added check_gcr_el1_cswitch but did not ignore the generated binary,
add it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index bc3ac63f3314..d1fe4ddf1669 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -1,4 +1,5 @@
 check_buffer_fill
+check_gcr_el1_cswitch
 check_tags_inclusion
 check_child_memory
 check_mmap_options
-- 
2.20.1

