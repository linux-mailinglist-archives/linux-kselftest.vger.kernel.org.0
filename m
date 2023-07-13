Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8C752BF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGMVRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjGMVRv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 17:17:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31002D6A
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 14:17:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso10047295e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689283066; x=1691875066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsJALsxCC7W/CAsd1l447Gkg4QP+b67KVu4aEHXx1H8=;
        b=bt3cywbmI2xlzlVR6vRTSp+EcwPMU/Po0YAkZsTxYd4qeBDWmBtWWW1L7ZLZu7/Rp0
         /rorCNOUTXNVUWcLrGeCXbk9yTbznrWpdKIZ7g9alJTVVuqw2gcb2COuguuFWoQ4WVon
         8Np8h5Mwx8NsaQNfcxYyX911xkWytdrDTsxbw4eODsgaFgUIe4+SqpMumx7RaLTQ5+8X
         MIOFF8AO8Bz0TWAlXVTJYgThE16Hn01Y+16mpzsUXW83Vbix9Z+QtRQAytDsiOD3+9vj
         z9e71xvYt+xLgB2ItMz8f8lLgv4n2Y8YAhJ+U0f4CoRe+c31H6HDYo85nab2G+EVApeg
         4c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283066; x=1691875066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsJALsxCC7W/CAsd1l447Gkg4QP+b67KVu4aEHXx1H8=;
        b=WhBeDuYseTNLkk3cVPxBdRYavRJQvQsmXOxWuhTQYWBDFmtrLpHufIRYGmG/Z1JL1K
         94xTB9XSFrVoY0JWa33F6rKRyott1AS5cubRVg/JZ36ucdCsFwmyJfSRwo3girzFK0TD
         1/JywgS+gf952oN8CLTdy/KZpzNslC7dMJkQYjNMna4rLFyLNgZX6JdJxW/KiXS23+l1
         /17rF0PILfLgq0k2Ujt3Qp6IJiyOa3adAcg6xuY46aZj0nFKmheCSsXeQwgQsi1zSEoM
         n8rjTX6Gw9ZZeDZmabFBuWzZ8xGuYBiBLtIc5531Lmlh8cj1yYVfTUkbSk8fBwP1wDp0
         89Yg==
X-Gm-Message-State: ABy/qLZZbTJKas8bhChXyobpfgoE0YU4A0+GiRdhu0r170f6AddkDQv0
        9IM9mfd4iX4yYQSaqPR+F+3fJg==
X-Google-Smtp-Source: APBJJlEqHDqd/DaR1zZg8FeNIPs0jDRzB47sGZJXntmh5xucKXav31Pxi0b1G9aQg7Zs3wM4F2CWHg==
X-Received: by 2002:a7b:cbc9:0:b0:3fb:e1ed:7f83 with SMTP id n9-20020a7bcbc9000000b003fbe1ed7f83mr2882825wmi.33.1689283066347;
        Thu, 13 Jul 2023 14:17:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bcb94000000b003fbfea1afffsm8734136wmi.27.2023.07.13.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 13 Jul 2023 23:16:46 +0200
Subject: [PATCH net 3/3] selftests: tc: add ConnTrack procfs kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YxZMkeKTSYd/i12Y6hiS0Va0uPxVYaw6onSJrdJZ2xk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksGn1bBYwvMN9ZJOmDSJeapOx7V3gAfyEaaHiq
 u4fgEkD5s+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBp9QAKCRD2t4JPQmmg
 c/79EADA/xNSe+OXe+fAkOmIazz02wIFBl+djuhBXh/Wq7uTJ/wXX2LVXz7haAPg0yi452RyvW6
 Y3umutQuwMqvWzIStUfkZHrvVTBjBp2u7zvgkknGe2hDS7tDLYXmbQ667Qs340s8OUMGqvptQk7
 y25FKL03KNuLSokg0OhB1Dp1u9hAYsuDmp18420NV6kDA3jPi1WMMzd9FV0iajheLOgk3TM1/JM
 CmY1+0inJwGExfLshAmG5soMIwQwZql8d1Lq4lD4hn2tkfUPO5tsrcoOaj3y2rDxE6vECvC9sWI
 3syinI2F9TgnuGw/+OXCL7GkqLbD/1ok/fTu0M2AQV1e6dOEbi4xTxMlqhAOYlqC48rsNVrwiIC
 5xxByReFo7qwwKI9y8JVMf98hF04OY8vwow1gw/Cbwf15/GZpWnIWqFRfA9PrYpyxFs0iq4ASeL
 6opLFLVqXBXpeOsySZvp6gl3GqxMk0oNCpDRg29Q9E8EkzzMlIjqJKZUsQnFvrwJOOKNPzi00cZ
 +AWTZiSk7qawGmeIBg1KKMdLx0xcG1puAieB1bzmmSB4ZXlR4aogcXkAE+ku92dZ6PYvTxdt8nt
 2UUXOHdQmUX2S4etArxuBVMbnXQ7cHk7oHy9Fat5T/EwBWQK3QQiWZEmdI/qPOxJotVjg3ZIiaG
 r69EzqvS4gPH/QQ==
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

When looking at the TC selftest reports, I noticed one test was failing
because /proc/net/nf_conntrack was not available.

  not ok 373 3992 - Add ct action triggering DNAT tuple conflict
  	Could not match regex pattern. Verify command output:
  cat: /proc/net/nf_conntrack: No such file or directory

It is only available if NF_CONNTRACK_PROCFS kconfig is set. So the issue
can be fixed simply by adding it to the list of required kconfig.

Fixes: e46905641316 ("tc-testing: add test for ct DNAT tuple collision")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index d1ad29040c02..71706197ba0f 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_CONNTRACK_PROCFS=y
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m

-- 
2.40.1

