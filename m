Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F85743300
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjF3DRj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjF3DRh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:37 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBAD3594
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:17:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39ea511930eso989727b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095052; x=1690687052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZoSuQHQ27DM/d6b7OOglRkF4w/BysG+jSVaxzCus5g=;
        b=HeDRz1ERohiy6m7ihytJYCLaW66pr6T/yVt3YJJVg+ByWiKq4yaXI4f/SVp6flkL+e
         MUFr8LdBari+Ig036YI4Hq83c5hmfUGZoLtXb3P2kvkgdyi+f132IV8Ci/c9QnPKnrFC
         QTiFkcVn8WpLZV0/xbD4SyhXu+ltOEWK6gsGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095052; x=1690687052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZoSuQHQ27DM/d6b7OOglRkF4w/BysG+jSVaxzCus5g=;
        b=DjC8/PgVsxO9bFQgPhWe2rhlDR5CLx6RTX+AcdiSM839Rl/Yh65jVQczPEtxWO35cQ
         L66CKUjW28YQePe3THM7AkgRD+gdJ60dQpHtu5anwBHgeBE/MVwBQAkQLBRjToVPtEB+
         OxtykWPkCo2RaPn6N4voQzE6CkBfvvgvIYi/refIPzxdUyGs01fu2K5w6ifc5/SA4Fee
         ImaohrzL0D/AdN+FcjZIalV/jM7htw3PmWqn+YIvhvN4xN8OvdDqJssmQkukGVTbUB/K
         Pz/BhCOuCzang+U3kb1+k4ONn6ZURHDbkTbyY4Yx0AmjNVIjQ7y5+gcdoUWorO9wcLIf
         2EHw==
X-Gm-Message-State: AC+VfDxyQoHyjcCmuE3rq2gEkkUWX81KCNhXD5HLwCkO4wn4KrJh908J
        M37K99kCv21DHVyZUWonIQIcJA==
X-Google-Smtp-Source: ACHHUZ5ieji9f9FFgUwk0QNqn8Z7w6bi8Vxc4p96KvUt1caQq7AD4bSuKudaVKFZdPoLr4vL1DK+jw==
X-Received: by 2002:a05:6808:d4e:b0:3a3:7e8d:b0b with SMTP id w14-20020a0568080d4e00b003a37e8d0b0bmr1648172oik.22.1688095052740;
        Thu, 29 Jun 2023 20:17:32 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id y12-20020a655b4c000000b0055adf339c35sm6407088pgr.31.2023.06.29.20.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:32 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:20 +0000
Message-ID: <20230630031721.623955-3-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630031721.623955-1-jeffxu@google.com>
References: <20230630031721.623955-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for sysctl vm.memfd_noexec is 2
(MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED)

memfd_create(.., MFD_EXEC) should fail in this case.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f..dbdd9ec5e397 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1147,6 +1147,11 @@ static void test_sysctl_child(void)
 	sysctl_assert_write("2");
 	mfd_fail_new("kern_memfd_sysctl_2",
 		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
+		MFD_CLOEXEC | MFD_EXEC);
+	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	close(fd);
+
 	sysctl_fail_write("0");
 	sysctl_fail_write("1");
 }
-- 
2.41.0.255.g8b1d071c50-goog

