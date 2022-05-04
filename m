Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFA51928F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 02:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiEDAIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 20:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbiEDAIL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 20:08:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A542EFC
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 17:04:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z11-20020a17090a468b00b001dc792e8660so1216081pjf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 May 2022 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lolNF5na6ezwHOllGytfK9EWHDRXUvw2xu6SIn6lfiQ=;
        b=rv5B+Kn3eMfEVOnYUOMyvbzSi54WrfqWS8YwOlXtTChiJm74YyuMmXZFc3qUYLHQu3
         RUtHg577Nel87C7paT84znz/tyFkf4I/2nPvmOddKmHO7ObqQlKhbhGL1ZbiHNF1kTqr
         9Byb+U98VOcOqSYNe0hctmYZ6wYBwZPPXkt8qt9yC3p2jStppKQ/0yn5Qg870qU+RWz+
         WDP8evFJIlTSJNcF9/b0brepgnWFVxWUdwRvcZbS8aU58sk81XIcjwK7AwzxDUKRulgx
         qAzQ+MLvJwDoV4ZGZlolgMbchvlrFRtHtqEFZ7+NpkU2HhAlf5NCU8h/VLghb2xcD3/I
         x2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lolNF5na6ezwHOllGytfK9EWHDRXUvw2xu6SIn6lfiQ=;
        b=3zJWDCVeiNTO+lzm55D73uaEW+99XkzLd53RqcOw1vMdtgwbCUz79wqDCRbFd/HN18
         HrVZk8Sw+TBl1TWVXkCz6X8W7sls4t014rGh4ATLIGCtK+wycYKow7Sg4bQF7Pdvw2D4
         9b3CKJ1lReY+xYvui2ycw/KLBjU7DRSCEuMNYrBAsknTM9Vq0mO2J/V5DvTFwjLdLA2Y
         uxvLS2R9Jq2UIyBOBxvKwbuor8CZTKXvp/y6FKOlzdNW/afO71vt4Jn84mjzJtOn2knm
         B6mhOhhUjL8R0OPtzgAqUvDm+3jgYAOBUCmK7LTZquZL82RaXCCvisaB/Qf6kFAGGPIb
         PaYA==
X-Gm-Message-State: AOAM530lo+h7T6wqEMEKeMEQZKQPtQA4ZCPV13FrAjl94E1ZTA74WH/U
        wHdg/yh7WkrRfkuM1yLCuDa7Ydr3wvjp
X-Google-Smtp-Source: ABdhPJxlNnp2FhHVp5naZ/23iqD6T7CS6Y0uQdSLS87TLV54f/oWg7j+OW/ulnqIWu5ag0JT8ohRyL0jznCo
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:a62:a211:0:b0:50d:cdb2:87f4 with SMTP id
 m17-20020a62a211000000b0050dcdb287f4mr17447824pff.63.1651622675780; Tue, 03
 May 2022 17:04:35 -0700 (PDT)
Date:   Wed,  4 May 2022 00:03:58 +0000
In-Reply-To: <20220504000358.1174849-1-yuanchu@google.com>
Message-Id: <20220504000358.1174849-2-yuanchu@google.com>
Mime-Version: 1.0
References: <f6cc50f0-318f-097f-af13-271a2fb4d645@linuxfoundation.org> <20220504000358.1174849-1-yuanchu@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 2/2] selftests/damon: add damon to selftests root Makefile
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the damon selftests are not built with the rest of the
selftests. We add damon to the list of targets.

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2319ec87f53d..bd2ac8b3bf1f 100644
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
2.36.0.464.gb9c8b46e94-goog

