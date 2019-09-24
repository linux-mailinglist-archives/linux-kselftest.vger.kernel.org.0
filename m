Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3688BD1B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfIXSTP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 14:19:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43631 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbfIXSTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 14:19:15 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so6765686iob.10
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOiRSARkp3F6HwO3VBjfruq1JmqAa9T16KuDWC1Mj24=;
        b=f0OtgxW1mZYsRiqiMXKFJAiP/qsfAm4vioC7LMMblRGULzt1gd02KiomCjgqsvDzh4
         s4n4AjWgNmNkU6E4+fXx9yva9igDd2N3/jH57gq+cUbTJg/bSkco5nR2pij96rVH40Sk
         9RUKae7Wu4kg3VlWbAUsqWHWn3dk9PYICH0nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOiRSARkp3F6HwO3VBjfruq1JmqAa9T16KuDWC1Mj24=;
        b=HYE18hH+nQLgJaxAWi9hoxycg/VL3YGAybVBvtH1v6+AHZSAdZXLAcKdQhwvkdwG7f
         RkXoyYc5WIeN6Co1lEDi/CrxLjLFzAj57pqsAgdze5Be3x/Ox0NDMT9MVNFXmoJ70Svx
         gWMeE+8lmmyM0Md1v4flOkcU6N+GyESxHuQxcAoiz061qgVL92QcWDiDTG4PS6eKICQD
         g8B0+FFacyQQ0dgrxcRxSRaw5g1RHJ1mWtnKQ/MV4dIoP1eXBS2+E8+Di33nwrswEDct
         moPfiuHQjNUinaGZ3dFtbHLUXwUIwO8DuImGklu1aKvJuDGMpgUd26+Ibo7cGUlzh0R9
         qVLg==
X-Gm-Message-State: APjAAAXCxjRnK1R4DeDxPenWVejtPo4r24NhyV2UhhV06CW5gUnosjN/
        mt0YiShaGh+ZV+tsarh1eP0mcQ==
X-Google-Smtp-Source: APXvYqw6wXfLz8lHYVaZ7lWb3saJlApZPvWBONhm0WBRi6N/bGzAMCA1AJj2E2PiLe/DqV1RSOh47g==
X-Received: by 2002:a6b:fe09:: with SMTP id x9mr4737235ioh.144.1569349154482;
        Tue, 24 Sep 2019 11:19:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w7sm3627033iob.17.2019.09.24.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 11:19:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     adobriyan@gmail.com, shuah@kernel.org, akpm@linux-foundation.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: proc: Fix _GNU_SOURCE redefined build warns
Date:   Tue, 24 Sep 2019 12:19:10 -0600
Message-Id: <20190924181910.23588-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924181910.23588-1-skhan@linuxfoundation.org>
References: <20190924181910.23588-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following _GNU_SOURCE redefined build warns:

proc-loadavg-001.c:17: warning: "_GNU_SOURCE" redefined
proc-self-syscall.c:16: warning: "_GNU_SOURCE" redefined
proc-uptime-002.c:18: warning: "_GNU_SOURCE" redefined

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/proc/proc-loadavg-001.c  | 2 ++
 tools/testing/selftests/proc/proc-self-syscall.c | 2 ++
 tools/testing/selftests/proc/proc-uptime-002.c   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-loadavg-001.c b/tools/testing/selftests/proc/proc-loadavg-001.c
index 471e2aa28077..e29326a708e4 100644
--- a/tools/testing/selftests/proc/proc-loadavg-001.c
+++ b/tools/testing/selftests/proc/proc-loadavg-001.c
@@ -14,7 +14,9 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 /* Test that /proc/loadavg correctly reports last pid in pid namespace. */
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <errno.h>
 #include <sched.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/proc/proc-self-syscall.c b/tools/testing/selftests/proc/proc-self-syscall.c
index 9f6d000c0245..6a01448df035 100644
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -13,7 +13,9 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
index 30e2b7849089..35eec74540ae 100644
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -15,7 +15,9 @@
  */
 // Test that values in /proc/uptime increment monotonically
 // while shifting across CPUs.
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #undef NDEBUG
 #include <assert.h>
 #include <unistd.h>
-- 
2.20.1

