Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD337620D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGYSBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGYSBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 14:01:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D852109;
        Tue, 25 Jul 2023 11:01:17 -0700 (PDT)
X-QQ-mid: bizesmtp62t1690308071tb5chd7q
Received: from localhost.localdomain ( [42.242.128.198])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 02:01:09 +0800 (CST)
X-QQ-SSF: 01200000000000403000B00A0000000
X-QQ-FEAT: C46Rb8GPIEc3xfoNnR2QaLlcCjq3plxK2uQScZMbmKIe1QFnj5OEkS36NW2qh
        EP9Gx1/4Er5YfP5OU5fVXfQKYR/oIXAH+PJ71RsTSFziKy8vkU+6dpMoVneU0NmCypI41pQ
        80//dRcXdatGRNfDOtMSjg0eGYxOXwmImk8xYlUl7bKJnG1x6VAOVKiFH/6hcYXHS+7POzG
        9T3m8VMyB25CnYwYwMnGFYxpQmbI5S0y08EADWr7MIulanA8kbAFkHAPn87x9iQNJW31jJM
        TtIN3rRuRy0Pw21PHCb7M0TRyEkta0X2VKBWAf42eP6++esJWEpYDjIMRZISoBVElzPrrZy
        VM8CGwv14PKqOyH5sTJ/zLBdxhvng==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9922490793517175682
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH 0/2] tools/nolibc: add pipe() and its testcase
Date:   Tue, 25 Jul 2023 14:01:07 -0400
Message-Id: <cover.1690307717.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Zhangjin and I are working on a tiny shell with nolibc. This patch
enables the missing pipe() with its testcase.

Thanks.

Yuan Tan (2):
  tools/nolibc: add pipe() support
  selftests/nolibc: add testcase for pipe.

 tools/include/nolibc/sys.h                   | 17 ++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 34 ++++++++++++++++++++
 2 files changed, 51 insertions(+)

-- 
2.39.2

