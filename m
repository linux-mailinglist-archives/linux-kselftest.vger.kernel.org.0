Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956D6D9D61
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjDFQTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbjDFQTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 12:19:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227440C4;
        Thu,  6 Apr 2023 09:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3862F64689;
        Thu,  6 Apr 2023 16:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE096C433D2;
        Thu,  6 Apr 2023 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680797983;
        bh=jMqpJsHHimG+sYAWIgFtMAhFlihVZMyC9o9J6HWut+0=;
        h=From:Subject:Date:To:Cc:From;
        b=FpFEvxren1GfnfOQEHS0klOdqSGtJN4B8vbCqlCyQR/ogBltgFo0Vz0dSgzWfe0lp
         BUwTIJ4oHgeUT1qoCo9gpDqJWTQ5zlKfevLqE5hE/lt69B16wZZQ2+S5Jax/Amfju2
         cYn7I8K1pZdcdYC0lNJkMF9+vTtiwQ07NiDfMntYNdIpU16JtU0/zpUIln7WrnWXog
         Lwpjgk7wDS5tFXT4qoSmrrKAeoP/N+14rjBKkQKkOtpZyZydr9j1GeFADRuksjKklg
         W5ndGRv1LtalHm7eoQDOcNvZG3lP/jR3pl8iIlM8IsJk36HGbvAJqKnIviCzZMmvNR
         ClAf/dB/Gak/A==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] tools/nolibc: Support vprintf() so we can use
 kselftest.h with nolibc
Date:   Thu, 06 Apr 2023 17:19:09 +0100
Message-Id: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3wLmQC/32NTQ6CMBBGr0K6tmYoiNGV9zAs2jLABGzNTEM0h
 LtbOIDL9/3krUqQCUXdi1UxLiQUQwZzKpQfbRhQU5dZGTAV1HDRk+DcJ5SkQ5zJee2d8Qh13XR
 wU/nmrKB2bIMf9+PLSkLeizdjT5/D9WwzjyQp8vdQL+We/rEspQbdVL3z3RVc3j0m5IDzOfKg2
 m3bfsg/URrKAAAA
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jMqpJsHHimG+sYAWIgFtMAhFlihVZMyC9o9J6HWut+0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLvEakQCMzhE33Qf9deXlKuBHr/y7aKTgXkKymfXO
 Lh0kuv2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC7xGgAKCRAk1otyXVSH0CWQCA
 CCboUeR4c27TdqGyMKngKDZOe5WsVx/NGxVTVtTc/Mt9fpkV+m2Gxha6EE0nVLzgPvktoNUHVBXmvT
 qyFuIasclIMkrhd2x1/qF6AjLf2As82CBq8787URYvHNSISvAZ9MEiK30gHXF96PKu6mlRstArK2J2
 N4kSrzdQGD/pByVl5MStovs+WKWNUjQyd9spj0iENQNIONRH+/36Xvv6ld1h1q6xqqQxLWtT6zYbRf
 L4hQH8vZiDC6oMicHsw38AMpl8FrmEVj77xdJdWhu9gn7z1oDrlP6Hn+1bOLv3KoEYXJKHBjfuiTw0
 XRvGmHLHfBDtlA+ihKgAgio7weF0ra
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
use of vprintf() which is not available in nolibc.  Fortunately nolibc
has a vfprintf() so we can just wrap that in order to allow kselftests
to be built with nolibc and still use the standard kselftest headers
with a small change to prevent the inclusion of the standard libc
headers.  This allows us to avoid open coding of KTAP output for
selftests that need to use nolibc in order to test interfaces that are
controlled by libc, we've got several open coded examples of this in the
tree already.

As an example of using this the existing za-fork test is converted to
use kselftest.h.  The changes to kselftest and nolibc don't have any
interaction until they are used by a test so could be merged separately
if desired.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Turns out nolibc has a vfprintf() already which we can use so do that.
- Link to v1: https://lore.kernel.org/r/20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org

---
Mark Brown (3):
      tools/nolibc/stdio: Implement vprintf()
      kselftest: Support nolibc
      kselftest/arm64: Convert za-fork to use kselftest.h

 tools/include/nolibc/stdio.h               |  6 ++
 tools/testing/selftests/arm64/fp/Makefile  |  2 +-
 tools/testing/selftests/arm64/fp/za-fork.c | 88 ++++++------------------------
 tools/testing/selftests/kselftest.h        |  2 +
 4 files changed, 25 insertions(+), 73 deletions(-)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230405-kselftest-nolibc-cb2ce0446d09

Best regards,
-- 
Mark Brown <broonie@kernel.org>

