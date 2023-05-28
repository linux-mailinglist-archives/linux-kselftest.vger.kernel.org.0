Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B1713B36
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjE1RgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjE1RgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 13:36:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E0F7
        for <linux-kselftest@vger.kernel.org>; Sun, 28 May 2023 10:36:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so16817005e9.1
        for <linux-kselftest@vger.kernel.org>; Sun, 28 May 2023 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685295367; x=1687887367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6K6x3Lobx0QTfuXnuqsexfdlQfCdQatiGE2P4TfjVI=;
        b=1QNqfwAjXGQ8lj2nB5KIJEJmvxLxHIYpQbxUVsUqP2hXYqLY8YF9bWvlvDvJJvniZw
         +7IVEf62g1bXPANco6ACu2HGPUdYUwFbmCSbLsIMTOnkIN3ExZi0j/hWxI/pX1Xn/8A3
         0PvzI/vfNHo/wqbMyyqoclkFtL1XSiI/+QtjbB2D9LiUQxZaODS+5bHkg2inokEhv0RB
         SLjA5tdQ7CZ7ZkzC1CB8qQceNwzQKgPRQvkKFczsDal10uZQ4lHZTq3d3lWnKg8UPVZW
         jhG3WifxxGHGRfKJFbzmAWRNtYTYfRFSRDg7DRrrIE+vil1Kqs5tBx1qPg1n5B3Fjaqa
         xb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295367; x=1687887367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6K6x3Lobx0QTfuXnuqsexfdlQfCdQatiGE2P4TfjVI=;
        b=M6xlxokMz1u6soVfjCg0yu7lc0r6IoeYAR3hvwZzJNA+cpcnhWqHtOMVdg7kibpTQP
         S9yjkWv5byynBQFKhmX9zQHoJUy5pFvrKsp/TVwYU1hXPGMbjL0VH8v115ntLz5AHkfE
         5D1dtY7AwES7/qLFf8YoHcB/1zHD6o1d1GmAvojoEuscjt4AlMvGQoVG281agjsZa2Xf
         5I772qV1/kVpnMR5isZ0fDpwH9cHPvGuN99etJrflHlnlM29r3Q3FjyxbZfPXvoN6Uac
         oljsoilVFf0XrB6pSqF5c2LiHI/cH2pF7RHjsnxCK8r/QFUV9qlwzv8Qtzo4iCqOfq2Y
         IgxQ==
X-Gm-Message-State: AC+VfDzRvQIcRCARIpxGc7geVZRR9B5RsIVMEkyHACKN+nRtmQH/0rdc
        P/Uzne+3LojXXdmf/xu8o7lPSA==
X-Google-Smtp-Source: ACHHUZ7ipPekOxIVl+/vcHnk0wij4tsKrVczygDe4bbcE3GO+crMQNmH7SICENpMQ6WXDLpv/vpH+w==
X-Received: by 2002:a7b:cd89:0:b0:3f6:4ca:479a with SMTP id y9-20020a7bcd89000000b003f604ca479amr6674402wmj.21.1685295366744;
        Sun, 28 May 2023 10:36:06 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm15334523wmk.28.2023.05.28.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:36:06 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sun, 28 May 2023 19:35:29 +0200
Subject: [PATCH net 4/8] selftests: mptcp: join: skip if MPTCP is not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-4-a32d85577fc6@tessares.net>
References: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
In-Reply-To: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SsOVrl07HCP7CyVkUoTtr6mVX+4hyXcjlT17Oj+pCOc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkc5EAs5z14UH5i9SlXEU/9nZD+c+nJpPDVd5gA
 5kFmMOf3q6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHORAAAKCRD2t4JPQmmg
 c0NhD/9X52SIPSCiXlegDZgEHVwg+6nivyNN7FOPblEzYOK7A3anDzDzxWD9MJNysOx+s0BSk3/
 gnAaKJC82nShOtmRhwqhCMt1OGTZaDXTPg6fzWWIeX9qaQMwTxRTfXMO46lKJzSByKV+r7Ah8h6
 9w871ERRkVAQnSXHj6cPToI64Sxp8Zs3Jxc/A8gqY3vJ1csYojcYHh4QCGvAc88pNLVPbsw45kV
 5JbfJlvyv/JQySCQsywmXrfEYmCS0PG2LoQWQgUWRsCY82zeKtxeOldOPcVhvz4o+wQJBS4ttIF
 F1us8YaJZlUiLt/NWaFBWBoc1QDluWwG4mMqT0c7X0YFmSDutMyMutdEosQr8ff/7M9MJSM+H9A
 xkceWuQhFp24c7SrCWQ10Dq5NqsdaqRLPJLKaQbNcriVsbRQZvvDCWMMSUsv8MW8HsWZY3grBpn
 4w9pbqILgEfrM6gSQppKROp4B/M40zgBvEPuhtg1fb/43+xWBMzL4m39JhaeGpx8DH6UYShSk5w
 ffsUbi15v1jqDcqnTjUqtVxNKGzjv24Ayk0dlGxPJxMEz5BvpALpvy3H80ElskzrZBVTqIr3/Fq
 I9k+pqNXmmNTZrOUM2iEKpUM9P91M8+pkfXdrGze+g5bSIjGbTtqIeLTumGGF1upN6+AuzfQxkL
 wd/fWhaRoN7lzdg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4f3fe45f8f71..96f63172b8fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -10,6 +10,8 @@
 # because it's invoked by variable name, see how the "tests" array is used
 #shellcheck disable=SC2317
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sinfail=""
@@ -137,6 +139,8 @@ cleanup_partial()
 
 check_tools()
 {
+	mptcp_lib_check_mptcp
+
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip

-- 
2.39.2

