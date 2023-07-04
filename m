Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71374747926
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGDUpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGDUpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:45:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4AD10DD
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:44:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso73163035e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503497; x=1691095497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2bvJB/FZnxo5jzEr4QcC8QklV4qR/ytDAB3uSZlV1s=;
        b=tpnnQtsF4wgpEDKgyTJ6ed4dl6w5FMipqzLOw6tx3Dnaxk+xjQG7Beq2jlvysO1P7o
         OW8iUB/ERBAFCOOGej3B6rOkfDoif4r4Zh3pxBcFoV5l93D/slqdgHtMD2sHMyAL0Bkc
         wV0RXaI2CN8PJ1Ju2kf/7uyuIDwcmFSLunWcAYpV+/LVZNJbMNngdbffUhv2709YGwuv
         i9qu67H0F7BTc9FEJ/BA4ZMePXsbnHoHEHUpN6yJicH12QzYzwDxeD4iSAXIT5ihNXXJ
         xuJqQ0PCgbEg4hiEZPE455N+NDVIB+LwDqTXVv9Crk9CJVpVUE78va0Q6DB+O4Lvnbs/
         0hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503497; x=1691095497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2bvJB/FZnxo5jzEr4QcC8QklV4qR/ytDAB3uSZlV1s=;
        b=AQGDhY38K9nDmMrLAR37JGW0KkI+7cz1vlOKOhXBjXd+maKwxp6udrle4JvkLBP66Y
         wWMO3WmtSvk9iLZpi/TE6etLk5N5sG41xFQWiXwu9Sdke6vQjyvrhXGSAiXVIb7bG7hC
         0zZCrHp80NWWfm2x2vMoKnySZ4ES1LqBi0SinnmUJmY7uk8LEoHWRMja8Vm0v762BRqq
         MM7gSwd7gYvjbXahO/eigCmGtNDlbmir7sJKvpooWyUMENtKdAc3t9gzy4TQD4UQkKOj
         nqZASSsm3oZBukPqq6NT0lcSw4xS1f78RkljeOvi4bZv6oidPu3GUCXMWxASv9QAzjQz
         aBUg==
X-Gm-Message-State: AC+VfDyQ7og/O/88eVWZP7s9aZhzCVmSSbH0xyY/d6hLUkYP5ZcUUlOJ
        QfIgPcdvS6NDMhtLvqONLV+81A==
X-Google-Smtp-Source: ACHHUZ5bU4qTTBJWpOZqM4B76rYJNoQTbEgYmNSim9mT2Ch4eVvSPN9VMvJO0RqepPhhLmrU0zRQTQ==
X-Received: by 2002:a05:600c:ac6:b0:3f8:f1db:d206 with SMTP id c6-20020a05600c0ac600b003f8f1dbd206mr11700790wmr.25.1688503497372;
        Tue, 04 Jul 2023 13:44:57 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:57 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:37 +0200
Subject: [PATCH net 5/9] selftests: mptcp: sockopt: return error if wrong
 mark
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-5-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=/4aVehRRev3S9W7xO/C/bt4X/bbi2VBYNMNB8ebnj08=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITD88GNsyzRs/Tn2r9ymESxt+KclVLdGUYpm
 d1byI6+yIOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c0nID/9d4QgKyGlEbMrwRLBaFKGQcBe2iolm2sR0Pv+l+rfuo8J5Xv1tBKHCOHZO+Og2P7XmlwR
 hc9j2ftf6IDaJpm8S38nnWV1QYwEWnzUgqroiN6a800Tw6vfTi6CInIZMAMuRSTk8aPn5Bquhpt
 XmIaqKbbUJHtBacCcCd4d9biN1+83oUlTlYMyLtPNIwQqbzwdtiAanCKy6onN5mQsMNBrz+dk9s
 PDu4AK3IMI/3WYlET+WCiojzkSce7xOW0jbTYkJT2C6BPjsi2fCXkdmj8C16JALj5uWSYf2zhVn
 OSGlpujXdlnIZCO8OJkOLvp8R72USRz1T6fVIUqjn0x4/Bk6nDpDzyBbyb9azy8J4b0jLssVLRH
 OIgJZQc8j5vk6d7et8sW5X0O+qHE1KHgy/KCJc5qt20KwMVpSokWzvaFEV8AiEgGDEgu9on7OEH
 JN5ZaDgFrmbIUSobBo4czJlM/IzzP9PKDyC47Mv2fSj8uvCesV5EmvpcZF+z6oHPk5BkqoAg9nU
 lF0jWWjkiMOR/uCsO2YccugMiloIOPB0lFB6wYvNzIFJ/hBUImx+acGsi1ETN3CxeOGtD/zQsqh
 cDaHYvsj3UY7bSKgtuXx39DiIH+x2iW4l00vEAfTxhV1TeklUoeHc/UxObBBols6NEOYaqRulBU
 MvrmanPtSkYfADg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When an error was detected when checking the marks, a message was
correctly printed mentioning the error but followed by another one
saying everything was OK and the selftest was not marked as failed as
expected.

Now the 'ret' variable is directly set to 1 in order to make sure the
exit is done with an error, similar to what is done in other functions.
While at it, the error is correctly propagated to the caller.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c21bfd7f0c01..dc8d473fc82c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -128,6 +128,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			ret=1
 			return 1
 		fi
 	done
@@ -227,11 +228,11 @@ do_transfer()
 	fi
 
 	if [ $local_addr = "::" ];then
-		check_mark $listener_ns 6
-		check_mark $connector_ns 6
+		check_mark $listener_ns 6 || retc=1
+		check_mark $connector_ns 6 || retc=1
 	else
-		check_mark $listener_ns 4
-		check_mark $connector_ns 4
+		check_mark $listener_ns 4 || retc=1
+		check_mark $connector_ns 4 || retc=1
 	fi
 
 	check_transfer $cin $sout "file received by server"

-- 
2.40.1

