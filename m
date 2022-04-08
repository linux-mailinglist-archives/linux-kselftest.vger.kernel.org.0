Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA754F8DD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiDHDvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 23:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiDHDu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 23:50:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F887B717B
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 20:48:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a5-20020a170902ecc500b00156762be487so3817667plh.10
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMxGJmiB5e6OzoXdsa0gQOrUzVf6+RM/u+nhhwmi1kk=;
        b=hm19arxpl/SU0iKf7/rYndp6fQcuitlvV+EWEfUK+SO7h84og7K6BK6obvHjeOO0UZ
         zkiR3a7LbnhQ4jOVd6TphIiV9u9GgO2vQzsLLqeWOlXd1+4BoVQ9fCbBiT5nqRytv/3y
         2Fzd5hvsY2aus3IZ1n1anlEKwfCNU//7TkvCPM5wNbdOJAhj9T3mYlLLAtktIoqNTvie
         MqxeVYL+BYInfOwYCLL6drgeHiCz5Sw2Mg4+Po9yBAaj9Egd+/tnkyxQBkVQMxfDOpVD
         urZXvT5dJiDjzaDNz4UQOmq7oci7CDnPekqCfN8JP77Z+QmRnY9+pGMfSAMtTSQymygg
         GX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMxGJmiB5e6OzoXdsa0gQOrUzVf6+RM/u+nhhwmi1kk=;
        b=THxTw9SazMCqmM40Z+TpjL0TGY3r9briM0SXDNLmajLRDVfU/PgEfEmcS+fetbvLxY
         zYHm4t4phPm/A3lJ3c0HoCr6FIRmf0USQ7u+o87nW3usgk6sMJuUqzYl/jElM/XAK8k4
         UQOwlgMwGMOjThexlXadLAs2bRKhqkvmiCr7DLksForzIfNz1yMkmZ9/pE/J+VSSb1NX
         vunIxerjuYBKLv3CgZKKdNlZMXINccM2S/6JYb0TsFJIYzh5kzr6gKr03TUqedod8A4X
         PBCBQBih6xDUex99ISLweT698LSX1pgmR195VGVUfqKWfj1GhITZUfG5bg8BHtoeGY3+
         Dxdw==
X-Gm-Message-State: AOAM531QQ+EMepVqRu9mbyWHPZ4URbJj0YOZHksVke1Gatyo3DoqGWqV
        Q9Jhx2q1XbWZObOHxdL2EpPB4eTtDC+KJg==
X-Google-Smtp-Source: ABdhPJx40q7xJ1d2dxEvQY/q+dodN34WiwwswNFTlP4A3FL8EJTbTurik/oaDhbNqE4hAIxdP9Y2/0ie2tMIiw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:3406:b0:505:7a1c:c553 with SMTP
 id cn6-20020a056a00340600b005057a1cc553mr1878476pfb.2.1649389736628; Thu, 07
 Apr 2022 20:48:56 -0700 (PDT)
Date:   Fri,  8 Apr 2022 11:48:48 +0800
In-Reply-To: <20220407223019.2066361-1-dlatypov@google.com>
Message-Id: <20220408034848.2081355-1-davidgow@google.com>
Mime-Version: 1.0
References: <20220407223019.2066361-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] kunit: tool: Print a total count of tests.
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
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

Add a count of the total number of tests run (including skipped tests,
which do run a little bit until they decide to skip themselves) to the
summary line.

Signed-off-by: David Gow <davidgow@google.com>
---

This patch depends on:
https://lore.kernel.org/linux-kselftest/20220407223019.2066361-1-dlatypov@google.com/

 tools/testing/kunit/kunit_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 957907105429..da01998d29b1 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -96,7 +96,7 @@ class TestCounts:
 		"""
 		statuses = [('Passed', self.passed), ('Failed', self.failed),
 			('Crashed', self.crashed), ('Skipped', self.skipped),
-			('Errors', self.errors)]
+			('Errors', self.errors), ('Total', self.total())]
 		return ', '.join('{}: {}'.format(s, n) for s, n in statuses if n > 0)
 
 	def total(self) -> int:
-- 
2.35.1.1178.g4f1659d476-goog

