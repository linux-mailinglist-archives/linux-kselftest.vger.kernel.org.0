Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2A4AB7AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiBGJcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 04:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241177AbiBGJWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 04:22:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D2DC043188;
        Mon,  7 Feb 2022 01:22:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s18so23499289wrv.7;
        Mon, 07 Feb 2022 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nZXczi6C0VGVtmz89xEAfWTFn3tEw4CtQGzJll0eCx4=;
        b=C2zZvx93c1YXMt79tE8s8Jb3PihXIjoInyAK1MvgNVVXGccfgn9/SllQZRW1jKrZYF
         2ho9PDLah+3FbqS4d+l2VEvYjavolvmDhi7cQagujQbESdY84abjGgqJOJ9tRhv2Sje0
         z76oNUH8LHs6e1CKpGldvwzh1XJdncNUFItMfL39LtF2/mo1DOxg53yamVyv6+Fl/Dxx
         y10C8NXFT4bhLLwn/aiVMwMGx+Bpx2Wc5xz5KwJ4kv9U36R/cnQYpZlGvw2FyEnGFcw1
         xlaqEbaA3oEIq1xE3oXXoME6BghM8oQoINGDpGqRrd59yNJ4uIVYcKzv0DtC4LjeWffG
         UkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nZXczi6C0VGVtmz89xEAfWTFn3tEw4CtQGzJll0eCx4=;
        b=eBCNdKzaLBVow+DZo2tV3y2mX39O5NxKR1By5Cpbn4pliYsrTR/c6KTp/kycCdvEWH
         wbBmauwmoWs1v5NugKzCOGDZfZBIaVdjb9IRFYbS/NQJjIr+c5tFAND3V04VjxRpC4e7
         qO54iKMhWCteJMo32R0em+17CRMn+sNV9DHKSpuY5vnZesSBJNqS2uMgQSmLypckYjck
         g1vqgxyBeRvkXXpuui6szgHMiz7VZyuksThmHry5TWSJsFcWT/F1btGdDtLchmlJAWFf
         qNQAKFZYzbRMrIy5ODvgJJqeEKsaNLe+EeAg5Yxos48qza6OVJkoL7TCIxXNKTa31b/V
         YdBQ==
X-Gm-Message-State: AOAM5312V/0rXY1vu9JlI/cX/JC+ivWu1PkRKs6QDv1wEEkZsEZvpVXL
        u87Yj2emsDCqkIr7wGFt0bY=
X-Google-Smtp-Source: ABdhPJybMsIXGUh1RzkJaVESTlrR03bfCQ5VzIOs1f03/DoZiXQy4UAlySTzfi0iky0Us5HZSHJx8Q==
X-Received: by 2002:adf:f690:: with SMTP id v16mr510766wrp.707.1644225758361;
        Mon, 07 Feb 2022 01:22:38 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g7sm9866205wmq.3.2022.02.07.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:22:37 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kselftest: alsa: fix spelling mistake "desciptor" -> "descriptor"
Date:   Mon,  7 Feb 2022 09:22:35 +0000
Message-Id: <20220207092235.240284-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are some spelling mistakes in some ksft messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/alsa/mixer-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index d0b788b8d287..eb2213540fe3 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -198,7 +198,7 @@ static void find_controls(void)
 
 		err = snd_ctl_poll_descriptors_count(card_data->handle);
 		if (err != 1) {
-			ksft_exit_fail_msg("Unexpected desciptor count %d for card %d\n",
+			ksft_exit_fail_msg("Unexpected descriptor count %d for card %d\n",
 					   err, card);
 		}
 
@@ -248,12 +248,12 @@ static int wait_for_event(struct ctl_data *ctl, int timeout)
 						       &(ctl->card->pollfd),
 						       1, &revents);
 		if (err < 0) {
-			ksft_print_msg("snd_ctl_poll_desciptors_revents() failed for %s: %d\n",
+			ksft_print_msg("snd_ctl_poll_descriptors_revents() failed for %s: %d\n",
 				       ctl->name, err);
 			return err;
 		}
 		if (revents & POLLERR) {
-			ksft_print_msg("snd_ctl_poll_desciptors_revents() reported POLLERR for %s\n",
+			ksft_print_msg("snd_ctl_poll_descriptors_revents() reported POLLERR for %s\n",
 				       ctl->name);
 			return -1;
 		}
-- 
2.34.1

