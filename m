Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25CC7E5C8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjKHRkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 12:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKHRkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 12:40:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C6DC6;
        Wed,  8 Nov 2023 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699465203;
        bh=fsZ5b5SAi66rd94CDnxZX6oRwgO/LdGZ1ZK0E5cCnUw=;
        h=From:Subject:Date:To:Cc:From;
        b=hPDJ3XUjuSpd/AzeDDCDK9viTNrfhnNrMLaZhOLVdE/zg/+JUeoo9VlmB1l/QP5aO
         VFbTLk3hePUJ73WfX2LCY8+uf/ctBPXrNhbyW91TZa6BE93vctstzDeSSRZdIlwg2R
         zTxKbDuj/xqbu/rFZJPL5ZjcdkIGwrj1tgnqDzr8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] selftests/nolibc: run-user improvements
Date:   Wed, 15 Sep 2077 02:13:51 +0200
Message-Id: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL/zlsoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDc3MDS0NT3bz8nMykZN2i0jzdUqBeXQsTU2Nz00Tj1GSTNCWgroKi1LTMCrC
 J0bG1tQB9ZPRZYQAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=3398890432; l=650;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fsZ5b5SAi66rd94CDnxZX6oRwgO/LdGZ1ZK0E5cCnUw=;
 b=JcoSryTkGSqJ3C6T2VirmN5n0CHj/Smp+gzJT/GRD5PdsIhsLPeHUaaOk3hyRe+nET3NrAluj
 jekjsPlMID8DhJ8+C+X3DdWl8KLsNmkmpe50MIvS+wwDBn8fn7J1fz8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A small bugfix for "run-user XARCH=ppc64le" and run-user support for
run-tests.sh.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      selftests/nolibc: introduce QEMU_ARCH_USER
      selftests/nolibc: run-tests.sh: enable testing via qemu-user

 tools/testing/selftests/nolibc/Makefile     |  5 ++++-
 tools/testing/selftests/nolibc/run-tests.sh | 22 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)
---
base-commit: ba335752620565c25c3028fff9496bb8ef373602
change-id: 20770915-nolibc-run-user-845375a3ec4f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

