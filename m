Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE62478BF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 14:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhLQNC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 08:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhLQNC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 08:02:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F0C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 05:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA0B621AE
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A46EC36AE1;
        Fri, 17 Dec 2021 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639746176;
        bh=49hLGTchRJ2Hk5xl4QHps7qmByi8UxeYOFjwOmMV8lE=;
        h=From:To:Cc:Subject:Date:From;
        b=m5Yc/v4HY1ojcF/RDjAj8L8iASEnT2gNcbcEPOGjEnu2zuWGlllOO0wo0F1KQI/H7
         5PWdvvcI1H+8eSI92KtNDIvOyOasiDrebB4uLCLHAOpIy4vApILjtpd9ifrKsmA40z
         dfVHeXqpjMUtwnIE9LngtEgAoqXTaocWiLz0ivBwGSXh0cJlL4FWXcj74/u8IMl99h
         1rSXge2DMYjjoJIfhPWmeRyvGy6iZuXUqBvSeBIbY8U61BGOGzToohS+bmsBNKsO1U
         x3BF5kQfA85ZhMZlzgzpVkSwpQUtqYHtPnvCRkfiO/+xwPbE8ZSvEnQ9RLJa+WB4aA
         rP38wtQ42bipw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] kselftest: alsa: Small enhancements to mixer-test
Date:   Fri, 17 Dec 2021 13:02:11 +0000
Message-Id: <20211217130213.3893415-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=621; h=from:subject; bh=49hLGTchRJ2Hk5xl4QHps7qmByi8UxeYOFjwOmMV8lE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhvIpLCX2gvUydmrsOwTwc9j8G5dLbbW7HK6JbFoDD 0kJNWtaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbyKSwAKCRAk1otyXVSH0EN9B/ wK0xX1ZOaUX7Pnr0jfTgk/tHDIBsOeJ5/AOlSUL0veGgPAIpHi/lu0RICLCr2Sy0vhKo79eoChbJ60 MuZcY1f7beqQ6ddJ4xnCdM7GhMJmwYgFJRtpvo17ASWhzAwKkWIZVECtNjoxw8ZzeASIGpehdSb/o/ VgsrPLNrysZAuXvMkKpbbrasMewoDrpjS/UgG1M7disBu8BiMTC+tg0WCqI2NyPNUoYuT/zvUgJnsm Alo3TZB+gJQChAN+zXZ2DYmWCMKvajhoQ2wyCbphIfBKLJ1RY76iMEqf81a9Dy2dTlKvmE/zQoHYE6 Mht0yzB/0hLg/yzV9CvJTf9kQGdrlj
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These two patches improve the mixer test, checking that the default
values for enums are valid and extending them to cover all the values
for multi-value controls, not just the first one.  It also factors out
the validation that values are OK for controls for future reuse.

Mark Brown (2):
  kselftest: alsa: Factor out check that values meet constraints
  kselftest: alsa: Validate values read from enumerations

 tools/testing/selftests/alsa/mixer-test.c | 158 ++++++++++++++--------
 1 file changed, 99 insertions(+), 59 deletions(-)


base-commit: b73dad806533cad55df41a9c0349969b56d4ff7f
-- 
2.30.2

