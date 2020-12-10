Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20EE2D52E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 05:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgLJEhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 23:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgLJEhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 23:37:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF257C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Dec 2020 20:36:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id w9so2295765plp.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Dec 2020 20:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jH+BFqTYM/TwX75APIA2AjyEOFPXOw7P8lcdqybb7hc=;
        b=Y/G9LwbZcGEr1UAJ0F3cFNU4kOSSyxfv3KDY4m2JT5W3oWMmwHCbAOgr+NrYLhCWUu
         RWQmywIWSAd4qT1aEXmUzTSSmNEH1gIHGjQcGtjvfQk0SS7QAAo/+DXns+IaI1vfthwY
         rKcrBaFWXWhAXboUQ2j3tOIbM+Ia5SOyFGMjJgWxaLo+7Sw7R6D/QEWZBCgXIxVYc5/d
         ubA76euzm/oTEPoOId5UNIPrLjK7SJD9HkrPflWzhAHDNEjxfkHjVYcXhu8wnKYFVtJo
         1Z/eYzV0zV0r2Qzk1JpfPobE2Cw8NK7SqeeHdRSlhf0nDa667CTkqk67pPWkslEgNeCC
         m92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jH+BFqTYM/TwX75APIA2AjyEOFPXOw7P8lcdqybb7hc=;
        b=UJ5jbKMqQ5pY1T+P/LKYQnPaU0rtGxEs4S5Rd04GK+1JPTlf2rNyy218+5FufsP9sF
         TJQjArBis4a5DqaPyTGI8K+ShA22nbWveGSsIBj65SgAX6M6YJDRiVqk5nnkRRVhK9or
         d3PCzB3qZf8I2d8MrVjr+so4wmZ5QKrckEppxyqiKdyxQTwaJUBmibq7cR79zF1xIQiX
         Jg53gPPOC+CSbKRkJn6xpVCuCqC015ekf4lRqaT16CADmcc2l9wCZHWR4P7Kf0Y0ZjbS
         V4rsE/74G8CnQrSXzOup/kidekahJQ5P1FGNCUd1YfZ1aj6E5bq2Hm/W/m6P51bvoEV1
         F1Ww==
X-Gm-Message-State: AOAM5311pMrR+AG7f0joSnm+qZUTAKY+F8gLbfK/7n/EroHf7GG1+VMT
        D+U4Z3zfoRUaPhhdDFj7W7JJOtpN
X-Google-Smtp-Source: ABdhPJxqFIjjdoRvM3pSV/+xbG2xUOSqpD6KJIhfiBxyCLRoTswMnTSxRBNTb98N4Houy5SUkGn9oRPCIA==
Sender: "morbo via sendgmr" <morbo@fawn.svl.corp.google.com>
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe0f:9f6a])
 (user=morbo job=sendgmr) by 2002:a17:902:6b02:b029:da:c6c0:d650 with SMTP id
 o2-20020a1709026b02b02900dac6c0d650mr4893633plk.74.1607574985383; Wed, 09 Dec
 2020 20:36:25 -0800 (PST)
Date:   Wed,  9 Dec 2020 20:36:11 -0800
Message-Id: <20201210043611.3156624-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] selftests: kvm: remove reassignment of non-absolute variables
From:   Bill Wendling <morbo@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Shuah Khan <shuah@kernel.org>,
        Bill Wendling <morbo@google.com>, Jian Cai <caij2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Clang's integrated assembler does not allow symbols with non-absolute
values to be reassigned. Modify the interrupt entry loop macro to be
compatible with IAS by using a label and an offset.

Cc: Jian Cai <caij2003@gmail.com>
Signed-off-by: Bill Wendling <morbo@google.com>
References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
---
 tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
index aaf7bc7d2ce1..3f9181e9a0a7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
+++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
@@ -54,9 +54,9 @@ idt_handlers:
 	.align 8
 
 	/* Fetch current address and append it to idt_handlers. */
-	current_handler = .
+0 :
 .pushsection .rodata
-.quad current_handler
+	.quad 0b
 .popsection
 
 	.if ! \has_error
-- 
2.29.2.576.ga3fc446d84-goog

