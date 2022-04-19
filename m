Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C783507A99
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 22:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiDSUHh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiDSUHh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 16:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053B26E2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 13:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02084B81BE0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11094C385A5;
        Tue, 19 Apr 2022 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650398690;
        bh=g81LlaPCU3rG4owRNlTDJhJOJADTE1YTnArrDNH4DLk=;
        h=From:To:Cc:Subject:Date:From;
        b=iKrZUxq/EB3ejqEdRlFeBZIVlK9LCn5YkJS6clDicVNQPIRsbzq3g6woUA/SugSrh
         Y2TmnqbVwfKO/vZfVpOj53Pj+30Pa2kjHsj6eiqlBUxT8O2r49jS8aPywSnYFhESnW
         dcJsnM/2hbMn3itfp3vngcj+egZRPglbVK0AOlt3wLeZJoKBxt4PbEGRFFt9LxQu+Z
         6NlrXGGHEQstET3VcBKDWwpoOPNZ/ET8Mlhvzd9jrIDgd5d7F2OH/ZrKixZ18d4Q8K
         sfREnfH6LizTRN7DV2eB/WKBpobMSHwNT8J9KLZaCClgnB5ijCJG1gUZLbNZeN1s/P
         gzraXAF3octQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] selftests/arm64: Fix O= builds for the FP selftests
Date:   Tue, 19 Apr 2022 21:04:38 +0100
Message-Id: <20220419200442.1374548-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=652; h=from:subject; bh=g81LlaPCU3rG4owRNlTDJhJOJADTE1YTnArrDNH4DLk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXxXWQRlsUWevhqCbdgHBkDQ3mwxsdsXOHNVW5wug cX+XcYSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl8V1gAKCRAk1otyXVSH0N+RB/ 9H8VdVkon4Y9MhiZznQjh65WKAckfJErD65pDbYVF44amkqPzev9pR117CcgzTsXHsxxsq/6V/Y37v ZRNGp/dBzSdqFkxQXnHCIpj+1D3YFro71lQIuM2hGqTdp6sn9k+P426aMlSzy4ElRrSs9xnkIuInr3 6o+zZnmdu1vxh0fS707ZDuxQzoprVL8n6jw2YBFJA4oyD1jMntDbKqhGQdO3Y/M4ryg2fEWKtq2PZN lgke3qb0lTgblIbrGtIVIjtXAJL7O1Tr+sr6NybGUMM0lal6I6+/0ZFjvbcnib5AKl5oVwrsE/yhMJ xvSSq0RRV/F+knKlRmmJzDPB+ekcEm
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v2:
 - Rebase onto v5.18-rc3.

Mark Brown (4):
  selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
  selftests/arm64: Define top_srcdir for the fp tests
  selftests/arm64: Clean the fp helper libraries
  selftests/arm64: Fix O= builds for the floating point tests

 tools/testing/selftests/arm64/fp/Makefile | 29 +++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.30.2

