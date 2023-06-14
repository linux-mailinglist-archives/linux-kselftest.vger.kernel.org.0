Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE6A72F694
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjFNHml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 03:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjFNHml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 03:42:41 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A81BC5
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 00:42:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgy7Z69zgzBQJYw
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 15:42:34 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686728554; x=1689320555; bh=snMogAIL9y2byMbsZXqj+hiozP/
        +XS6VEZBwL8D7BD8=; b=QCwMuqdVsxZLhCViwgbZUgy8hRFEaVoU5f6prngM7lj
        xh2B+HTGC5E3icZpe9pcHYrn82WrJ1tZCRJGtZSoCn11TzJ/ipPmkRhM7SiTpdVM
        Qv+Zu7eV8KP/vOOwyulFckqmtzXtLw7j5exUW/EKRv3CxWfBpVLWEMmd9v0Lr72E
        t5KiUlLOcM9QjZ86AO1w/3jf1pN79SKgVmkMEJU/VFf5nNA1Iwhot9YOZLLNJNVj
        01KjzIjRF3jYDx8i99yzBXy/rEYG/bB05ZA5PS0KQ+LWeDRl+jIQwU+Sy7mu9uV4
        1rZP7f1F/+zWHkWUqdD5cCGhscrvrtoOM4M3njOn4Lg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5I_SSF-f8Rkz for <linux-kselftest@vger.kernel.org>;
        Wed, 14 Jun 2023 15:42:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgy7Z3WNczBQJYk;
        Wed, 14 Jun 2023 15:42:34 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:42:34 +0800
From:   wuyonggang001@208suo.com
To:     andrii@kernel.org, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix the address is NULL
In-Reply-To: <20230614073443.4894-1-zhanglibing@cdjrlc.com>
References: <20230614073443.4894-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7f34bd3ce377d9d89626c2df8fa584e0@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck error:

tools/testing/selftests/bpf/progs/test_ksyms_weak.c:53:6-20: ERROR: test 
of a variable/field address

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c 
b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
index d00268c91e19..768a4d6ee6f5 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
@@ -50,7 +50,7 @@ int pass_handler(const void *ctx)
      /* tests non-existent symbols. */
      out__non_existent_typed = (__u64)&bpf_link_fops2;

-    if (&bpf_link_fops2) /* can't happen */
+    if (&bpf_link_fops2 != NULL) /* can't happen */
          out__non_existent_typed = 
(__u64)bpf_per_cpu_ptr(&bpf_link_fops2, 0);

      if (!bpf_ksym_exists(bpf_task_acquire))
