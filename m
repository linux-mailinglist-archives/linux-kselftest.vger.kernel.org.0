Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0284A584B87
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 08:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiG2GP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiG2GPm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 02:15:42 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA332DA0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 23:15:31 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id d12-20020a056e02214c00b002dd143bee38so2435547ilv.7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j24QTnRW2WQx+RjstTVyEuiliRIDIVKlQJ1Kiz8ekAE=;
        b=TEY2CXEZm6Qhc3rYKvDwoWR/qoEJmmQ7Dv9aTFM4za8jX3EZDWIALRH/Jk0rO6tPEL
         04GuD37Jd3MrehHYH11XBPPlg4Ar0TKo05/09sN/luz3mvH4iOyypcvdVRxfZxH1jiLq
         z6KNyVuyRvOrF4sbUH0kFFCIH44cHkjk9Ca/vEhgLt5eCqosFqxT3Uv0lbcxlA1OinoY
         eCy6RGBjPmwCDEiP+1BZ7XztqysMqUukHNaowrmkwQ9t25Av6nS4HGYTibxIvcKbm58T
         b84If3L1S4cDWzjgsUdPA3aHu/qxczyKskkktR/6a1+RDH5qSMsEybpvE8wQhxHPmUoX
         NgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j24QTnRW2WQx+RjstTVyEuiliRIDIVKlQJ1Kiz8ekAE=;
        b=z1jB1Drw00S8Mx+f2X7qbJeF9kQRI6y0v9vHkesBMIWxh2PQu+7tzmQNWoI6B3V3Yy
         W5PF7Gb7UdRxZoQX1067IrHaIUPblmpLIrxnxU2wEVoBn59LOabWcxnVXZPEWCekqvKj
         9WwlOJKICrCacd3jS49Ze/Om5990Gsfy+/6A2V0AVn0/M2T3BJnKdYPwSRpb/sTIHnyS
         J+FJu63tU6Hcx0wNiV/WwinEJWNADRW/Jmdylfdw4c4i/mIeuftc1nOYWfhZj5bUc1mO
         RFTulX3BMUYdieUSZ8mfcJrTv8Nt9LfuQl4dhx53PCALFG+NOVMCXXjHyAQHM7lu6Ahv
         tQsg==
X-Gm-Message-State: AJIora8Ar/n1l2hRMwBI6DONCSR3I3JzDtpd5MuazwnNtagluXHhWDvd
        QNIcpgvA70I44Y1E9OX8nJ0AlgKcgAA=
X-Google-Smtp-Source: AGRyM1uskQwYHUNqkg5mvGxPHUBp/Ocjhd1K7H8Mnvd07a1z9dH1JiWMOc91PrXNG4arVs1JBvaBPDb8FW4=
X-Received: from jeffxuk510a.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:65b])
 (user=jeffxu job=sendgmr) by 2002:a05:6638:13c2:b0:341:5b3f:399f with SMTP id
 i2-20020a05663813c200b003415b3f399fmr873301jaj.91.1659075330697; Thu, 28 Jul
 2022 23:15:30 -0700 (PDT)
Date:   Fri, 29 Jul 2022 06:15:04 +0000
In-Reply-To: <20220729061504.744140-1-jeffxu@google.com>
Message-Id: <20220729061504.744140-2-jeffxu@google.com>
Mime-Version: 1.0
References: <6f71a4f3-8f8e-926b-883c-1df630cfc1a0@linuxfoundation.org> <20220729061504.744140-1-jeffxu@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 4/4] selftests/memfd: add tests for MFD_NOEXEC
From:   Jeff Xu <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

Tests that ensure MFD_NOEXEC memfds have the appropriate mode bits and
cannot be chmod-ed into being executable.

Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 1d7e7b36bbdd..4906f778564e 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -36,6 +36,10 @@
 #define MAX_PATH 256
 #endif
 
+#ifndef MFD_NOEXEC
+#define MFD_NOEXEC	0x0008U
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -1006,6 +1010,35 @@ static void test_seal_exec(void)
 	close(fd);
 }
 
+/*
+ * Test memfd_create with MFD_NOEXEC flag
+ * Test that MFD_NOEXEC applies F_SEAL_EXEC and prevents change of exec bits
+ */
+static void test_noexec(void)
+{
+	int fd;
+
+	printf("%s NOEXEC\n", memfd_str);
+
+	/* Create with NOEXEC and ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	/* Create with NOEXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1179,6 +1212,7 @@ int main(int argc, char **argv)
 
 	test_create();
 	test_basic();
+	test_noexec();
 
 	test_seal_write();
 	test_seal_future_write();
-- 
2.37.1.455.g008518b4e5-goog

