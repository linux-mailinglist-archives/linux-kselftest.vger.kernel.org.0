Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481267DB65C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 10:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjJ3Jq5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjJ3Jq0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 05:46:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF313E;
        Mon, 30 Oct 2023 02:46:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2956839b3a.1;
        Mon, 30 Oct 2023 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659161; x=1699263961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qt/HOKHOh/EIoMj31tq2KB1WSLaylYnzKSJxpWkse0=;
        b=jD23SJwEnddN5MaIBuuG8VG7+j+LFBd/vtZRwXSiaZNYVll10lYCCNhbTlAiXcYxCy
         U4UMTqEXckD08yqndiSJxQkEz0QZEFsLE3PaPOiJVTAGQLgC4accOpszW02/uIUtBKLn
         ti78ocK2FBpnrHFYzK9XFEt8VZolEBpLuOoslQKZ+dh1TuC+40ZpgKcnFRf+FQo9UlsS
         sb2fNTDwPaxgaIkc7tzkKgLGTeRCvKSDVcHXyhQ3Xki9tUPsDyzxq5/HalC8eA3zAnvB
         2LhpHjFMj/YFYYnKm2S8ZkH7btvyWWmcI76oyzCk7e8h+k6ktQTU1gczFnfqZG0UKBQm
         Qgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659161; x=1699263961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qt/HOKHOh/EIoMj31tq2KB1WSLaylYnzKSJxpWkse0=;
        b=tu6hmXPYckI4AO7Xpjucw/aqw/uUAihIYS8LMY9o6EYBQ3NolV9brR+Ul9O1cmqAAM
         LEySYfHR6BCMToAEVp0JGWeTgsy/6nkDqAKY9mnP2rhno3xWKB/fu3kUsX5hWrAcTSYq
         AqjGWPC4ml8oHw671mfWpTu3zM7NsFVT34DSo+q5Z8Z2XvvENz4qkI/VkgtXHRoZKV1d
         6al0iiIndn4dDvPtx9V0S2f/gE7TJ8zr9i6/Jvk2Rh7Ukhc3tsKuVPOZdyvo8sFfq4kb
         cKXuE8ZqHrTL1ZcL8sADePtW85zURIYOsypMbnlm+gK/crz/yG6Lx9QIV3mMBtL0ao87
         2qMA==
X-Gm-Message-State: AOJu0YyvJrlyQMKFXpzUI8VyQVvILKwla6n6eHNAua3FbIkwJHps83Xk
        zLwzc4s3WdBSetJXXOo8C9BHnqy+JI7Owop0
X-Google-Smtp-Source: AGHT+IHda227dLb5xvfoFxbvKZx60NqI4jMh7xM9cDab5JG8z2312iqgR4pl7TYWDcAcsMxCp2YbcA==
X-Received: by 2002:a05:6a00:26ec:b0:6be:c6f7:f9fd with SMTP id p44-20020a056a0026ec00b006bec6f7f9fdmr15652504pfw.11.1698659161182;
        Mon, 30 Oct 2023 02:46:01 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r17-20020a62e411000000b00686b649cdd0sm5528142pfh.86.2023.10.30.02.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:46:00 -0700 (PDT)
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
Subject: [PATCH net] selftests: pmtu.sh: fix result checking
Date:   Mon, 30 Oct 2023 17:45:55 +0800
Message-ID: <20231030094555.3333551-1-liuhangbin@gmail.com>
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
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f838dd370f6a..b9648da4c371 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2048,7 +2048,7 @@ run_test() {
 	case $ret in
 		0)
 			all_skipped=false
-			[ $exitcode=$ksft_skip ] && exitcode=0
+			[ $exitcode = $ksft_skip ] && exitcode=0
 		;;
 		$ksft_skip)
 			[ $all_skipped = true ] && exitcode=$ksft_skip
-- 
2.41.0

