Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6860661595
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAHN6T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHN6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:58:18 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57BD2FF;
        Sun,  8 Jan 2023 05:58:18 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id E1B5D7E500;
        Sun,  8 Jan 2023 13:58:14 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186297;
        bh=NdCVmLa+pw7nZy6+S+FXSNHPcYPSKeVE+Ni5WrI54Yo=;
        h=From:To:Cc:Subject:Date:From;
        b=fSsP07xGNskU3SZbEmoErORykg9QJTOKDWXaBhm9JXOeW1ArhZf/CY2jci2FNGcEk
         2bFAbnwWq2tpEWezkt2PRKRx1hFfbgkH5xRUS7lR/9x9pAJlGLzS0xD2Bfx9mzFt0K
         PsLCp9q6Qw77vY7cE0yNPSh0tnGdImCxo0p7Ocz46C86lpd3MTkpl+xCGWsrsx1fWc
         xBlhWQf2cE83vAI9zA9DSplX5HazawSFFDJNqpzWyAo9sIk8aPzJk9lhoaarmirso8
         V596ySDc/HnfvMW7GxdGS69Par2r2sQkZUM1PRklQO+8zRd+SkJEuXNorbaDq6rz4v
         zBhh8gkvejSfQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RESEND PATCH v1 0/3] nolibc auxiliary vector retrieval support
Date:   Sun,  8 Jan 2023 20:58:06 +0700
Message-Id: <20230108135809.850210-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Hi Willy,

This series is a follow up of our previous discussion about getauxval()
and getpagesize() functions.

It will apply cleanly on top of your "20221227-nolibc-weak-4" branch.
Base commit: b6887ec8b0b0 ("tools/nolibc: add auxiliary vector
retrieval for mips").

I have added a selftest for the getpagesize() function, but I am not
sure how to assert the correctness of getauxval(). I think it is fine
not to add a selftest for getauxval(). If you think we should, please
give some advice on the test mechanism.

Thanks!

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (3):
  nolibc/stdlib: Implement `getauxval(3)` function
  nolibc/sys: Implement `getpagesize(2)` function
  selftests/nolibc: Add `getpagesize(2)` selftest

 tools/include/nolibc/stdlib.h                | 27 ++++++++++++++++++
 tools/include/nolibc/sys.h                   | 21 ++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 30 ++++++++++++++++++++
 3 files changed, 78 insertions(+)


base-commit: b6887ec8b0b0c78db414b78e329bf2ce234dedd5
-- 
Ammar Faizi

