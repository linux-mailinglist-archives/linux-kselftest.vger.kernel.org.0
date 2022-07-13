Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C0573DFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiGMUqi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbiGMUqh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:37 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7662B1BE
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=vca7nd1WLODw18YJlNvBePUslvp
        lVqYhcHwVyGI3iSk=; b=QijN5/1vuNqnQeF9AXCPgoHYZGZngr6L1ZMRsc2e+GH
        06ISyUOVXAQhr60jpQM/OqoCft5f23/I2xvy6MjzTR/M+YTPO/NPpHNDXD6cF4Ig
        8yTLi2itq56j0s4U+bstBRzZlbmEDFcGmU+HGi3rsWok7RsJdsQdBfFhb45gXbdI
        =
Received: (qmail 305555 invoked from network); 13 Jul 2022 22:46:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:32 +0200
X-UD-Smtp-Session: l3s3148p1@LOkJ4bXj5qQgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/9] selftests: timers: fixes and improvements
Date:   Wed, 13 Jul 2022 22:46:12 +0200
Message-Id: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The timer selftests are quite useful for me when enabling timers on new
SoCs, e.g. like now with the CMT timer on a Renesas R-Car S4-8. During
development, I needed these fixes and additions to make full use of
the tests. I think they make all sense upstream, so here they are.

Patches are based on v5.19-rc1. Looking forward to comments.

Happy hacking,

   Wolfram


Wolfram Sang (9):
  selftests: timers: valid-adjtimex: build fix for newer toolchains
  selftests: timers: fix declarations of main()
  selftests: timers: nanosleep: adapt to kselftest framework
  selftests: timers: inconsistency-check: adapt to kselftest framework
  selftests: timers: clocksource-switch: fix passing errors from child
  selftests: timers: clocksource-switch: sort includes
  selftests: timers: clocksource-switch: add command line switch to skip
    sanity check
  selftests: timers: clocksource-switch: add 'runtime' command line
    parameter
  selftests: timers: clocksource-switch: adapt to kselftest framework

 tools/testing/selftests/timers/adjtick.c      |  2 +-
 tools/testing/selftests/timers/change_skew.c  |  2 +-
 .../selftests/timers/clocksource-switch.c     | 70 ++++++++++++-------
 .../selftests/timers/inconsistency-check.c    | 32 +++++----
 tools/testing/selftests/timers/nanosleep.c    | 18 +++--
 tools/testing/selftests/timers/raw_skew.c     |  2 +-
 .../selftests/timers/skew_consistency.c       |  2 +-
 .../testing/selftests/timers/valid-adjtimex.c |  2 +-
 8 files changed, 80 insertions(+), 50 deletions(-)

-- 
2.35.1

