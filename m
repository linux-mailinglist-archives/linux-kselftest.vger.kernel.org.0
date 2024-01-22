Return-Path: <linux-kselftest+bounces-3384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EAC838473
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 03:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762571C2A334
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7166DD0E;
	Tue, 23 Jan 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mLTTD0JG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED86DCFB;
	Tue, 23 Jan 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975401; cv=none; b=IDbPDFpykikhwhW5q07ObpccMUANOGvcNsDQ4DjaRkFFI8r1vTtrlKiGduMYni7hz0PKKGiA5CBbaeTKfUxsyZkPnt6HTGAN0f/I15oidyLroINgweqodmftdXAYxGv5YjdVL85SGSi7jnB5XwN81ms0WEPEahh2t05dCPvOmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975401; c=relaxed/simple;
	bh=dBSnXot8tbZMBZAoqjrEB2uU5x3A+53cTEVWdeDC4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6BlXLkS+peUIzgQd3EIghi1yrhRl7wKHoB2h2aAuQWsHpFlKsVL+oHM+Te8NcxIFeop5rbJXd1g2xnaQggo+CNb4d+8cb/270feJu1UHELuWwdKR321FwXtJ93Ov1rU/q3Z7APG2J0cITn30lE1S3l9wL8cP3IFTXiCNOcmjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mLTTD0JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEDAC43394;
	Tue, 23 Jan 2024 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975401;
	bh=dBSnXot8tbZMBZAoqjrEB2uU5x3A+53cTEVWdeDC4jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLTTD0JGRZbpx3gymdnXbt5JaufnnPo+9v4jZBhxcxDy8/hhdjPS/J/jHy6KETGND
	 WZVAyIsm64DF/E4yLmykqRJuYUKy/AdWPdVY4iYG/FAPilLVfQXa6cF4vkXuXof5XI
	 C34/b1clkf1Zm2klSMUMsB2m7aiEjvArTRs8Ogcc=
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
Subject: [PATCH 6.6 335/583] kselftest/alsa - mixer-test: Fix the print format specifier warning
Date: Mon, 22 Jan 2024 15:56:26 -0800
Message-ID: <20240122235822.293205600@linuxfoundation.org>
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

[ Upstream commit 3f47c1ebe5ca9c5883e596c7888dec4bec0176d8 ]

The GCC 13.2.0 compiler issued the following warning:

mixer-test.c: In function ‘ctl_value_index_valid’:
mixer-test.c:322:79: warning: format ‘%lld’ expects argument of type ‘long long int’, \
			      but argument 5 has type ‘long int’ [-Wformat=]
  322 |                         ksft_print_msg("%s.%d value %lld more than maximum %lld\n",
      |                                                                            ~~~^
      |                                                                               |
      |                                                                               long long int
      |                                                                            %ld
  323 |                                        ctl->name, index, int64_val,
  324 |                                        snd_ctl_elem_info_get_max(ctl->info));
      |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                        |
      |                                        long int

Fixing the format specifier as advised by the compiler suggestion removes the
warning.

Fixes: 3f48b137d88e7 ("kselftest: alsa: Factor out check that values meet constraints")
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20240107173704.937824-3-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 208c2170c074..df942149c6f6 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -319,7 +319,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		}
 
 		if (int64_val > snd_ctl_elem_info_get_max64(ctl->info)) {
-			ksft_print_msg("%s.%d value %lld more than maximum %lld\n",
+			ksft_print_msg("%s.%d value %lld more than maximum %ld\n",
 				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_max(ctl->info));
 			return false;
-- 
2.43.0




