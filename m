Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4D6C899E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 01:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCYA1p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 20:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjCYA1h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 20:27:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C101CBFC;
        Fri, 24 Mar 2023 17:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43EDEB82643;
        Sat, 25 Mar 2023 00:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAC8C433EF;
        Sat, 25 Mar 2023 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679704048;
        bh=cvUWWtgA1J7mommYPeAxxudQwTezoPJRTlpvvuo3EGg=;
        h=From:Subject:Date:To:Cc:From;
        b=KezCvTI+FE0RZ2jiu3p2o8+HcfbK4KDT/9YmEC3TBanBpuoBBYwKq4yqojQeKsz4s
         vxn4ZxVPpRK6OyhP89rdw3kqv3MIE6Y8Bk+s72b4CWIBbIBS7tgUDCTHlMoWOcehtM
         4rXmCXY65Z4TGOG8Ns9BLactN/AqsO/gDzaN6OSFo/ENyDD9TI3uW3PoBCSjX1aWNg
         ZW0EYxBCeoziDcQWWd/orNB3aSNOWdo6q3mudsR1ps3oJWSqFEyJu+45WP/bQgGOx/
         nBPv7LrGX56E775JRI9qhKnNSXx/Vq8RNePa+VbQM4RsONfHpi/CVR5n8rEW8oTeTt
         jh9Fk1+/f4AJw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regmap: Initial KUnit coverage
Date:   Sat, 25 Mar 2023 00:27:16 +0000
Message-Id: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQ/HmQC/x2NwQqDMBAFf0X23AXNVpD+SukhSV91kUbZVC2I/
 97Y4wwMs1OGKTLdqp0Mq2adUoHmUlEcfOrB+ixMrnZSi7uyoX/7mccl6YdDkCjoGkgbqSTBZ3A
 wn+JwRttk46lnw0u//8v9cRw/NFVvmXUAAAA=
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cvUWWtgA1J7mommYPeAxxudQwTezoPJRTlpvvuo3EGg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHj/rtwPuUQdzTRU/flQ8gIxbAoSvb5Q+om8zLSvd
 fyx2AEiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB4/6wAKCRAk1otyXVSH0GCmB/
 9/UL+KlpKCOOLrPJ2A+508m0onmrBQlbIYzvsj6yxv9+1//f5pCNWWgb9RnjUvqr5aPwjLVUupXwqq
 3fodDQJDIaNADvhmTrf+rWqSgLge81eFDAfHmH1AjYXS4G7juy2nzzqguA3ylT5Wv0D4lV2h4riGZP
 Iw+v8C2q7wxgTozAglkMxdFtAdb3luF7evkRDZSZNzxEZxTgmFk/0OfYRld1rkggiiVUgS/HlZiW8v
 X11DkR23WKkc3vRwBNv86SJug/8jseJRIIuaUeRyqqcNSW1ZqYwkZAe0jEUwbEyprXT+umvwFN9rpt
 pO5zhNc7cFucV/2mM5lDMVyyFqg0hE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series provides some initial KUnit coverage for regmap,
covering most of the interfaces that operate at the register
level using an instrumented RAM backed bus type.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regmap: Add RAM backed register map
      regmap: Add some basic kunit tests

 drivers/base/regmap/Kconfig        |  10 +
 drivers/base/regmap/Makefile       |   2 +
 drivers/base/regmap/internal.h     |  19 ++
 drivers/base/regmap/regmap-kunit.c | 631 +++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-ram.c   |  85 +++++
 5 files changed, 747 insertions(+)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230324-regmap-kunit-bb3c3e81e35c

Best regards,
-- 
Mark Brown <broonie@kernel.org>

