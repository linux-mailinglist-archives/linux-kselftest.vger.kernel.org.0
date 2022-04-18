Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F0505EDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiDRUXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 16:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiDRUXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 16:23:18 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D92E6B8
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 13:20:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s13-20020a17090a764d00b001cb896b75ffso9226802pjl.6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qRrjWLMfdu6yIcwripxOfFds2oSTzWm8NOly78GvImA=;
        b=iGKBSQMhB5Dcpvx90+XkjZsRwajkAuHhifHP93zi8BjBNhyUN6cd6lDfkfvOIzlP7l
         dZAf5VimM8LMXGHpL11bN/5/HMIk4F+WG/l90ME7Y5gxjEIq3N+Cs2g1gWYXNRpcgr14
         l4JWFolmT/LUz2cvHBkecDrGenJ/HYRecqWqJovbOF7lAX9gCsYpWvLny+3uegoP+Ye7
         Oahw6Cocr64RS2PxJte0noEKgVzaUPM9RSAynaBVWSVrKLklHVl3P+RYRn8qiuGtOIy+
         Ms0IjPqovGZ/n9e4pPRoh/kDxniUmKKBDVI/fJs0//g6zR2Ke5ymUGOO89n2HSNloNT/
         ZrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qRrjWLMfdu6yIcwripxOfFds2oSTzWm8NOly78GvImA=;
        b=NUq5I2wUiNffjGlub8uWOqNDt8aug0/D501fgJn9PaUfd0h4sbwVmmNCT1IICZqO9M
         hMF4NDBdfugdsoPSJGLMG4m/qMC1RCNRqcGtuQIj+JLOQF9fc3/8eEhjGlceyVPr8q0E
         7I0Rk5zGYisjYBW5Br8kfk+5kLof4ZJY7yoRL6ENq9aFOnwQRpEVkFSn3PwyRkJOjyty
         xzWDMr4KZJfk9NOnvvM2gm6TJA2/zDhoOzusLYst/10sNlh6UqaZ2tMA/RBE/UUadrdT
         IglVLHymz7wu13Vdynnfpd1DerLwEWC8svNiqCHeBvD9M5dqwMKo8w1FwsZ7aWmxbj8c
         a0ag==
X-Gm-Message-State: AOAM53219taS/R/dGUf4lXYSUuz36yyj4lihLHkwW3idkJ3DYMAarfkh
        /2Ginar6cFWC3TA/r5MRPc57u5f6CoHV
X-Google-Smtp-Source: ABdhPJxiVFcTI4z0xGMr9ZyulQytlCLw/B1VBP49S/XaxYsvHk5VzyCtbJSYi+urWup0bdAjQ4KVIcmi8IVE
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:a17:902:ec8e:b0:158:fefd:a2c2 with SMTP id
 x14-20020a170902ec8e00b00158fefda2c2mr6244114plg.85.1650313237814; Mon, 18
 Apr 2022 13:20:37 -0700 (PDT)
Date:   Mon, 18 Apr 2022 20:20:17 +0000
Message-Id: <20220418202017.3583638-1-yuanchu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH RESEND] selftests/damon: add damon to selftests root Makefile
From:   Yuanchu Xie <yuanchu@google.com>
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the damon selftests are not built with the rest of the
selftests. We add damon to the list of targets.

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d08fe4cfe811..ffe453760a12 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += damon
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
-- 
2.35.1.265.g69c8d7142f-goog

