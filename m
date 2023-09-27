Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A377B01A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0KTN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0KTJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 06:19:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF3210C;
        Wed, 27 Sep 2023 03:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18759C433C7;
        Wed, 27 Sep 2023 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809948;
        bh=0PmME+5Au82O+VzIZuXB83pi8BaLUH3zUZNmXJdkrUw=;
        h=From:Subject:Date:To:Cc:From;
        b=UUVM9YpTeVoJO7P9hubHPoCkeQFm1IGkHTUaVajqOqHbJigSKZkr0pN0IkSjW3xqX
         F0yKQniqdk+kNmIvXzKbFFIaqA0WDX4tro39EcusJujOF3MEuwutz4H0o5NoX6c6nO
         vIaVIsUUGa85ciSfeWaUT1f5nArjW2mVn7XnsyRUBTbRogpMgAifiTsJxA0Nl6nUdl
         4vq9gh785fcHtUj4K4hCJo0dzOd/O/kCDobeJ2Z3b26irOUwB8dVs5Q4kSWZKkYomg
         fIlcAMZDD2IR8+gR2mIXrBQh5LnYnByF7Sdw/ARtqOxnyWPtUMD+2r3pnVoUrBqK1w
         uAf8h3oiFR8NQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] selftests: timers: Convert some more of the timers
 tests to KTAP
Date:   Wed, 27 Sep 2023 12:18:56 +0200
Message-Id: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEBFGUC/x3MQQ5AMBBA0avIrE1CUeUqYtEwmIhqOiKSxt01l
 m/xfwShwCTQZxEC3Sx8uoQyz2DarFsJeU4GVaiq6JTG/bIe/Sn84MUHBUHdUteaWuvSNJA6H2j
 h538O4/t+Gqfw/GMAAAA=
To:     Shuah Khan <shuah@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0PmME+5Au82O+VzIZuXB83pi8BaLUH3zUZNmXJdkrUw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFAGXHvGD3YtH5Be1xhGkqOjkUjLKQQ+Q8Nsbe
 bdu8rk1DriJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRQBlwAKCRAk1otyXVSH
 0MJGB/94fv4Ns+92xD2BTjAF4KBDDqEgvHJZUOUnmdoFrI9d+PowvFNZtxT0W6+0hZzIlcD1vZb
 uW4D97T6Zzylj0Svz3HYyv2um0EeLG5IhsQDIMVtkuJPTwJYhUcxCuRREhX4cdnsOd2cMzdiOFj
 fL+LVmjY3bEwIQvQi2KH8JQ62fHbYgcVDpvoSKSWGzi/Sd3WHHK1rSCAkKzQw8jpA/ePC42JXO+
 MtKOY++xh4+NtJDvlHIM5MNHnZewcSl045TIc5A+TbouC66mi4Zkrsk+Ve0XmJ5PreWFI/7Chy+
 fqzQlC80GLWOUyC78mVDIrM95vmOtY2FAB6jk9+Y+0521wXd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KTAP is the standard output format for selftests, providing a method for
systems running the selftests to get results from individual tests
rather than just a pass/fail for the test program as a whole.  While
many of the timers tests use KTAP some have custom output formats, let's
convert a few more to KTAP to make them work better in automation.

The posix_timers test made use of perror(), I've added a generic helper
to kselftest.h for that since it seems like it'll be useful elsewhere.

There are more tests that don't use KTAP, several of them just run a
single test so don't really benefit from KTAP and there were a couple
where the conversion was a bit more complex so I've left them for now.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      kselftest: Add a ksft_perror() helper
      selftests: timers: Convert posix_timers test to generate KTAP output
      selftests: timers: Convert nsleep-lat test to generate KTAP output

 tools/testing/selftests/kselftest.h           | 14 +++++
 tools/testing/selftests/timers/nsleep-lat.c   | 26 ++++-----
 tools/testing/selftests/timers/posix_timers.c | 81 ++++++++++++++-------------
 3 files changed, 67 insertions(+), 54 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230926-ktap-posix-timers-67e978466185

Best regards,
-- 
Mark Brown <broonie@kernel.org>

