Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4EE752BF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 23:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjGMVRy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 17:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjGMVRu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 17:17:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E02D64
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 14:17:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so11173075e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689283065; x=1691875065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VAWVwpGDXDMLo65Ubj9cQ9CL/GZFLpXbrG0guU8ZAk=;
        b=R1OO/MLDlYuqf3n93Xf3dZ0JRKHT83rtvi6Aw9xfoACQknf2haLiKf3g1XekYARe+s
         zK0OwTVC9nFl5dK3x6irNe1Q/HtqnB8wAFyTNfMavMSP+wp7E3FZirFjt0SNTNKMkiTW
         9CerwuZBtoCpbXVb2Kttpe+0YOmkatXWXMBfpEvu0ouB4Alxdw+NglTInaXbs7aIesQv
         J+n5pnG3Wt0JoO0/1LsrTCx5HpvEi2bXw+8itAL3hsLnH7tzLASdWDMdYetDS3lilaBX
         OOC9awSd1siy1lSSnOw4suFFY0jxhe4Aou2N2BNs5K7mGy5vUMgk0vdp5ueNMrIQRy2b
         0aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283065; x=1691875065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VAWVwpGDXDMLo65Ubj9cQ9CL/GZFLpXbrG0guU8ZAk=;
        b=cEZb3HA8YiokPV+UF7K4q7MLMvgbdr7ZTc7kGO5EOWifnJ3Y+8+sQgXBq7XW4Yqwsq
         5kVpLBoRRr30dnLVWKDiYGS9BBecgLP1VQzMj+Iii0aD/QGJBLgCHPZhAkOVaQCLpOUF
         Hg7maNRRFnD3CK/rwXuorBM8vtpt7/I5maQHoSr1JyIr2TeREVowPASFL2FJCSDEEDI7
         6M9YrPNvjvJdGWQDroIs834U8XYSvBfuyr757vilf+MkfRAg+UAKtnT7BCU01e28SCTJ
         6bJnXuvIq/Wag/bGGgPETA+YH94nF0kJgEkR1pKjqDWg6hhisW+wq0IYh8VL2UlUK0Et
         3wdg==
X-Gm-Message-State: ABy/qLZe/z7NQTjyO5funuHTMrmZXUoPX7MWuQgtFrVKhTpUL88B7W3k
        1VF/4JPyJE/16CQ1yG6yHOvkXA==
X-Google-Smtp-Source: APBJJlGJfccKQX1JLE1xnHoeFIbj6RN1IT7Jy3v/iRsIf+J6yYbAAbYGO1wdvFHWqPoQ4vDsKW2zQg==
X-Received: by 2002:a05:600c:2141:b0:3fb:dd5d:76b with SMTP id v1-20020a05600c214100b003fbdd5d076bmr2479666wml.7.1689283065118;
        Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bcb94000000b003fbfea1afffsm8734136wmi.27.2023.07.13.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:17:44 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 13 Jul 2023 23:16:45 +0200
Subject: [PATCH net 2/3] selftests: tc: add 'ct' action kconfig dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-tc-selftests-lkft-v1-2-1eb4fd3a96e7@tessares.net>
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        mptcp@lists.linux.dev
Cc:     Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5L5yVXJPUIN5mPcgi9qNT31nW3zr8gj1H+S+tv1zJXU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksGn1Tfm4gXr9yYcL0NutlcfJMBFjlfmCxUnB6
 n3hJPa5tJKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBp9QAKCRD2t4JPQmmg
 c1L4EACFKJywHSS8y1HqKPLTPlIicSUIMYCQxyOjN6qcNyMopaA+qlnrbtgOAj42KDFZu3MthgT
 mLS8Z1bhO8ogUW+ylNbMvJ7wOGQtJ0ktZG1fpw0rTBXzGxwo6ZC+D5mqg0txCZic4wzLrWdKLJv
 tFbqRXmbHZUbx+D84kk1vvRoZH7T8NNC1lhMs+HT7YnvAAM8rtuBhXS/qzi4Fg0LQNsonm89cs+
 0LuGqspqLGYmmYNgIVnjHat5a4PvhiigGFZUIKoxuvKYpqpomA1ABKuzW0sX83aaX1Y78HsB2kA
 Cgjz+uaWswRZLbbq4ZU4W2imaqYsIviuxUXXgoiN/I+NI0Wtea4EJU7U0VKosQwRVwdCId2xF23
 1vZrhXoR7fh53jJ3xx5U9iOWD0u+tERIbKh642LijNnsPs/JA038YlnZGhabYTnX2PJrUDyVBKA
 fCRne9isCIMOkF6sTYeMkcyz8npORDs4aF35/TU7Tme/gU3alsPs0wshz/re4zOOdVVJ//soNRp
 fKVgMbKkvNrOKV6xIJQgQbK6EsPkTYBZHkQ3g+0n4TXpYMnRotatXkVvCmeDpHY5Mt/2FkjUWQI
 KsLLDiy3rxjp83IzCGzN6CwPCg3gmJ2y0e+yg2dc7U9Yw8uymMP2z+rUs3285uYSzL/gnTxVbmg
 480Z9i9gDVEZiuQ==
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

When looking for something else in LKFT reports [1], I noticed most of
the tests were skipped because the "teardown stage" did not complete
successfully.

Pedro found out this is due to the fact CONFIG_NF_FLOW_TABLE is required
but not listed in the 'config' file. Adding it to the list fixes the
issues on LKFT side. CONFIG_NET_ACT_CT is now set to 'm' in the final
kconfig.

Fixes: c34b961a2492 ("net/sched: act_ct: Create nf flow table per zone")
Cc: stable@vger.kernel.org
Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index 6e73b09c20c8..d1ad29040c02 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 

-- 
2.40.1

