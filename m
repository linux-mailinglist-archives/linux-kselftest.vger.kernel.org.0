Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84671FF2B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjFBKZV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjFBKYH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:24:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B6170B;
        Fri,  2 Jun 2023 03:23:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so18047845e9.2;
        Fri, 02 Jun 2023 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701412; x=1688293412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zsWsO0SYQc2zuAFXTltDM4jvFhQ6oDnJCWqcpd786g=;
        b=LU4R41oGxlkBy98OrlbBVW7Wp8pbWnN6DV/EvdZHvc0d8DC+O4FAonI4plWiMFQX2q
         A8HwU2Ls79uqvm1sfiKvAhBjIpi1uwEKKwH3EUZjlxTN1j4hC0+agvXp3q5gbBSsdvqw
         znYnMg1FtuRK/AeZP+IJTHPwqh1mrubdM+6yTfZVgkzzIAJeO652mvrCSK6VzJjBfOpN
         X1dlI7Ah9o5e9uWO5ihIJwN7OkVgX5ZU8t+Q1m29BBnmXFQIb/2v3bTUcmn7J3t8w5nK
         legiO/tChDYMMStOX01s3fJ//cgXFv2yaPrYhVesAyZPqThUIhpbqwEYxOAbKTLfJPhb
         XKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701412; x=1688293412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zsWsO0SYQc2zuAFXTltDM4jvFhQ6oDnJCWqcpd786g=;
        b=dvHT3lpxCBUwsDsRwja6yk8OkU/gZDK7chnfzUYcWrGU+lz/V5SizKPpFZ/jDXZSvz
         AwRW4hNI8CsWmsJGauMAvm5OKKC2EWU9UPttXM0isBWrMHag8fwVDFFbOZ9s/5YZFWn7
         0zhZ0fllKToRY8OisKy/V9T/w+sLEFHeO5XMbCJb8mGxfp5PKrm6Y3/Ay4bLAfz0Nfd6
         uT7t/XT7veJnLiKcE94d3KzhopsUkz8OJQaC+xfA806BuQ+/sSLsQnLGdiUQYk+CgLqp
         3Ts1jwZUTzgudVQxlFHr84F9GwnlmYU3fqGi/5nQMENl0m7lniXoFyEvOXZENoFL/b24
         H4Gw==
X-Gm-Message-State: AC+VfDwZ4sVbUvo/H6uBNk73euXY8s/3CewQ1l133VFa+wXr41mTxW54
        DWfF53Vkc5aaFYo+nlXnruC5f13j2IC6yQ==
X-Google-Smtp-Source: ACHHUZ4Fl3gljkQdCDOjzrgPzwI2Pjo+30dGKXdJ0cCSR8AkNPESiVXzE3/y3lx+UGWXjhGjLZC/Kg==
X-Received: by 2002:a5d:4a52:0:b0:309:3b8d:16a8 with SMTP id v18-20020a5d4a52000000b003093b8d16a8mr3808046wrs.50.1685701411933;
        Fri, 02 Jun 2023 03:23:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g9-20020adfe409000000b0030ae53550f5sm1245989wrm.51.2023.06.02.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:23:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: s390: selftests: Fix spelling mistake "initally" -> "initially"
Date:   Fri,  2 Jun 2023 11:23:30 +0100
Message-Id: <20230602102330.1230734-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/s390x/cmma_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
index 6d0751ea224b..576fe8ee0aec 100644
--- a/tools/testing/selftests/kvm/s390x/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
@@ -656,7 +656,7 @@ struct testdef {
 } testlist[] = {
 	{ "migration mode and dirty tracking", test_migration_mode },
 	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
-	{ "GET_CMMA_BITS: all pages are dirty initally", test_get_inital_dirty },
+	{ "GET_CMMA_BITS: all pages are dirty initially", test_get_inital_dirty },
 	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
 };
 
-- 
2.30.2

