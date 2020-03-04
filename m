Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446D5179B92
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgCDWO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 17:14:26 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:38449 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbgCDWOZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:25 -0500
Received: by mail-il1-f171.google.com with SMTP id f5so3250222ilq.5
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNOtEzNwp4ie5FRfbU1U4EX7nRGPjUgtolRpVq/MBE4=;
        b=OjekLCqZXQTwkl6Q5+uW5RbrmRq1XHvjg72IzgF+tE8FYdmbprWuZXrMRaz2opWp96
         eogbo2K2F7+AuIYJXXRlnEbypRyif+rw8vKoVtGZtYDP7P/6XPjLzZGOvctKs/o8fNmS
         sPQwOLyx918g6f4J/GeVMND2UO72j7YBTftAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNOtEzNwp4ie5FRfbU1U4EX7nRGPjUgtolRpVq/MBE4=;
        b=q9tI9FCf7SyFV+cITaaiDNRzFGIhDq4fWHRJDIJDP9iq6UzvbTt9UTD0ax6RUsqhf5
         5qC5dvnW2d2TeHdc3MHq1CBTtMTsxszsEUD6PG2J82P13Gyne3A/fAMp/FNR343fOHHR
         Zz6V5pQehlqecNZl7Hy2ewl2Npy07Rj4DnyeOjngXsbYDyJjToLuGgoVkhE8/ch06NDJ
         Bku+hbFGp+f0EWLOzej9hAJ+gYIBwKvboqgIkDXC/KMabh6RhtEVeK/DDQSnhWXcCv0j
         +rVBh+0gIFJ+9DbgdiUaQci3YcmvB0da2ROWYOCAlfEC79hfqegi3p6Tow2UikmgITey
         yJ2w==
X-Gm-Message-State: ANhLgQ0iuplbEEJJfcIVw5kmEW8uYGYwQh2BfFVwXY7N3KhT7pSNqDWA
        tAM4EpVk/Z9pX9pQUINfAKrMuw==
X-Google-Smtp-Source: ADFU+vsMyK+BNv06am40GT7NHnRVpySeoKNzTfsH6ZdL+TH4iiTcuGpNh3lpNJhPS8RjcOqAd+KcwQ==
X-Received: by 2002:a92:5b11:: with SMTP id p17mr4890257ilb.202.1583360064649;
        Wed, 04 Mar 2020 14:14:24 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:24 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests: android: Fix custom install from skipping test progs
Date:   Wed,  4 Mar 2020 15:13:35 -0700
Message-Id: <738dd72fe6c4c277a39f1cab10b342c477e0464f.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update custom install rule to install all generated test programs. This
fixes android/ion tests to be installed correctly.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/android/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 7c462714b418..9258306cafe9 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -21,7 +21,7 @@ all:
 
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
-	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
+install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)  $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 	@for SUBDIR in $(SUBDIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$SUBDIR;	\
-- 
2.20.1

