Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ACC7B4657
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Oct 2023 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjJAIhv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Oct 2023 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjJAIhv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Oct 2023 04:37:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CDA7;
        Sun,  1 Oct 2023 01:37:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b29186e20aso1403437866b.2;
        Sun, 01 Oct 2023 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696149466; x=1696754266; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKCiT0Iifb0CtpWzGitgnJVAW7NIhgQwEiMWWCVthZY=;
        b=WOZnVlwOIShwnwcE9g1WsNw3qiTGk/c09sWWD+mva109hX08HTyJp5OYyjn2EMIEIY
         VjfcgpVA3Xa7qYbm6lHtistsnyX1Vz3WL7lq3zrTp/cBzyERHRMGh9nHeveA2NT+Ivde
         PgZAsXeXU68R2FcHrltVq8iZW+byEi1rCBQOEeEPeuF1sIWBbvIIvACl+/p72KcS+pAU
         MEk5V9+4SjxDZ6MLxVfNjLEbTtQjLUijxDq+neFpWBecDaeH1ycNApr77GmvaiXg5O5k
         fksP3u4p8WuYkddzgwg/rnPyJ/DrFbvmmFaW8N4ik3w3ldA6+kyLRAVcHLjoX0I8sqlH
         +ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696149466; x=1696754266;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKCiT0Iifb0CtpWzGitgnJVAW7NIhgQwEiMWWCVthZY=;
        b=a24YsQPsgvTBBlkgWSrSaMAnKg50O8FffJJQQ0vouAvDFeZMBIxOagnBlPkWYWUb5r
         nZsno5ESKPTSVtEdC5SSV4ZEli7yDGC8S5M8I3HnXvWasRn6kXp2xdrW7TRWW8QikHpk
         F+ONry8GmTpgG/nrp2v6KFlxaDqyhtXnxDiZQL7tXKRNfcPgQl3RJevFi27qj6cM2KXI
         XGrz294c7K7ia402pMPtVhRQcI6etpaLYaY7p9AB2aRccb1jw56lg4MxjVRoM+VwK2xo
         S4Bv7oUnPVR46agciRh5VmhRBdbsvFrOoPnVp+2K+mAquK3txT1RoGut4Nr7SLbgArhU
         rOZA==
X-Gm-Message-State: AOJu0Yyo3m2iybCG3IHIKZDV14iYqWw3e8zsWe2+VQZlQxO+SNYfLKcX
        Z8DZoF5tZpRVeOUmrVuiDixSlK70uZ5Hwg==
X-Google-Smtp-Source: AGHT+IE+AYpwCV+T05pdMhELTcZqS8EBtQzUZgoVHRaGdGak5rURWO0OzKfpG3QuxIYLnjsoB4MtTQ==
X-Received: by 2002:a17:907:b1a:b0:9a9:f14a:22dc with SMTP id h26-20020a1709070b1a00b009a9f14a22dcmr8360790ejl.8.1696149466226;
        Sun, 01 Oct 2023 01:37:46 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-4c68-6c03-863b-ad4e.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4c68:6c03:863b:ad4e])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709061f1700b0098921e1b064sm15130499ejj.181.2023.10.01.01.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:37:45 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sun, 01 Oct 2023 10:37:44 +0200
Subject: [PATCH v2] selftests: uevent filtering: fix return on error in
 uevent_listener
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-self_uevent_filtering-v2-1-2d0a958c235b@gmail.com>
X-B4-Tracking: v=1; b=H4sIANcvGWUC/42OQQ6DIBQFr2JYl0ZQMe3KezTGAH71JwgGkLQx3
 r3UE3Q5bzHzDhLAIwTyLA7iIWFAZzPwW0H0Iu0MFMfMhJe8Kh9M0Og21DSAmYYdEtg4TGhilti
 ZslY1FRdc6VqQbFAyAFVeWr1kh92NyePmYcL3lXz1mRcM0fnP9SCx3/pfLDHKKBcwQlO2Y93U3
 bxKNHftVtKf5/kFqZkt/dsAAAA=
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696149465; l=2613;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=HtH6ZooiQZhj/+OvGcNzkDPBy9n4u+3X6ldRAYYPCDs=;
 b=at6YPXx+fOXZkwoEOETeXgA4z2Z7fCl2ihfE8DLduQh1rZ+hOCVx2PrRpu6RmisMIosh11dRe
 X/8cMgwZmxRCwBDrU1MwCJGbHMWaHhxInwRkeHGiRg+wtUfFFGs28GI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ret variable is used to check function return values and assigning
values to it on error has no effect as it is an unused value.

The current implementation uses an additional variable (fret) to return
the error value, which in this case is unnecessary and lead to the above
described misuse. There is no restriction in the current implementation
to always return -1 on error and the actual negative error value can be
returned safely without storing -1 in a specific variable.

Simplify the error checking by using a single variable which always
holds the returned value.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Remove fret and use a single variable to check errors.
- Link to v1: https://lore.kernel.org/r/20230916-topic-self_uevent_filtering-v1-1-26ede507d454@gmail.com
---
 tools/testing/selftests/uevent/uevent_filtering.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index 5cebfb356345..dbe55f3a66f4 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -78,7 +78,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 {
 	int sk_fd, ret;
 	socklen_t sk_addr_len;
-	int fret = -1, rcv_buf_sz = __UEVENT_BUFFER_SIZE;
+	int rcv_buf_sz = __UEVENT_BUFFER_SIZE;
 	uint64_t sync_add = 1;
 	struct sockaddr_nl sk_addr = { 0 }, rcv_addr = { 0 };
 	char buf[__UEVENT_BUFFER_SIZE] = { 0 };
@@ -121,6 +121,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 
 	if ((size_t)sk_addr_len != sizeof(sk_addr)) {
 		fprintf(stderr, "Invalid socket address size\n");
+		ret = -1;
 		goto on_error;
 	}
 
@@ -147,11 +148,12 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 	ret = write_nointr(sync_fd, &sync_add, sizeof(sync_add));
 	close(sync_fd);
 	if (ret != sizeof(sync_add)) {
+		ret = -1;
 		fprintf(stderr, "Failed to synchronize with parent process\n");
 		goto on_error;
 	}
 
-	fret = 0;
+	ret = 0;
 	for (;;) {
 		ssize_t r;
 
@@ -187,7 +189,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 on_error:
 	close(sk_fd);
 
-	return fret;
+	return ret;
 }
 
 int trigger_uevent(unsigned int times)

---
base-commit: cefc06e4de1477dbdc3cb2a91d4b1873b7797a5c
change-id: 20230916-topic-self_uevent_filtering-17b53262bc46

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

