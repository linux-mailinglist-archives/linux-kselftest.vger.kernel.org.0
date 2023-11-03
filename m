Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808BE7E0775
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjKCRem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjKCReX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 13:34:23 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E9136
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Nov 2023 10:34:20 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so343269066b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Nov 2023 10:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032859; x=1699637659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hFjtTwWiYmJQZ40RLPL4/H8vlzOG8WtCtwjnuFM5zw=;
        b=grsO/0pjuDmurJPXfS16WGiMj6pj+QefPcK8yq+ABEysrIaQxSfnq/9EV1sNzHalGb
         GZENLueYjtvWkQUHt2ab6WxEfdQFCX/nClOQN+5UN8sc+PipvBw9tLpB51DXJYAzt/6n
         vCySHhO0rcwt2xCNUgFbeFJ90qK2JHy3P8QkGaRadAMt6FGGyjsRseQHVOcXhB3YyxqC
         JKQmcZC9SqpTHY5Z+cTaDIRe/s39EElkPdoArBb7GQAMTbyTmW5wlBdkWKCu2AKNEEEJ
         XI56I6rFz7/46tKrVoBo4F3cS9mVC02M0cFHrtRHe88Me0kQUP6v2XChUMfUA3T8fY4q
         Qfmw==
X-Gm-Message-State: AOJu0Yw6dQz68LSi8mvoYEzDh9Haokw/xscip91l+wWuHR9o1TI+XVuB
        IzjeznAg9+6zD9C4SO/ir+A=
X-Google-Smtp-Source: AGHT+IFTBhL5MrYj5hSjrY8jTtAlqzE4ZUFyWYa7xs2BYKdLWbFtpGYLZ8CQnfvF98tLv7CEEqWJTA==
X-Received: by 2002:a17:907:7291:b0:9c7:fd91:4309 with SMTP id dt17-20020a170907729100b009c7fd914309mr7351813ejc.0.1699032859214;
        Fri, 03 Nov 2023 10:34:19 -0700 (PDT)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id lt10-20020a170906fa8a00b009ce03057c4dsm1127955ejb.2.2023.11.03.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:34:18 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     ryan.roberts@arm.com, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: [PATCH 2/2] selftests/mm: Add hugetlb_fault_after_madv to .gitignore
Date:   Fri,  3 Nov 2023 10:34:00 -0700
Message-Id: <20231103173400.1608403-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173400.1608403-1-leitao@debian.org>
References: <20231103173400.1608403-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

commit 116d57303a05 ("selftests/mm: add a new test for madv and
hugetlb") added a new test case, but, it didn't add the binary name in
tools/testing/selftests/mm/.gitignore.

Add hugetlb_fault_after_madv to tools/testing/selftests/mm/.gitignore.

Fixes: 116d57303a05 ("selftests/mm: add a new test for madv and hugetlb")
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/662df57e-47f1-4c15-9b84-f2f2d587fc5c@arm.com/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index cc920c79ff1c..4ff10ea61461 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -45,3 +45,4 @@ mdwe_test
 gup_longterm
 mkdirty
 va_high_addr_switch
+hugetlb_fault_after_madv
-- 
2.34.1

