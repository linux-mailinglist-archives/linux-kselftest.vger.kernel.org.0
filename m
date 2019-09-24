Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF646BD0E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438576AbfIXRrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 13:47:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34401 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395557AbfIXRrQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 13:47:16 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so6611969ion.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sONLmqddY+Y0W77yDXFSLQK6pHND+fJKUek6mxyHYu8=;
        b=OIblsRJ5uIelXVRQU5YmPxM7aQ3XvPIVU47v7i5VzUuiJWVQc+ZCGV0TCtwsq7vAhi
         7AMeQqeA2gwlL/3weIidhv7ZGQX6/23dFe7T4uMbvpTtf82zBBTn38y8S+Y+5TOs7GX1
         Vg5cAscqbc2YNKmTfs4E5gAGVLi/epm7vwmAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sONLmqddY+Y0W77yDXFSLQK6pHND+fJKUek6mxyHYu8=;
        b=QMuKTtToCqu2hXKwQDLH+aMkYS1tLNSUkRBxdCSG8MpQnWv6VSgGNSokS4ShlGlcbk
         8Y9Q17yiS5ehPNYZVpVVYkOBImSNgC5eEMgZ2zn6HPhLZYB5TkkPTqrmC8+WR2KNbMKC
         uSbTcBrpcFrnxJTK1N8btPImyfdAdf8liWWYvJQLyD7HygK3T9C+XKRPkYwZaZKKHfpz
         El/MQScyqxWDl8amE6WMDjW2Xg2NAZeYQp7eRDVLP2EkunjPi60TMKa3gid/Fd5h8rI9
         FJZUjTjO4CxxO9qlb0AryROH1TMbQLqV03pxZkC81EvXpR28us/DY4JBIMbXBkxjHB1Q
         bX3Q==
X-Gm-Message-State: APjAAAXEGujDz9D1Mbs4odJA6bhxjXF5X0ASAJAOsoib3NQhc+rJY5bt
        E3W+xmUN4TYqE/efmPPWjik5Ug==
X-Google-Smtp-Source: APXvYqylUpTbfQAiSexVdEmVaZha7iPWjbQujTYTfuWbX1w4iDVVNEBgOFmVwbAIZzylyr4NItVtAw==
X-Received: by 2002:a05:6638:738:: with SMTP id j24mr5280350jad.74.1569347233737;
        Tue, 24 Sep 2019 10:47:13 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l3sm2345828ioj.7.2019.09.24.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 10:47:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
        sabyasachi.linux@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: execveat: Fix _GNU_SOURCE redefined build warn
Date:   Tue, 24 Sep 2019 11:47:10 -0600
Message-Id: <20190924174711.22068-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following _GNU_SOURCE redefined build warn:

execveat.c:8: warning: "_GNU_SOURCE" redefined

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/exec/execveat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index cbb6efbdb786..045a3794792a 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -5,7 +5,9 @@
  * Selftests for execveat(2).
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE  /* to get O_PATH, AT_EMPTY_PATH */
+#endif
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
-- 
2.20.1

