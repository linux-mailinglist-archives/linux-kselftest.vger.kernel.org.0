Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5142B73F685
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjF0IKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjF0IKu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 04:10:50 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFE1FE2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 01:10:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qqy831ymFzBJTDC
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 16:10:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687853443; x=
        1690445444; bh=e3UwDzjkt6zQY2elBHfHZVTB3hn7ul2PuefCVyS2dQA=; b=d
        iJUumXKGsIsWdXSntswHQtr+q7NzdDQkJhBunBjuPr219gI+mxrFu2T+ZQYSqOUv
        aiHg/uEq7Hw+tDgILNzTyCnBX1YTivXIYyNlHpx+2CLutPQeL+w26n+SaSA3W7iO
        uvpiqOWb9lCpWHoEAZq35JUEpxGZdKbqOk7NqMkJE/4NofDz0fPBan1qVj0k7E+Z
        F8vZAIjQcy+jSQrGV25YPoTN+Gxdm1I+yTpu3zF0HnrmHhTQC8aDcz6WPaIszqzP
        1MgQPP4MTH6/7Z+w1J8a5Hz+RBbiJBxhLGBI1QKu1jNKXV5wQ06QmqA64kvtB4iV
        4d+hAvWXrGzGH9QU0+bHw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O_cUYm8y15GU for <linux-kselftest@vger.kernel.org>;
        Tue, 27 Jun 2023 16:10:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qqy826PfFzBJBHT;
        Tue, 27 Jun 2023 16:10:42 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:10:42 +0800
From:   baomingtong001@208suo.com
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: timers: set-timer-lat: Remove unneeded semicolon
User-Agent: Roundcube Webmail
Message-ID: <2a1861f16769deb2f831b6daf14a1e8d@208suo.com>
X-Sender: baomingtong001@208suo.com
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

./tools/testing/selftests/timers/set-timer-lat.c:83:2-3: Unneeded 
semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/testing/selftests/timers/set-timer-lat.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/set-timer-lat.c 
b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..d60bbcad487f 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -80,7 +80,7 @@ char *clockstring(int clockid)
          return "CLOCK_BOOTTIME_ALARM";
      case CLOCK_TAI:
          return "CLOCK_TAI";
-    };
+    }
      return "UNKNOWN_CLOCKID";
  }

-- 
2.40.1
