Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6762A708D3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 03:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjESBTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjESBTb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 21:19:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732410E0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d2467d63fso853744b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684459169; x=1687051169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlYfhs3BTQ2EJ5c00OoF7xAAokRQfPc4lQTpfzHm9OE=;
        b=JWIfslA4UKDBw1Mp583btzlGGK8G9E6xpS7M8yt3iOyE0agyVlu+KO5Lxq4vpucXSU
         HH1YA4BQeb7OL6OLVkoix4UxlcxXNVOrDy2c5gWBw82vyYqfMb8tY9sDkBb9j+Na0b8j
         0kO3Cd+a0jrUOyQcvN7J2vDvvbkTYN/CiGCqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459169; x=1687051169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlYfhs3BTQ2EJ5c00OoF7xAAokRQfPc4lQTpfzHm9OE=;
        b=NpsjGwNnckXxhBG4ltSMlQpq71fPz/mPQoQ00YFGPOu1nYrOcvdMnHkRIK2GvuwnOW
         Ae/r8UI7X4AlLNI1NAYs3SQIWFReK7yUEbZF2gzzEUJVLnUtVYuXZKOi/1oYQBjv9oRQ
         KeLqbopr5RC06N544ECuQpWrOQ1KnF6xJxMfsglWstO4QPrMDn9DNxyc77puZQ2CQScI
         MTK280zrJbDscBGpmf7Tbfags4fEJp2d+mNIfKTJ9UgeYHQLFs22zw0M49RWV/YqD1AS
         RhDWQtXBYk3zFuUqzCi6ZyQbHvhKC0KDEM/yyMnahwOBjBGDbrMAjG+x/HCM5U5UY6IM
         7IaQ==
X-Gm-Message-State: AC+VfDwt1W20xoZPIXXO3zvNewSpbUCgAIJhd2IsiVVJeIbkM+EKdsuQ
        r72n5XbcUKIGBz9soloQClNZWA==
X-Google-Smtp-Source: ACHHUZ65BMUPG6NH0sSEE5yDD+qKd1DPXj0Iug+5r1nNE9fAXNvkKS48swgrqtg3LFDKz96p8HSxUA==
X-Received: by 2002:a05:6a20:8422:b0:ef:205f:8184 with SMTP id c34-20020a056a20842200b000ef205f8184mr425525pzd.13.1684459169739;
        Thu, 18 May 2023 18:19:29 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id c24-20020a62e818000000b00643864d03dfsm1960424pfi.171.2023.05.18.18.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:19:29 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
Date:   Fri, 19 May 2023 01:19:11 +0000
Message-ID: <20230519011915.846407-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
References: <20230519011915.846407-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patch enables PKEY_ENFORCE_API for the mprotect and
mprotect_pkey syscalls.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 mm/mprotect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8a68fdca8487..1db30b8baac3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -794,6 +794,17 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	/*
+	 * arch_check_pkey_enforce_api checks if current thread
+	 * has the PKEY permission to modify the memory mapping.
+	 * Note: this should only apply to the cases that do_mprotect_pkey
+	 * is called from syscall entry. Ref. to munmap for other cases.
+	 */
+	if (arch_check_pkey_enforce_api(current->mm, start, end) < 0) {
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.40.1.606.ga4b1b128d6-goog

