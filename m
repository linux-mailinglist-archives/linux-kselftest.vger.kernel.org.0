Return-Path: <linux-kselftest+bounces-13784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FDC9329A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F00F1F23B7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABF19DF80;
	Tue, 16 Jul 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGwKNO6D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54219DF69;
	Tue, 16 Jul 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141300; cv=none; b=fBmPeQb37YQaxQ1zC4jI/poL5FyhoiEa2iOEuZFd8EkuLvJ6tXQ5pfvtLAkJ+dne1Ld9mMJ7j7Uv4l9LXVvC7ykKUuI2M1DCPEHxSnazWefEPB9RDXEA6rMONBUBNBJ7e8+F40VHoaDOlwdH2IH71PJ2bV58h8zqmnbxDGvBxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141300; c=relaxed/simple;
	bh=Tuz2Cqp7OAZTUWZxMCkgxInLDeSPCQDXRM7Tshu+UVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzTDwR4YsPlFaKVgHvAAeQhCJW8sd0iMPo14FwXUmWvkzFtjlrtTuZOG1U2nH/Si9qYs3m2ubEctUNuQm60+OXUNcgAWXAnXMhsj0UUzzuLxOowdsjqqRv9zHE8eQQ9RUxfG34SFmgBWLVAllONl3mWrh3RHpvlYqD5nGBiiYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGwKNO6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EBFC116B1;
	Tue, 16 Jul 2024 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141300;
	bh=Tuz2Cqp7OAZTUWZxMCkgxInLDeSPCQDXRM7Tshu+UVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eGwKNO6DY7e1m1YLACLSfor4erCPo6t+7zQCbLnB60QH7jLugfmwDpPX6c5PMRtL2
	 d/h/0kJkVblnKm0+tAQYxb/X+sOWhVz1Tge8IyR4XCRNSOM5CLMFnn3wwygRLb+tFZ
	 TU5V/y+BLRWt/Ecd4QnnlavdFk9DQH2KeHZdqAmjtbC3YsUE/u1w9WCjz41FBtFPel
	 Vb22fudnrCE72Z3kRVwqk4VCGwtRGzeLC/IiUlSgbrigEdF5gzUqpRQ/eS9O3DL6Y0
	 NJ8oDF1lVmCvB8hmnXch+56ZX2gr2MwlEWdAJi7FLu7WVftc3RnneARMKcyf4B6b0F
	 8RcCvH50Qebzw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 16 Jul 2024 15:48:00 +0100
Subject: [PATCH v2 2/2] kselftest/alsa: Log the PCM ID in pcm-test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-alsa-kselftest-board-name-v2-2-60f1acdde096@kernel.org>
References: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
In-Reply-To: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Tuz2Cqp7OAZTUWZxMCkgxInLDeSPCQDXRM7Tshu+UVQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmlogsg4N4aKcab1kvUtEMEejyFV/+puYuIz89EmPH
 jqiOzk+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZpaILAAKCRAk1otyXVSH0JfdCA
 CG1RoHgLkdx8CjGJWC7jzgdl7KJSQ3rZYrwlcyB04wDpAd109fwN+V97SzFyRRl94hUBVcHAjl+iXv
 CoDBiRhGdAHhT+49ZaQjgJdGNxUC0LgEay94sFL5+kxnApr8iyMBN9mxNd0H5YUR9knmNswdFkEPT7
 fP6k0EU2BXwmC1riMx5Wro99c+nf6CK4BMJcMhrrqyPyEfx2nekh2isWpYocRn4aS72ft6Pf/msvF0
 5B/CAi1h8caQgnJvXv3idet954lSJiIf+rFN/55WcCuqF+gYcQcstSK3qViTes83ktxMlkKd8lqNnS
 b8noohoTGBaBf/2PBkSxxlpjBv0uFV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Drivers report a string with a name for each PCM, log it during startup of
pcm-test as a diagnostic aid.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 7abb21845e10..70a96d64cbdc 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -240,6 +240,10 @@ static void find_pcms(void)
 				if (err < 0)
 					ksft_exit_fail_msg("snd_ctl_pcm_info: %d:%d:%d\n",
 							   dev, 0, stream);
+
+				ksft_print_msg("%s.0 - %s\n", card_data->name,
+					       snd_pcm_info_get_id(pcm_info));
+
 				count = snd_pcm_info_get_subdevices_count(pcm_info);
 				for (subdev = 0; subdev < count; subdev++) {
 					sprintf(key, "pcm.%d.%d.%s", dev, subdev, snd_pcm_stream_name(stream));

-- 
2.39.2


