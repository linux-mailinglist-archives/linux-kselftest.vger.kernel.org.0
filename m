Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33976D98C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbjDFN5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbjDFN5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 09:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F7A5F7;
        Thu,  6 Apr 2023 06:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6C76456E;
        Thu,  6 Apr 2023 13:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A7C4339B;
        Thu,  6 Apr 2023 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680789439;
        bh=UK5JJfdjiAdN9kwU5At61bUGQenEJhFJVNvEndfAWkg=;
        h=From:Subject:Date:To:Cc:From;
        b=IE52y9OSvrDsq/qGBBJkmB2j05+j9lw2T2ob9/QkVqO/PyUngTEWVbSRCieWPi6R8
         ZtzVpD21IS9CZ9fW/B08b6k4rc5q/5xtHRzUziAB9spTCFC6Wxo1dvmDBLpVJoSx7J
         6Yic4XcYtoX669XTvda+qWSbBqgQW3fQTkr2B/I4xLrNq4upp/lLaDd0nWKy+fgcE2
         jkuVjrjGpDG+l2Akpf8NnNJw6sKP9XZcKelGlqBSLaa8NfT/u8Fuep5eQFVJk7ikqv
         2Go3ooxSSF8dhDzT48HEdoDEk9eBtRalrJfCD42AD3koaxq8WPN2X6fmZjh3/zILuk
         zXjg4uCaW9r0g==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest: Support nolibc
Date:   Thu, 06 Apr 2023 14:56:28 +0100
Message-Id: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzPLmQC/x2N0QrCMAwAf2Xk2UCsVdBfER/aLHPB2UlShjD27
 3Y+HsdxK7iYisOtW8FkUde5NDgeOuAxlaeg9o0hUDhRpDO+XKahilcs86SZkXNgoRgvPV2hZTm
 5YLZUeNzDd/IqtouPyaDf/+v+2LYfjLvkRXsAAAA=
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UK5JJfdjiAdN9kwU5At61bUGQenEJhFJVNvEndfAWkg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLs+7k+k7gQDbtDEjL2cEjcLJgulQT9C2jU5yInP9
 TZZJ4OmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC7PuwAKCRAk1otyXVSH0I4CB/
 9p1/dGEQmbpFozJZoptPdTRtXccp9r7HSg3K8nmCuP/kLeje5ebuMpUPL1EjH6C5FgEL6xd0k2Xm/C
 BxGBHaHGAcfydZV99U0m6C82xD3XhmXXYj0tpunoJcVfT6s09lywO6AcHzbUcxtt3No6cG4/TfNP4C
 YKhP0qeRkGZ2ScrmRMPxtUx3BA3eonc9qaHjkPg8OXvt422Q8hXUBK/cF0VTuAw/S5CpPgKH2lmaQO
 Td/y89LL/cmxWBWjunb7U+g/jF52IO0COXW7gTY1G6LbHd95h/PVAh70cZVlxqTf0mskVQD/3oo/Md
 iPbuJ2WbdSLRa4KxAipuF75cPI6Z8w
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

At present the kselftest header can't be used with nolibc since it makes
use of vprintf() which is not available in nolibc and seems like it would
be inappropriate to implement given the minimal system requirements and
environment intended for nolibc. This has resulted in some open coded
kselftests which use nolibc to test features that are supposed to be
controlled via libc and therefore better exercised in an environment with
no libc.

Rather than continue this let's factor out the I/O routines in kselftest.h
into a separate header file and provide a nolibc implementation which only
allows simple strings to be provided rather than full printf() support.
This is limiting but a great improvement on sharing no code at all.

As an example of using this I've updated the arm64 za-fork test to use
the standard kselftest.h.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest: Support nolibc
      kselftest/arm64: Convert za-fork to use kselftest.h

 tools/testing/selftests/arm64/fp/Makefile  |   2 +-
 tools/testing/selftests/arm64/fp/za-fork.c |  88 +++--------------
 tools/testing/selftests/kselftest-nolibc.h |  93 ++++++++++++++++++
 tools/testing/selftests/kselftest-std.h    | 151 +++++++++++++++++++++++++++++
 tools/testing/selftests/kselftest.h        | 149 +++-------------------------
 5 files changed, 272 insertions(+), 211 deletions(-)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230405-kselftest-nolibc-cb2ce0446d09

Best regards,
-- 
Mark Brown <broonie@kernel.org>

