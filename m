Return-Path: <linux-kselftest+bounces-3377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26660837C8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 02:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2AD1F28AFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 01:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A087135A68;
	Tue, 23 Jan 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MrTokDvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F4135A5D;
	Tue, 23 Jan 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969672; cv=none; b=ezbpEaU5Ig9k9rBxbJBlxLt9QhaD4lSBGjqJCrbjvwfie6bU8m4lwPQ0/7mBqgKtPvrGQi5/hnGEaq6cMSXAubZQ+3GHaY3uUyJk3cZRnbzVz/4RtA6m7Sf+J13eFVmMbrZW6xU1ts24EOyCFXICghsHlclx7Vd0rxCkrohCH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969672; c=relaxed/simple;
	bh=VrDnV4sKkCbfB7rSu6GqqmN+jeteq48KPxaAT8t8XtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij6pjGCg48LznPyIT/MPQROZsOMUo1LpNQ/giQMDQN1Y6RC6tlHyPMehBHv6TbkKr8NoM0GQ5uNQiBUuu6llZLU5ZjflJcikRFcWYkIkqtImYJlBmW1xt6Jcg3ERYq1JFRGi9pllR5bN8fpltIsVXgByXn7tBQ9sdS2x0g4HI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MrTokDvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96353C433F1;
	Tue, 23 Jan 2024 00:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969671;
	bh=VrDnV4sKkCbfB7rSu6GqqmN+jeteq48KPxaAT8t8XtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrTokDvrby0oluEFs8umIAQrf53qIWFa0QZOnhGlWHWi9mUb8U3rHHeCGHGfL6MX3
	 Nx1SUBCwHm0n+NObaeM7bOSw9Gb1KD/4NavvM4tj32AKYU6X4y2jqkvAWQFLSdaUvh
	 ayzymtrfjKPZ+jPDDpwxgqE6OTNByARyUd2EjTwc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 370/641] kselftest/alsa - mixer-test: fix the number of parameters to ksft_exit_fail_msg()
Date: Mon, 22 Jan 2024 15:54:34 -0800
Message-ID: <20240122235829.531554436@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ Upstream commit 8c51c13dc63d46e754c44215eabc0890a8bd9bfb ]

Minor fix in the number of arguments to error reporting function in the
test program as reported by GCC 13.2.0 warning.

mixer-test.c: In function ‘find_controls’:
mixer-test.c:169:44: warning: too many arguments for format [-Wformat-extra-args]
  169 |                         ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The number of arguments in call to ksft_exit_fail_msg() doesn't correspond
to the format specifiers, so this is adjusted resembling the sibling calls
to the error function.

Fixes: b1446bda56456 ("kselftest: alsa: Check for event generation when we write to controls")
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20240107173704.937824-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 23df154fcdd7..208c2170c074 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -166,7 +166,7 @@ static void find_controls(void)
 		err = snd_ctl_poll_descriptors(card_data->handle,
 					       &card_data->pollfd, 1);
 		if (err != 1) {
-			ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
+			ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for card %d: %d\n",
 				       card, err);
 		}
 
-- 
2.43.0




