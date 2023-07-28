Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11F87678B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 00:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjG1WyB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 18:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG1WyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 18:54:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982D173F
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 15:53:59 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-785ccd731a7so30338139f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690584839; x=1691189639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gd1qe4QbPmGfO+Bk3+XG73JXlXmRvH7reO6CZtVAH5Q=;
        b=aAHrOOZtX4YkS5dDp6i00RVInJ/V8YYEPGFes6bIW0Fsm8zR37E2cKe1vRa68XDYXg
         eCLVnUvhRgoDKMWfuMZVUWXV5mhfMGrzT0x+os1CCmpB6QKV6vXiyDHyJHi8WZYmboqM
         OZ7g69zW0tivBmCTfqZtUTyD2S/GCx2bWvyFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584839; x=1691189639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd1qe4QbPmGfO+Bk3+XG73JXlXmRvH7reO6CZtVAH5Q=;
        b=VIFG6urV4G+eBTp/Op7MmPQbnMq2bktS+r6L7+ACqejvPukNhC+VJKATKUYKyCrkNR
         8On2VtUX0v7VtlGnIpzK5INA+zO3z7HqwbIYmffl3KvJ66yBXX1E1yVLyU0CW196pwkL
         YFSfxDNAD/4kGRNfV+mXNJEwZ+miZcxKLaSntOrAcxqujwu3LOTGEgmHpWzqp5Zt5Qt6
         KJrwoWfL+O1p9pXOtwDXKcHwtY86qhD0B+CLiNeIuSW+A2h56vBsOdda5D5r8LxY8Bb9
         o1K0Xz/omTJLESBOpjnkDSQ20UGxuJAVuVMifSZFof+sVaMxuaXKpx/39QJEm9cRWF2S
         OMgw==
X-Gm-Message-State: ABy/qLZ4H7Hl44c+S175gMfHw4W/dSv7+Ot7xbgUaBpMShU91abNxhho
        Tj3HmU7cQ5kNzwz1lsN0zCLMPg==
X-Google-Smtp-Source: APBJJlEQXrT7SR1MWYs6jOY15jiBZ4mcr+ymnQR0S5CeMOjSgotgPOLwXobrq/pJILhYpogyuroB3g==
X-Received: by 2002:a05:6602:3d5:b0:780:d65c:d78f with SMTP id g21-20020a05660203d500b00780d65cd78fmr1413820iov.2.1690584839167;
        Fri, 28 Jul 2023 15:53:59 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i7-20020a02cc47000000b0042b0ce92dddsm1390337jaq.161.2023.07.28.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:53:58 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests:connector: Fix input argument error paths to skip
Date:   Fri, 28 Jul 2023 16:53:57 -0600
Message-Id: <20230728225357.5040-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
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

Fix input argument parsing paths to skip from their error legs.
This fix helps to avoid false test failure reports without running
the test.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2: Removed root check based on Anjali's review comments.

 tools/testing/selftests/connector/proc_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4fe8c6763fd8..4a825b997666 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 
 	if (argc > 2) {
 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
-		exit(1);
+		exit(KSFT_SKIP);
 	}
 
 	if (argc == 2) {
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 			filter = 1;
 		} else {
 			printf("Valid option : -f (for filter feature)\n");
-			exit(1);
+			exit(KSFT_SKIP);
 		}
 	}
 
-- 
2.39.2

