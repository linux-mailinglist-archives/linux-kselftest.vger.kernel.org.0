Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92D76B8C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjHAPj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHAPjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:39:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C0BF;
        Tue,  1 Aug 2023 08:39:39 -0700 (PDT)
X-QQ-mid: bizesmtp85t1690904373tci210qy
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 23:39:31 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: rZJGTgY0+YPw0GRdK4Rh4/tgFw8Gc+bqaSxlFBgep5trguI+AAFVBeoKzcT2X
        eF+iR+1OE4WamuO8Vwj0FNMVQKVbM6TpP/53Cmeeb4S6/IplkchhbVZl+I5R3xI4KdkyCzS
        rWDuJO3TnNWQW72msPt4WiJ90AzzXTVNhJzA8fTNZKTSD+BYmasqRtMdUY/u0yMofS7a4Ny
        PAtlmcGChQ5YX37VyEzRQm0ckJs4/AmjF8yrij1nDQODzpc3Vqz9N1TT534/+ifpp+fUi5j
        id14tkPALT5KMRLrbPcmQH7XSg0UeItpDgJMZdamnnJ7Hvfk9213k82d4spNKNPjRaveg2y
        1Qhg+uR9PQ2T+qJW3PAyxxuuf9y19v8827v5xsb
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17724266934189728209
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v3 0/2] tools/nolibc: add pipe(), pipe2() and their testcase
Date:   Tue,  1 Aug 2023 23:38:47 +0800
Message-Id: <cover.1690903601.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Willy and Thomas,

In v3, I have fixed all the problems you mentioned.

Welcome any other suggestion.

---
Changes in v3:
- Fix the missing return 
- Fix __NR_pipe to __NR_pipe2
- Fix the missing static
- Test case works in one process
- Link to v2:
  https://lore.kernel.org/all/cover.1690733545.git.tanyuan@tinylab.org

Changes in v2:
- Use sys_pipe2 to implement the pipe()
- Use memcmp() instead of strcmp()
- Link to v1:
  https://lore.kernel.org/all/cover.1690307717.git.tanyuan@tinylab.org

---
Yuan Tan (2):
  tools/nolibc: add pipe() and pipe2() support
  selftests/nolibc: add testcase for pipe

 tools/include/nolibc/sys.h                   | 24 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 22 ++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.34.1

