Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8A6CCBC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjC1VBj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1VBh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 17:01:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5522D95;
        Tue, 28 Mar 2023 14:01:36 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680037294;
        bh=d+fvmyfUSzhUgxwDSrwqWNNLmLsj3aO+oqVW6OGvk3A=;
        h=From:Subject:Date:To:Cc:From;
        b=VZzHrNZhomS1SMIyGCWppNfpbjA5Tw2fcNoI7rmmwASmFCXPhyTcND8rWH+4bd9PN
         h/Su9l+cv6/jgov/IgGNKGoFFX5N9OCxr62o7E8hVU+atFG9HBcDMIVipNAQUoMc9l
         vqA2K1fgS9OD+KxGiQSOYWl/f9b5e+2DohZQ5LGw=
Subject: [PATCH 0/3] tools/nolibc: add testcases for vfprintf
Date:   Tue, 28 Mar 2023 21:01:28 +0000
Message-Id: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKhVI2QC/x2N0QqDMAwAf0XyvEAbEWS/MvbQ1jgDJUrSjYH47
 yt7vIPjTnA2YYf7cILxR1x27RBvA5Qt6YtRls5AgcYw0oy6V8kFDxNtKzb2hmGiZUq5UIwz9DA
 nZ8yWtGw91XetXR7Gq3z/p8fzun53GLlPeQAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680037292; l=802;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=d+fvmyfUSzhUgxwDSrwqWNNLmLsj3aO+oqVW6OGvk3A=;
 b=xId/1SWlZoHASHtUkpxicbQWrIqif4DMVhip6Pl9gZZa50xqQlGP4ejKE5Wq6wCn95fxgRV6c
 mUtgk3+MrCSBZIS02ajTsubXtI/RdO0zz7LCGtes2ouqTaQuent9lhu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vfprintf() is complex and so far did not have proper tests.

This series is based on the "dev" branch of the RCU tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      tools/nolibc: add wrapper for memfd_create
      tools/nolibc: let FILE streams contain an fd
      tools/nolibc: add testcases for vfprintf

 tools/include/nolibc/stdio.h                 | 36 +++----------
 tools/include/nolibc/sys.h                   | 23 +++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 77 ++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 29 deletions(-)
---
base-commit: a5333c037de823912dd20e933785c63de7679e64
change-id: 20230328-nolibc-printf-test-052d5abc2118

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

