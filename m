Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BC1DD875
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgEUUhN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 16:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUUhN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 16:37:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BF120748;
        Thu, 21 May 2020 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590093432;
        bh=yXWP8qF0H4Lf7P8zsz30ApGS3ldARmbgR/xW/I/BfP8=;
        h=From:To:Cc:Subject:Date:From;
        b=AybnBR5/UfThiQ4J+Wlmmu8r6gUeGZ1L2Qbtkay8Ex5NixtZRbVKU7YMzqAaFViIy
         uTIiNHh4eTpkEQhjLcGxO0z9JDBono7a4s+JukQYqFzCR33OafroPT2tU5PUx2ETcj
         dAhPaLHunru5TW+InywVXsBHNn2TXmx4lwH8gSQQ=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] selftests: vdso: Add a selftest for vDSO getcpu()
Date:   Thu, 21 May 2020 21:37:04 +0100
Message-Id: <20200521203707.37304-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series does a bit of a cleanup of the existing tests for the vDSO
in kselftest and then adds a new test for getcpu().

v2: Silence checkpatch

Mark Brown (3):
  selftests: vdso: Rename vdso_test to vdso_test_gettimeofday
  selftests: vdso: Use a header file to prototype parse_vdso API
  selftests: vdso: Add a selftest for vDSO getcpu()

 tools/testing/selftests/vDSO/.gitignore       |  2 +
 tools/testing/selftests/vDSO/Makefile         |  5 +-
 tools/testing/selftests/vDSO/parse_vdso.c     | 24 +--------
 tools/testing/selftests/vDSO/parse_vdso.h     | 31 +++++++++++
 .../selftests/vDSO/vdso_standalone_test_x86.c |  4 +-
 .../testing/selftests/vDSO/vdso_test_getcpu.c | 54 +++++++++++++++++++
 .../{vdso_test.c => vdso_test_gettimeofday.c} | 10 ++--
 7 files changed, 96 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/parse_vdso.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getcpu.c
 rename tools/testing/selftests/vDSO/{vdso_test.c => vdso_test_gettimeofday.c} (84%)

-- 
2.20.1

