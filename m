Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF465B6FFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiIMOUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 10:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiIMOTF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 10:19:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB47642E6
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 07:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BF3EB80F02
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 14:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B96C433D7;
        Tue, 13 Sep 2022 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663078308;
        bh=XbuMF/e0sBc4Kp8DlVrMfNZibyp0UP0902gYdkyg8R0=;
        h=From:To:Cc:Subject:Date:From;
        b=goC0MYDXBipz6EZusFrcilAHHHDuqqOrRPONylsyc5wGGLf7lEUDO1X8hCtf+hYKv
         Alf+IByggdMNh433OGFRFRQjY0I4ntMD8qh71j8cDlfocmSw7EBLFwqgTCYfK6RwKK
         U6stqHnNDTiQib2C6MIwSPeMeGhWfSiI+wQGavhGC2zLAjWwMaOdj23qM7xvwk2ZYY
         +hUY9n4JPNNFtE3ledmq1VjpHG+rEiJy5t//YS+OGLNJCDjJQuWsTJC7gijPZS3BKO
         elJgJ4NFb3bJMq2oNEK7uMUiLIOzGdh1s5ZwMlQ3w5FNEQZszUz7GnMexmU0dpch3z
         sIGgL5BVvHLUw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/3] kselftest/arm64: Updates to the hwcaps test
Date:   Tue, 13 Sep 2022 15:10:58 +0100
Message-Id: <20220913141101.151400-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=575; i=broonie@kernel.org; h=from:subject; bh=XbuMF/e0sBc4Kp8DlVrMfNZibyp0UP0902gYdkyg8R0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjII9yVIo15BLAHDrBxo+W2it6vWt9rtCqYWxJtogq r6zSftGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYyCPcgAKCRAk1otyXVSH0LOMB/ 9FSDstufZwRMQ8AgOseUZSt+cJ67usq7eVYnlP8if6WZGF8LKnBfxJVcShAnnvGqSOci8kj5ngsrTe 8gBca0DwyVvmIekfv0KY3JQeP5bIXR+nm1PgE8kq2QUefmtzZvf8FBLonHw1JuWZjdOFCqUdLAtsZL Rf/FGPbromR7RnglsH8GF6TC4QUJqwq51l79uRCWOFuvvNV51LJbHbEJtcwjIBNRppNUKoRbFIxmO5 vDY5emr+goie5JUcWyQ7PQz2eBsAcQKMB/4OUQKfESfqwChhRSCZZqN15f9neL9WuTC48m5DWFgVxe U9v1cemJpIAr7qqFqWXQvjd3Xs+Can
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

This series fixes an output formatting issue then adds a bunch
more hwcaps to the hwcaps test.  This includes the recently added
SVE EBF16 hwcap so this requires both for-next/kselftest and
for-next/sve.

Mark Brown (3):
  kselftest/arm64: Add missing newline in hwcap output
  kselftest/arm64: Add SVE 2 to the tested hwcaps
  kselftest/arm64: Add hwcap test for RNG

 tools/testing/selftests/arm64/abi/hwcap.c | 150 +++++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)


base-commit: daecb3077f330058d1c53de32d272bc23ff61a25
-- 
2.30.2

