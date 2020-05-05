Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07E61C52CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEKPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 06:15:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46901 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgEEKPQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 06:15:16 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jVubI-0000r0-8o
        for linux-kselftest@vger.kernel.org; Tue, 05 May 2020 10:14:56 +0000
Received: by mail-pg1-f198.google.com with SMTP id j16so987746pgg.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 May 2020 03:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3jQdO0StdvNBvV4/pWErSvlqKP7ZpKyE2C4p/RjopqA=;
        b=kfO1L8H8c3W/a/TYgeV3dX1k5FZUcND7T0NXe8lRtK/aDuZ3W3vki2TsDbAVhtaQxq
         /2ybQbiHz7lZK7hPa5Hrsz+yIT1NBNCwiDJORiEHBy7/SQg7HgM55dXlgUEw6ZJh7swu
         Tsxv4yxDlp2inAz/E+41+UhF/Qdt8F8XW4ULf7HlShMeKiNQNdbmfVzrf0+694dyuBD+
         S7lnm3pEuy9/WIZP1VA+LUEYcN4Ftk0kuPy8jMwxW7Mfeeo2FqwYYfopSUspj27N7vxW
         b9mqMOd6L3wnX5bWxlFZKkMzxVRQKdHMgI2rcGPsCfzgMfRgxRB+hvqtyrneUmL82VFs
         ghmg==
X-Gm-Message-State: AGi0PuZg3SsoY1eNYHIA7aQ6DDk5+O+/zLO+KA+YEyDZjtCOyQ4tqDvw
        O4SKSeAdfGv9LWUTCa05RSxCIACZwZnjI7j0XERjHkcD2NKnoSYHa9k8ZX0PtQUyPpyxuOZ8x54
        mCzTNNQIH7C38HTLolkouAwZWf5IG5j+i66YYqClsLbos
X-Received: by 2002:a63:4d3:: with SMTP id 202mr2384178pge.248.1588673694645;
        Tue, 05 May 2020 03:14:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGgjuYe84gOCOst55qT44cCXLJjkRPwtBO7m2lJXOC7uPLyI8xx1unsOLavkC6BInlPCukhA==
X-Received: by 2002:a63:4d3:: with SMTP id 202mr2384156pge.248.1588673694369;
        Tue, 05 May 2020 03:14:54 -0700 (PDT)
Received: from localhost.localdomain (111-71-115-42.emome-ip.hinet.net. [111.71.115.42])
        by smtp.gmail.com with ESMTPSA id d35sm1235727pgd.29.2020.05.05.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:14:53 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, mhiramat@kernel.org, po-hsu.lin@canonical.com,
        joel@joelfernandes.org
Subject: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as unresolved if the test module does not exist
Date:   Tue,  5 May 2020 18:14:45 +0800
Message-Id: <20200505101445.27063-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The UNRESOLVED state is much more apporiate than the UNSUPPORTED state
for the absence of the test module, as it matches "test was set up
incorrectly" situation in the README file.

A possible scenario is that the function was enabled (supported by the
kernel) but the module was not installed properly, in this case we
cannot call this as UNSUPPORTED.

This change also make it consistent with other module-related tests
in ftrace.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
index cbd1743..2b82c80e 100644
--- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -17,7 +17,14 @@ unsup() { #msg
     exit_unsupported
 }
 
-modprobe $MOD || unsup "$MOD module not available"
+unres() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unresolved
+}
+
+modprobe $MOD || unres "$MOD module not available"
 rmmod $MOD
 
 grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
-- 
2.7.4
