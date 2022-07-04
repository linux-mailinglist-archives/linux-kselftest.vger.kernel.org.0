Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61500565D6A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGDSOy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGDSOv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 14:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F3DF80
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 11:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECFDE61614
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 18:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52058C3411E;
        Mon,  4 Jul 2022 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656958490;
        bh=MItEJNsOMYjbjnHe2FNf7afYJ8OSCRCPr6uQEUvQGzI=;
        h=From:To:Cc:Subject:Date:From;
        b=LqG1+sqP23ZUZNlHKwYLPBj9JHqNiKpIGhi3CAyG6atkcVgsRC5PCIIPlHnyoZ7jf
         TJgjOKun9nOK1uoqgDjz4XF1QQ6psqjQbCui8deEzhZzEJhx15en1GfJiY9gzeDeLS
         p68zjXpaMi2ihdpFJEUYjXmvrYzSChSQXsg3nu8s9DOjS4ljkMkUty15ewq4VY5ab1
         duOZ0ubunMACiZPBM9sMiBGihB6pUp3cGrOCplLApRaYcdSLS7xuyVMDPXzypqWP6C
         eR3FulDh+eiU4gDyyAhsilxeVT0E5iMwncJmu58+oa1cnViqazzkFvptTpOdMVKIll
         jtKDL9ohytAPw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/4] arm64/sme: ptrace support for TPIDR2_EL0
Date:   Mon,  4 Jul 2022 19:13:28 +0100
Message-Id: <20220704181332.3318214-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; h=from:subject; bh=MItEJNsOMYjbjnHe2FNf7afYJ8OSCRCPr6uQEUvQGzI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiwy3IGjPb7hy65Nb36r8PtR3irp1TouZUX1EveGxF EJUJXF+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYsMtyAAKCRAk1otyXVSH0NRZB/ 9DOifPrZLdcs9kT6FEKrLY+2R/UroVResqPoAggwPMZBzXtzBVhQoBFxbZTCW7VqYFtnMPIZw/14n4 qLEa1QFgdCdKZtagpHuRRdKwPUqyKQeQa+ncSxth/zd3xtOvVdQeRrNpUPlOTX4aRHyRjaLZbwyXPL nhsGl7sTkETOucy/sTse8DewUY5qa8yvmbc6q3ucmajUfDwst0lILscSWf7vGYbgOOoW0Zw4J8Zrnc pVrcKKWceitgeeS513mqTcT19dpzYJbiFCJDPDoVB3m0KbCNi+uPkZ0AY2pu19FLR63gbQJ47+DqV4 3KJdkAgFcb7nlGjJkeS98HDXNhk6WP
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When SME was initially merged we did not add support for TPIDR2_EL0 to
the ptrace interface, creating difficulties for debuggers in accessing
lazy save state for ZA. This series implements that support, extending
the existing NT_ARM_TLS regset to support the register when available,
and adds kselftest coverage for the existing and new NT_ARM_TLS
functionality.

Existing programs that query the size of the register set will be able
to observe the increased size of the register set. Programs that assume
the register set is single register will see no change. On systems that
do not support SME TPIDR2_EL0 will read as 0 and writes will be ignored,
support for SME should be queried via hwcaps as normal.

Mark Brown (4):
  kselftest/arm64: Add test coverage for NT_ARM_TLS
  arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
  arm64/ptrace: Support access to TPIDR2_EL0
  kselftest/arm64: Add coverage of TPIDR2_EL0 ptrace interface

 Documentation/arm64/sme.rst                  |   3 +
 arch/arm64/kernel/ptrace.c                   |  25 +-
 tools/testing/selftests/arm64/abi/.gitignore |   1 +
 tools/testing/selftests/arm64/abi/Makefile   |   2 +-
 tools/testing/selftests/arm64/abi/ptrace.c   | 241 +++++++++++++++++++
 5 files changed, 266 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/abi/ptrace.c


base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.30.2

