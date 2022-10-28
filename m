Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B836114E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJ1Ond (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJ1OnU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 10:43:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C411F8128;
        Fri, 28 Oct 2022 07:43:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n18so4170317qvt.11;
        Fri, 28 Oct 2022 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRwJKEcQ0Hj/RT3YqJ8AoMPqLaWpCYHYaDCqc/JUl2s=;
        b=bS/EmyhIlDXTTzU2EwcUthfcDkvObqeh3OWmsvxHBclDyuHQYMSCUVFco4PBybMGPu
         UBqzSQFg8fLPeY7kuO04h2nL95CDqqb8tM+F8ocWtrYoLZdnnizDgBkVJ6Km4CqidEF4
         h9KYEQZ40WTqf/P6SS2c5qTCx3WYkF9KTr11eJAnxAj1nispUFS1g/QQTN+1i2wQwuW0
         BKclEI2DeAz3HSMkidbgacW2+qSVgJj9VC799qMUCS5fJ38H57ESCgedL9JDpiNLxgkG
         wcs0SWEgkakMWf5LyiJAiK0vJVFecfQarQW0itSSbhuMNkms1wsAX9qmO+iD/BGOSELR
         ZRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRwJKEcQ0Hj/RT3YqJ8AoMPqLaWpCYHYaDCqc/JUl2s=;
        b=OGJcK6SgJr433bO5aOuuaTFXlEdEkYUTKXMO/IOU1DkjjGGkvctZU3arRC6vg5gq9d
         A083UlBWim/jktHZp+lvb7kbUyTaNIaM+zqoMOszMTSvlBxJpiWjjX4TcKAoeb/byk72
         Jc4YvvGTnfuGAOY0CVgajR/w61uwWa9u+sP9FDL/kNJvcdzst1h3J4ptUcquwI/1kPsR
         iGFG8+bqUMx+8lXk12bf+5Tu3mK5bVkGdTyvq+CD4yljDBMrXuF5rYmamAJMVBnLS1A1
         mAfzq6Qk0oaPzZaSGUYqwfyktNcDIf2EabWT2Gc5Do3zr8QFOtcddsfAiSGxnO1EV0bQ
         tVwA==
X-Gm-Message-State: ACrzQf1VfopyHNPtBptWKlPqC3flaxd9MeKQgWcXWLPjbYUza0Dx+Q44
        BHzI3lRosXoFqJmJmoE6bjQyUPIYMzE=
X-Google-Smtp-Source: AMsMyM5vsQoDOU9mLhdm2+tItfsnCa84lmoF1FIHME5DhVQuuK9fQkxCaku0c2/l2k+sMd8/tL1Q1Q==
X-Received: by 2002:a17:902:b402:b0:179:e5b0:96d3 with SMTP id x2-20020a170902b40200b00179e5b096d3mr54453723plr.142.1666968178448;
        Fri, 28 Oct 2022 07:42:58 -0700 (PDT)
Received: from ubuntu.localdomain ([1.221.137.166])
        by smtp.gmail.com with ESMTPSA id z13-20020a170902d54d00b00186ad73e2d5sm3137922plf.208.2022.10.28.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:42:57 -0700 (PDT)
From:   "YoungJun.park" <her0gyugyu@gmail.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        "YoungJun.park" <her0gyugyu@gmail.com>
Subject: [PATCH] kunit: alloc_string_stream_fragment error handling bug fix
Date:   Fri, 28 Oct 2022 07:42:41 -0700
Message-Id: <20221028144241.634012-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When it fails to allocate fragment, it does not free and return error.
And check the pointer inappropriately.

Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
---
 lib/kunit/string-stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 72659a9773e3..0228fe814e96 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -23,8 +23,10 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
 		return ERR_PTR(-ENOMEM);
 
 	frag->fragment = kunit_kmalloc(test, len, gfp);
-	if (!frag->fragment)
+	if (!frag->fragment) {
+		kunit_kfree(test, frag);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	return frag;
 }
@@ -56,7 +58,7 @@ int string_stream_vadd(struct string_stream *stream,
 	frag_container = alloc_string_stream_fragment(stream->test,
 						      len,
 						      stream->gfp);
-	if (!frag_container)
+	if (IS_ERR(frag_container))
 		return -ENOMEM;
 
 	len = vsnprintf(frag_container->fragment, len, fmt, args);
-- 
2.25.1

