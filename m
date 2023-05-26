Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE41971217F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjEZHvY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242496AbjEZHvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 03:51:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4B5134;
        Fri, 26 May 2023 00:51:22 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685087480;
        bh=Zyhdh9ZuPo+ME50q2El6he6ySdHrvo67VyZNo1LLr7c=;
        h=From:Subject:Date:To:Cc:From;
        b=kJXGtny1GsJg3RMvIQSM8MtCYqHctFeCKIxZWqMdRE/+MvsFn5bCsnfEb3lFHMp9x
         OfFgF+Tano/572BXd4w5AnL+Ui1mV4zkhAGSFWWfsfvnavw8SzgYXS+UfAFaL0iwLv
         5zjFiYLvj9p9aTLGFi/XYGpD0U97Njm8SkuTZhXo=
Subject: [PATCH v2 0/2] tools/nolibc: avoid coredumps and speed up tests
Date:   Fri, 26 May 2023 09:51:18 +0200
Message-Id: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPZkcGQC/32NTQ6CMBBGr0K6dgytAuLKexgW/RnsJFhIp6CGc
 HcrB3D3vS95eatgjIQsrsUqIi7ENIYM6lAI63V4IJDLLFSpTmWlagjjQMZCQk55g5ufE2hppGu
 rqnH9RWTTaEYwUQfrsxvmYcjnFLGn9566d5k9cRrjZy8v8vf+jywSSqgVNuqs29oZdXshMbP1s
 z8GTKLbtu0LCAyznNAAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685087479; l=896;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Zyhdh9ZuPo+ME50q2El6he6ySdHrvo67VyZNo1LLr7c=;
 b=lhFCnONVLCvjgo3bPQSrTE2QYVYVMBqDGxEknyxufSq0kos06yFsUc9d+ZGq58A7dQOPfV6LA
 6EbRK97jzyABM13PBu/HwBHFJcYhFzgNoOxC4M+BMa54nh1iB0GuViq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Small optimization to avoid coredump writing during the stack protector
tests.
Adds prctl() as prerequisite.

This series is based on nolibc/20230524-nolibc-rv32+stkp4

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Fix compilation warning in prctl() testcase
- Link to v1: https://lore.kernel.org/r/20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net

---
Thomas Weißschuh (2):
      tools/nolibc: add support for prctl()
      selftests/nolibc: prevent coredumps during test execution

 tools/include/nolibc/sys.h                   | 27 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  3 +++
 2 files changed, 30 insertions(+)
---
base-commit: 1974a2b5fd434812b32952b09df7b79fdee8104d
change-id: 20230526-nolibc-test-no-dump-a1b1d9557df8

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

