Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A017715588
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 08:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjE3GeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 02:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE3GeM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 02:34:12 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B3BF;
        Mon, 29 May 2023 23:34:07 -0700 (PDT)
X-QQ-mid: bizesmtp89t1685428435tjs88flb
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 14:33:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ILHsT53NKPh+Vf4xMsr6y3bHBEHWUUnRi1ghv9wT/qGSSt9pNLNvHdozNDzCX
        1FIgAFiE0Yuz0+3Hi8+4nJEwsdFBayeit8CoSC67DiiD01jczO+8TMxkbA/h/eOj1LDd/Ay
        RTH//UIXABuBugm7tsryWGYk7G14ra0YGkbCqjK0p/KAxjctuOzFukamVxjPRQDdbqSrkpt
        TuWxj54BJCiltXLehhYKZBwb4XpffeeqWh1WVXmU3qkkldsXghlh6PVm/WXVJQ6p3xPmdqA
        9TgsdQ0PoP8nokkAlZxWrV7QxEyW1TjtXov4T3XGiUzy9ntWo12jNAAnUiTsuH+ATT6pbBo
        UPjLBj7kxAZ0DNvmg4L2ZBWFLklu6diSKqOZuexEdyJuZB2/jQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1304149608474469896
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 0/2] nolibc: add part3 of support for rv32
Date:   Tue, 30 May 2023 14:33:51 +0800
Message-Id: <cover.1685428087.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

These two patches are based on part2 of support for rv32 [1], I have
forgotten to send them together.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/linux-riscv/cover.1685387484.git.falcon@tinylab.org/

Zhangjin Wu (2):
  selftests/nolibc: add new gettimeofday test cases
  selftests/nolibc: add sizeof test for the new 64bit data types

 tools/testing/selftests/nolibc/nolibc-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.25.1

