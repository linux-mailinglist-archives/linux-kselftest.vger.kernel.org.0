Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B869C93A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 12:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjBTLER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Feb 2023 06:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjBTLEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Feb 2023 06:04:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895CACC17
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 03:04:04 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 21C1C3F71D
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676891043;
        bh=8s2ZZvrSW+uH/rhz7pK/tGrl1ulPHLMkcDQleiMlk1E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nYqdSQyP9F1YGDhONpy5OxRcdiJn0GqrdRd+5J+YuO5NV2IjKm5LL3aqRKxVxE2UJ
         W3lROrRmUMGDWqYBfZxpjBNlSeNOAe/91YDHk/Dl7byB+uz7d4AoAyt4v6HihQfdu9
         /+wML3UfyPm21kJ73TsqV7RsPOjfJuzq/J44clxus9cEbPz53O7LMFxNlLeLwQvX9l
         SSZ1zN49jjIdTo/QEQElP33eApS7juI2sY2mlER8I7IOclnQU1+hYnBgubKk1sY5PV
         G8tLM5thr/OpZW17p5oMICmfg5R/P/XQWCbMTGi6L2zzuVUZLeTZ8BoteAKAZ4EzND
         zgTR/fYgucnIw==
Received: by mail-ed1-f71.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so1347689edh.14
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 03:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s2ZZvrSW+uH/rhz7pK/tGrl1ulPHLMkcDQleiMlk1E=;
        b=FUp3yLE5JI9tQ7/G4CpCVkaTAeuMdmH7LFRAqOUcPeNXySrs/SsTv1YHiSfI74IAkW
         9nzx1S2ow5hyhCUCJecRxlM1O7IOeQajq+u1Awceesf8zwQZqZo8vo48kXS4xkDVs8Ej
         LDPhAb2FwvWclXzONjFtX+pgX24cA2pzE/xYowM7OAFg5+5mh5fdY5vaqC2dbo5kE9iN
         tzwuQ38owlgCUe9Mrj4R9bfaMt+8SqyVTTReblHwLqwA2PwRFFY3Yj4LTkDukb+nXPlM
         X2ueHsz7t6z3sHYIHm5ajLuHefyLnQvzJ/xWbhDeRCxbcSKWenkGpe8a4K1cjsryfrCf
         pClg==
X-Gm-Message-State: AO0yUKWqFKRJOnRq7AAxl7mf3ZP0YHJg+PaARinsKsObPmp3Q2R7RiQK
        umsqili9XcM+/Qco7PS48qRm4xjHRkDcCfVSbbP2oSgXFQZ1mOYjFYg3AquHaIf85lxYUpDayHf
        zHatdCalIC+julgioBRsE3nyJpJ8jVBCWn19e+HDESZNQ5GQcXXeDVQ==
X-Received: by 2002:a17:906:f88c:b0:8b2:8857:5963 with SMTP id lg12-20020a170906f88c00b008b288575963mr10167721ejb.8.1676891042743;
        Mon, 20 Feb 2023 03:04:02 -0800 (PST)
X-Google-Smtp-Source: AK7set90wDqto+2q0VKKfX4TGmc7OSMp/t3KCccA9ptGYfkhYgpoWsEjZZzx//l8J+KfKcAh1aBtUg==
X-Received: by 2002:a17:906:f88c:b0:8b2:8857:5963 with SMTP id lg12-20020a170906f88c00b008b288575963mr10167703ejb.8.1676891042503;
        Mon, 20 Feb 2023 03:04:02 -0800 (PST)
Received: from work.lan (77-169-125-32.fixed.kpn.net. [77.169.125.32])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709062b4b00b008b147ad0ad1sm5582552ejg.200.2023.02.20.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:04:01 -0800 (PST)
From:   Roxana Nicolescu <roxana.nicolescu@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] selftest: fib_tests: Always cleanup before exit
Date:   Mon, 20 Feb 2023 12:03:59 +0100
Message-Id: <20230220110400.26737-1-roxana.nicolescu@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Usually when a subtest is executed, setup and cleanup functions
are linearly called at the beginning and end of it.
In some of them, `set -e` is used before executing commands.
If one of the commands returns a non zero code, the whole script exists
without cleaning up the resources allocated at setup.
This can affect the next tests that use the same resources,
leading to a chain of failures.

To be consistent with other tests, calling cleanup function when the
script exists fixes the issue.

Steps to reproduce it:
1. Build with CONFIG_IP_ROUTE_MULTIPATH disabled.
2. Run net kselftest suite
3. fib_tests:fib_unreg_multipath_test fails when executing
`ip -netns ns1 route add 203.0.113.0/24 nexthop via 198.51.100.2 dev
dummy0 nexthop via 192.0.2.2 dev dummy1` because
CONFIG_IP_ROUTE_MULTIPATH is disabled.
This results in resources allocated during setup (e.g namespace ns1)
not being cleaned up.
4. When icmp.sh tries to create namespace ns1 during its setup, it fails
with the following error:
Cannot create namespace file "/run/netns/ns1": File exists

Roxana Nicolescu (1):
  selftest: fib_tests: Always cleanup before exit

 tools/testing/selftests/net/fib_tests.sh | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

