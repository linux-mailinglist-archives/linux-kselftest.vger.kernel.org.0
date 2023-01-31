Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACA6839BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjAaW4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaW4w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC926AF
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 306B76173D
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 22:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC45C433D2;
        Tue, 31 Jan 2023 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675205810;
        bh=r9zFAcCDC9u36l4cZwW0HdkMNBYXJGy6sbJP8D7ZUcU=;
        h=From:Subject:Date:To:Cc:From;
        b=lMPKrC/fiHlb0XN+meN84yIW5Uiko5DdVp4qBQaZ6r5x2Eo4oK5LJkVhQAmJlYnin
         Y7XP8XRbJmaBe8dWwRrc9w4EyGr5EmU3i8A8gjmvnWYIlkjWufrBFKOeNUjD/cthBZ
         eqYDcP2qmyB7yO7+x7RsyMi3k3dME+P44C4D9/uB1VSpnPuu1ZvEH0Fn8Q7LSstuWY
         Brs7phcsGqqSZ4Zn7FhXr1rzdaQ9cHKgJe9rmPjQxjWJpU01jAt7cLCDbws7XufR5p
         FFsENtgS+SQgrlae58cvmcUapfERq27NqYDb9XrEOUgoPYL1S1Z4sBLlBInE5HboEr
         rv44ZGcNAfnug==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/arm64: Fix enumeration of SME VLs on systems
 without VL 128
Date:   Tue, 31 Jan 2023 22:56:33 +0000
Message-Id: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKGc2WMC/x2Nyw6CMBAAf4Xs2U36UIP+iuFQ6AIbpDW7RE0I/
 07hOHOYWUFJmBSe1QpCX1bOqYC9VNCNIQ2EHAuDM84b6y0Gme9XnJTe/UK6oPKAOhOmjNbVWMf
 o7MObW/AOSqQNSthKSN14ZH5ZpkN/hHr+n99Xs207gfmEr4cAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=r9zFAcCDC9u36l4cZwW0HdkMNBYXJGy6sbJP8D7ZUcU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZyuEzHhXZrW7uLcd/h1UKqBpoWh85K4wV3zfS6b
 PB1pjdKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mcrgAKCRAk1otyXVSH0BumB/
 9uKe2/vH/ZGki/V0znR8cDRIvZpaaIww5Q1LoOm/m8G62AquggtQp/9lVSm6Lhg6KeRP7ogVbtU7fx
 g5oxfZQOkgmI4e87cfxJQwEvEqLAgEL5MZ1xZEQA1hYkvRjdchZkCM3L57/emNhFA/m2u6wncd/HZY
 8exNx9wb5dmIOepQbgHWdp3IM5EhImAWVKGZWeCbYqZqlN+RAvHJ/dpHG6V+JRnxZpytL5L/lUd5nW
 akoTwe/Zf+77S3QMCrJBvjYoNM9SpxQ0nnZuimo6ZCe6YZPCO6/rji8emmOP9oAX1tDffehKAqU4e+
 sEvkOxaUFaFFSkFScX8/Rp33SsXQzG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These two patches fix a repeated error with the way we enumerate SME
VLs, the code for which is cut'n'pasted into each test.  It's in two
patches because the first applies to Linus' tree and the second covers a
new test added in -next, even if they're both applied for -next now this
should help with backporting.

It would be good to factor this code out but that's a separate issue,
I'll tackle that for the next release (along with the general fun with
the build system in these tests).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest/arm64: Fix enumeration of systems without 128 bit SME
      kselftest/arm64: Fix enumeration of systems without 128 bit SME for SSVE+ZA

 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c    | 4 ++++
 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c | 4 ++++
 tools/testing/selftests/arm64/signal/testcases/za_regs.c      | 4 ++++
 3 files changed, 12 insertions(+)
---
base-commit: 8154ffb7a51882c00730952ed21d80ed76f165d7
change-id: 20230131-arm64-kselftest-sig-sme-no-128-8dd219305a32

Best regards,
-- 
Mark Brown <broonie@kernel.org>

