Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309372F7B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbjFNIWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjFNIWf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 04:22:35 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F7199C
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 01:22:34 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgz1f05VJzBQJYt
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 16:22:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686730949; x=1689322950; bh=ybW66CHsYCMw2UbPEZse4W5NxYw
        6eFf/tb2POZswvC0=; b=Rt03H1y5STJ2RdRjE1wXL+L2EFaZlHJMoi49G7tI08A
        rPBDUue8HG3z4Pzq8Bfl8S0g0kbOLYBBIfylk13XpGkOqKA4K3d/ElJ/FMvwGov6
        64HtvIv8DmxIkbAmtrj9BtrusVT8E6uaA/Nb0nBI3d+BeemmXzManLblaX1ftaNH
        NWq18RjP749y0HRXn/A/rcmFaa/wqzRZz0pqLu9wecMLj7IUU+VzGOfDEKAmepXm
        RKqaRqG6iyWd+BReHItn38Jrs31Oq0Ip+QhnsOSVWNf7/ddIEoioEbGfU2ZV9JMh
        rgmUMg9GfMX0f+Igk/wfSy8+r1wl68ZBD7gbJfC61NQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zUZCzRsXvxuo for <linux-kselftest@vger.kernel.org>;
        Wed, 14 Jun 2023 16:22:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgz1d3s4DzBJJCt;
        Wed, 14 Jun 2023 16:22:29 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:22:29 +0800
From:   baomingtong001@208suo.com
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: timers: Remove unneeded semicolon
In-Reply-To: <20230614082010.28632-1-luojianhong@cdjrlc.com>
References: <20230614082010.28632-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <1d085048fbb2fcbf2a50328d9b407d99@208suo.com>
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

tools/testing/selftests/timers/nanosleep.c:75:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/testing/selftests/timers/nanosleep.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c 
b/tools/testing/selftests/timers/nanosleep.c
index df1d03516e7b..34e61507fa1f 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
          return "CLOCK_BOOTTIME_ALARM";
      case CLOCK_TAI:
          return "CLOCK_TAI";
-    };
+    }
      return "UNKNOWN_CLOCKID";
  }
