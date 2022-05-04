Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E8519CC6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348003AbiEDKVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiEDKVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 06:21:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE26275EA;
        Wed,  4 May 2022 03:17:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so3399412pjb.1;
        Wed, 04 May 2022 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJYlzjivvg4x0LA1Mys7GMbCV8Bt3juMYK9Cy3MmoLU=;
        b=hFZ8k3oPcVy36TqGx81qIrDgEfDiMpr/cxI9lzfZB09NvxfRVSjw43tKW3b3athbVd
         sP9OtyEdQRbV2mBfEb+A2UVxLfZzQf4tQ1mj+SBmCieTLg9zNzkVR5ZfRJf/QYDoHPs2
         Kvhs98H4C+fZLdZp4nF36HzBqKgzuYMeOb2XfsQaRTm3/83euU6VsWVQ9HnVJ8q2Uy0Z
         SeTgiFLj6OVrDZ1msYiik4aW3dY4l+c/5QQtiI9kWrwtbtKUE3AsJqte42hc0Ms74sIB
         UGUY+8wpgRTqvUVskmJ+PFEUaWeegKaAP3XcIrx1mrRHzpyzEynJkqHjo8Tyx3ptsbGC
         ahQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJYlzjivvg4x0LA1Mys7GMbCV8Bt3juMYK9Cy3MmoLU=;
        b=4gpc7se5lsZPC5jfVtE3PLqeR8mOsIUdUZpKxmq6x/+fEsvbfCS4fq4nq3QYPOjDX+
         SZmjHQTJAAPGjZtuLlbjqo5AWLwcodtrkF6vcOPbgXbbDRLB2mel+anbZpC9K27k1cKt
         q4u6ejCyO/yAPDrvLQMykzEysHrsGzkDo6IzHc8Ka2Pn2mbPkSi3rTMnfDCnhOKQ2c+g
         BiCAS72Wr0azWOXswyi3l9ZszBtp1DXrMEGsapOo0i44l3dn8oTY0LhmCiayx6ZhZa/G
         opLw1IbXz5xb4zw2lnfOnHjeXnvCYnoAdaeB/F4EU1vEFgR/q/O+RGHFMnDAhXb4cPAJ
         5rNQ==
X-Gm-Message-State: AOAM5335N4Jlm/Rf07EzdFtemwGziGC0EIo6NQWNZkWZp2mQRlPHhika
        vdx1ejEIfIAlrpGEkjlkP8w=
X-Google-Smtp-Source: ABdhPJweibV6qmF85/LZj3tNlIhZzM880Btio6Uw/DjGCsKoGzm0TaZ6wRpGeD+TCxEmeYI2FOFPVQ==
X-Received: by 2002:a17:902:e811:b0:15e:b27b:92ef with SMTP id u17-20020a170902e81100b0015eb27b92efmr9982070plg.142.1651659452093;
        Wed, 04 May 2022 03:17:32 -0700 (PDT)
Received: from localhost.localdomain ([122.169.215.54])
        by smtp.gmail.com with ESMTPSA id j17-20020aa783d1000000b0050dc7628166sm7864781pfn.64.2022.05.04.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:17:31 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mqueue: fix all errors
Date:   Wed,  4 May 2022 15:47:18 +0530
Message-Id: <20220504101720.5201-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All errors and styling issues were fixed.

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 .../testing/selftests/mqueue/mq_open_tests.c  | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_open_tests.c b/tools/testing/selftests/mqueue/mq_open_tests.c
index 9403ac01ba11..c3cb40eae1e9 100644
--- a/tools/testing/selftests/mqueue/mq_open_tests.c
+++ b/tools/testing/selftests/mqueue/mq_open_tests.c
@@ -59,12 +59,12 @@ char *default_queue_path = "/test1";
 mqd_t queue = -1;
 
 static inline void __set(FILE *stream, int value, char *err_msg);
-void shutdown(int exit_val, char *err_cause, int line_no);
+ void shutdown(int exit_val, char *err_cause, int line_no);
 static inline int get(FILE *stream);
 static inline void set(FILE *stream, int value);
 static inline void getr(int type, struct rlimit *rlim);
 static inline void setr(int type, struct rlimit *rlim);
-void validate_current_settings();
+static void validate_current_settings(void);
 static inline void test_queue(struct mq_attr *attr, struct mq_attr *result);
 static inline int test_queue_fail(struct mq_attr *attr, struct mq_attr *result);
 
@@ -78,7 +78,7 @@ static inline void __set(FILE *stream, int value, char *err_msg)
 
 void shutdown(int exit_val, char *err_cause, int line_no)
 {
-	static int in_shutdown = 0;
+	static int in_shutdown;
 
 	/* In case we get called recursively by a set() call below */
 	if (in_shutdown++)
@@ -118,6 +118,7 @@ void shutdown(int exit_val, char *err_cause, int line_no)
 static inline int get(FILE *stream)
 {
 	int value;
+
 	rewind(stream);
 	if (fscanf(stream, "%d", &value) != 1)
 		shutdown(4, "Error reading /proc entry", __LINE__ - 1);
@@ -150,7 +151,7 @@ static inline void setr(int type, struct rlimit *rlim)
 		shutdown(7, "setrlimit()", __LINE__ - 1);
 }
 
-void validate_current_settings()
+void validate_current_settings(void)
 {
 	int rlim_needed;
 
@@ -202,7 +203,9 @@ static inline void test_queue(struct mq_attr *attr, struct mq_attr *result)
 	int flags = O_RDWR | O_EXCL | O_CREAT;
 	int perms = DEFFILEMODE;
 
-	if ((queue = mq_open(queue_path, flags, perms, attr)) == -1)
+	queue = mq_open(queue_path, flags, perms, attr);
+
+	if ((queue == -1))
 		shutdown(1, "mq_open()", __LINE__);
 	if (mq_getattr(queue, result))
 		shutdown(1, "mq_getattr()", __LINE__);
@@ -224,7 +227,9 @@ static inline int test_queue_fail(struct mq_attr *attr, struct mq_attr *result)
 	int flags = O_RDWR | O_EXCL | O_CREAT;
 	int perms = DEFFILEMODE;
 
-	if ((queue = mq_open(queue_path, flags, perms, attr)) == -1)
+	queue = mq_open(queue_path, flags, perms, attr);
+
+	if (queue == -1)
 		return 0;
 	if (mq_getattr(queue, result))
 		shutdown(1, "mq_getattr()", __LINE__);
@@ -498,5 +503,5 @@ int main(int argc, char *argv[])
 		printf("Queue open with total size > 2GB when euid = 99 "
 		       "failed:\t\t\tPASS\n");
 
-	shutdown(0,"",0);
+	shutdown(0, "", 0);
 }
-- 
2.25.1

