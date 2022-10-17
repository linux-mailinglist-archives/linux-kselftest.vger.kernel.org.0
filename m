Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962156012B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJQP0o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJQP0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375354CAA
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 116D5B80B6B
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D48C433D6;
        Mon, 17 Oct 2022 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020400;
        bh=RuOhSPrvvH9gTDsmvQ1faozljhC23IB8LE8aNw+zUwM=;
        h=From:To:Cc:Subject:Date:From;
        b=ME0RJZehPmF5J9M+OrGVe4q35MKweS8R2IOyvBf+4vyVbnuhwjTFF+uIUGe80ADtG
         0zjN4HGYu5tt+c/KiEn+QIiWv0f/lcUqse8ujN6H3FJsvGF5cUACyQatKJ8zJA4SgP
         Teofs9MnvTc00+dt4MqBk3AKBrq03vGwccfDdoamE7EBWjiMEgYFeS/9HQD1YQgjo/
         tF5ICMZB3+thlluwcdsAIGNxuoKzg2dteZkO2KAQdftJ7MtuKvT2WIWIsVYP6b9XIk
         AoYX6dWfmiyniTdpHQz6JATZ/4nx3lB9zGYcCKaag24hZ7x1JpYD4MhIQwfkLAhC4r
         0k7x0yR7jqrLg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/6] arm64: Support for 2022 data processing instructions
Date:   Mon, 17 Oct 2022 16:25:14 +0100
Message-Id: <20221017152520.1039165-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=broonie@kernel.org; h=from:subject; bh=RuOhSPrvvH9gTDsmvQ1faozljhC23IB8LE8aNw+zUwM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPZXSyr9S2xtMskwYR9ZYxOIaybUXndZ2311UZx iwZoYYCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z2QAKCRAk1otyXVSH0MxMB/ wN2Ozd1xFxfGWYam8QD9ZXG58kwNCtwLIP0UafGO0ZpTV4a4twj81cEag/wyDK8ACBdD1yZgGHIT+L iQqmbUv30PvN2f8mnX9i8FNuDgyNupA1iddx0c4UfMXh+y+9pdRuODAFu3p8WsrxSX7y13elggFrJ3 BV/kS9L42CPkoU9UTdFyf7ON9tvzMvm+Tj9i1ydYgFEnHmla4BAjN/KHNw4NOFdDJawPv64lct8e7U pQ0KaYPEXSsRWG7EcdgE4y9Pajz6IDxpxn4OfzWcweZv1wXg2YyrjYuBy1o5Uuie7xW6hqFgpdYyrP qSRnoGwBCZmUGGZN8cJURpu8Ey/My8
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 2022 update to the Arm architecture includes a number of additions
of generic data processing features, covering the base architecture, SVE
and SME. Other than SME these are all simple features which introduce no
architectural state so we simply need to expose hwcaps for them. This
series covers these simple features. Since the SME updates do introduce
new architectural state for which we must add new ABI they will be
handled in a separate series.

Mark Brown (6):
  arm64/hwcap: Add support for FEAT_CSSC
  kselftest/arm64: Add FEAT_CSSC to the hwcap selftest
  arm64/hwcap: Add support for FEAT_RPRFM
  kselftest/arm64: Add FEAT_RPRFM to the hwcap test
  arm64/hwcap: Add support for SVE 2.1
  kselftest/arm64: Add SVE 2.1 to hwcap test

 Documentation/arm64/elf_hwcaps.rst        |  9 +++++++
 Documentation/arm64/sve.rst               |  1 +
 arch/arm64/include/asm/hwcap.h            |  3 +++
 arch/arm64/include/uapi/asm/hwcap.h       |  3 +++
 arch/arm64/kernel/cpufeature.c            |  5 ++++
 arch/arm64/kernel/cpuinfo.c               |  3 +++
 arch/arm64/tools/sysreg                   | 12 ++++++++-
 tools/testing/selftests/arm64/abi/hwcap.c | 32 +++++++++++++++++++++++
 8 files changed, 67 insertions(+), 1 deletion(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.30.2

