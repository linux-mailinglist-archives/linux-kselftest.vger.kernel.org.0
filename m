Return-Path: <linux-kselftest+bounces-2422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C464D81E395
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 01:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D46E287EAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905456B82;
	Tue, 26 Dec 2023 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvhwdIPv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973ED56B7B;
	Tue, 26 Dec 2023 00:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C04C433C7;
	Tue, 26 Dec 2023 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550205;
	bh=vuiFUmo+/Uvg4t51evSEl2GA0GWfApvdOK7ESuVSiAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvhwdIPv9hLNI68OiS2rebRcmgdFJXl4gYg20CPS5WRV0AA085Qwg7OZQ6Cd8cInd
	 vxvdAxVUBP6MIRy0hx3evGmWV/4VZBhTFs2ES7+Eayf0UjvBeXouII771llHmx5QUJ
	 AHnBbK6DGHMzLDY/6aYdNCUgeKPCCmYG8o2rg6Na405Wr007m+X+moYdOGZyvIBzEs
	 67vuXupv9F88nAg+VLRkwhGaWqcSX8dOOlJvJ8+FsvOOgApr6CM9B9Sq3vCFkZGlWA
	 r6l2unNtOjT21ZBscPRTtjCIocZ0kztz8xQCA8IZ3opnKuL0xO64+BVfuqhAcXqr7N
	 CYnb8UmSrJrlQ==
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
Subject: [PATCH AUTOSEL 6.1 10/24] kselftest: alsa: fixed a print formatting warning
Date: Mon, 25 Dec 2023 19:22:03 -0500
Message-ID: <20231226002255.5730-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
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
index a38b89c280306..37da902545a41 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -177,7 +177,7 @@ static void find_controls(void)
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


