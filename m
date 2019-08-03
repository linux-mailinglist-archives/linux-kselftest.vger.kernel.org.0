Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87580351
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2019 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392586AbfHCABd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 20:01:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39555 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390433AbfHCABc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 20:01:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so36811493pgi.6;
        Fri, 02 Aug 2019 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQSuZnTRPWf3T6mX0Bl3o8p4nBqzmIPdjBmsGPDs5Ss=;
        b=F4YnsZ29X2gWKSDDvhAtTfNbM1UYZzHWDlWpXTtEwjuN0Rq4Joazw6bbgOqFA1NdrP
         6p369qRjvxmoRRqIQZpr+o1dLExbD3pu9yBp8esIHTulKYcRIXshStIa+InVDAnLTWkD
         HS5m/y3BRNKfe9k/UxeTjmiaTH3wADlqnxxsoV4N7kxOFZubkFBT2Cf2gRC9BOOd3MB9
         HbpgOSLuRbybor9tJztVxSg2sN7nw4yBHFq5VuEUzI29f4CyYH5+DqY+A9XOQ0YmmOGP
         7Fd/V7i/SjFt2njtF73P+NRWKgzNOFjTt3FLu8bDMQai2wdLFIJgyTWmd6XkFMHe0K51
         6vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQSuZnTRPWf3T6mX0Bl3o8p4nBqzmIPdjBmsGPDs5Ss=;
        b=O2/FhqJMp+1mcaSG40upWevJYUDfOjzZ9qm7tESbzJEzg7sypShW8ZyoPPtMfMt4GG
         bn1m0+3DFlO4v8ar2NZ0LPRMS/1L202OvhEbRwdoLg5/xAwqSrdM4yd+CXvnQLfgBcn4
         6JEbLeABfuSbORACMI1VWH8iBFFaojeagFR+K8eiZ87/WxBrSTpm9prSWCxMg2NG+bnw
         xHqTAGmN3+GtxxyL8lU479Pzla8TfhMKr3QNMz5RYVx+RhdR0KYY6E+gICEfadQnXYEn
         tkW28cfoBAodG++Qz8xSAT/Bgg5orxcmsBfuQnU+dNgcFWpzTuc7leAGVs9FNWod+LxK
         SqTg==
X-Gm-Message-State: APjAAAWLWK9vojh5+ax5Kc7mUwotNNG6PCUlaJj1hmoDEe4ik2/KRWTD
        YIdItz5GFw4GfkgvAOS8ZaQ=
X-Google-Smtp-Source: APXvYqwVJqlRISlzSjmzSAYihmfc6AS7Yul0pLQ7909Ek4fR8PXArcr/fCwDSZCj5M4psvMFGXwE0g==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr6720670pje.77.1564790491865;
        Fri, 02 Aug 2019 17:01:31 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id v13sm89529582pfe.105.2019.08.02.17.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 17:01:31 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 7FB00201237; Sat,  3 Aug 2019 09:01:28 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] selftest/ftrace: Fix typo in trigger-snapshot.tc
Date:   Sat,  3 Aug 2019 09:01:26 +0900
Message-Id: <20190803000126.23200-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch fixes a spelling typo in tigger-snapshot.tc

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 .../testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
index 7717c0a09686..ac738500d17f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
@@ -28,7 +28,7 @@ if [ -z "$FEATURE" ]; then
     exit_unsupported
 fi
 
-echo "Test snapshot tigger"
+echo "Test snapshot trigger"
 echo 0 > snapshot
 echo 1 > events/sched/sched_process_fork/enable
 ( echo "forked")
-- 
2.23.0.rc0

