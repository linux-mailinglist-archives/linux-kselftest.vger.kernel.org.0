Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDCF7A0A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbjINQCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbjINQCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 12:02:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598A2721;
        Thu, 14 Sep 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694707293;
        bh=BLwVkYfDRtmtpBN6kGDW31k/g2b9DTTOXBHjuDCkrU8=;
        h=From:Subject:Date:To:Cc:From;
        b=JB0OPAsJN2q+I4VRX9/xT/yh1hwn9H5m00pqJUkonCBtDdVYO+NfpplF2Mm8ecUdw
         ffVwGVJh/FB5/WzSHLXGewXgFRLR04ii7vjqTXRKQGf8HudjEao5emfFSAorWYMUHr
         3x/9yUdUD5Xl20aVFL+x1Eo66tn3z09kAJiTGKZk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] tools/nolibc: cleanups for syscall fallbacks
Date:   Thu, 14 Sep 2023 18:01:16 +0200
Message-Id: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEwuA2UC/x3MSwqAMAwA0atI1gb8RLBeRVzUGjVQqjQgSvHuF
 pdvMZNAOQorDEWCyJeoHCGjLgtwuw0boyzZ0FRNW5maMBxeZof6qLPeY4hobLd2RK4nQ5C7M/I
 q9/8cp/f9AAWx/81jAAAA
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707292; l=865;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BLwVkYfDRtmtpBN6kGDW31k/g2b9DTTOXBHjuDCkrU8=;
 b=Leqnx5jr5VxyW77VJxQgkc5h9t7xLORcnxxjwYepzcHghifMXS3GSYDqqQICNz/zyWESoIjgY
 A4Tb5syvPYBCwV4WVu3QTVPegNjBp0b71OoPUDRes1CudcEr8oTCoh5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      selftests/nolibc: allow building i386 with multiarch compiler
      tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks
      tools/nolibc: don't define new syscall number
      tools/nolibc: automatically detect necessity to use pselect6

 tools/include/nolibc/arch-aarch64.h     |  3 ---
 tools/include/nolibc/arch-loongarch.h   |  4 +---
 tools/include/nolibc/arch-riscv.h       |  3 ---
 tools/include/nolibc/sys.h              | 42 ++++++++++++++++++++++++++++-----
 tools/testing/selftests/nolibc/Makefile |  1 +
 5 files changed, 38 insertions(+), 15 deletions(-)
---
base-commit: 3f79a57865b33f49fdae6655510bd27c8e6610e0
change-id: 20230914-nolibc-syscall-nr-9a5f544c8494

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

