Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD16752219A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347646AbiEJQts (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347599AbiEJQtl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:49:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25691FC
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 129ADCE1F65
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7465C385A6;
        Tue, 10 May 2022 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201138;
        bh=RqMQj2FgPffXIasZ6S1LlLrssuO5z7pwAA+xHAwzIZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qZxrv6DIF16y0EfCcBQlgZUS99hJ5LsDZ1SZdJsz0+tgNKGRNVcnDI4/y6HD4mrqE
         fUSx5OeOILBGlgjEVCG/Vnfk7JJNr5W3oZzr7LmaZmZRH73NFxK9PAdAEfGdKYW7d7
         7qC2fxcg26NpjilaG+vWxL9BkotXN3bfr0aCOwFXvZrrCkq8IxVtKsH/XOvkmQzwRg
         DiqafLBbZfFDzjqwS6mMS8BNRkEA/RLlNCqqj4W55lnR38xbzLXBF8U+koRUPaWUhW
         QjxZHuvgOgwIePKUOwODS4oPch3ITiVuYhtdV/+h/0FUj0tyxtWoJfdvx4S+GCEaSd
         6q/KsDQBEOluQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/5] selftests/arm64: MTE check_tags_inclusion cleanups
Date:   Tue, 10 May 2022 17:45:15 +0100
Message-Id: <20220510164520.768783-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; h=from:subject; bh=RqMQj2FgPffXIasZ6S1LlLrssuO5z7pwAA+xHAwzIZQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiepabe4GjGtVwZBhqCHjbow5PFt5W5oYa1LvxyWDq 4KPTu4OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnqWmwAKCRAk1otyXVSH0GgyB/ 9YczG0DBKzv4pYk8XjbmcfF4tdCxvKtgWY3MeKLwiLZtyELoNT/cAYvhooUCsc76VuMmCFcFCGv0b8 GpTFI7GRsrvKRfIHsDA6TTRB4X41t5SIXKR8SHTHo7L1Iu06FYEH5po10rBhe8X5VI53tqBLR13yTl NKGeE4ShHCe3jrRM2umhXSIKLiJnSP74gVYDSSd7PiW9KcSVInkXfUkSpIhZCQgSOmtlSg3OT2VI6v o7XyHbHa9ln42G6Hk/v0KTbyV9LidmPwITtZ8VXP2N1zHDi63SMpQyxUPDT8vGWz9CpouKRdXI68y3 SNp3QOks1MCsA6CMmQEBTxtOgCe7H4
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

This series contains some random cleanups and improvements that I came
up with while looking at the check_tags_inclusion test.  There's nothing
too exciting in here but the changes did seem like they might help the
next person to look at this.

Mark Brown (5):
  selftests/arm64: Log errors in verify_mte_pointer_validity()
  selftests/arm64: Allow zero tags in mte_switch_mode()
  selftests/arm64: Check failures to set tags in check_tags_inclusion
  selftests/arm64: Remove casts to/from void in check_tags_inclusion
  selftests/arm64: Use switch statements in mte_common_util.c

 .../arm64/mte/check_tags_inclusion.c          | 54 +++++++++++--------
 .../selftests/arm64/mte/mte_common_util.c     | 25 ++++++---
 2 files changed, 50 insertions(+), 29 deletions(-)


base-commit: ae60e0763e97e977b03af1ac6ba782a4a86c3a5a
-- 
2.30.2

