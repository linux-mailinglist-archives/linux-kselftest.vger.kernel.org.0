Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD274792C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGDUo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGDUo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:44:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596610DD
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:44:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbd33a573cso33112955e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503495; x=1691095495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDHxKzuw+FQN3yqmvZTInWTuCOW02pUJl6ttc2wpkgY=;
        b=nDhOY1uFJRI7sTrPHZ2ISJa0InUVg0tW7CH5q75pO7s3duzK+LXUOe+NUypd0QJE7b
         jY/DONqMdinpTuwZy43GxqxidM4MwIHpGWHNedMf+8XGQkjSAyUDDVYCqzI643dncPUs
         nxXiB4MkdlqBZ2c1MCLtMVdc4t4Bt7Kxag6OfYkAufQMknRT0ymGXVTRSNflXz69UylA
         m8ETwddi2XkrCP5IilBIuNpMXVGhvyGtCa2zKBRJw9ZqxRZImhWCp7B8G+V8eUw+WqIT
         bcIRT+1R18xEWEEbXEMOANvdKf/zHJAHHUPstjhuinqaS3LGvGYblF8i3ePzCdubnN8j
         7T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503495; x=1691095495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDHxKzuw+FQN3yqmvZTInWTuCOW02pUJl6ttc2wpkgY=;
        b=el9hqktHFw+tPmgfoWnONkSfHvd9bhI7Gf7w0+tS1TLP2Z2fZIPP4AEsgHT9lt1GOF
         BW8gi3OW3b72IoldJOkzGImz+3KHEH5X2LfozuXu0LuOUmQEOmt8n4MeoEoRuccucf5+
         hsUZCaoRHmRyv3Ykgp0dw5eMRBF21exagHa7JsG0dh/Y29YpBTw0EUqVVJQ2sY7Sqqxv
         Nl8oAM35Dny6Tjayl4a6EmHGYUNYiKYmxop4DDC1WEEbC6ftTFGEvSu1WtgxgLPvv6hN
         U9v1npj43ZMmnx1SliwpiZ0g29R5+UN8+3PYQitn/PyYUNRQFQu8UHBfHiByNF5ANNPV
         eDgQ==
X-Gm-Message-State: ABy/qLa9ZXnJB7Fpu+sXoJNxc2qUzEqBkhmMF+mYQUPvx+zuH3Bjuilw
        gU3YP5KAp5GpKagktuF6WdkBCw==
X-Google-Smtp-Source: APBJJlEDq7kPaqBJhj2tw4QTQfhouDPD/kuwj8ANuALjc+JfzPIfriVuSKT2j98z1RnqW9eGxTcvQg==
X-Received: by 2002:a7b:c849:0:b0:3fb:e4ce:cc74 with SMTP id c9-20020a7bc849000000b003fbe4cecc74mr922840wml.8.1688503495554;
        Tue, 04 Jul 2023 13:44:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:35 +0200
Subject: [PATCH net 3/9] selftests: mptcp: connect: fail if nft supposed to
 work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-3-d7e67c274ca5@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=0Rssl8kPQuTQe6YW3ClerkSvvyET5dErT/6Ju+EMAIU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDsXCQh2/8B+/EEQwajr3UOcNe0KC1T1VSR
 i0nw+qmmjaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 cxI4D/443M6kpFU9MXcEibFvfOqfGe5agpWmRjTJYh6sp24Jx/FKUz8oIdKF/NAAYU+93dPU23k
 ebgFzK1lBnh63Sr9L6l4zCPEjiGz2HGDn/qGRkc9KTsXvdXyKnQWlv7etoWbRtnDMdD4R/imLvN
 +4RitnVQtMHdTor3MM7U7RH5ZxhRnbXJwv9DzWwI3HoK0gAB6Rryu/uqOdaivvuviZHpWiZpv7y
 GfvU5zB7PIugU3ob8XCldTysNqz8w15gho6rmnStFGT8OCBxdBmw6vJ/Gf/djsqV8peKlIQk90r
 QAUaYwvf1ufJBeTZtf6nakm5RI+F58e4SQ4/D1RW4TJijMZUVhkMwdbysGPbFiA9zIVUh3rXZ7d
 9rDx+3+ie7rJNV7eo1moNdFQW71D1df78NrjWue7+otlGnpFeDXgKq4m8hP/gHdnjCHwvzP/we5
 +kWDY2i38TNbQSdecl2hTBEqCfTH/wAzlGA5jAnW6zjcDFBlrOcFh0yxvX16Uz5FJ3vv0AsT8O6
 gaIMoB67IlQELv5IMHDbrjH+jXNU2WHWVQATqIug0W6oI+9WwgfKPju890uywfPiqdzsL+jCL3/
 fesPuICLiiwDZBqnjcosKs2E+MSkIBigJLYrake8h/F9EZQNml/Ie4o8D8qwiGzUCI11klKMS27
 Y2a1MOZQrAqodHg==
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

In case of "external" errors when preparing the environment for the
TProxy tests, the subtests were marked as skipped.

This is fine but it means these errors are ignored. On MPTCP Public CI,
we do want to catch such issues and mark the selftest as failed if there
are such issues. We can then use mptcp_lib_fail_if_expected_feature()
helper that has been recently added to fail if needed.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 13561e5bc0cd..bbae40882bfa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -718,6 +718,7 @@ table inet mangle {
 EOF
 	if [ $? -ne 0 ]; then
 		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_fail_if_expected_feature "nft rules"
 		return
 	fi
 
@@ -733,6 +734,7 @@ EOF
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_fail_if_expected_feature "ip rule"
 		return
 	fi
 
@@ -741,6 +743,7 @@ EOF
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
 		echo "SKIP: $msg, ip route add local $local_addr failed"
+		mptcp_lib_fail_if_expected_feature "ip route"
 		return
 	fi
 

-- 
2.40.1

