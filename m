Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8DB59AECB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbiHTPDZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiHTPDY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 11:03:24 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89106BE11
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Aug 2022 08:03:21 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 830B830EB90;
        Sat, 20 Aug 2022 17:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661007798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j5EhH9ScD23XwiVsIhfIT8NRiSdAZtvTjNxcUmiTssg=;
        b=FRfKR9v8AhC82CGJBmF/aOAOGv6TYcqM+wdyJ9FB9gRaE3nTVt7/S7UxqYNN8Rt7MbcPaH
        qv3unpTHppeofKxyo2NBw8islhvd3q922vDmBV/oUPNiNMOAHYeCk7AYqaaF5g39r3lg4c
        AWqUQ4r4udlqJrWhB6pHzCaUMKK6VbOAtvwkUi6noDGow8cBY5Umuhi+0MyXSOysBU0zP2
        I3C6+at7rH8FWCsjMUR5zXzl+NCscPXwbtESwNVQDk+YxiHdULVRnXjsub1PmdhRhlXCMg
        PeetKch+oQNQOcIHl/3FfJe8bzlAQsCILpTo2cCHdj4f0VxoakHMMUAh2oIrhw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 0/5] cpumask: KUnit test suite fixes and improvements
Date:   Sat, 20 Aug 2022 17:03:08 +0200
Message-Id: <cover.1661007338.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes the reported issues, and implements the suggested
improvements, for the version of the cpumask tests [1] that was merged
with commit c41e8866c28c ("lib/test: introduce cpumask KUnit test
suite").

These changes include fixes for the tests, and better alignment with the
KUnit style guidelines.

[1] https://lore.kernel.org/all/85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net/

Changes since v1:
Link: https://lore.kernel.org/lkml/cover.1660068429.git.sander@svanheule.net/
- Collect tags
- Rewrite commit message of "lib/test_cpumask: drop cpu_possible_mask
  full test"
- Also CC KUnit mailing list

Sander Vanheule (5):
  lib/test_cpumask: drop cpu_possible_mask full test
  lib/test_cpumask: fix cpu_possible_mask last test
  lib/test_cpumask: follow KUnit style guidelines
  lib/cpumask_kunit: log mask contents
  lib/cpumask_kunit: add tests file to MAINTAINERS

 MAINTAINERS                             |  1 +
 lib/Kconfig.debug                       |  7 +++++--
 lib/Makefile                            |  2 +-
 lib/{test_cpumask.c => cpumask_kunit.c} | 13 +++++++++++--
 4 files changed, 18 insertions(+), 5 deletions(-)
 rename lib/{test_cpumask.c => cpumask_kunit.c} (90%)

-- 
2.37.2

