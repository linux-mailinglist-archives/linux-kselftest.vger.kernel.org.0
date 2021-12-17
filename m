Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548C478BF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 14:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhLQNDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhLQNDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 08:03:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D153C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 05:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD3A762063
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A8DC36AE9;
        Fri, 17 Dec 2021 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639746180;
        bh=TY0V7AI9o/rOip8k5bSrB5QxCjKmjF4nwvLn6k9eTZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YT+5XX249OrNlx+PHAC4OvXpCQx2jGPno4CZKU42Z4JJ49iVxS346bWX84YcJIofg
         gZyqMT9v4zLIGjzkuidRt0PVz6GZHzw1K9xVlZMo3SS0l+uWYSoi4+axICdhtGhc6i
         9gl6CuezV49aIop3EDmgB5hIktSTU+wqFq747UASsZrH7EdxKpps4QVmz1Y6kWeyr4
         v/ujxr1pt8C5j9LFkCTGelhRR0tlxnZ+2i7kDkk72gLFPA/dvNLUYwBBSP3Wx2FRUY
         L5Ks1auNt6XrM224gg1Cm+ILMF55ufJEn61/EJ5IWRs7qf6zon5Td7LlZzzvcH7XPS
         qypNWf0srfVjA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] kselftest: alsa: Validate values read from enumerations
Date:   Fri, 17 Dec 2021 13:02:13 +0000
Message-Id: <20211217130213.3893415-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217130213.3893415-1-broonie@kernel.org>
References: <20211217130213.3893415-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; h=from:subject; bh=TY0V7AI9o/rOip8k5bSrB5QxCjKmjF4nwvLn6k9eTZs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhvIpNINJsd9u2GOqr2y3tsCH8PH/9AGzxFQF4/bEv EMPMliiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbyKTQAKCRAk1otyXVSH0IQQB/ 4q/VupXstKGRjhr7iapGoDkw1zEGSo+Ay/40Tvnuzw7de5MrKUxRgVO9xcEdfThm115wc9ZKBdyWFI rL3Tyi08koEZKG+XtGyyeFGglG8PdAAhahZ9nw4kdIzmvT0rZPiVqtY0H773w/7DZ82bPkX0L2nO4x 7SnNrDS/t41yqPvRDx6UlLjCXKDgTq+2SeVmJQKM9DYXo1usT8ix849MhJ3BbOA1I4Q9GWQL/dLJ3p wHD1spotYn9zhU/1FHc3Vv+MDqmjeAaAmQvfpUGw0KzCwjOCDPA0lfP1BVNeWM99ZxpD6zdcbrKItl jj+CrxTWxbAKoU4WDycZihXYoLT7Ib
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enumerations should return a value between 0 and items-1, check that this
is the case.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index b009fc5df605..17f158d7a767 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -276,6 +276,23 @@ bool ctl_value_index_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val,
 		}
 		break;
 
+	case SND_CTL_ELEM_TYPE_ENUMERATED:
+		int_val = snd_ctl_elem_value_get_enumerated(val, index);
+
+		if (int_val < 0) {
+			ksft_print_msg("%s.%d negative value %ld for enumeration\n",
+				       ctl->name, index, int_val);
+			return false;
+		}
+
+		if (int_val >= snd_ctl_elem_info_get_items(ctl->info)) {
+			ksft_print_msg("%s.%d value %ld more than item count %ld\n",
+				       ctl->name, index, int_val,
+				       snd_ctl_elem_info_get_items(ctl->info));
+			return false;
+		}
+		break;
+
 	default:
 		/* No tests for other types */
 		break;
-- 
2.30.2

