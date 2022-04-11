Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2A4FBB67
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiDKL6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 07:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbiDKL6X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 07:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8586403C7
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 04:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9107CB8154D
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 11:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9533C385A4;
        Mon, 11 Apr 2022 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678165;
        bh=YqTKOAq1Q8o7tdhYQRSBSdCTbkg1kFFmgQcXDY54Ns4=;
        h=From:To:Cc:Subject:Date:From;
        b=mF1O23n0Upb8sVPeFtcFCw3bKTQ4i7wuqWRC7ItW2Pk9IDRMTPZyBFYc8q2om+/CB
         kUhZfepw70L3ZXCwTVyYIXqF3tg5GbN40EAOSBxyn+yAnaGDMZCTzXbfoGIUc3pXCV
         UnswglJspwtT8kMVCY5a0Pr+TY3VjCnBtLc+OwK1AaYXn3n6TlLXBg8s8ODmvC23kA
         TOkdc2CTZrIJl3VqbozUS9m0YOXcV43VV0N59anUYAzbP0xgSzi6tDxr5pHXtLZaDL
         9TzoyP+NacPTkS4sqinp/N7Um0RQRoMhe/LVw/WzMvRqP9lkPrxTYvqIR85plDlX7J
         SxCIPokV2Ishg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/4] selftests/arm64: Fix O= builds for the FP selftests
Date:   Mon, 11 Apr 2022 12:47:06 +0100
Message-Id: <20220411114710.16204-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=618; h=from:subject; bh=YqTKOAq1Q8o7tdhYQRSBSdCTbkg1kFFmgQcXDY54Ns4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiVBU3SREL7tcNhlsZg2/nvp8hRnPdyJU6xQ7Qfzrz A2ky2+OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlQVNwAKCRAk1otyXVSH0NB6B/ 9dz2gDlrXCt0rpLfhsjpWHEDx94035fVcRBCvdsrmMpUcWuxsI4+pU9HD8kuYLgB6QU1G/IHd+tyEW 4wbDdPw9ie4hpHJfmSPlD8rGc4sTf+wunua3+bjCp7+2ydgUkftWUWY00jww8ovWLefynVoSSSNJGH 8BsOsBYHmszP8h5ocbglnic1sy98mpnj82+x7rua4y8/g+WrzbokVOBH1mj3Mx/8X9uJj7KrOBXssV GPl+aqDVlGpv8nG0m4WcPymP5avDr2G/8PYaNXcVgYNj7oknrb33iZOA2M/SRRRYFpZy1Qi0GYOT0E reVtUZlKXaaQAHmMozf7orQVSzuo0c
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

Currently the arm64 selftests don't support building with O=, this
series fixes that, bringing them more into line with how the kselftest
Makefiles want to work.

Mark Brown (4):
  selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
  selftests/arm64: Define top_srcdir for the fp tests
  selftests/arm64: Clean the fp helper libraries
  selftests/arm64: Fix O= builds for the floating point tests

 tools/testing/selftests/arm64/fp/Makefile | 29 +++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.30.2

