Return-Path: <linux-kselftest+bounces-13782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DB9329A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CBB20BD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112B19D079;
	Tue, 16 Jul 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZx/lAmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058419CD18;
	Tue, 16 Jul 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141295; cv=none; b=McJ9jh4Xr/8POzWDGYg4rjHkDMazKDaaNiSrKnL1+wEXiIbtQNOIHUlr/mz1qwUTgTbKK7vzbOEog+yFYAQUxXOs8XzcapR5BVcW7xY9gzqNZcg1CpgAJKXzq2UtzfvOTTSAUa67jwZahsjiAQcCkdMiGQzVv0srZFc3wDAtQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141295; c=relaxed/simple;
	bh=ZT/7h9ZsmsVC1L12GWEyZknnq1KJmu8yPs8c4XxpnEw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jcgnRnsMo5EQ3i+Q4PQaZVcQoog+b7hSP1aUXAr65MrKESnu5lv0MG7g0wV/BJHAQWuW+lH50NNbaRjbVmkYRC5BMu8n0onVcC4WbFBjH6GO1tJU3xH/rOmebLxb9+/xpghxdYX0utIYjulAWENtVQHHljcIX/b6shO3TYD7fiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZx/lAmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA05C4AF0D;
	Tue, 16 Jul 2024 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141294;
	bh=ZT/7h9ZsmsVC1L12GWEyZknnq1KJmu8yPs8c4XxpnEw=;
	h=From:Subject:Date:To:Cc:From;
	b=CZx/lAmryLgsDGovHxRjryR00put2+RlYvVFcMInR61Z1iLYtYIMF1eLbf9j/H6TB
	 hxgtcGiDXhxS75cCyij5/SXfsMHM3/srMCACu1RIUagrbm2iFeba462K3aZEF5yw5Z
	 G6q3lkTwazgCFLXPFIKRwQjpE7XOKrU9mLEr3cvr3AzrEuXVteWo3LgIP/IscpOlZA
	 WrF+JyJTKY1dfTFhxc0YWYDSHgVLpvNeXOn45xY3k0O84R7oNmaaur9fygjMhDgYlu
	 SfB/LY9ZlZO9q+iDaMg/idWGt8UybLcoTKS0zzcuKH6vQw2/1UY3iuYQF+DNUF+X6+
	 0D0OUVDCIURSA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] kselftest/alsa: Diagnostic improvements
Date: Tue, 16 Jul 2024 15:47:58 +0100
Message-Id: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+IlmYC/42NQQ6CMBBFr0Jm7RjaoCauvIdhMaVTaMDWzBCCI
 dzdyglcvv/z399AWSIr3KsNhJeoMacC9lRBN1DqGaMvDLa2TX0zBmlSwlF5CjPrjC6TeEz0YuS
 GDHnfdIFqKPu3cIjr4X62hYeoc5bPcbWYX/qPdTFYanfpgvXOMV0fI0vi6Zylh3bf9y9TfEhgw
 wAAAA==
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZT/7h9ZsmsVC1L12GWEyZknnq1KJmu8yPs8c4XxpnEw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmlogqfW0+3H5ztW5AMoEpdMErrGOvHoxgIfG0GMk5
 m7ygr/iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZpaIKgAKCRAk1otyXVSH0Db6B/
 4yrWmJXQ8WyyMU9zexZ0SYdD86TSgTshXM/1oFQjz7xJdnSIeMg/DLz76gkviXb8tCfyfGd7ZJISM6
 N88ZF9Obb1nQqa2fnoBT5GMAabBUvvMlRg8dNORkOv5sKZGG/qfF+Zy1Sws6pdjmGxNEtVXGKXNbdE
 M3/VnB/AJYQAMq7XvfLcHvGyNdXcJgkiOkT6jYf2hr4c0x/f6xs0gohtOyZitGp20ctgGV9iD98ed3
 /PzBld3Iz1jCfa+M4j3LetCyIhy9n7MMokuUGRJd+ybsq5vb/Bz8ddTd1Bf/6MHDjsavWF1bAcJHLa
 rYYF5B9UkkEIgfgUj1es7P6jzSjg8a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The first patch fixes unstable naming of tests due to probe ordering not
being stable, the second just provides a bit more information.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Switch to using ID rather than longame.
- Log the PCM ID too.
- Link to v1: https://lore.kernel.org/r/20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org

---
Mark Brown (2):
      kselftest/alsa: Use card name rather than number in test names
      kselftest/alsa: Log the PCM ID in pcm-test

 tools/testing/selftests/alsa/mixer-test.c | 98 +++++++++++++++++++------------
 tools/testing/selftests/alsa/pcm-test.c   | 68 +++++++++++++++------
 2 files changed, 108 insertions(+), 58 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240711-alsa-kselftest-board-name-e4a1add4cfa0

Best regards,
-- 
Mark Brown <broonie@kernel.org>


