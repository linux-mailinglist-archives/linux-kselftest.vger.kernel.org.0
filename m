Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6D74C1CF
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGIKHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGIKHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 06:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C6183;
        Sun,  9 Jul 2023 03:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC39660BB8;
        Sun,  9 Jul 2023 10:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C42C433C8;
        Sun,  9 Jul 2023 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688897229;
        bh=YiC7vsFEwKb4652ST6mgQTuJ5tIJjs2WjiDvNytTSkA=;
        h=From:Date:Subject:To:Cc:From;
        b=ak8eYXRykzYaZ+CT8VZ16gkWxFdhtbScVb+ZvC9HD/YYtk7Y7Ym8SSnrUmiZZdP90
         Grkri2piYNGS6NTkkTpqtQf2tcJcSEDg4uT9ElY7Zj96SfVLtUAG4jTk9G6EMZcq6X
         yoGbUxvPH+wsT8T1KmBO0PyGaaqecFCL2KXoeUUCat2kcGT3FSxSpj55iOfYJd3r+0
         rCT2YVHSEWIynhea7+1uTQPDqjDJvYd9GBJ2pxMc9Db0ni3ENEVSmyA7xm84AypmCE
         ykaA8oK/tFP97AGaJ6kSpf3gtrJdzaQklNpCZ52QvAFQ5o0vaHv0K7q/DUAYi8Ruf6
         ejR5JGuAeOAdg==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Sun, 09 Jul 2023 12:06:56 +0200
Subject: [PATCH] selftests: hid: fix vmtests.sh not running make headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230709-fix-selftests-v1-1-57d0878114cc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL+GqmQC/1WNSwqEQAxEryJZTyC2Cz9XERf9SWtAeoaODIJ4d
 1t3Ll9VPeoA5SysMFQHZP6LyjcVqD8V+MWmmVFCYTBkGmqpxyg7Kq9xY90UfefIhRjrYAiK46w
 yumyTX27rNb77X+aSPX/jdJ4XvvrwRn8AAAA=
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688897227; l=1238;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=YiC7vsFEwKb4652ST6mgQTuJ5tIJjs2WjiDvNytTSkA=;
 b=i8Cad3ZOWxNgSbxUlrlETAV29S0Wk04029Ut4MMM0wYaxWf3haJ9O8kHyIOWA3MVyaNT9lKm0
 yPkRH7D2akoAKHeeRzPYxjnuMgEpBWOSOZQg/HRyIirjpMVbcU5OC3y
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to commit 01d6c48a828b ("Documentation: kselftest:
"make headers" is a prerequisite"), running the kselftests requires
to run "make headers" first.

Do that in "vmtest.sh" as well to fix the HID CI.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Looks like the new master branch (v6.5-rc1) broke my CI.

And given that `make headers` is now a requisite to run the kselftests,
also include that command in vmtests.sh.

Broken CI job: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/44704436
Fixed CI job: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/45151040
---
 tools/testing/selftests/hid/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index 681b906b4853..4da48bf6b328 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -79,6 +79,7 @@ recompile_kernel()
 	cd "${kernel_checkout}"
 
 	${make_command} olddefconfig
+	${make_command} headers
 	${make_command}
 }
 

---
base-commit: 0e382fa72bbf0610be40af9af9b03b0cd149df82
change-id: 20230709-fix-selftests-c8b0bdff1d20

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

