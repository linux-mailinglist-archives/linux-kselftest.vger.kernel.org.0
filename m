Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7020367EF5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 21:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjA0UMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 15:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjA0UMn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 15:12:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D32100
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 12:12:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5066df312d7so66539457b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 12:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U5PweF5Md6NbIdnNvsH2BayzCnZUUA5GzHDCZFW7bFw=;
        b=ONWctdoEud7qQ4B99HG3h//Nh6GFQlodrwLFPGz7gXjP/o0pmC2lz/qXuJQsiAbwzm
         SxXvQaEy5uFk4g8C8Ye8SoZfrkZniuArrj65jPMjByR+bJNLMuQLqllZTO/xvgSAMAUc
         bhHbrtseaiyH7TspyFJj83HWGtNFn0r1BrpHVv71Nalq3rIuVU9t+fYuruji6+laUcs6
         UnCng6BcdB7yF8DLHN6LpqQDsWsAoS5KbB84BbmoO/35D3s/6TkTqmydFW7atw+np343
         IftJe77NrK2rUbZ5jJ7tB2zyseRG/CNlTr3gk/ZLWRvIYyJ6cU5w/3IWldHh45/MzENF
         Skdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5PweF5Md6NbIdnNvsH2BayzCnZUUA5GzHDCZFW7bFw=;
        b=OOsPViDoqQp1lopBhUdoFj1wsEZumJuj5fMiGu1gjWxQqshheEwgctEsmwz1itAqR+
         2XEILNC+iGZIJsxw3QeXy3JPgQIeDyofE+06J8kjVj9QerX9zGhXx/0vV9W4lOvHIAmv
         ufQVdQT3iEwI7DQDMFp3nVWqFFumeacjU5y9LDgS1CDOd6/W4dpYCRYwqqZtgC5n3q4X
         OVnPrQxNRFojdPd5A8u+8I91cJXrSaZHm+N3cA/S5pHC0UJvzkDX0epoSlp9sMrbrnj+
         un/bvHdA5WaftWHyr8dN0dPFSyqAVbvHHlgQr7mKvs5FbKkWc0nEQE3Uw9wmK7HMs3e2
         RPew==
X-Gm-Message-State: AO0yUKWkvFraO6mfo3d0fEmgOoZpqx723K+qJbXJv3JhhYY4hBdYG1G9
        FF9ZO8U98MBRL45jVkeUOszbZseA7Q==
X-Google-Smtp-Source: AK7set8VJGEtbKBZlU6hCuahzp1rc7G7d7am0mQLFXrImBHYa3g9f/I+bQ2PeH4yNwPIDrBhDJ5z+OkK4A==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:61c6:0:b0:50e:8ebe:45be with SMTP id
 v189-20020a8161c6000000b0050e8ebe45bemr193751ywb.214.1674850361795; Fri, 27
 Jan 2023 12:12:41 -0800 (PST)
Date:   Fri, 27 Jan 2023 20:12:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127201219.775410-1-rmoar@google.com>
Subject: [PATCH v1] apparmor: fix use of strcpy in policy_unpack_test
From:   Rae Moar <rmoar@google.com>
To:     john.johansen@canonical.com, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     apparmor@lists.ubuntu.com, skhan@linuxfoundation.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Rae Moar <rmoar@google.com>,
        kernel test robot <lkp@intel.com>
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

Replace the use of strcpy() in build_aa_ext_struct() in
policy_unpack_test.c with strscpy().

strscpy() is the safer method to use to ensure the buffer does not
overflow. This was found by kernel test robot:
https://lore.kernel.org/all/202301040348.NbfVsXO0-lkp@intel.com/.

Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Rae Moar <rmoar@google.com>
---

Note: This patch is based on the apparmor-next branch. However, the
patch should also apply cleanly to the kselftest/kunit branch.

 security/apparmor/policy_unpack_test.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index e1bfdab524b7..5c9bde25e56d 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -69,31 +69,30 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_STRING_NAME) + 1;
-	strcpy(buf + 3, TEST_STRING_NAME);
+	strscpy(buf + 3, TEST_STRING_NAME, e->end - (void *)(buf + 3));
 
 	buf = e->start + TEST_STRING_BUF_OFFSET;
 	*buf = AA_STRING;
 	*(buf + 1) = strlen(TEST_STRING_DATA) + 1;
-	strcpy(buf + 3, TEST_STRING_DATA);
-
+	strscpy(buf + 3, TEST_STRING_DATA, e->end - (void *)(buf + 3));
 	buf = e->start + TEST_NAMED_U32_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
-	strcpy(buf + 3, TEST_U32_NAME);
+	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
 	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
-	strcpy(buf + 3, TEST_U64_NAME);
+	strscpy(buf + 3, TEST_U64_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
 	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
 
 	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_BLOB_NAME) + 1;
-	strcpy(buf + 3, TEST_BLOB_NAME);
+	strscpy(buf + 3, TEST_BLOB_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_BLOB_NAME) + 1) = AA_BLOB;
 	*(buf + 3 + strlen(TEST_BLOB_NAME) + 2) = TEST_BLOB_DATA_SIZE;
 	memcpy(buf + 3 + strlen(TEST_BLOB_NAME) + 6,
@@ -102,7 +101,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	buf = e->start + TEST_NAMED_ARRAY_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
-	strcpy(buf + 3, TEST_ARRAY_NAME);
+	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
 	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
 

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.39.1.456.gfc5497dd1b-goog

