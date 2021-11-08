Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0126844784B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Nov 2021 02:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhKHBc0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Nov 2021 20:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHBcZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Nov 2021 20:32:25 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C2BC061570;
        Sun,  7 Nov 2021 17:29:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 188so1377263pgb.7;
        Sun, 07 Nov 2021 17:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7vm9h0bfl38xYkcjMU2qFVdP2aC2hP2eWsF46t6vK4=;
        b=Q3k3npeuuSd1ekNv92aYFF+b5wA/w4L0WMj9yP8BZvdD+0E87+aegY24g6e2p5WRFL
         ubSkbnEUGNHkJDlk31ZyOQLuZPn6FyVlLUmVUtgfroVHm/v8aHIraYcmy0ttJj3tGGtM
         CQOvE3nKpKp3+GfWO/62HyhLbON9wwpJTU/vvsRDlWGNucgfrx5tJNImnioMM5nfa01/
         Q7EBfApdKNX/5RDvVZZl9Td93o17Uwu/Nu3oRFaj0KVc5OwoKJdRtdGsvuuacrH+uu6y
         OCzHRwZO7/U7044PpUKr5zfw3GO8Y7dS7Gu/dzg+wbHyC07PJUdbxlWxMLwIdlzU2NEP
         VDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7vm9h0bfl38xYkcjMU2qFVdP2aC2hP2eWsF46t6vK4=;
        b=oHKGQCEQGpuih4ZHlnF3+hkt3ujlR2s0VV8INqIHDFs1EtuiIPGHO5f/dk+nQvpuDO
         c3sZAOXSeen5U4WaBHS0wd4jNFLBW+C+CKJZWjsv9Cq/IXSuI+CwN1WWw/kDEwO22Ko3
         Bnl85pmMKMvjz7AbFWP0NIE9CR8Ri3VsWQq3mhaoA+aWxYBYd7gvrbzI40jcdVUNOv+J
         j1XwfxzzlXEH37RXULLzUw9PR3QH9T49UN1RECgEGDA6j2QvuGWvNrEIK2LWCGOAzmkq
         c0aw5OH8D7qg7IEo3otXdpozNNRtK3yFax7NjfL25KMNMaHiEepBqm6kdI8e6gO18KvM
         zMbA==
X-Gm-Message-State: AOAM532AulcoJE7iLhAo9A3V0RId2o7X0bjMKmrY5yx/JBKuP1R7+yVf
        cvCrYLUx/ic1vhXyxMF6BErLwWsxSRMoKA==
X-Google-Smtp-Source: ABdhPJzRIZ8/7B02z8nwhqAgWLf7RqWVKOWLCCidtufEOReXZPON/TqrCmDsbwcAOgsMZlcmqCaFEw==
X-Received: by 2002:a63:2702:: with SMTP id n2mr22999298pgn.319.1636334981281;
        Sun, 07 Nov 2021 17:29:41 -0800 (PST)
Received: from sol.lan (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id t4sm13800861pfj.166.2021.11.07.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 17:29:40 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com,
        lizhijian@cn.fujitsu.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/3] selftests: gpio: fix uninitialised variable warning
Date:   Mon,  8 Nov 2021 09:28:50 +0800
Message-Id: <20211108012851.7772-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108012851.7772-1-warthog618@gmail.com>
References: <20211108012851.7772-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When compiled with -Wall gpio-mockup-cdev.c reports an uninitialised
variable warning.  This is a false positive, as the variable is ignored
in the case it is uninitialised, but initialise the variable anyway
to remove the warning.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/gpio/gpio-mockup-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-cdev.c b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
index e83eac71621a..d1640f44f8ac 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-cdev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
@@ -117,7 +117,7 @@ int main(int argc, char *argv[])
 {
 	char *chip;
 	int opt, ret, cfd, lfd;
-	unsigned int offset, val, abiv;
+	unsigned int offset, val = 0, abiv;
 	uint32_t flags_v1;
 	uint64_t flags_v2;
 
-- 
2.33.1

