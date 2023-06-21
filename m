Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814CC739138
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjFUVBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUVBU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 17:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6EE19C;
        Wed, 21 Jun 2023 14:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D84616D7;
        Wed, 21 Jun 2023 21:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD2BC433C0;
        Wed, 21 Jun 2023 21:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687381278;
        bh=jlWJbhOrjnKVTwHPTVGHq334iwyIMm2mAeU6LYyasFM=;
        h=From:Subject:Date:To:Cc:From;
        b=sqGwHkhh/RtwEsmY/s6OMERkZGXJQNzZSRHuV7hqGSyvUc13q6PLfMM5jouJooT57
         0xcMorV1vbB24/T4FNVK9+5U++bGSYDvnmXT6p7JN6SHSYDGBG6edWwA3IFFHpolZS
         91tZIGufOk3DnP+DDiIg9ohuaQJUuWjNrnx+6w1P/f5maSXXWUq6YP8e3nft1pSKGH
         RduHRMQdyxJzbAyshVNFls35OFUVpvDwqC87msRXfHt5/1LaD6BeKOVDESdd1wSLMC
         +719qHFdXSKWcmfhcFW1U/SjaAUSGEW1437NLn56GrYj/5bP+ZvZotSDcNNKrEnG7M
         bBjIpZl8cwrUQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64/signal: Fix handling of TPIDR2
Date:   Wed, 21 Jun 2023 22:00:49 +0100
Message-Id: <20230621-arm64-fix-tpidr2-signal-restore-v1-0-b6d9e584d2ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFlk2QC/x3NQQ6CMBCF4auQWTsJbQlYr2JcFDrARG3JDFETw
 t0pLv+3+N4GSsKkcKs2EPqwck4lzKWCYQ5pIuRYGmxtXd1ag0HebYMj/3BdOIpF5SmFFwrpmoW
 wMy561/nr6D0UpQ9K2EtIw3w63yzPc16EivE/vj/2/QDHSZHfiAAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jlWJbhOrjnKVTwHPTVGHq334iwyIMm2mAeU6LYyasFM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkk2UayLmMV7bhjwqgQSk8JxacfjjHw7fXHZBgtRzQ
 3U7eprmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJNlGgAKCRAk1otyXVSH0CHRB/
 4+TKV4M117JVnOwEgv+VhL2tlZUiImG0JWrKcycaD1OrRB5qQ5bFMqSole80KLA702OuIlDccQmvcq
 qT4HA+q2SzHzoZbXaURUcF2RCqYyFXxa46LvtXqR+pz4rYnIfCZnkc+evIfFK4OM7mgK4MKyiuIw6z
 Gheq3Bz7ePhzSO6jb9cWQ0MxlNIXoG1CSYcmkj66WlM2IiuxngDeLutvBZgDFCicgJY/CPdZz591x4
 /HSl2ag9Fl45WSD2rXZSguFBKXJDmy1sqho0yAGLsm4ANG+pka7pxbf+GII7wFq13CiTvbdawYzaH/
 G1ncrAk2juLGDSkFeg+S2Y6Qs1Uwy7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The restoring of TPIDR2 signal context has been broken since it was
merged, fix this and add a test case covering it.  This is a result of
TPIDR2 context management following a different flow to any of the other
state that we provide and the fact that we don't expose TPIDR (which
follows the same pattern) to signals.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/signal: Restore TPIDR2 register rather than memory state
      kselftest/arm64: Add a test case for TPIDR2 restore

 arch/arm64/kernel/signal.c                         |  2 +-
 tools/testing/selftests/arm64/signal/.gitignore    |  2 +-
 .../arm64/signal/testcases/tpidr2_restore.c        | 85 ++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)
---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230621-arm64-fix-tpidr2-signal-restore-713d93798f99

Best regards,
-- 
Mark Brown <broonie@kernel.org>

