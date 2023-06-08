Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4672855B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjFHQkZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjFHQjq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF935B5
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 09:39:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30e5289105cso663578f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242345; x=1688834345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kh1r2jxB7ScuO/6zF4R4uXq5Ks2IDFHVjEbkZQpHayQ=;
        b=RKqKzS8QPbGaeIBMGTZRNc05LSqhiwAp4jXdLWKgA4QtgOPYxhnnAXoS/zIa1FRHzw
         SJI/A16CDCg+8s/QqlgRmOhnNEKdnSuTz6l26p9ojwJS5NsNAtxLH6g+ifJm/2lqHyQ/
         KzHSGSa12I2z1pPhxb7eioT5ThmWWEJ/Ee8e1WPT9D6MqhtsJUCEacvN/Aq0K0c3+INl
         CpvLO7ZA3+hAPHt7zXK4+TNfQD1UF6A63U9yFbGBdwqjPnHBwsrdVGV601r1ODsTP8mR
         TDsiaEYiJv3DhxydZKT/PQ05An43Sw3KFh5x3N2ElnBPYO/pAhh2d8OquOH1P4TkuaMk
         trWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242345; x=1688834345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kh1r2jxB7ScuO/6zF4R4uXq5Ks2IDFHVjEbkZQpHayQ=;
        b=bBi45P3XNzEg2l4GkyXIGmEL9SyYlaAhpkLIgRIqRIxCJ6J/IvjBhuxdTcCCmXaBnO
         22/9JlaRjKFITJSwkYG6l1GipLAgP7Xg+0bLWszvoKAKhhlb0tZZhid6lRTh7Ml6/Uu/
         o3njjjWOODc7ioyJwbjBrlD62Kp5+5Fw7fKUILNMmacvO3zEXnMfEOXhm3RnLqLVu7p8
         msM5SZ8SrffJKuqn8dzfrqI2SNwLkwRFur5ndoP9k4YvrAtM7CugBqA+zCF5BX9d+eQp
         DEhnSkmbKyYJrFeMC4kVkOCBer4imdBQsTElvljiBXT8QHePm4LGk2AB0Hgbhkxt2qHG
         ACQw==
X-Gm-Message-State: AC+VfDz7K++u5ido+dKw0Ne8qa+cSULIp7+pjKYuDq96VCx5X0J8ELS2
        dPGQnGvLrUe8OeErNfwa5LxeKA==
X-Google-Smtp-Source: ACHHUZ7tnKmsx4hYMI+pCbVjaBxTj0d1u3pf22ESdyXQkXihNLJxr3z02asgW4yGdc+E9apx/5T5yw==
X-Received: by 2002:adf:f9c7:0:b0:30a:8e58:7955 with SMTP id w7-20020adff9c7000000b0030a8e587955mr2292429wrr.13.1686242344924;
        Thu, 08 Jun 2023 09:39:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:04 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:52 +0200
Subject: [PATCH net 10/14] selftests: mptcp: sockopt: skip getsockopt
 checks if not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-10-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Dmytro Shytyi <dmytro@shytyi.net>,
        Menglong Dong <imagedong@tencent.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=uRooKe+CzLnbd+RolTp1KPScrbpPmueveZsvj6eHVbc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQaCPNceWDOur+3v2zawhBoDqTcRbUXxos8C
 qPz2ZqvR7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 c40+D/0Xggte0l8UQZafD2aZynfUG/9JaLeHYjbwxPH/3cUBzx2qqOfLuegnHPdzz6jRinLi47J
 hX6k+TzdlvwJvFx0xuAvIbnyUVY+W/s7N0xXKZMTWA2erSbhdr8rQYprDFlP8YWCt3F8TiCXbfj
 hm2Fmuk6ic7ik4U3zTW7ptIMPlhoMqmyWJsgEBXy/9L5APoVQyF6lfAV61NY+mmHe/Brviam2Yk
 e8Hc471uZeJPPw5bCbgVvfdg7N81OgOtKjh1o1eKeh9E+77D2L/c04fjOk9/RnfJq5fs0wNrnj+
 iae6vhgbzxC1Eau9UuqMzwQdM8wUI5qrdp3suSpAdPYYDqYVLkex9b2dhkd4nawxW8O1QEn9Qz5
 hSTipJubRm2mnKAfoOOo3OCBJ8xwuhmJveyd3JuTBAThrkKgPcVqaxtL9DdrWrny9UbMPkUzTaZ
 eMRxOC0KjXrN7XbYRUJjvqoSXFWuKZoIItqtGHMaMbc4OG+aU8whOevwNnsrFaCM4gY/lWBDY3Y
 K2wxo+iSBNc6m4PBvyz2eAyC7fucRBt4i3xX198srFx8AsK8fSZRpRoZVeq2Au5jK29N0N08LXO
 TJYSQt+8TSyBeFi5e0E5V9bGFeoZYN5w/u+6KY/sXl1H/GOeWBnUS9S2g6ybIw7wIUlpI/mv8c4
 6vis+MPkfQtVJmg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the getsockopt(SOL_MPTCP) to get info about the MPTCP
connections introduced by commit 55c42fa7fa33 ("mptcp: add MPTCP_INFO
getsockopt") and the following ones.

It is possible to look for "mptcp_diag_fill_info" in kallsyms because
it is introduced by the mentioned feature. So we can know in advance if
the feature is supported and skip the sub-test if not.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff5adbb9c7f2..1d4ae8792227 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -87,6 +87,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -253,6 +254,11 @@ do_mptcp_sockopt_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
+		echo "INFO: MPTCP sockopt not supported: SKIP"
+		return
+	fi
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 

-- 
2.40.1

