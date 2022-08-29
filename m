Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F65A50CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH2P5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2P5p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099692F56
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF771611D7
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2FCC433D6;
        Mon, 29 Aug 2022 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788664;
        bh=L1eXUfXItox/5PahKb84z6blIXyo6xAMExszNdrASV4=;
        h=From:To:Cc:Subject:Date:From;
        b=lmRM3QuosRnZCs/5MQeyCIPCgZIJAZbuD7g5uEHUjYQcDM9wLoSiK39wx++qClKss
         kE595s9G7dFLI4HjOdwP90flpfakC6Fw5GXjvmqy2XwidWwIt4F3BX3IoZqpAjqsKS
         K5HRBlxjNv97Nvg+tLtn2msIqD9sOQW5sVcyjWzrObcQYF8WRIuct7LLZ13rxiQFap
         iXbbNlb+UTK+Nw0baQodNEX+ziPOp4+2ygeYqTTZsljbeOk64y/bQwNrvo5p7BxyuA
         7qwec9a/TlSwGwRKSYNJqxqdMD5+Bz8g7fDr4lH4xRrL/1dkAX7VT40yFe8iECPaVA
         BKSC3CrPb7W0Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] kselftest/arm64: Small improvements to ZA signal handling coverag
Date:   Mon, 29 Aug 2022 16:57:26 +0100
Message-Id: <20220829155728.854947-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=broonie@kernel.org; h=from:subject; bh=L1eXUfXItox/5PahKb84z6blIXyo6xAMExszNdrASV4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOHm33GvboeoKUve8EtlwJeNhmYZA38xYdjvCuhx Iu184x2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzh5gAKCRAk1otyXVSH0CV6B/ 9plr9WM5aJDyiZfphKjpYSB8dhRFW8qql3cqTSQ1N10HdcCNRBH37wN4ftJ8ayBg9YS5sRb9FEtydV VqhQ1RV28m0jJVAsThP+rpOgr/4dp6Uzitwip+Hrt+ikWjZIvCapDf2ma9eAlPkc9NRPHRmSDRzuGp jayq35eIndb30cHT5F00qGhKIaQ94Bck82eryKfS6Go7JZZzDFkpmaxurjBE/6S2sWwVNtaqbsHu0p WlgBk2YUTGY7hVcLOJSLkm2it8tlOWq0rjaupVFEn4/1o0H5OCd5Q5DYInssWSMY7fDFSqae/+AlLd g6TEFms6DuzWu9WurBH6Rr2ebh2SV+
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches improve the coverage of ZA signal contexts a bit, adding
some validation that the actual data is correct and covering the case
where ZA is not enabled.

v2:
 - Rebase onto v6.0-rc3.

Mark Brown (2):
  kselftest/arm64: Tighten up validation of ZA signal context
  kselftest/arm64: Add a test for signal frames with ZA disabled

 .../arm64/signal/testcases/za_no_regs.c       | 119 ++++++++++++++++++
 .../arm64/signal/testcases/za_regs.c          |  16 ++-
 2 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

