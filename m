Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F1185199
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCMWXw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 18:23:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44966 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCMWXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 18:23:51 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so1008110iot.11;
        Fri, 13 Mar 2020 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ws1qF1uTCNYsgxxjp4yd52hGyHdhppX9MnmDhs+46Rw=;
        b=VWnh2VjxfIzzrfPbPrVBlf8XlVZu9u517h8yI1XM8rjR8iT5dzQWGmzpwiHH5A6cfa
         +v+L4ts+2PM/oKphT4LpKamiQz4i2eisRXMsKz+4ddSKht9nThs3H74S0stlseDvHw96
         dRKcgHpEXCtnFoWF5Cz5U8MhP/hFwMiuX5inumMa0iep2u/PXhQd5E2xkn4TYvYRT9ti
         T/LgG2YObJ/aF/H7Mb1PZtS6KjLGBlfwbbVlrhuPh3obppjBZSKIoUnVIzlOT6oGIMKU
         doy971ZY34/AVcbJCBLmDVXfbX6BQBbW/DOlHYHf6m485EP2c9lY6+GCqAwcEIsCs6wA
         +pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ws1qF1uTCNYsgxxjp4yd52hGyHdhppX9MnmDhs+46Rw=;
        b=bMPA8wExTdDg2Lvi1OB4coyH09kXqPyjLL1H/bDh9wJhkJ5notxeHsdFhQL1r0gWMP
         WR3KAMMVhqWTDF0G62AfB+UxUAZNaNJ2EIcCwLr09wLFZrVx7k9VEAQtOuU+jQx9k1wQ
         rQJhmahuJQlmeZVQnJ0POjbLDfaHOwM1lndZ3Y3rx9CaT7qeBC6lxjvWSe7upe1Sws3o
         F9TNRZkCBMxOOP8Of37VqEzpsfcdZ+Kn8pz1EEt9ksxWYGBFpjJgmDAipz/ggq89pBgy
         YVmdsCvXfTuT73rfocCQBVPpFBe3i2YzfaUbxhUyKT99d6NoODTdpAhtKz0AU/uNuQWA
         L8cg==
X-Gm-Message-State: ANhLgQ3L8S3eYCIT0W2LSRG2FsopptBMomOIjIJ90JXjmxRZk4ng+KrA
        GC12w5IJ3Iux4/ifFed2QoY=
X-Google-Smtp-Source: ADFU+vsDS71IvRFI76JmQdgRRa08uX56kGOEvrG4DMJ2n7KDxmj3NVLmBF7xv5y+z47mYsErg3U8wA==
X-Received: by 2002:a6b:e70c:: with SMTP id b12mr14577593ioh.33.1584138229253;
        Fri, 13 Mar 2020 15:23:49 -0700 (PDT)
Received: from timdesk.hsd1.ca.comcast.net ([108.165.36.110])
        by smtp.gmail.com with ESMTPSA id s68sm11833465ilc.72.2020.03.13.15.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2020 15:23:48 -0700 (PDT)
From:   tbird20d@gmail.com
X-Google-Original-From: tim.bird@sony.com
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        tbird20d@gmail.com, tim.bird@sony.com
Subject: [PATCH] selftests: add 'show_targets' make target
Date:   Fri, 13 Mar 2020 16:23:24 -0600
Message-Id: <1584138204-12238-1-git-send-email-tim.bird@sony.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tim Bird <tim.bird@sony.com>

It is useful for CI systems to be able to query the list
of targets provided by kselftest by default, so that they
can construct their own loop over the targets if desired.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 tools/testing/selftests/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 63430e2..9955e71 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -246,4 +246,7 @@ clean:
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
+show_targets:
+	@echo $(TARGETS)
+
 .PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
-- 
2.1.4

