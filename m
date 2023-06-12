Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959B372C4FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjFLMvV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 08:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjFLMvU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 08:51:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80107E71
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:18 -0700 (PDT)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 625693F374
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686574276;
        bh=nsdnueWG4qts2MX2wFeyUr3O+Edx/8ph3DP4zrxQHVk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IqwoV49YCXlYRo4AWjPdxF+WjKotu5Mh9uqwqs6FyqQ71jQbvnfZCsN2SEzEuwnNY
         rifvkrW5soN1JCfU6dqHaau7UFs6PMxYHyqtrgiTfE/zRdlSLg74oj+coflrqMXlIy
         By56dJ7fR0QeE/EkknlpqJq4gX5Z7UJgeaPeqnewkPS/5kFDF0Eog5rUw53xK3l9Cv
         uRcpvdY4ZOqpYkBTVPdNZIW4W6JG78NrjB6RghF0mUlqAyMEv9uslykN5fg0dh3Te+
         uFkRotzFBUykj/SBtA/0fW+saFCetkZaZShIeo4pbIIBMdVOE69/8Y8P4gGDS9v++N
         S7oIhPg2fGCjQ==
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b2bf00f6beso3293693a34.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574275; x=1689166275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsdnueWG4qts2MX2wFeyUr3O+Edx/8ph3DP4zrxQHVk=;
        b=QmmH1R/PqUJmi7WfINw0mlsCvW8gAWejbwJvbWaMqDhtxcs68KFekpdSB42WPTmcDU
         /0IIKMgaL2fgffM7Bp1a5yvakv7NtgFfcgJa5T5ifsFAYd83OoyTW61oEWB2AOF56p0S
         EXydMn3MygtgbWmm3HBeiISH+s5NNBwk+qoE4etFKnT6pPitY0Y3kcr4CxEFfLXpRDTj
         1RxJkDvuaZwzSmG1RcHJJ1zo6cq3vO1Z+hoGT74vpjwIAsrljneVLp5qER3u2Im0G/Zt
         pT/G1zNOlJQHyhrBCUd6fZxN3joTlSGEWrHykYovnKz7FLKEWf+bDoQidZkqi1ztUlaE
         jFwA==
X-Gm-Message-State: AC+VfDyfUoLedNaC/+zFk2gc5wTWgTh33/cgyMmp0k4udoDokmN1uhCu
        nR0GyQjKxMdMOAGBfhBYQAG3WYhxgCcf5O2wBinpUCfaaxsWcDnTHYi9X56t1+wLVQrAE1RMycu
        5AiB/DF80+TVWckx+oqZL4LgHcuQ8rFllJjWFzzZNjkW53A==
X-Received: by 2002:a05:6830:1e2d:b0:6b2:9c2c:5eb4 with SMTP id t13-20020a0568301e2d00b006b29c2c5eb4mr6684882otr.1.1686574275275;
        Mon, 12 Jun 2023 05:51:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61vhe7IGv21iHd9QSMCXvMkwaDpF47c3oFSaeAkvqG7WCHf95PG3sRmD0BJwaW/yWoBQD19g==
X-Received: by 2002:a05:6830:1e2d:b0:6b2:9c2c:5eb4 with SMTP id t13-20020a0568301e2d00b006b29c2c5eb4mr6684866otr.1.1686574275026;
        Mon, 12 Jun 2023 05:51:15 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:d612:b95d:6bdc:8f6d])
        by smtp.gmail.com with ESMTPSA id j22-20020a4ad196000000b00529cc3986c8sm3157193oor.40.2023.06.12.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:51:14 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, dsahern@gmail.com, edumazet@google.com,
        keescook@chromium.org, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, tianjia.zhang@linux.alibaba.com,
        vfedorenko@novek.ru
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/4] Check if FIPS mode is enabled when running selftests
Date:   Mon, 12 Jun 2023 09:51:03 -0300
Message-Id: <20230612125107.73795-1-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some test cases from net/tls, net/fcnal-test and net/vrf-xfrm-tests
that rely on cryptographic functions to work and use non-compliant FIPS
algorithms fail in FIPS mode.

In order to allow these tests to pass in a wider set of kernels,
 - for net/tls, skip the test variants that use the ChaCha20-Poly1305
and SM4 algorithms, when FIPS mode is enabled;
 - for net/fcnal-test, skip the MD5 tests, when FIPS mode is enabled;
 - for net/vrf-xfrm-tests, replace the algorithms that are not
FIPS-compliant with compliant ones.

Changes in v3:
 - Add new commit to allow skipping test directly from test setup.
 - No need to initialize static variable to zero.
 - Skip tests during test setup only.
 - Use the constructor attribute to set fips_enabled before entering
 main().

Changes in v2:
 - Add R-b tags.
 - Put fips_non_compliant into the variants.
 - Turn fips_enabled into a static global variable.
 - Read /proc/sys/crypto/fips_enabled only once at main().

v1: https://lore.kernel.org/netdev/20230607174302.19542-1-magali.lemes@canonical.com/
v2: https://lore.kernel.org/netdev/20230609164324.497813-1-magali.lemes@canonical.com/

Magali Lemes (4):
  selftests/harness: allow tests to be skipped during setup
  selftests: net: tls: check if FIPS mode is enabled
  selftests: net: vrf-xfrm-tests: change authentication and encryption
    algos
  selftests: net: fcnal-test: check if FIPS mode is enabled

 tools/testing/selftests/kselftest_harness.h   |  6 ++--
 tools/testing/selftests/net/fcnal-test.sh     | 27 +++++++++++-----
 tools/testing/selftests/net/tls.c             | 25 ++++++++++++++-
 tools/testing/selftests/net/vrf-xfrm-tests.sh | 32 +++++++++----------
 4 files changed, 62 insertions(+), 28 deletions(-)

-- 
2.34.1

