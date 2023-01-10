Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE0664DA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjAJUuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAJUuQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:50:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7621121;
        Tue, 10 Jan 2023 12:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875E9618CF;
        Tue, 10 Jan 2023 20:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F728C433EF;
        Tue, 10 Jan 2023 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673383814;
        bh=qsmIV7z2ROrysoc3ga3c9CM8AWy3O9KvJvYAdYJhtWU=;
        h=From:Subject:Date:To:Cc:From;
        b=DQBq8sbqluqgRT0lRM2TYOC5BR+PwDxoqFft1bIOWQJHsR8HBcUF34SOWEJ1Xhcx0
         yt1zUPXd0QeYBq2DYZA1+aXpL6Hu54q79bfrp+gZvTyKYjRA2Dvy/+4aNQWYPC/L5L
         6vIQaw75LJMl7rcB7+GNREpYoJaqSCUGUGK81hoWCPcwHb2rp2COQRiW8RLqjN9iVJ
         KbsHbkDcyFoSM4uADe4lGUQ8qBAkvPigwmm41QLAoQWt8jRegkDT6lRv7lSQpp6azH
         5UOf4dTLDnuVVODOT+ckmzmjjlyrM729kEAqsP5P3dY9yTEtRbEWpjnMpy8oFS0Qn6
         E6OABqg8tHPRw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/arm64: Improvements to BTI tests on non-BTI systems
Date:   Tue, 10 Jan 2023 20:49:58 +0000
Message-Id: <20230110-arm64-bti-selftest-skip-v1-0-143ecdc84567@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbPvWMC/x2N0QrCMAwAf2Xk2UBb52D+ivjQbokL024kRYWxf
 7fz8Q6O28BIhQyuzQZKbzFZcgV/amCYYn4QylgZggtn573DqK+uxVQEjZ5cyAraLCv2PPKF+pZT
 F6DWKRph0piH6eg/i86HXpVYvv/h7b7vP9nqhUWAAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qsmIV7z2ROrysoc3ga3c9CM8AWy3O9KvJvYAdYJhtWU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjvc+CfyK8IEgBI4hDKykgm0FqQKOuqvSVzd+haxWJ
 jOF8vyGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY73PggAKCRAk1otyXVSH0CgSB/
 9j0SnaRPrsZYjxhQbc+UUmG7l5Z9KKnyJ4AfVnttxBX1LzGDm0oGth9yGK9KZQTyUXHe48OIkFTLxe
 574MzBS6ZcaD2i6KhBu6bWKZEemMufHVYtj0dPbXrlYoNtBt4+s4hft2qZHhJPW2KDpzjjmxteZJSL
 AXsP1Y/j+FlU+ag3u+B/YkUZWaG7NLNvExNjyp25SSnbktgHMJYztDyrog1JX2wB/ugm7XqtgxzRsK
 emQuzZ6yv9lcjUrtg8DmojORg8a8uvZ7Wk6fqh2T0z7XpRovye8PQ6aH9RfUB7j0kxr0ZjwwZJQsVL
 VUaZGzXNEzbAXEzZWVFE8pW6WeWv65
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

While looking at the BTI selftest results on a non-BTI system I noticed
that not only are we printing invalid test numbers in that case, we're
skipping running the tests entirely even though there's a well defined
ABI we could be verifying and the code already knows what the results
should be.

The first patch here is a fix to the reporting of test numbers when
skipping, the second one just removes the skipping entirely in favour of
a runtime check for what the result of a BTI binary should be.

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Mark Brown (2):
      kselftest/arm64: Fix test numbering when skipping tests
      kselftest/arm64: Run BTI selftests on systems without BTI

 tools/testing/selftests/arm64/bti/test.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)
---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230110-arm64-bti-selftest-skip-9fdf5e94fb62

Best regards,
-- 
Mark Brown <broonie@kernel.org>
