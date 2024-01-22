Return-Path: <linux-kselftest+bounces-3383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A254B838471
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 03:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58D61C2A31D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14246DCFC;
	Tue, 23 Jan 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1YLHgrni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD06A354;
	Tue, 23 Jan 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975400; cv=none; b=MEKHDLTCUiMHyOTCHt80ZYZ4BmSmfCnKJhHmZjJh5B0sGFIoUkhSkTNcZ/8okxZBn9xxiEqxV2KePyaIzRox2asJXPqr4Rd0XtBS7SrrQIagYIOB/pC6501C3xVTv3MCVUEXy+rCUCQJ+WR28XRxttrTHYoiasoQV44wF+eOqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975400; c=relaxed/simple;
	bh=c8xwEGJmZiC4PEY0FW+gNYMISXxDbKQZe/pd9tqJpn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge6S1IqEInw2/sTR90PotnZCDKyS2OJTLsfRKKJP3TzWkPhPlUm8dywEosUHCkMuPgrMrBUDV1LfSG6RFfsUpCTZLwC8d6iFjGzcDdusvjjsXIvQ02/DsUHyOqK34oZDXZibEJOoSjcF8k7mnccOY41vrwmhP4LZCZCklDOAfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1YLHgrni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAAFC433A6;
	Tue, 23 Jan 2024 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975400;
	bh=c8xwEGJmZiC4PEY0FW+gNYMISXxDbKQZe/pd9tqJpn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1YLHgrnii0OaGB759RzptkHq++PzwubjUdM9n9ZIk2OPWBk6pI+hvZZHfFJGxAyah
	 4v/3BuQSw/hFRl6neAcly4RMATXxo/D9Ef32+4gHqflMykTDFcEidmsCblZlRtlsnR
	 kOxdprmrKayCk/vpy8M/qLLsfS38K+j5fyzltFow=
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
Subject: [PATCH 6.6 334/583] kselftest/alsa - mixer-test: fix the number of parameters to ksft_exit_fail_msg()
Date: Mon, 22 Jan 2024 15:56:25 -0800
Message-ID: <20240122235822.259476148@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




