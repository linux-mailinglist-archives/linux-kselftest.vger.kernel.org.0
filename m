Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB046702C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 03:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378145AbhLCCuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 21:50:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:32904
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350481AbhLCCui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 21:50:38 -0500
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 45DFF40013
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 02:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638499634;
        bh=fDAstI6DIL9UfbvksL4gr0n/7nHn2PQecVhugGjIupQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZU2eeVXNzUJZSbPZSbWV7gv2FZvbkcJq5o/p9hk2JSueAWv0NvgkZ3McG4dnKpkEQ
         F8zwFn2Yjrhg2LAPlRnJj8dmuxEgFcqJgWbIVUfRlp1b7KJR4OSTWLkseDFXrUdOb3
         rUsTZ4/zhaIBdEzv+Qr9bUN0ICAiZXWSpEkPCa06WVBHljfnou54RBRvTPym6FinGx
         6Atd56dvaxdsh2doyIL6HDz9ozV0twyWFQH1JCWL5Ke4B5/iDTMBSBVeK2vk2KT6S3
         nzD/e3ItZkky2/QW0UKD3hzGIUmB6svbDeR6wFYP+yUAXFAFxPUKrsx25ocsh6ZdWl
         VnCFB5jl9Z6HA==
Received: by mail-oo1-f70.google.com with SMTP id m11-20020a4abc8b000000b002c5b22a18d6so1255707oop.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 18:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDAstI6DIL9UfbvksL4gr0n/7nHn2PQecVhugGjIupQ=;
        b=d4Urf0bjINSaTHdtUsWa/50BGDZtfGANxnaB58A3l/KlHf3hxJGa4AwmnxgT8Wj3pI
         GKOmbklhl5sWhYPYDvNMwacmih+wKNg+mTpWF1fZtVbnW+f3z7EW96a93QoEvStlwd0a
         gdyakBs3eOLYNZiqeomnB6hVnWub76+UPyTKZHByhweYQyu68904tGluKXjZ1wUWFVm1
         V/93/1wbqo9c6HBUVJv67uoZakKBure/F7D+LVzHSBwOcflGX/RP+d8ExJ5u73vu19sS
         UOoRXBmI+U9j4jTP5wqbWuUIZZGOeTBup9pX761tei0B+PCQb0q9Eq/BjVDzQUMl9rps
         2UIA==
X-Gm-Message-State: AOAM530cBCZvrbh5lSGPNNfguZTyD2Z4X4NnaCvBYQp0AMZrOErjfbd7
        qY0STMUyITidnODH9bgk7cITBwd2nYi9j5m5LZqPgsHQKPjeqgWAWqmF7HLwIJap5d0R3yB8gwK
        YV6F0qjOE4VZ0LtC/xcoFVqfBrceX6yXYSbLj8cg0Lc7ttQ==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr14480133otu.143.1638499633046;
        Thu, 02 Dec 2021 18:47:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhvmsZ9uP4iST+5v+2YQgJz4fxTD7lkuQNSN+Aaq46H6JYE7tj9XMThgNR4o3MjXZvoX2lvg==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr14480122otu.143.1638499632877;
        Thu, 02 Dec 2021 18:47:12 -0800 (PST)
Received: from lukenow-XPS-13-9380.attlocal.net (108-249-109-234.lightspeed.sndgca.sbcglobal.net. [108.249.109.234])
        by smtp.gmail.com with ESMTPSA id s26sm452642oiw.19.2021.12.02.18.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 18:47:12 -0800 (PST)
From:   Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/memfd: include <asm/types.h> in fuse_test.c
Date:   Thu,  2 Dec 2021 18:47:06 -0800
Message-Id: <20211203024706.10094-1-luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add <asm/types.h> include which eventually includes __u64 typedef.

The __u64 typedef is sometimes missing depending on the system headers
installed, leading to compile errors. Adding this include makes this
test more likely to compile on a wider variety of systems.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 tools/testing/selftests/memfd/fuse_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..725561ac5a38 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -32,6 +32,7 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <asm/types.h>
 
 #include "common.h"
 
-- 
2.32.0

