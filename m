Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2651C28EC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 03:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfEXBUp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 21:20:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbfEXBUp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 21:20:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so4058024pgm.7;
        Thu, 23 May 2019 18:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wjBM6bom7PUFxoIMEGkCV+PHcAdXcG+G3bGPxdfSjkg=;
        b=IfO+Pnmbq7poyYM/5EZwXwxuUoy9EkjBgkm2L+v4CKqmyvHC16J9tndQj/+7k73olM
         71L+fopZwPkhgmDFeTY1WXVRb44ber6DlalEslpEY4aaj87EWOK1mWLC7ebgBIDsAK8X
         l24f04WVzfhbQAEOFn0n5PfcYgIDT+7XF+zFZWsTKs2G1P0CQJVeYPvkd3ZGT7/MO4Aj
         leh8Ma9BNyKFuqsNTiEznSWBB+1V3ITzBmelZI3sSTJnjU9FIVmFSZIF6TpSMcXGzTE5
         ZOYl+IvlSWBfLTqC73d2hXagBoGC7F8kO7tiqgH18zrU0MMX1B9moN0slBgmNKFtrQ6m
         tkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wjBM6bom7PUFxoIMEGkCV+PHcAdXcG+G3bGPxdfSjkg=;
        b=prYW8YvcBt6eoHGlnMjzvUaWL+nptA6CY5faCAJKvSkd5WW/sbBJStqSSbZJiryieZ
         hy/ptG4m+zu71GHcgD/1H4FC0yalNh3LN6IN6h0/x4JuTsNYfCQNXt9ictbsJ23J6W7b
         xqbi4/pR0nQHhw0+igMtRnsH2KHzV4RBFB7frJihgJCU70hG8IE0376HUEwt0tLqh7wf
         Tb/sVtiMHOf0DHJ7+79UgmbntvS+/hzy0VkQ7KZuNsKSMKuP61idTEnw+WL1+hjn/BXq
         AzYOq4D81FISWHkP6a2bo9kRvbfOzaHzdi3YmKWQ2wdvkSJ3elAVAMPGuh8ZPP9X+JOs
         T9Yg==
X-Gm-Message-State: APjAAAVoffLJOxW2O76eB1aePgPWrGQ0fFGoluwcF4VaDMkd3SPGgIDs
        qwW6JsxrxnGPeMca4pPeo/Q=
X-Google-Smtp-Source: APXvYqz4Pqo2ZbVrYpORsgp6dI+Sj724gAx02se7zNPOJ44V33PDcDM5JvUhK9T1W3rYGdjZmiDYsA==
X-Received: by 2002:aa7:860a:: with SMTP id p10mr92210505pfn.214.1558660844238;
        Thu, 23 May 2019 18:20:44 -0700 (PDT)
Received: from ip-172-31-44-144.us-west-2.compute.internal (ec2-54-186-128-88.us-west-2.compute.amazonaws.com. [54.186.128.88])
        by smtp.gmail.com with ESMTPSA id i7sm677374pfo.19.2019.05.23.18.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 18:20:43 -0700 (PDT)
Date:   Fri, 24 May 2019 01:20:41 +0000
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kselftest: fix function return type
Message-ID: <20190524012041.GA75353@ip-172-31-44-144.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ksft_test_num function returns sum of unsigned ints and hence should
return unsigned int. This fixes the following compiler warning

In file included from sync_test.c:37:0:
../kselftest.h: In function ‘ksft_print_cnts’:
../kselftest.h:73:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (ksft_plan != ksft_test_num())
                ^~
Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index ec15c4f6af55..5a98c80e079e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -35,7 +35,7 @@ struct ksft_count {
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
 
-static inline int ksft_test_num(void)
+static inline unsigned int ksft_test_num(void)
 {
 	return ksft_cnt.ksft_pass + ksft_cnt.ksft_fail +
 		ksft_cnt.ksft_xfail + ksft_cnt.ksft_xpass +
-- 
2.17.1

