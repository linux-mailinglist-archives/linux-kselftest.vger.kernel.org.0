Return-Path: <linux-kselftest+bounces-3385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80C838474
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 03:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6663299A45
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6F6E2AC;
	Tue, 23 Jan 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKDYHnrz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAD6DD10;
	Tue, 23 Jan 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975402; cv=none; b=tD6KrPf0MpTFcHmA9PYopD6OdHjma9P7WB/lVwS+KQ7OtyjPTLdCILKJOViJ7WeRYil+cUaw25SoGlvhlkOKoo8hTkNjk4rKZYRcl/2m4DkVOLxjwyFM5uQGqb96AlCFiRQEdiABGVTGdxR/ijVL4kUm7RKIZW7zgcHZWDhSXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975402; c=relaxed/simple;
	bh=d3K/yKOImQ36E1YGVhkcYMk7iS/P9a3IEySAfHcpSiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQ4d7/TLUfFe+DyiIi/dxDEWWkvhFl3/41rhyjaTAjrZ54a80sskZE+9jdZWf0l5ufvG7Uswudvlq96pwH334/TSq3JLzaSc5JgzOKuyvof/rzI8TCE51Yzvx1NXSUVB9q9EGoAI9tFSt0KdMOaT+FPKDSPsteWYnKev2DTDE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKDYHnrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D552C43394;
	Tue, 23 Jan 2024 02:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975402;
	bh=d3K/yKOImQ36E1YGVhkcYMk7iS/P9a3IEySAfHcpSiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKDYHnrzFif/5I6d3pFGZfqlN/5nt5DDMVUw9ZDuv/2vPEGChx794FiwBminqvB90
	 EOZ8xFK8+Nu8epYFzLS/Y5R0H0lqeDSefh3LWYca3ObvXBVTD9rm4aP2GqaWx4Q3Yp
	 sZfYO85d4CNr8k40SAs+WMEG+NHLEBoSDIbRLtBw=
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
Subject: [PATCH 6.6 336/583] kselftest/alsa - conf: Stringify the printed errno in sysfs_get()
Date: Mon, 22 Jan 2024 15:56:27 -0800
Message-ID: <20240122235822.316368588@linuxfoundation.org>
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

[ Upstream commit fd38dd6abda589a8771e7872e4dea28c99c6a6ef ]

GCC 13.2.0 reported the warning of the print format specifier:

conf.c: In function ‘sysfs_get’:
conf.c:181:72: warning: format ‘%s’ expects argument of type ‘char *’, \
			but argument 3 has type ‘int’ [-Wformat=]
  181 |                 ksft_exit_fail_msg("sysfs: unable to read value '%s': %s\n",
      |                                                                       ~^
      |                                                                        |
      |                                                                        char *
      |                                                                       %d

The fix passes strerror(errno) as it was intended, like in the sibling error
exit message.

Fixes: aba51cd0949ae ("selftests: alsa - add PCM test")
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20240107173704.937824-5-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 2f1685a3eae1..ff09038fdce6 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -186,7 +186,7 @@ static char *sysfs_get(const char *sysfs_root, const char *id)
 	close(fd);
 	if (len < 0)
 		ksft_exit_fail_msg("sysfs: unable to read value '%s': %s\n",
-				   path, errno);
+				   path, strerror(errno));
 	while (len > 0 && path[len-1] == '\n')
 		len--;
 	path[len] = '\0';
-- 
2.43.0




