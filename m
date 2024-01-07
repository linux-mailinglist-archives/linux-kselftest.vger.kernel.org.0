Return-Path: <linux-kselftest+bounces-2698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41AA826552
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55021C214C4
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9A13AF1;
	Sun,  7 Jan 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ZD3sLIG0";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="bLVAPVEM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A613AE1;
	Sun,  7 Jan 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 9A6566017E;
	Sun,  7 Jan 2024 18:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649036; bh=sCVROg27cZxAXjRssVmgTduiqvtFmW20cj6qSjIYyOg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZD3sLIG0MjQ8u3kBo86IpY74MgdKxdcACAWZO6AVxldhF3x7Y7oQszvba9+QErwIN
	 YC/Ir+ZLO4Q8d00DTGwGQHWGQi6OG10AZitR72K6xF6Fs7GTqOUK3M63ljIQfE1k6g
	 OiWiBEGqMx5WIjZ5tmP/FbO06vqBs26ntln5eLd5yzi/zf4wgsLOvbZHSodsEuJrph
	 z7kHKvccwr0QEV7I9d65lVYz3zJE+7WkbEcRvQh3beSdFAc4/p2PE+ZqmLdD7lDrZT
	 V0de/BfZKXqfSwtVCSEofCLh4Cenx6PVcyrolIJwXwRsckXy4X3aNLuXI08bSN0itV
	 +9VedvnSnki8Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzRIk0TXl6Jj; Sun,  7 Jan 2024 18:37:14 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id D85BA60171;
	Sun,  7 Jan 2024 18:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649034; bh=sCVROg27cZxAXjRssVmgTduiqvtFmW20cj6qSjIYyOg=;
	h=From:To:Cc:Subject:Date:From;
	b=bLVAPVEMy5ST9NNyVhUE9CrG60iNjGBsZj61g0p/zjipkF5dh3kE7N3YEIP5GFprx
	 TQtEwyPJf2+2NlrWp894vao0ZgbNqQ+b8wso0yCweynEiked+/2vhazAw3TltI80x+
	 Rx2T3hkgoGWOEWJvFhtOfNlBRNC5eZSY32NN3snvFFWSKnqqaVUbQM70jRgJ7Y+VQk
	 lSj5CgBX1tJSytPcW62WjHRV3aq/hEuuJjXFWNZeM55PBxBzzG5YliRdL+U1E9oNal
	 w9eB2hBDQvyKfa/PrP6x/pula93dv/jYZ/EPDiGn5+OGJ1+Bk8S9WSusc7Sr5QkpKK
	 9xTSGpfG3HkYA==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v2 0/4] kselftest: alsa: Fix a couple of format specifiers and function parameters
Date: Sun,  7 Jan 2024 18:37:00 +0100
Message-Id: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Minor fixes of compiler warnings and one bug in the number of parameters which
would not crash the test but it is better fixed for correctness sake.

As the general climate in the Linux kernel community is to fix all compiler
warnings, this could be on the right track, even if only in the testing suite.

Changelog:

v1 -> v2:
- Compared to v1, commit subject lines have been adjusted to reflect the style
  of the subsystem, as suggested by Mark.
- 1/4 was already acked and unchanged (adjusted the subject line as suggested)
  (code unchanged)
- 2/4 was acked with suggestion to adjust the subject line (done).
  (code unchanged)
- 3/4 The format specifier was changed from %d to %u as suggested.
- The 4/4 submitted for review (in the v1 it was delayed by an omission).
  (code unchanged)

Mirsad Todorovac (4):
  kselftest/alsa - mixer-test: fix the number of parameters to
    ksft_exit_fail_msg()
  kselftest/alsa - mixer-test: Fix the print format specifier warning
  kselftest/alsa - mixer-test: Fix the print format specifier warning
  kselftest/alsa - conf: Stringify the printed errno in sysfs_get()

 tools/testing/selftests/alsa/conf.c       | 2 +-
 tools/testing/selftests/alsa/mixer-test.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.40.1


