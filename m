Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8D7DC4F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 04:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjJaDro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 23:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 23:47:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF980B3;
        Mon, 30 Oct 2023 20:47:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d2fedd836fso864775a34.1;
        Mon, 30 Oct 2023 20:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698724058; x=1699328858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Czgp9M/VQwIvKpJJ23KpbS/RwSCQYYhjyYgdFdgOC8=;
        b=NZlQpBYe62e1nkr3T8ApJVqrjfE1zKGFy+dU4J8SIfJFvuue5iN8XKbEO+lPcBHhqL
         XvlQJT29uWvpztkh02Uaan7LmkhXp5NcADPV617lxzqG2g3kKNkODi1GEBUF8lbE9OOf
         sO5THKLBUIYKUJfIkX0ahfI/pLdcSLLF681jsNprFe/E8QNPHqvQmQ0+UfQhBqfLGSlP
         M/7XdY+A9sPaUotYHa4Wx06hni2FizK86D9envvN+r5HyM/jPGCLrayNbkpU+ATx6oDb
         LFp3RGe8wAUnYFIHYiy8pqa9wki4Y0QAe3GiAfC3R/CW+nYAdLD8OOmdtc9k5EdmpGhN
         33/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698724058; x=1699328858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Czgp9M/VQwIvKpJJ23KpbS/RwSCQYYhjyYgdFdgOC8=;
        b=wtCorEm94yKYrbmR5vcJQ77PLYd3aC6RcolfeVzMGUcRxqr+4ZB/ZXTvzyJCvh0Um0
         gZelLvEmg53iXvtkOFtR4c8V3uKBl59svH8Y0lpCx2euSe3VOR2JsyliEf9Jbn43v7dW
         726itEpDHmTv+EdqqSViTeBdZ0t332Z/cm5kMXMzj5FVtcHgOWytiLwWs52ylGu+rkDL
         K6g/YNLV1+cCLL7PP9rjprrUluXbuN+/dBfaYMuymQ4DSBs6efG2KtagMzAO+roc6P9R
         oYbYZfaMAyx76IKcHYmvCsLvzOm14K9TWOahdnmk6h+VpBazMD/6FCRW3ZanpT8kG1Qb
         0SKQ==
X-Gm-Message-State: AOJu0Yw+OlNpSI+nYr8GIKW1P/7NMHBONCYAk1vG27QncX4Kqk6wg2Xn
        IrmiNR67wROvZa1x15EVglRLEp2WrEjx6dTZ
X-Google-Smtp-Source: AGHT+IE3aue1oV29RCABXc2jIZc4pTMk6701dcSvVJvWfQv3/Nq/iTZmywu+W2yFjG6kxzchA1O4sA==
X-Received: by 2002:a05:6830:3105:b0:6bc:c542:6f75 with SMTP id b5-20020a056830310500b006bcc5426f75mr16290902ots.0.1698724058456;
        Mon, 30 Oct 2023 20:47:38 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ei7-20020a056a0080c700b00682d79199e7sm246140pfb.200.2023.10.30.20.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 20:47:37 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] selftests: pmtu.sh: fix result checking
Date:   Tue, 31 Oct 2023 11:47:32 +0800
Message-ID: <20231031034732.3531008-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the PMTU test, when all previous tests are skipped and the new test
passes, the exit code is set to 0. However, the current check mistakenly
treats this as an assignment, causing the check to pass every time.

Consequently, regardless of how many tests have failed, if the latest test
passes, the PMTU test will report a pass.

Fixes: 2a9d3716b810 ("selftests: pmtu.sh: improve the test result processing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: use "-eq" instead of "=" to make less error-prone
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f838dd370f6a..b3b2dc5a630c 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2048,7 +2048,7 @@ run_test() {
 	case $ret in
 		0)
 			all_skipped=false
-			[ $exitcode=$ksft_skip ] && exitcode=0
+			[ $exitcode -eq $ksft_skip ] && exitcode=0
 		;;
 		$ksft_skip)
 			[ $all_skipped = true ] && exitcode=$ksft_skip
-- 
2.41.0

