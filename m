Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821755DEA8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiIUSRe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiIUSRc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 14:17:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8869DB76
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 11:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98833B828D1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 18:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DABFC433C1;
        Wed, 21 Sep 2022 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663784249;
        bh=CSIxbNEbeMumJImohrgbOtlQTRlNnDfB6GWhqmwCCLY=;
        h=From:To:Cc:Subject:Date:From;
        b=o9QjZuJpku5UkiJkeUBInDBdkC/XbgdvcezWskQTbsIwXNYjMvZZJUknFQP+jDWHR
         u3ZxwKBj1b/qFegaibvPWnXTIcS3jfDUX7rBZfp90MloXDqb6PkycMEyLJYdFURoFt
         SdJfoiyK4Z9bcTNREToGjxnv2jbatdIi3nl1Y79F+RJBjrO2oBXdJoCAcH7C6Iacxt
         V8SwWo7bP/b/GT2RLpt7pEeBgvYzvsfeYc8Ym53me0WoiSA6E9sYTRs+jkaXwsOZg6
         OlvzmaIlmaws/bQ0WzRE2ZfS8IVqlRsoW1vD4X7Bqi2Gy8ywj45UxYFMdpH6Tmh47G
         8jW/epALz12WA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/3] kselftest/arm64: fp-stress updates
Date:   Wed, 21 Sep 2022 19:13:42 +0100
Message-Id: <20220921181345.618085-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=513; i=broonie@kernel.org; h=from:subject; bh=CSIxbNEbeMumJImohrgbOtlQTRlNnDfB6GWhqmwCCLY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjK1RWYRVR0cj658E1js8Yt/DvWYGnoaxYjj87ikhd 1KLal9CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYytUVgAKCRAk1otyXVSH0GrqB/ 91i55mNtRTwND9ncWKkUVeI4O0A8Aj1QNXYZj4feUpwZrjrqffa+TO1IAHKbe6ecvSPHePmZ60NL+l 9Ibmks5apmpHmp0aselHzIXZFEfopBBbfZubfF9AtegrHUdKJh5ZIcvrrqVGTWQ/O029XFOXZtkzpn B2zeIp7oaimD5gVj1YBuT2idXDXGHP+Gtf7DM1djwIZEz48Ugejarn2Lg9i8Z8TTF1dRX0nS7LNGCP M1B7EE9tFr1AcgYurxp0XIVmD1jzIc5NWKwXxI0h7dXbNmXTxgktbtGKkmn+eL0qhsXP7klOBKBQV7 upoYntyvCCrw6d0DKygHI7sH/W/YvW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few small updates for fp-stress, improving the usability with
signal handling a bit.

Mark Brown (3):
  kselftest/arm64: Don't repeat termination handler for fp-stress
  kselftest/arm64: Flag fp-stress as exiting when we begin finishing up
  kselftest/arm64: Handle EINTR while reading data from children

 tools/testing/selftests/arm64/fp/fp-stress.c | 90 ++++++++++++--------
 1 file changed, 55 insertions(+), 35 deletions(-)


base-commit: ea84edbf08025e592f58b0d9b282777a9ca9fb22
-- 
2.30.2

