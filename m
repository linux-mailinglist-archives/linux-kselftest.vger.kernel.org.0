Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381E758824
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGRWFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGRWFj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:05:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320681BC9;
        Tue, 18 Jul 2023 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717869;
        bh=uR0sTN6cNOvKNnO9OoxW8UErtp4zZxwiB1QXI/X1W0Y=;
        h=From:Subject:Date:To:Cc:From;
        b=LtaeV1mdIO5HMGFupBODjL7yC/5hJStsJaxFp+ZHqN0lgTzVrqT3ECrUJ7qwlzQ7I
         jU0Ey0B4nsfs2BVfB42OKbNoTWcyGy7Es4XCX78AvLFMWCPgPA8bZIVzd55sA8hh3o
         1J0Zfdwzlg+IwkCb3jTj6xiN9Tw73aC18X8AX5iU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/7] selftests/nolibc: KTAP output
Date:   Wed, 19 Jul 2023 00:00:38 +0200
Message-Id: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIYLt2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0ML3bz8nMykZN3sksQC3ZLcAl0TEwOLNFMDUyCVogTUVVCUmpZZATY
 xWinIzVkptrYWAGoAd05mAAAA
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=1442;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uR0sTN6cNOvKNnO9OoxW8UErtp4zZxwiB1QXI/X1W0Y=;
 b=eghAFq46PEAKzym6InAJfk4ZSTAO7e66OM1D44KtUzQd8AzkfEKPxJiQdryUEpjTbirSwgHqI
 Zen8XDJrNuZCHKyw0notZsMFRwPBnnKwlSW1tGWE4BXUSqWtfyswbyH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series demonstrates how KTAP output can be used by nolibc-test to
make the test results better to read for people and machines.
Especially when running multiple invocations for different architectors
or build configurations we can make use of the kernels TAP parser to
automatically provide aggregated test reports.

The code is very hacky and incomplete and mostly meant to validate if
the output format is useful.

Start with the last patch of the series to actually see the generated
format, or run it for yourself.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (7):
      selftests/nolibc: statically calculate number of testsuites
      selftests/nolibc: use unsigned indices for testcases
      selftests/nolibc: replace repetitive test structure with macro
      selftests/nolibc: count subtests
      kselftest: support KTAP format
      kselftest: support skipping tests with testname
      selftests/nolibc: proof of concept for TAP output

 tools/testing/selftests/kselftest.h             |  20 +++
 tools/testing/selftests/nolibc/nolibc-test.c    | 197 ++++++++++--------------
 tools/testing/selftests/nolibc/run-all-tests.sh |  22 +++
 3 files changed, 127 insertions(+), 112 deletions(-)
---
base-commit: dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf
change-id: 20230718-nolibc-ktap-tmp-4408f505408d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

