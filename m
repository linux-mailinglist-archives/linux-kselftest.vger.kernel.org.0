Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28620BB1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgFZVJh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFZVJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:35 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101BC08C5DF
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id f79so1421702qke.9
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=QoyX5QkLkeZufbY3DPWqVcx8p1G2Pf6aerfPyt2zQE/ujAwEYOP4MavORdpoC0kiKu
         EBTjnDggRXo0KQe45lMKlqgesoVoq2M/WZaVEKYilzw17KOXTZudXtu6crQek7qlLud6
         wgqfeApVUIS2o9DKhJa1hfmORSYPYOqHxCziPwrSa4G+57ASkLll7CukI9nktN3Owv9v
         NukYDAxu7zl52PVDoi+7jdhfKkThnizMJ68rg/tVzgIVSHiP3aAKWELQxmH03U/bRKpt
         6Wgu+YeU85Wm8LsbzjbD34Ud+5/9JGpyI65sawIxfi18MEFZnvGjX41U/bIx6IVwD7H1
         RvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=IacQXtDPchkpKAzudzT3X1weMXXi/CVOCPnaKA3RKwkqG4R7GVqF28vbf4BSjMkXJ1
         IbPsgbNM1sh8kKjyq+J4XcgYcMPzyNAOAJIjTZARmRnCAAPjFWHaefOQClWglL3h9t+7
         xSZGxXjYTd86+6sFo2JGksw/62pYRVuzbmacgXW/jWBalH5XJ+AszT98U4Ezg1lsC9pI
         6pzPvcEOFA73RQUkJhECVoLctXL6C14PW/mQs2xicXBe23wTa2IxorQOjjUdCLDwdsH4
         3iazzpUbn+erk0dYhpSVoTmnnfa2AQUqjSS2rI0B72OU6OMF/EaP+4Srq/KFDpmINhSe
         DpMg==
X-Gm-Message-State: AOAM532t2MS1RlpvB1+3etkgUEJvAK1BpMS5sA+hbcy5A0oAe5c+md+g
        RpkHwoUJ/gJSLJ2l+roHZvoHOThO+SeL19/qEsdJ0A==
X-Google-Smtp-Source: ABdhPJypYrK6iZse6cCSs4YnSv2AzXM6d8Vad2NCnBdBrfM4NUTiqCIXIvHzUdHQAv3Yb81UEf64dXgB2cs8yGqX9AXtcw==
X-Received: by 2002:a0c:8e8c:: with SMTP id x12mr5032791qvb.55.1593205773222;
 Fri, 26 Jun 2020 14:09:33 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:10 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 05/12] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41bd..9a9c97f45694c 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.27.0.212.ge8ba1cc988-goog

