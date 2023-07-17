Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5951E75648E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjGQNWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGQNVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C33F1989
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-314417861b9so4061399f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600097; x=1692192097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O90CD0u0WgrycTGhb5eGCR0q+HgrQYH4TPNauX1lK8=;
        b=FLgxa6CTqV5EDAd4NWtRxVZJtd9BzOkM4YnYrZxhRoyfwszQ6PIZw4d7MzhaVBm+I7
         aygLSbuH2U0fxWmjjFuOrugcKGElgW8HUxYj5Te2ECyY7GYkGAOqX+wwOqdWz5oFInOQ
         deWqCMCJTe/54KLXU7wKjW+ZJhZFWNdERAsZcGSpRv6QqzuLjNpsIEwqR5A8GPWBnIjl
         CSlSRtfd9ZXf5ZrLVQmGuUcAIrcp+q0vOd4HcmUP5Xxf4cYMhsGgAy4mGSSY9kfDwwZ4
         ZLoSrvwMqHKj+qTksPRLcjwvPJ5S7FCLE4DoDHMn7+sHOX9m+4RdKShmlPy+oWvB9osi
         y6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600097; x=1692192097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O90CD0u0WgrycTGhb5eGCR0q+HgrQYH4TPNauX1lK8=;
        b=Bygn5JDaC+ROpqhrJ7Kq7QpfS4FQ1kU3YhBXN4QICKL1D53QkM98Yfzfh8eXLFBUTp
         4yzy59QWygiJ3awMHwLm4pS/A5vGrW3buft4VeQM66MBXOpsVutxiskjInA3sfT5ywPK
         qP08yiiSx1hwczI9srvn4hfI9rbPKNgOrAbNXxuORY2Un4J/SsQZa7JFo+zN3//clepA
         n2hUGGDYyTyB2pQNT+4lRdELZgAY4oqG1XpxbttxBSI5IklPIExyE3e+LgsGLt29s6wB
         ugPtZy6ai+0tSM9o+Exwdro86hO3W3DCDplH0LGWmRNRu1shmfsZX+9HIJSAn4WWwx+S
         +X8Q==
X-Gm-Message-State: ABy/qLaUzU5JzHlWZqu8Kyo6YUmCcTb28pDoG6EBJuHBqzfWFQbd8bb3
        LjXYkum6oIaTho8/IVbwK0ysa1z8IX/IYlS7k/EXJA==
X-Google-Smtp-Source: APBJJlFHS98pnKg4uOyPDka5xuhIXBpMKhRe/tLeNajBbpky+jwUvz+Axd5eSOGSHLsc6xR3nJUwkQ==
X-Received: by 2002:a05:6000:1a53:b0:314:172b:a7d5 with SMTP id t19-20020a0560001a5300b00314172ba7d5mr9263581wry.27.1689600097647;
        Mon, 17 Jul 2023 06:21:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:23 +0200
Subject: [PATCH net-next 03/13] selftests: mptcp: userspace_pm: fix
 shellcheck warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-3-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=bRVvDDCCzFhpBiTbSaoJIqZXEcTk48OV9KA36DbkqKw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdahLD7yrn9oFfciPouPuC6DdRAES+TV/ZP
 4Lq5sl1qpSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 czzXD/9lmpQ+Z5ZEGiD/dYP+vbonTU1ONs/RQaajB3GWSEvnla16GfY7zBGu4nYLO2IAt+VCqZ4
 sLaVUfrpfOlzrsaQ3pcSoIcH0EaemcM3Br/cEECbmLG2Fv973Ucg6U+W7IXehv4Gb2iVWLu8uQ0
 72rfpA6yyYCSboJ0osBAzrMph4XO8fChJz8OW4QseWHR/JbFWNRBpKZKcbEzMhu1cTgOh+2yrwu
 Uzxy8tnb/D/UhgmiWu/EqN0qLJfNOsKijbK26Srfwdhqu0t2+QzMc6eX0Lc5Xet8xaoq5lQp56C
 Sg67AikUUPkDNP42cUg+y8P6YHDy7q90nYmAPFwQOOyV3pvilXPcpRloz0BibWau5MVR0J+003+
 XAWUolBGdBTkWEId0mh5QzXwxXd6XC9Jqo8LAIpc4cnc4c74R7JW5keGYk9BNxSpEYY1qXWlfHS
 OEmNyAHAYpVr1UaX1MdWgMe9g+lHmxBENEGSbu3xnku0jw9BPwBe9KXFm03hx553lno0EE0kfYp
 Gw6q/as9A/e85I4HwpRjV+v65Q5ZGHw8ztEy/IaKcjvZt5aP1USl8JiP0ufBBWx9xqX325WTFnw
 r2cl7TNMOmEokKnYRpD2l2ifJS4HJF4twLw+7U/lEuZhLa9fTq+kiRcTvw7z6/2tuNP3PKLjYxN
 vqnyizlTynKFY6A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

shellcheck recently helped to find an issue where a wrong variable name
was used. It is then good to fix the other harmless issues in order to
spot "real" ones later.

Here, three categories of warnings are ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoke indirectly via the EXIT trap.

- SC2034: Variable appears unused. The check_expected_one() function
  takes the name of the variable in argument but it ends up reading the
  content: indirect usage.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

One error has been fixed with SC2181: Check exit code directly with e.g.
'if ! mycmd;', not indirectly with $?.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index c57ce4df4973..63d348693e98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -1,6 +1,13 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it.
+#shellcheck disable=SC2086
+
+# Some variables are used below but indirectly, see check_expected_one()
+#shellcheck disable=SC2034
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
@@ -11,8 +18,7 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	exit ${KSFT_SKIP}
 fi
 
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
+if ! ip -Version &> /dev/null; then
 	echo "SKIP: Cannot not run test without ip tool"
 	exit ${KSFT_SKIP}
 fi
@@ -68,6 +74,8 @@ kill_wait()
 	wait $1 2>/dev/null
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	print_title "Cleanup"

-- 
2.40.1

