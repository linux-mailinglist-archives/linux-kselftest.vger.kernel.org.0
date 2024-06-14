Return-Path: <linux-kselftest+bounces-11969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE1390909F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274051F23C76
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE417FAD9;
	Fri, 14 Jun 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CByp6SDw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350A16DEB8;
	Fri, 14 Jun 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383254; cv=none; b=nRaO97TxJHEwaLQuNvqKX5TXRMQt3EYCWHLz+4rI3I0aWL08JNsLC2qcKIZCYRmuFIQB561Z75kL6hibuxhSoHZRVT/jkhX5iIdDW41GnlycZRZfOaNqpbTuhR3PjgT68QMybX5mvanGnuVLm7aQT7MqK0O2IRFT25K0jJC4xkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383254; c=relaxed/simple;
	bh=Wu1djpYKdLoUSz8UIyrvQsOHyXiBbARCLMnJhRaWGQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a6LcSbwrOTSKlGyjMbz6JFFH4PmulzKowF21wTxo4HD6Txhp653mBGmg2e3WAvD+meT1A7MfvCQJO6/bc8itMUqq8cdVJamP4unRt+j1xRwAdp8UsEvfH/5AUUrLIo6G072Yo395qgi8fyZSTJSmgTMudDr4MVp3p9ulIU653Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CByp6SDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F315DC4AF1A;
	Fri, 14 Jun 2024 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718383253;
	bh=Wu1djpYKdLoUSz8UIyrvQsOHyXiBbARCLMnJhRaWGQ8=;
	h=From:Date:Subject:To:Cc:From;
	b=CByp6SDwcRrSnLPgzqPkbj3Q5x0nDwCEmcde2ATFtf7nAXNgq9IY4T8LsxVuI0JxE
	 lfGayROCIu6t3s1Sc+gWuMIsCKEGsbETBR457FnwpNwh4X2l52wb6ruJLkOoO+LNaD
	 5TTs8XQ0Y/SuvxK50aqqcFTJmFz6WTAUcJ3+4etVofD9lCQfxJeybGz0L2KJNhftgJ
	 X99l6MPGfUaOz936WmoAhBZmQHwa2htZz+nF7L2mSJhk8WkOG3a+ZbJ5XgZ2vF0VLX
	 MgUNdS2IHf+W9SYKivJlGVxTS5JP0dw8kKU2IacYFErs7fYrst0NYp+OjVPUelAuhp
	 NaVVGj7tJRyDw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Jun 2024 17:40:37 +0100
Subject: [PATCH] kselftest/alsa: Fix validation of writes to volatile
 controls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-alsa-selftest-volatile-v1-1-3874f02964b1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIRybGYC/x3MQQqAIBBG4avErBswi5CuEi2kfmtAKhyJILp70
 vJbvPeQIgmUhuqhhEtUjr2gqSuaN7+vYFmKyRrbmb7p2Ef1rIghQzNfR/RZInjpQwsH62bjqMR
 nQpD7H4/T+37DiyxgaAAAAA==
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-0bd45
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Wu1djpYKdLoUSz8UIyrvQsOHyXiBbARCLMnJhRaWGQ8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmbHKSVrfFkQw5bt3HgitV4OiUAdlDIjjXDGHii
 CyAzVGbs82JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZmxykgAKCRAk1otyXVSH
 0KY/B/4nN+zWeNS7MpBmJVkNOSoRCwH+6McZ4FSrF9xCEn8qpq7Hpk6BCk7dgXJEmZgLKsYJlqQ
 QRzS1r6sEHQQ5Utf7bSLHFtq38QEAIQE/zgXaAUfTsl3LQaOMmnyMQ1C3cnZyOXM/iCAQWOtO6v
 kVtVRGsP9ANqZklxkZssJk87+ISLRoYIvsl7r/Z00PvBFP16fEBVNa73vKkgZ+410ZE5kEGUpWT
 buWB3b8cuR9ANfFKd8vGym3odpBx/AgkjidppVbOF47r/60hnWSOx+/5R7NNQYLs5cTSduO0Gos
 q4HOoVfmvIrcGiGasHmpz57gBtkP+G1jvP0JbnnVXeRGvj3I
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When validating writes to controls we check that whatever value we wrote
actually appears in the control.  For volatile controls we cannot assume
that this will be the case, the value may be changed at any time
including between our write and read.  Handle this by moving the check
for volatile controls that we currently do for events to a separate
block and just verifying that whatever value we read is valid for the
control.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 45 ++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..dd74f8cc7ece 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -625,6 +625,21 @@ static int write_and_verify(struct ctl_data *ctl,
 		return err;
 	}
 
+	/*
+	 * We can't verify any specific value for volatile controls
+	 * but we should still check that whatever we read is a valid
+	 * vale for the control.
+	 */
+	if (snd_ctl_elem_info_is_volatile(ctl->info)) {
+		if (!ctl_value_valid(ctl, read_val)) {
+			ksft_print_msg("Volatile control %s has invalid value\n",
+				       ctl->name);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
 	/*
 	 * Check for an event if the value changed, or confirm that
 	 * there was none if it didn't.  We rely on the kernel
@@ -632,22 +647,20 @@ static int write_and_verify(struct ctl_data *ctl,
 	 * write, this is currently true, should that ever change this
 	 * will most likely break and need updating.
 	 */
-	if (!snd_ctl_elem_info_is_volatile(ctl->info)) {
-		err = wait_for_event(ctl, 0);
-		if (snd_ctl_elem_value_compare(initial_val, read_val)) {
-			if (err < 1) {
-				ksft_print_msg("No event generated for %s\n",
-					       ctl->name);
-				show_values(ctl, initial_val, read_val);
-				ctl->event_missing++;
-			}
-		} else {
-			if (err != 0) {
-				ksft_print_msg("Spurious event generated for %s\n",
-					       ctl->name);
-				show_values(ctl, initial_val, read_val);
-				ctl->event_spurious++;
-			}
+	err = wait_for_event(ctl, 0);
+	if (snd_ctl_elem_value_compare(initial_val, read_val)) {
+		if (err < 1) {
+			ksft_print_msg("No event generated for %s\n",
+				       ctl->name);
+			show_values(ctl, initial_val, read_val);
+			ctl->event_missing++;
+		}
+	} else {
+		if (err != 0) {
+			ksft_print_msg("Spurious event generated for %s\n",
+				       ctl->name);
+			show_values(ctl, initial_val, read_val);
+			ctl->event_spurious++;
 		}
 	}
 

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240614-alsa-selftest-volatile-d6f3e8e28c08

Best regards,
-- 
Mark Brown <broonie@kernel.org>


