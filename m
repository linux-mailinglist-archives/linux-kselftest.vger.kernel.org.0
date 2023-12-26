Return-Path: <linux-kselftest+bounces-2421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5355B81E33B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42B2B22089
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50544C8A;
	Tue, 26 Dec 2023 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4/JkUAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C61FB3;
	Tue, 26 Dec 2023 00:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF1CC433CA;
	Tue, 26 Dec 2023 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550068;
	bh=4Xo4SfAr1zYLkWGxWNFDUUfdfI5dg9HyRqOMSkSSL4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4/JkUAJYc5UEfzKx0qTsUHGEyFfYgJ+icY3T926Tv1jyun6nRhbxpF5G0q+AxUPj
	 aypZ3997SDpILBLyyq1eREwdS5i9FX04JJkjYJn1a/Ng8QyQEdVljIkzg+Un+HGdeL
	 P57qt7xsN4P3L83IWuGFow2zZUTdPEVYPDCqj+jPDLbqgwTDuaCN0bnBtd9dl1zJ2/
	 jAKc4ciDx31zRBiUcDLflsjHF8CATEtQI2uUCijWSFvc8mFMCF6jZuW2n+LLdpuACh
	 R/rfxCe6eAwdhJwKrvjrTWXlYZgZyaqAt6Vz8wxc1S5rO5Q2LRIy3pFgfeoJ3828zG
	 cXHg+8a+8MExw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/39] kselftest: alsa: fixed a print formatting warning
Date: Mon, 25 Dec 2023 19:19:07 -0500
Message-ID: <20231226002021.4776-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit 13d605e32e4cfdedcecdf3d98d21710ffe887708 ]

A statement used %d print formatter where %s should have
been used. The same has been fixed in this commit.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Link: 5aaf9efffc57 ("kselftest: alsa: Add simplistic test for ALSA mixer controls kselftest")
Link: https://lore.kernel.org/r/20231217080019.1063476-1-ghanshyam1898@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 21e482b23f502..23df154fcdd77 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -138,7 +138,7 @@ static void find_controls(void)
 			err = snd_ctl_elem_info(card_data->handle,
 						ctl_data->info);
 			if (err < 0) {
-				ksft_print_msg("%s getting info for %d\n",
+				ksft_print_msg("%s getting info for %s\n",
 					       snd_strerror(err),
 					       ctl_data->name);
 			}
-- 
2.43.0


