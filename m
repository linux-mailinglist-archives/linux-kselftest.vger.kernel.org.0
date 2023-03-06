Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C326AC55A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 16:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCFPei (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 10:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCFPeU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 10:34:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6AA4ECF;
        Mon,  6 Mar 2023 07:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF7261012;
        Mon,  6 Mar 2023 15:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA15C433A7;
        Mon,  6 Mar 2023 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678116818;
        bh=7+nAtHf2/40sJdNDudrlb9sywI5p24XSs9r4jtaXcho=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=swgC7WJo+uPv82x70+Bo9D1vcq7rpG+Bp3FC2WVZCMnru14hGHhSmUpuNvozX5O5C
         0mVzx2BpmJ8kY47FTsnMdaYyNvnBq5yAeJuAsf/lJcAouob+vErhxr6YooyhDTgXRr
         /WZx18ciPEirdlqH80ylft6mTuitZzAjUdZNf86DZtZHEzAgCbaHqE9izbqHFnQtXX
         slSQxP5oPY0PvFizyZ5dpcNHU7CW9JcRvoO1yDpLWKwXXW4294ABbc8pJ2jAmWor4j
         QowkisyLZcUvhqd5wg5gMYVaTv+b9ZXX0G+Rg+IPsQjrlk/UgsSO3QKxANNtbMM45r
         l/F1L54KBmVAg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 15:33:28 +0000
Subject: [PATCH 1/2] kselftest/alsa - mixer: Always log control names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-alsa-log-ctl-name-v1-1-ac0f10cc4db2@kernel.org>
References: <20230223-alsa-log-ctl-name-v1-0-ac0f10cc4db2@kernel.org>
In-Reply-To: <20230223-alsa-log-ctl-name-v1-0-ac0f10cc4db2@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7+nAtHf2/40sJdNDudrlb9sywI5p24XSs9r4jtaXcho=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBgfNsxpvllJ20MQSB8Ro22PZttfPXnQqWNYGee+C
 JodG21iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAYHzQAKCRAk1otyXVSH0EF2B/
 9Kpuja8aY4ykr8vAYRIXEzSKrLR3yhtIg2OPQ/XSUdv7+E+UvHmfF+8dZocSRsFZU5+VpFJ8qF8n2X
 o+ASKKAdLxmBHBN2Ob89qTbSbM8fYFxzE0E1OifWoXVOrSfkcJK+zcSiYezsQU/2vtlzPzVPzRqFHe
 aa5gN6X119dqj2G3KIqNQB1m0/k+im4ktAi6RPtk9KLlC3u8SWDs3zAJaUE6id9b7vgl8nKV70wpwt
 TCiZUjCsAkRGy6qhSS/WSy/Yo74qbolAJ5ongTq/XEfeV61L11ZZMGH1YoYLg2DDJs3CZmkhmwjxt1
 yydw2lis3VywnxrUHi8srI+AsNCefm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we only log the names of controls on error but it can be useful
to know what control we're testing (for example, when looking at why the
tests are taking a while to run). People looking at test logs may not have
direct access to the target system. This will increase the amount we write
to the console, hopefully that's buffered.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 05f1749ae19d..12f58c9c17ab 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -422,6 +422,9 @@ static void test_ctl_name(struct ctl_data *ctl)
 	bool name_ok = true;
 	bool check;
 
+	ksft_print_msg("%d.%d %s\n", ctl->card->card, ctl->elem,
+		       ctl->name);
+
 	/* Only boolean controls should end in Switch */
 	if (strend(ctl->name, " Switch")) {
 		if (snd_ctl_elem_info_get_type(ctl->info) != SND_CTL_ELEM_TYPE_BOOLEAN) {

-- 
2.30.2

