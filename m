Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE97727409
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjFHBQR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 21:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjFHBQQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 21:16:16 -0400
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA8269F;
        Wed,  7 Jun 2023 18:16:15 -0700 (PDT)
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-55554c33bf3so51039eaf.2;
        Wed, 07 Jun 2023 18:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686186975; x=1688778975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSpPic4HmJs/C9WMNII22r3kQ6JIvpVttYGRAz80e/M=;
        b=G2HoSEpik4AGUwYRQeiNsZKaUNfkn5gfZY6ln8/e3LBjQX2cBrEI4IHeAZFLyXP3Wx
         HbriVl+7F7yKCEPDUD6S+ioX2MJPNaPv3XBtecojbFR/bQ86t6xPMe8c7izQ5SnJAfK/
         5Ra6G2oBW7V/O9D3rKH8UlVXjaZWREx33LsGzgBD3s4mlze7U/iULSYAqrF7hpDIxiwH
         BT4vSX71Xpz/5DF/r3D7x+nMYBoiK6OkeA6KNwt66/Cy63/44wrb93nocowZ1+vtyJUc
         nJnCTkbEkFwh7IX8+s1cNGRrICkQboyH4jn5qilRH9R1WDbDs+MEn/IuKOPDXRN/GZEb
         KggA==
X-Gm-Message-State: AC+VfDw8ZCqulo+p58dHmC1etfuMg5+RocJsVtXWyOgqBbFXrnOKmJk3
        AzzKNjiDWurHV1anPBY92A==
X-Google-Smtp-Source: ACHHUZ760c+feJm6WKUkGQL2e9fQmx+JBuG5W14oQD67qrskXStPD/G2KG06FrTroLk4iF821MAOSg==
X-Received: by 2002:a54:4588:0:b0:39b:8f0c:3936 with SMTP id z8-20020a544588000000b0039b8f0c3936mr6769371oib.27.1686186974893;
        Wed, 07 Jun 2023 18:16:14 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a128b00b00250334d97dasm1906691pja.31.2023.06.07.18.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:16:14 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 1/3] tracing/user_events: Fix incorrect return value for writing operation when events are disabled
Date:   Thu,  8 Jun 2023 09:15:52 +0800
Message-Id: <20230608011554.1181097-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608011554.1181097-1-sunliming@kylinos.cn>
References: <20230608011554.1181097-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The writing operation return the count of writes whether events are
enabled or disabled. This is incorrect when events are disabled. Fix
this by just return -EFAULT when events are disabled.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 1ac5ba5685ed..970bac0503fd 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return -EFAULT;
 
 	return ret;
 }
-- 
2.25.1

