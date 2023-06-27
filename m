Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11F373FFAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjF0P3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjF0P3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 11:29:42 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DE271D;
        Tue, 27 Jun 2023 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1687879778;
        bh=uiKyq04n6rExvj0t54UGSPj+46xRc1cYQAoeXXHf6E0=;
        h=From:To:Cc:Subject:Date:From;
        b=XMquB34DJl0AiaNaL7zrao+mC40Xt+t0SA57iW8ceifmk3HD2VMkiagF4rKvOyRwF
         YEyrI7bYgACMUlGTi8VEjiVV1a7c08Z/w93DS3WU6d8hD15JTZ19zcarpc2o1Hrg41
         V63YMKep8HPd0XeU+V0KmVMH5PZltvQANNzoC3XefrAQAvFIiqdNQ2f5ujV0gcZYdA
         Db4zik/Ov7B/1ytyWB+AOcIAW1Vm6/a+FSlEhKKOeRl9Czq/YYHnBSYd4szitympYr
         bTtmBxu7yCz7yw6PUOGENPVdr2YWj9+O09qYBH+RgCbYa+LWR1vrFau3nFHAffU5LG
         8gtzWIeLtz+MA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qr7tV4BJlz19mY;
        Tue, 27 Jun 2023 11:29:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/4] rseq selftests updates
Date:   Tue, 27 Jun 2023 11:29:19 -0400
Message-Id: <20230627152923.133238-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

This series contains updates to the rseq selftests.

* A typo in the Makefile prevents the basic_percpu_ops_mm_cid_test to use
  the mm_cid field.

* Fix load-acquire/store-release macros which were buggy on arm64.
  (this depends on commit "Implement rseq_unqual_scalar_typeof").

* The change "Use rseq_unqual_scalar_typeof in macros" is not a fix
  per se, but improves the assembler generated.

Can you pick these in the selftests tree please ?

Thanks,

Mathieu

Mathieu Desnoyers (4):
  selftests/rseq: Fix CID_ID typo in Makefile
  selftests/rseq: Implement rseq_unqual_scalar_typeof
  selftests/rseq: Fix arm64 buggy load-acquire/store-release macros
  selftests/rseq: Use rseq_unqual_scalar_typeof in macros

 tools/testing/selftests/rseq/Makefile     |  2 +-
 tools/testing/selftests/rseq/compiler.h   | 26 ++++++++++
 tools/testing/selftests/rseq/rseq-arm.h   |  4 +-
 tools/testing/selftests/rseq/rseq-arm64.h | 58 ++++++++++++-----------
 tools/testing/selftests/rseq/rseq-mips.h  |  4 +-
 tools/testing/selftests/rseq/rseq-ppc.h   |  4 +-
 tools/testing/selftests/rseq/rseq-riscv.h |  6 +--
 tools/testing/selftests/rseq/rseq-s390.h  |  4 +-
 tools/testing/selftests/rseq/rseq-x86.h   |  4 +-
 9 files changed, 70 insertions(+), 42 deletions(-)

-- 
2.25.1

