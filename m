Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD066155D
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAHNJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHNJB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:09:01 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C7E0DB;
        Sun,  8 Jan 2023 05:09:00 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 09F1D7E5F8;
        Sun,  8 Jan 2023 13:08:56 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183339;
        bh=NdCVmLa+pw7nZy6+S+FXSNHPcYPSKeVE+Ni5WrI54Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJHfbNkSQy1J5IE17SSbyzprSn1EF6JsMzukarbUsCv+ZVwTvxP+CuRhsKBajJpp1
         aR83PMxxlZvkagjtW8xYgWyPyr83TDM+m1viKsWFwP20QpMzh35YFQq4ewv0uyZB4W
         FYiZDf5wVGxBqt2JPM9vEOVuM1EMR1F055PQFCcc/hLKKqx0k0ITI58qls+EhfLgda
         6rT6SYaPobX05G3U+Ubzyisqhe+F/v/bJToTwda54Bj6yzFaOZw0g8PfdQryNqWFJx
         Z53h+firsRasbaujdQmHyaFGoeZ8h9UkP3OPVBzlO2vVYpetEBtlw7yJOLKm2cZwhJ
         Uku9CL8cFr5Cg==
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
Subject: [PATCH v1 0/3] nolibc auxiliary vector retrieval support
Date:   Sun,  8 Jan 2023 20:08:49 +0700
Message-Id: <20230108130853.840948-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
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

