Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422274CACD1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbiCBSCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 13:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbiCBSCc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 13:02:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AF4D5F77;
        Wed,  2 Mar 2022 10:01:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id ACCB71F44057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646244106;
        bh=6DltTDrqqoo+1sbXqZ8HBcJEVvAAxkOr4W8gwR7K9Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beDeqYBeE8oXVoKd0nzuLmDezeftmBBm+dAET6ojxYUj7VAIluVlilJXHugt9N7Dh
         JXPhoYu42XKS/PnXYTL8lAwQLGJgnO5xQ+9Borr2tmVxhiSrjhwfuRaceAyTyoUyk6
         ZOMQOUhz7pRYxsQLYCq2JbehXr8j4vH25poUCiD2WU+/vyLfHjUqbonnmDSQWhhR8z
         yl+iRMFrgthk4kLyfcREGf1MlYCy80sWgatRJIJz2K6LLVM8HWFMWSK5of0pr5Q5Zi
         n6agntz3dnA2L4jQg+10LjMXzNHARXfMXRhMJjyVee0VHgdXw2f8vrpUyjPDkJv3Ca
         OiWJiFzpUCDqA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] selftests: kvm: add generated file to the .gitignore
Date:   Wed,  2 Mar 2022 23:01:20 +0500
Message-Id: <20220302180121.1717581-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302180121.1717581-1-usama.anjum@collabora.com>
References: <20220302180121.1717581-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add hyperv_svm_test to the .gitignore file.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 7903580a48ac..4d11adeac214 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -21,6 +21,7 @@
 /x86_64/hyperv_clock
 /x86_64/hyperv_cpuid
 /x86_64/hyperv_features
+/x86_64/hyperv_svm_test
 /x86_64/mmio_warning_test
 /x86_64/mmu_role_test
 /x86_64/platform_info_test
-- 
2.30.2

