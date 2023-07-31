Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575B768B5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 07:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGaFu4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 01:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGaFuw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 01:50:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6EA10CA;
        Sun, 30 Jul 2023 22:50:46 -0700 (PDT)
X-QQ-mid: bizesmtp76t1690782636thuejwr0
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 13:50:34 +0800 (CST)
X-QQ-SSF: 01200000000000605000000A0000000
X-QQ-FEAT: c88coFtlRu1M+imO/ng+mrc4U2TsZQSPxP5GCaWnTfBRGJg1WEGGW9YZsYfXa
        u8AITmMzeNXTRTB0TKOZRJkAFPxJBpCW+tFbv50/NV6E9zJM5+VqBkC+lQSz3IF6HZgoxuX
        yZbjCmwy6MYUU7b1fMVreDnE5qUOOMfqmRcG+KYHDad5psGofPKFlqlklxvQzka8ZP+k+xO
        BpqCbTxMh7wImKt7MQFkfcrhA44QWofhF7DlwsdIkcxBtZA00ly3dDqhHmCzWdOcSXlDYuA
        dxSSw8UebFP4WPcdrcmFBmrpNL56b0xnuAA3iwU01WiJZ2Z2KU+VmWl8b6UEWzq7QB8L5fl
        W3fk93ae75dbaCa2Vo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1150988465716755568
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 0/2] tools/nolibc: add pipe(), pipe2() and their testcase
Date:   Mon, 31 Jul 2023 13:50:31 +0800
Message-Id: <cover.1690733545.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi, Willy, Thomas,

Thanks to your advice and I really learned a lot from it.

V2 now uses pipe2() to wrap pipe(), and fixes the strcmp issue in test
case.

Best regards,
Yuan Tan

Yuan Tan (2):
  tools/nolibc: add pipe() and pipe2() support
  selftests/nolibc: add testcase for pipe

 tools/include/nolibc/sys.h                   | 24 ++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.34.1

