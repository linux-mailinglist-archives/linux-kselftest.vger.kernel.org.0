Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9B76735B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjG1R3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjG1R3f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68E35B6
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7748ca56133so23307039f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565373; x=1691170173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuA89WjH66+oRZgNKFoC7RQpjlgTsdzDJBprqnr0FHw=;
        b=IAy+tr7webKUVIYTbYZ3+jMG9e+SLvCy1lRwlIA6odcD7pfpmsLH4n/Zmptj2QKAN+
         MjcbIvWBxeRLPNXObo+QhSNvUR5blz1BhmX5B3NYGTkyP7ONmVDuirYJxkDS8cx73hj3
         Ox5zA+1aTG9Feo6KNRFjFnSS8qc0eIoTzcNL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565373; x=1691170173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuA89WjH66+oRZgNKFoC7RQpjlgTsdzDJBprqnr0FHw=;
        b=gL9i7hDlS/sxLOaYVLaLh3fIEJcR9u4jiCuaesMMd7o0Zzctwlt+3PJLYsFmBBWsl/
         7977wpyUKAlT8xnwY7L0ZgPWFeHqPb/ElcA18D8hHRBrhfUwCpNM6ojkyzELpQ6Ozjto
         7YPChndXBy/KTPmJ/KvN7q09/ASvSjel0JqQTl8swAIXGk3X5NFyFgkyyWBLEkco2Hk7
         JS3HhPrilCT9AX1XOXU2WRKPhxzC/+SAiVhZknpymc9HpIHAPQ6THBnvAyusyWcpn0Ab
         9gOQllxz6DOHQfA9WO6u1D7Gs2Nyz8CcFqtkRZEmSBwTplHOPgChwZ8FySfOuZi17+qc
         xLTA==
X-Gm-Message-State: ABy/qLYSHoHR6CYSwecMesdnGm/zXBnoKkgBbF2grJeNXz/Sq7Lesq1w
        8K2AMV8G8HSRVKM7rYqQynfpJQ==
X-Google-Smtp-Source: APBJJlFzdMGCDX1zblqKU916FlQ1jnF3KuGDuuZWNWcFedwwUFsC2XmS+hROGqQpBAcHWPUDGJ1cBQ==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr339316iov.1.1690565372907;
        Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next 3/3] selftests:connector: Add root check and fix arg error paths to skip
Date:   Fri, 28 Jul 2023 11:29:28 -0600
Message-Id: <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

proc_filter test requires root privileges. Add root privilege check
and skip the test. Also fix argument parsing paths to skip in their
error legs.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4fe8c6763fd8..7b2081b98e5c 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 
 	if (argc > 2) {
 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
-		exit(1);
+		exit(KSFT_SKIP);
 	}
 
 	if (argc == 2) {
@@ -256,10 +256,15 @@ int main(int argc, char *argv[])
 			filter = 1;
 		} else {
 			printf("Valid option : -f (for filter feature)\n");
-			exit(1);
+			exit(KSFT_SKIP);
 		}
 	}
 
+	if (geteuid()) {
+		printf("Connector test requires root privileges.\n");
+		exit(KSFT_SKIP);
+	}
+
 	if (filter) {
 		input.event_type = PROC_EVENT_NONZERO_EXIT;
 		input.mcast_op = PROC_CN_MCAST_LISTEN;
-- 
2.39.2

