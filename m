Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E856AE0A39
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfJVRM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 13:12:59 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52164 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733193AbfJVRM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 13:12:59 -0400
Received: by mail-wm1-f51.google.com with SMTP id q70so11013477wme.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2019 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsdgsMcU3HKx96SXZpLXR9PuPe4fAaa7s6eLfWcojk4=;
        b=Y1HBxO8V5Y0iD5fKeN0sXhVG1pO538VxcgM0gQN/f/tb3jMldemzDiw2VyXoMlUOog
         W5H8zhpQqCB47YU39tMe0iF98cF3KJyWYleFX8CKPXMMWQ1GbCVcc+eausOwwkbmbM8X
         WfK5WjScKPTxKjc8Nq+J7eYWmzTM9baIG96WCQxH8U9WX9dKJJMQO8nUZrPvZurbjmwI
         75bQCcPI+/WN5Q9BfB4dVVgV2P/vBF6tzQ2gIQtpSElOn/KBKTEbjOuxBkL8EEBbOtQj
         l/9iB50Ke55wMMpqX48bKv0jBGvyauZ3IyV41yqfxLG1tYr/eSM9AqXAIpMNwjsZ67rE
         NqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsdgsMcU3HKx96SXZpLXR9PuPe4fAaa7s6eLfWcojk4=;
        b=m3Nyp+3pT2Zo8/pv7jLwpFM5Qpv5DDk65+LBTis6LcQZ1s9U8l3K7KrK+qKbBe/M/f
         1ZSENZJBjv0QtT7i6UYkg2R4vvwo3BmNdb+Jg279t4E9nk5q3eIpYy+EZK5tzKglUzT4
         z7+ah5UPh6FsxHR0xQxO+lsgK8j8sY/RrEWTOSEE1t6FvVZbCAeXHSivjdRS/35MtYyX
         yeJKfsoNITIBbHcbniH+Ul8UZmGbWufbzo5ak0FTGIsULnxWXq2n4sV/N5+zt4UO4ZuD
         Wm5mTYB/CX8Y6/wuonYtSZqAq/yPSpUe9gmLsBgqEtwU6wnP5AiVF2og9aVJ1GrBfSCY
         LKuw==
X-Gm-Message-State: APjAAAUZhGCdqwFrWWBx2moMd6PqqBuJFzPEXjl0l5AjVfbTYG8QfbA/
        CRBq6kOWM3/8lq+BPu9BKW0EeJ6P3K+itg==
X-Google-Smtp-Source: APXvYqyBjSpq14ScGELyVv252XLFhNfBPEZJpet8FWhwaC7umORhfRibmOExBWNszeZwotRWlmluyA==
X-Received: by 2002:a1c:5458:: with SMTP id p24mr3786077wmi.32.1571764376501;
        Tue, 22 Oct 2019 10:12:56 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y13sm28309810wrg.8.2019.10.22.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:12:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: settings: tests can be in subsubdirs
Date:   Tue, 22 Oct 2019 19:12:20 +0200
Message-Id: <20191022171223.27934-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
timeout per test) adds support for a new per-test-directory "settings"
file. But this only works for tests not in a sub-subdirectories, e.g.

 - tools/testing/selftests/rtc (rtc) is OK,
 - tools/testing/selftests/net/mptcp (net/mptcp) is not.

We have to increase the timeout for net/mptcp tests which are not
upstreamed yet but this fix is valid for other tests if they need to add
a "settings" file, see the full list with:

  tools/testing/selftests/*/*/**/Makefile

Note that this patch changes the text header message printed at the end
of the execution but this text is modified only for the tests that are
in sub-subdirectories, e.g.

  ok 1 selftests: net/mptcp: mptcp_connect.sh

Before we had:

  ok 1 selftests: mptcp: mptcp_connect.sh

But showing the full target name is probably better, just in case a
subsubdir has the same name as another one in another subdirectory.

Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout per test)
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 84de7bc74f2c..0d7a89901ef7 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -90,7 +90,7 @@ run_one()
 run_many()
 {
 	echo "TAP version 13"
-	DIR=$(basename "$PWD")
+	DIR="${PWD#${BASE_DIR}/}"
 	test_num=0
 	total=$(echo "$@" | wc -w)
 	echo "1..$total"
-- 
2.20.1

