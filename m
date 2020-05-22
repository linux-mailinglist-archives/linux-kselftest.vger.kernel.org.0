Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A11DED1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgEVQVn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 12:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEVQVn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 12:21:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CBB2070A;
        Fri, 22 May 2020 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590164503;
        bh=5niBKoyyo+z1xiBLh9FBJrqEJeoXUYx7FC4/gtluDAU=;
        h=From:To:Cc:Subject:Date:From;
        b=e8qVOcKaf3OP98hNrtrm97GX9k6tI1PIJbbn/BeAPine0/bGEgmSKBRHFEtGZkWro
         Uc2xjMSYe0C6yXFCtKKr5YDMx0o0zPFsZBsDQ4kaw7vbh0FiqlZc/oEZiQjnCeqRns
         goHQ+s7HdblZdIwvaiehjMSruCq5UXBeaz17KCrQ=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/3] selftests: vdso: Add a selftest for vDSO getcpu()
Date:   Fri, 22 May 2020 17:21:36 +0100
Message-Id: <20200522162139.44380-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series does a bit of a cleanup of the existing tests for the vDSO
in kselftest and then adds a new test for getcpu().

v3: Remove some extern keywords.
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

