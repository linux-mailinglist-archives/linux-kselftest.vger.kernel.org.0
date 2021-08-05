Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BD3E0E91
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Aug 2021 08:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhHEGwe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhHEGwe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 02:52:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1CC0613C1;
        Wed,  4 Aug 2021 23:52:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l19so6690011pjz.0;
        Wed, 04 Aug 2021 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlmMJcvsNL7r2fqrc4Rymp5aSqY0XLGbpUjwdzjt8TE=;
        b=s4jwRYLozfAWXk3CdFQRL+6GIY85SN+v/QOTmDuaxwPo39Q711NlDvjCbBcbulWsLj
         7NiQhtHqqRRe29Xi1RBJD3UjJ5cbPyWJipn3Pwrny3d8dRd8MgVY3Qz61l6zSAGfDXOF
         /ZLk+ROT9+dyKdzKgvCBvUCRWH0Mcq1LKoopZrMjXPrBpjxUJGfs+DBAhH7EWywMVeCQ
         Otz9QF3U3tev21aAlCWh9wGLHsivMRe/DH4+Hhm+a+r2c7JoqeECGkq+L8o7WbZZyA1u
         rfnqC/IEpAS5vpw7CnC9dXkUnoPKt+1uVlNb1Kaup8QZ+QNn7bFb5HQFLtUuklaLpDaK
         v6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlmMJcvsNL7r2fqrc4Rymp5aSqY0XLGbpUjwdzjt8TE=;
        b=B2FWc82d+afgDFvjDtyfcB+hTZ0U0oNbBn0jDoejSsUbIX6fkx7XAVEr1sVXA971/K
         rkM9OniYJeKdRp03hWFNVZgFWA14AF866miZn6V/1o8OGpQGqJLO6LVjqZ/LrAAmPAoI
         qUBXxfgdxdL0S6Hl1JLjYBQZ98yIyh66UkR9J0tcd9BOUTiaez7VmjnDuGU5/zu6UrIl
         HKvBxJT80tV8nzBqgyc+NZr7kWYuaYbLjBeV9vRrUyT1PN/nHyfMmm5OA+RkVdC3sSP4
         q1RZCYVKfCGU2iTElczivQn/rNYixdQtacQLTRyfddU5Q3EG3AG3lMaLLKRRqH9m5oVh
         EUBw==
X-Gm-Message-State: AOAM530EAukknpg+NoL9xQceW6ZZvqOq6jxJQ3J3otWzAZdUwyNQEjCV
        Tk7TOYjJtGm1Pdt3uGNnRCA=
X-Google-Smtp-Source: ABdhPJyxRn4WdhDjQJdsYQc6bC6ojEMmWOv6W9V6kigMMmMlKBLxxYaU6M0/n8LxQ0lpTosPugc5vQ==
X-Received: by 2002:aa7:8d10:0:b029:303:8d17:7b8d with SMTP id j16-20020aa78d100000b02903038d177b8dmr3690606pfe.26.1628146339294;
        Wed, 04 Aug 2021 23:52:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i18sm6623194pgb.83.2021.08.04.23.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:52:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, shuah@kernel.org,
        yong.yiran@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] powerpc/tm: remove duplicate include in tm-poison.c
Date:   Wed,  4 Aug 2021 23:52:55 -0700
Message-Id: <20210805065255.628170-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

'inttypes.h' included in 'tm-poison.c' is duplicated.
Remove all but the first include of inttypes.h from tm-poison.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
index 29e5f26af7b9..27c083a03d1f 100644
--- a/tools/testing/selftests/powerpc/tm/tm-poison.c
+++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
@@ -20,7 +20,6 @@
 #include <sched.h>
 #include <sys/types.h>
 #include <signal.h>
-#include <inttypes.h>
 
 #include "tm.h"
 
-- 
2.25.1

