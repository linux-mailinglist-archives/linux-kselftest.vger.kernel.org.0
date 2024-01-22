Return-Path: <linux-kselftest+bounces-3378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74F837C90
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 02:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FAC1F289D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A5136641;
	Tue, 23 Jan 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UqVKyBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183E135A7A;
	Tue, 23 Jan 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969673; cv=none; b=p2LOabqKkGYWdt6U29TFwF8enkVAT91cPdIsIjQsrgfi9AyfD4cVD7wFjfUlb62v7BjJag/WGQdT/sgWUNQyQc0f2/p1NHC5ipNVwptf94Uq3hwUG1iUBOomOLDo37Mwot+jk9v7IyNV6fI0vnFFvOEDnQGrajvS7gbsRXmEj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969673; c=relaxed/simple;
	bh=0FNrusc4PLat6vAf0NRD8TEgqwzb2lCIG2ku+GSVspU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr+20AUjhx8R/yw9CQ3a9YbN+f9TQSQmzqMzVmn/4n1cqGr1Dacg6211jV2Nex4f+QxpUV0vtInJKFnwj/0nNvDAPIKsUwxMMcCPN6sh39onAi+onaeVIVMl/kUj4AYCnd2DPTIkQDVR5IlcgZ38MwD6m/uVyFJI+W4s43pxS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1UqVKyBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2363C433C7;
	Tue, 23 Jan 2024 00:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969673;
	bh=0FNrusc4PLat6vAf0NRD8TEgqwzb2lCIG2ku+GSVspU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1UqVKyBG1Tqune6XnFgAwWTNAP27tidlsY97ScMX5D6XexEzNLLCDipkfJDkghB7N
	 His7ZSZ3q5R8jReq4WRHAFWp6ogsmOWYTULRmT659WVANIfjESc2Yywg/FqnNyPgy0
	 jIdlhiEmta4YvS3TZwX7ILJ2uKlqDmIhn/8Ksjvc=
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
Subject: [PATCH 6.7 371/641] kselftest/alsa - mixer-test: Fix the print format specifier warning
Date: Mon, 22 Jan 2024 15:54:35 -0800
Message-ID: <20240122235829.563209643@linuxfoundation.org>
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




