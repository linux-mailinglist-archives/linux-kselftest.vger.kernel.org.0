Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95A54A2BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 01:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiFMXdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 19:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiFMXdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 19:33:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8098B3055D
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 16:33:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 206-20020a6218d7000000b0051893ee2888so2943867pfy.16
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Lpl6bFxJI4CHRgZzmX1LV+v0qDroFLN/nvNicZhBWbk=;
        b=PBbqm2oEvfRdfqUL7Z30R+/pfa0TDaOZnOfFZ0FGkyyXTVfaeA859rqjWm5M1jgU4x
         x9JF9CHjapYA+Mh3kZOTZBfRwi95ukBYi4SdXiCXBziNv0P/HPw9E1dCWO6gbH+BcCKm
         tkhDkanIMftPysWbsqKlgR9QcfvPiyPBDZ/GSuklEWBnmW3oudZLo8ywT96P48LV6iA4
         XmsVCsryoiDxhn+5j4mLRhSC2gJiFeyyEotYhoPswCKK6KwnReLTepOho7gwxE37W1Zi
         K/rIYy1sy8uQjBLmW9Eh+KI/HR8kZ34ztVrGSb3dFKCZ8WMgaXsxVEFfLfbbLSPqJGOj
         6gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Lpl6bFxJI4CHRgZzmX1LV+v0qDroFLN/nvNicZhBWbk=;
        b=VqMYAZgz60dItlMX1ppV7jQrawYcTqC50Iy5ff4+Z+Re7xUASfOojMu74cv751YvES
         RLIcTlG61p2wDK+y+01jPcxTQs1A/yiPfX9/DOVFT3u+fUr0smaf70kGsniDF2Rdo3at
         pj9nCim0kUlBj2MlRPrJvmXiAwdQ0iZt4XnhqoKf7hX1JLYTkZ8Y9+1lexlx13X+5MeG
         iDJSM30hPJEw6/H965OkkWvJs2TVpMp8H/+T+Fd/VcwimUbsH9Yz0ZLCw40NfrVFNvWE
         7I70FnD5esgVcg7+KCf8Vsso+S9QU1iRf84IsT2CtTsZAiBm4/64i58hPl5EwBzklKNs
         /dXA==
X-Gm-Message-State: AJIora980SQZgxQ+6sRkvWsjpBieqYSL8B7GJyhmY1P7qESU3TZYu6BM
        3oYkM1xFLTrH0IsNmy6VewsaiA5TlwY=
X-Google-Smtp-Source: AGRyM1txbt+9NgJBywZye18wHMFrzrxDjzOEouzPoc8+gANuChnXlXGrxwM174nRDA4EmaMfxx9wSKZ3OXQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a17:90a:e7c8:b0:1e6:92fe:84c2 with SMTP id
 kb8-20020a17090ae7c800b001e692fe84c2mr1259645pjb.194.1655163228891; Mon, 13
 Jun 2022 16:33:48 -0700 (PDT)
Date:   Mon, 13 Jun 2022 23:33:21 +0000
Message-Id: <20220613233321.431282-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v1] userfaultfd: selftests: infinite loop in faulting_process
From:   Edward Liaw <edliaw@google.com>
To:     shuah@kernel.org
Cc:     axelrasmussen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com, Edward Liaw <edliaw@google.com>
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

On Android this test is getting stuck in an infinite loop due to
indeterminate behavior:

The local variables steps and signalled were being reset to 1 and 0
respectively after every jump back to sigsetjmp by siglongjmp in the
signal handler. The test was incrementing them and expecting them to
retain their incremented values. The documentation for siglongjmp says:

All accessible objects have values as of the time sigsetjmp() was
called, except that the values of objects of automatic storage duration
which are local to the function containing the invocation of the
corresponding sigsetjmp() which do not have volatile-qualified type and
which are changed between the sigsetjmp() invocation and siglongjmp()
call are indeterminate.

Tagging steps and signalled with volatile enabled the test to pass.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 0bdfc1955229..2b2a68722ae1 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -931,7 +931,7 @@ static int faulting_process(int signal_test)
 	unsigned long split_nr_pages;
 	unsigned long lastnr;
 	struct sigaction act;
-	unsigned long signalled = 0;
+	volatile unsigned long signalled = 0;
 
 	split_nr_pages = (nr_pages + 1) / 2;
 
@@ -946,7 +946,7 @@ static int faulting_process(int signal_test)
 	}
 
 	for (nr = 0; nr < split_nr_pages; nr++) {
-		int steps = 1;
+		volatile int steps = 1;
 		unsigned long offset = nr * page_size;
 
 		if (signal_test) {
-- 
2.36.1.476.g0c4daa206d-goog

