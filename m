Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73F798BA5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 19:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbjIHR6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbjIHR6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 13:58:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0621FCF
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 10:58:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e5e2e608so26095547b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195885; x=1694800685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNRAzZU/edQLTJw3qIY/o1dxHISQKnf/BXQhNzjVbbY=;
        b=2qSjhcS0RK7HJABT1Le0Aj7tqR8nz/9wcSX3NJzL26yTMiYoFtqPnZ05T3ya+9GSMS
         VDGhE8w6S6gPu6RB9e91do03PTw2mTij5Oh//DYubXC6S/w5HmMm3OqZM1WrDvS4dWXS
         L6OGTauhNjnFJR7+2DarFhsrkRqMWimwuG1k6zkiLkgAzhMJR5JsE0MATkIPlY1qyDtw
         Zpr2lQIdPEzcqGDYua+NI74QUjy16VLltzViM0AJhpxGnooaAitClfLc3hGq2ecZNrEd
         YhcUzXf2bS1FdMugB3nc2y0+ocRn+NJ+SDMbnsHSnoyL7wyYSxA+CrsBpo+oC3QGHl2Y
         +O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195885; x=1694800685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNRAzZU/edQLTJw3qIY/o1dxHISQKnf/BXQhNzjVbbY=;
        b=dED0d+LqJ7jEdB7/vmhDwWzitOuTHbQX84a8lh+MDgtH6u3CniOApsTO1PmJKK3sFm
         IKfFkqaiWaMjpXJNCaOEeNPOLb8rSPNkGH71etCTZu2ux0nEMuBGTNDlzbkVgYVkFKlT
         dCGWRKkMGClcNoTxzH2PZnUJUp5dBGhtHPwIYj8GSlDF6I2/kAyikyDhdRjQTHY4iyT+
         uFDUOey6GDM4QbH4QHASvrL5J/tsWVhwfEeFHoIHRCMafItoKR0F8fQdgkfoL+c/LUs6
         HY1/ifgfCta1ceVS920uCbwrrRfNZUaUAh99j9iLZw11n/LyOGQ4T0cLhuMuV7SyFpDr
         7dPA==
X-Gm-Message-State: AOJu0YxwaN0C+KVeWqB27Kia5bE0ZKTBiIcSDj4/muwaK+z6X85F83/n
        8mZQSHGovafQR8ff4ciSqqhJ39Kuxy3yuNz6
X-Google-Smtp-Source: AGHT+IFoF1EiaUeA0+DU6tYzZsfsoi52XXqVRErttNtmBwyZirUf/VwWuA0433pCTHLt3+OeKv0sjSkOLMN7x+ON
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:aa82:a90b:b76f:32b0])
 (user=mclapinski job=sendgmr) by 2002:a25:9208:0:b0:d7f:8774:dfd4 with SMTP
 id b8-20020a259208000000b00d7f8774dfd4mr62282ybo.12.1694195885073; Fri, 08
 Sep 2023 10:58:05 -0700 (PDT)
Date:   Fri,  8 Sep 2023 19:57:38 +0200
In-Reply-To: <20230908175738.41895-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20230908175738.41895-1-mclapinski@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908175738.41895-3-mclapinski@google.com>
Subject: [PATCH v2 2/2] selftests: test ioctl(MEMFD_CHECK_IF_ORIGINAL)
From:   Michal Clapinski <mclapinski@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yi Liu <yi.l.liu@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Steve French <stfrench@microsoft.com>,
        Simon Ser <contact@emersion.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
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

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 3df008677239..1a702af6e01a 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
@@ -39,6 +40,10 @@
 
 #define MFD_NOEXEC_SEAL	0x0008U
 
+#ifndef MEMFD_CHECK_IF_ORIGINAL
+#define MEMFD_CHECK_IF_ORIGINAL _IOR(0xB8, 0, int)
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -1567,6 +1572,31 @@ static void test_share_fork(char *banner, char *b_suffix)
 	close(fd);
 }
 
+static void test_ioctl_check_original(void)
+{
+	int fd, fd2;
+
+	printf("%s IOCTL-CHECK-ORIGINAL\n", memfd_str);
+	fd = sys_memfd_create("kern_memfd_check_original", 0);
+	if (fd < 0) {
+		printf("memfd_create failed: %m\n");
+		abort();
+	}
+	if (ioctl(fd, MEMFD_CHECK_IF_ORIGINAL) != 1) {
+		printf("ioctl(MEMFD_CHECK_IF_ORIGINAL) failed\n");
+		abort();
+	}
+
+	fd2 = mfd_assert_reopen_fd(fd);
+	if (ioctl(fd2, MEMFD_CHECK_IF_ORIGINAL) != 0) {
+		printf("ioctl(MEMFD_CHECK_IF_ORIGINAL) failed\n");
+		abort();
+	}
+
+	close(fd);
+	close(fd2);
+}
+
 int main(int argc, char **argv)
 {
 	pid_t pid;
@@ -1609,6 +1639,8 @@ int main(int argc, char **argv)
 	test_share_open("SHARE-OPEN", "");
 	test_share_fork("SHARE-FORK", "");
 
+	test_ioctl_check_original();
+
 	/* Run test-suite in a multi-threaded environment with a shared
 	 * file-table. */
 	pid = spawn_idle_thread(CLONE_FILES | CLONE_FS | CLONE_VM);
-- 
2.42.0.283.g2d96d420d3-goog

