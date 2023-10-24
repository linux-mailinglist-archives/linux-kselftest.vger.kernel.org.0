Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770CC7D56EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJXPv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJXPv4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:51:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404CDE;
        Tue, 24 Oct 2023 08:51:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [116.71.169.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04D0A660732E;
        Tue, 24 Oct 2023 16:51:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698162713;
        bh=YeYy3+CWlsTYWmE3ZY32EUBI7hsgZl3/P6viV1Tr3jo=;
        h=From:To:Cc:Subject:Date:From;
        b=lRD69P3Cm7hmctulCRoxmdcSFIIHWL4f6Yx+BmQrOIU8+qh2zV/lI0najChNE2Fs0
         x6BqwVKEpJvPqYQ55vvI/5i8DAZeGa8MNIt6fmhT8z/2Je+0RKAXsTP0KXRBGUrVpv
         iY3oiKE9pC4u3SjZr0NwOA2vRRo4GIRZ9r11xOkZD1D5RHLASoOalp6UVLDe9NlDUW
         dGsM0eDdETHP0cxx4yyOP7oVmZ4yCk863OE5Zu+q2+pVPk3DkcvYsNsASIG2+MvnAu
         N+quqP64kjvEnpw/tTn9HRp8ozlgqHkfgHaER7XB8ciQKGQNAyM9rFDYD/dFwm4e6l
         9APAUG98fGlmg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, Aishwarya TCV <aishwarya.tcv@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros
Date:   Tue, 24 Oct 2023 20:51:25 +0500
Message-ID: <20231024155137.219700-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Correct header file is needed for getting CLOSE_RANGE_* macros.
Previously it was tested with newer glibc which didn't show the need to
include the header which was a mistake.

Fixes: ec54424923cf ("selftests: core: remove duplicate defines")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Link: https://lore.kernel.org/all/7161219e-0223-d699-d6f3-81abd9abf13b@arm.com
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/core/close_range_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 534576f06df1c..c59e4adb905df 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -12,6 +12,7 @@
 #include <syscall.h>
 #include <unistd.h>
 #include <sys/resource.h>
+#include <linux/close_range.h>
 
 #include "../kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
-- 
2.42.0

