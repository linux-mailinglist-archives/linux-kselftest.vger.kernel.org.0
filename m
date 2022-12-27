Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E89656D42
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 18:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiL0RIO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiL0RHj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 12:07:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B634BE30;
        Tue, 27 Dec 2022 09:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44801B810AB;
        Tue, 27 Dec 2022 17:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D40C433F2;
        Tue, 27 Dec 2022 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160851;
        bh=D42E5y8FdtxfQXs/2hUywnM+rHr45IO+HscRXS6eAM4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Z6L3rseOX3KHQkU1Nm/L3Dd8SZM0rWsj5EoTT6jP9nJo+4k81C6ZkBKhEx0YPd9rU
         3biq7UZS7kmdMvQTj/+/ufxLEFAA9dQtbQ13sOjvaQryTz6ugmTarAvBrhnqc+knbk
         FU0cDWdir3VarbRObpzwHx/i4BZmig9EKG5I041Jn1RlyjoFVFaTQn8CxndttWPNpm
         WxthkWXyAqiOaor8CLFquGyIFb7NwNx/LCQlYaVYpiIVzXJXc+PgDjwCWJOeJSL3og
         iptpp4bxNhP+Drm36eNoqbiAmfs+5md3LaKrIoFcpIsfUHg/8DjxvpK1PYB9lSI4od
         Oukwfv4SqwSxw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 17:06:51 +0000
Subject: [PATCH v4 6/7] kselftest/alsa: pcm - Provide descriptions for the
 default tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-alsa-pcm-test-hacks-v4-6-5a152e65b1e1@kernel.org>
References: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
In-Reply-To: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D42E5y8FdtxfQXs/2hUywnM+rHr45IO+HscRXS6eAM4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqyZEyfwXa5iZU6mVgxLzWh/Mj1JsaY3GxX6l7f1q
 ZmUBMS2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6smRAAKCRAk1otyXVSH0HgWB/
 9a3SG6C4gW8prD/27zhse5YklxGE1xTvfyrbvpu3VvneVrE2T6oE3ytitNwiF0vJYF+9x0USrUcNcq
 EuKIp4KUVC5iCbchad17sKWL4s7kx8qpfrTUu/kA2DhTAztTAnX5CdbSgFHoeVLzE5RVb2P/QyBwyD
 MiSJTsuNbai9Rm3KNvzklhquDKbZk7OOKwhYS3nwt1G1WuxnpgRS4cqEIaJVfVN+RXcNT6TfmCNASW
 enHXned6BDDh8PR49/P7Hm5QdCrJg/faJ1nqyawSEPX6kWmBFGz6PHZg3y8/ML9bcYIxkjCPAnXlIQ
 2HSyKqvZIGA7QiI3lttfsJy6wQ8OAo
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

Help people understand what the standard tests are trying to cover by
providing descriptions which both serve as comments in the file and log
messages in the program's output.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/alsa/pcm-test.conf b/tools/testing/selftests/alsa/pcm-test.conf
index 473a19251b49..1662a8c7073e 100644
--- a/tools/testing/selftests/alsa/pcm-test.conf
+++ b/tools/testing/selftests/alsa/pcm-test.conf
@@ -1,4 +1,5 @@
 pcm.test.time1 {
+	description "48kHz stereo small periods"
 	format S16_LE
 	alt_formats [ S32_LE ]
 	rate 48000
@@ -7,6 +8,7 @@ pcm.test.time1 {
 	buffer_size 4096
 }
 pcm.test.time2 {
+	description "48kHz stereo large periods"
 	format S16_LE
 	alt_formats [ S32_LE ]
 	rate 48000

-- 
2.30.2
