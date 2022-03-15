Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AC34DA5CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 23:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiCOW6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbiCOW6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 18:58:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9705D5E8;
        Tue, 15 Mar 2022 15:56:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r64so298512wmr.4;
        Tue, 15 Mar 2022 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24VtKr5EZlRUAniNrHl7Vqv7yBDi06kzFW/0QHQhnB8=;
        b=iOXBAO77/3BxYFKnUR3HJOj0oYwu2mPCVP8ro8d1TeO7WOc5+Kh2QIm4LdvrPudqmP
         qrqrcW3y/qQlOeFsejQIYAyQ2MR3JdPg41qlgHh+dFDn7Qx1mXD7adIxjt9DueUwZbvj
         CvaPHqLgeNznzoSypSlSrZJ3XB58BKfJFy7sDlG3ehc+eLpWCzcKTpDmOce7MUgDk6+6
         pNM+bgxX5z//NS4rZStaKpNhd3F0DIQiXJrZXl3VkfYRjb0rlrfRsH6BYWe8YieIzROL
         0lZIkySK+NCTeybzHBE/f87UQT+tv7b//Swo2qeX9tiY+wSNqyKfuEUAKvq1lpmXf00c
         w+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24VtKr5EZlRUAniNrHl7Vqv7yBDi06kzFW/0QHQhnB8=;
        b=O62r/36SdGqjKQYypp3ZBQuJdq7BQ7uWsSfkxaHn6NntU6H5zXkvnqWs20Gx6xOH5s
         20n8xMUsPBgnLisAMvjyQQABMf+Bd7eFAwywk8PkBU3osa7mkB8rM1iiD5szakFEx0za
         gymXXbxWBPgUMqu2KlBEeyGVeD/l48Mp+2GbhQ8td/PdVPr1p2DSYZlm46wIJhNz53gL
         LswRnBpJrOLRgFJmgT0vkDd3wcMSSGCl+yDWL7r7p1V/D6CpKyLEGvhNx+uBIXDSJ0pa
         arQoD5cd2g4qS4qz7W/746LREU/rKiufAArcaUnA+VXwQHbSq6No2apXDI1Jjx6aH2tT
         vTNw==
X-Gm-Message-State: AOAM531cYPnOBkxUzquua/6oBCy0FA99vMolLqr2ucLNmkl98sk9P+3t
        B1fxOVcDfKBFcLBazoVHDug=
X-Google-Smtp-Source: ABdhPJxxZGPsRiBZgZTSNbvIqcIom80atjiTUxAC5vg9WqZDEpWBmtueEfZ+7k4YNsyBiUizj6d+sA==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr5167966wml.160.1647385012614;
        Tue, 15 Mar 2022 15:56:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm150641wmb.3.2022.03.15.15.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:56:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kselftests/sched: Fix spelling mistake "hiearchy" -> "hierarchy"
Date:   Tue, 15 Mar 2022 22:56:51 +0000
Message-Id: <20220315225651.2963692-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 8109b17dc764..62b579b601bf 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -267,7 +267,7 @@ int main(int argc, char *argv[])
 	if (setpgid(0, 0) != 0)
 		handle_error("process group");
 
-	printf("\n## Create a thread/process/process group hiearchy\n");
+	printf("\n## Create a thread/process/process group hierarchy\n");
 	create_processes(num_processes, num_threads, procs);
 	need_cleanup = 1;
 	disp_processes(num_processes, procs);
-- 
2.35.1

