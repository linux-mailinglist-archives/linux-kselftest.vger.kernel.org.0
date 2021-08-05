Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C83E0E3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Aug 2021 08:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhHEGUL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 02:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbhHEGTQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 02:19:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6EC061765;
        Wed,  4 Aug 2021 23:19:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c16so5836022plh.7;
        Wed, 04 Aug 2021 23:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aW4Q9FWzJpfxhbSADpJi1VcSywR7yqm321YMrX0lug=;
        b=QuRtJs2kpcQWdZRijQGvPf4uBlvVEUbbcB1iy928hktO9ClNv79k5IGppg5QqxCasd
         efxKpnH52cEaauVB+FmR6CGH4y2f+j04LpDc8TjXxwAOXh49Fw44/DvZ/bxsJGa9iodF
         3DTP1wHFit/+/AnxOyVeWhCPNsfxzD6aePkaTJwIAFaA77iiXVsCvD+9L9n8I6xwbjPy
         yEuX1YjPEPlNhk06W70cA1oSfGgVKhKb6DXr+9bc3svnbbA+JvmIfW5bt8YHIYLA7IR8
         5PpT1doR4GbcwMVhSfM+IwRjk1GFfg4Ai/VfTc9AgPKm3L8kzNbLTBFpUvE6OPfHN3PZ
         tCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aW4Q9FWzJpfxhbSADpJi1VcSywR7yqm321YMrX0lug=;
        b=KaNd9z/KND9BYoSxoUaz8pvJWlVL44WkcSG1xYIS9i043MpWDMfsIGatxcjNptZnme
         kVqUMeqZNs4kEItT9YpgVAu2BWFwVp5zIAE942ATiD+Sex7nIBP1ROCxyGbCcYSXa74R
         2q/GwOpQfefebxj3CYadcMBuTBtYOgpbbKeQihqnKPLjvxbanY4vhaUP4iT1iIcFjFOI
         21tvewiDlX2Tq8pBOV4iYencL7g/S06s5AsdhHH4n3Q5OJq/3aTwG3yXGoFWalIM2HzV
         O743NVQXgh9HzUCBlhZ89vFUmjZ+atdO6wdVnD76cfDeA30FXf7eCvxBUMwxz/japzL0
         pkbg==
X-Gm-Message-State: AOAM533SSy380EVX1lrrPeGZU8CA8Cbx+2TrDtK8cN6G3cgRX6sE5Jv4
        bLpauPhMgTEoUMmXx3ZS1Wk=
X-Google-Smtp-Source: ABdhPJxwwRu1PPQqk7JjtrA71nM2KJ2kaZrf3pgHYSlOcM6cyNQ1l7rUEF8s1RblGTNliXEGO3TqQA==
X-Received: by 2002:aa7:921a:0:b029:2cf:b55b:9d52 with SMTP id 26-20020aa7921a0000b02902cfb55b9d52mr3466531pfo.35.1628144341252;
        Wed, 04 Aug 2021 23:19:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g3sm4811043pfi.197.2021.08.04.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:18:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     chris.hyser@oracle.com
Cc:     shuah@kernel.org, yong.yiran@zte.com.cn,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] kselftest: remove duplicate include in cs_prctl_test.c
Date:   Wed,  4 Aug 2021 23:19:19 -0700
Message-Id: <20210805061919.627607-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

'sys/types.h' included in 'cs_prctl_test.c' is duplicated.
Remove all but the first include of sys/types.h from cs_prctl_test.c.

'sys/wait.h' include in 'cs_prctl_test.c' is duplicated.
Remove all but the first include of sys/wait.h from cs_prctl_test.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 63fe6521c56d..7db9cf822dc7 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -25,8 +25,6 @@
 #include <sys/types.h>
 #include <sched.h>
 #include <sys/prctl.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <unistd.h>
 #include <time.h>
 #include <stdio.h>
-- 
2.25.1

