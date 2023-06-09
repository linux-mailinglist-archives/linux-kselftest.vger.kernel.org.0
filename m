Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FF3728E43
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 05:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbjFIDE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 23:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbjFIDEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 23:04:22 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B4230E8;
        Thu,  8 Jun 2023 20:04:20 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so1022860b3a.2;
        Thu, 08 Jun 2023 20:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686279860; x=1688871860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcKARLPblfhsOqgdK39JcUbv8MjDLZ8IvMWHzSBNScQ=;
        b=NmRQRMaxM0+7angDvMYYf6yLkZ4m6S9gu+3FQujEUmAoGSOylV6PKKh4c6Rr5Ez0Ny
         1ExgMMZLKcL9CadORIpPXlumnAbIvuv5ONAGDtHzrJLy2zEhypmD1W6TMXKmaZ8ji/fI
         WWNpC10Qzj9NC9zatuV/mWDG8K1OttCaZNgDtqoIoLg8Vssrvr5/8B4Hq5x4Nalcxjp+
         EXbfVTPYw/WguXryW26gKXYIwxsoDYzsx3f2Afxz+w8Scx23YXKi64wkshHXbJrrSaLv
         HuIjjNBG6vGCUYEN4fCbU8RGrGf3EBH20ytxke/lrGB0UciQ+5l1uCoY44kKutqAr5bD
         b3ug==
X-Gm-Message-State: AC+VfDwK6hQWaxghY80Aexe3BgH55bvVUtiDFrSwSRCfFfW8/tAHBfmC
        vWJC2jD+LBqr5sfogUVWmw==
X-Google-Smtp-Source: ACHHUZ65Jiks2flBKktsFvZoSfjAD0b1fcxC3t0e5+cOSXnVdrYpThYCVKd7XmYBGt0YZ8n7EvLKhQ==
X-Received: by 2002:a05:6a00:1a4e:b0:662:b5de:27f6 with SMTP id h14-20020a056a001a4e00b00662b5de27f6mr52364pfv.17.1686279860393;
        Thu, 08 Jun 2023 20:04:20 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm1713778pff.0.2023.06.08.20.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:04:20 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        rostedt@goodmis.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v2 1/3] tracing/user_events: Fix incorrect return value for writing operation when events are disabled
Date:   Fri,  9 Jun 2023 11:03:00 +0800
Message-Id: <20230609030302.1278716-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609030302.1278716-1-sunliming@kylinos.cn>
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
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
this by just return -ENOENT when events are disabled.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 1ac5ba5685ed..92204bbe79da 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return -ENOENT;
 
 	return ret;
 }
-- 
2.25.1

