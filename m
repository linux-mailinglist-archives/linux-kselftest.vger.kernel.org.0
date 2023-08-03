Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44E76ECF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 16:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjHCOoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 10:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbjHCOoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 10:44:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA835B0;
        Thu,  3 Aug 2023 07:43:57 -0700 (PDT)
X-QQ-mid: bizesmtp77t1691073824tmsn1dyp
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 22:43:43 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3jQcUuMVk3R8jCS0ujaw9GIBT64uT4scAtyMG+CuNEQ6Yv56GASy
        8eTZTrATyHNbbmRaKLe2A+xzClpxnF1dApnVgGnAaQFamrhNjS0acwQf3NtsvVelvC09FA+
        QlRruasBO/Mu16C/lzNtNBbaBEwKM1XQ5K8pacWz33R1tZ0MdAtjcGYfV094Ax2fe0s9HHx
        pOGoxLjjouDHBbXcn8+9Y3oFDHVP7sOXwlLp3jC9AftbulRr737o70mQxSnLk/Vw6Ye8CTR
        rHDYAtT4FQ3wRSytB85DRDJbzVPes5MZtIw+FrgmLQnAOn81aD8OVrzXm+7p+fqAtvOhyi7
        E6WxQOxKFWSJQctMEHa2nT1RdyT1Mh9CERxbKN+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12510286017298524960
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v1 0/3] selftests/nolibc: add misc improvments
Date:   Thu,  3 Aug 2023 22:43:35 +0800
Message-Id: <cover.1691073180.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Here is last 3 patches for v6.6 from me.

It includes two generic patches from the tinyconfig part1 series and one
static related patch derived from Thomas' series.

Best regards,
Zhangjin

Zhangjin Wu (3):
  selftests/nolibc: allow report with existing test log
  selftests/nolibc: fix up O= option support
  tools/nolibc: stackprotector.h: make __stack_chk_init static

 tools/include/nolibc/crt.h              |  2 +-
 tools/include/nolibc/stackprotector.h   |  5 ++---
 tools/testing/selftests/nolibc/Makefile | 11 +++++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.25.1

