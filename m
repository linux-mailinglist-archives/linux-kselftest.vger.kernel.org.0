Return-Path: <linux-kselftest+bounces-2688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0482649C
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83D7281EBF
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F95134BE;
	Sun,  7 Jan 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="Tcr0kwTQ";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="AwU58B0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA9134A7;
	Sun,  7 Jan 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 238B76017E;
	Sun,  7 Jan 2024 16:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640353; bh=xn6DasHTsMAQHER5mfWi98jQpRtzxJAUx0/2f4aE9zE=;
	h=From:To:Cc:Subject:Date:From;
	b=Tcr0kwTQWFCATkAr9varlglUMYZLdT9m1TBGW/MdxJKzW3seW9cvE7tXbfUw9Qzo/
	 koEoyI/3QBymlfKFiqzxQdRV+39qF2QAnnLdqu1eP/dL33otZggfHHrQqDXv9bKhOH
	 PdvK8FWsLOB1pChE/HC+0XHgi9Y/+OaxxvfiGumdGpTEwyPm50VntadLJUi0NHvuZ6
	 4GxlEqnnlIRcol/sM94/NyaFroLuja+UNiF1PN47pMgdkbWm403DHTjm/D2d0gIcU0
	 4p5/T4Yh2/0O039ikxYxBclNPXd4E3mEIotzJcmvRtHmk4D5AVkTTjF/oTxxbT6k9+
	 bjQCPnxYka0jg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IS2Lb0vPvWkg; Sun,  7 Jan 2024 16:12:30 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id D482660171;
	Sun,  7 Jan 2024 16:12:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640350; bh=xn6DasHTsMAQHER5mfWi98jQpRtzxJAUx0/2f4aE9zE=;
	h=From:To:Cc:Subject:Date:From;
	b=AwU58B0vyBi9bCOIcPhPES5jCuQ8hvZndwNawnRf8r4Wcd0cpGHPSEfSqaaC9aRvd
	 F7GEvM9l8GEZOTPoqEx4YBREC6idHn954PeHjAy2URbi2hUHn22i5vT/mr9HVPprZx
	 4sAEAaXbQJXn/M+N5HgrO7xpV0i3MNXDJolVSichyyoL8nDM4V5Bsd4JfgDXkAzScl
	 QLEDKHR6p/PCXfMpyvNGyThKWlg0q24w1pKP1192JYJgsaSmJ+Q4Mi+Fh5fsaWAkXs
	 8PkKZhA6qi0bAmDa3NZMFQ+Q86zrWiyCbK/eVkNxp/kA0cylov85Dq66Ybg31+UjU9
	 0wB1z7BRDGCfQ==
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
Subject: [PATCH v1 0/4] kselftest: alsa: Fix a couple of format specifiers and function parameters
Date: Sun,  7 Jan 2024 16:12:14 +0100
Message-Id: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
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

Mirsad Todorovac (4):
  kselftest: alsa: fix the number of parameters to ksft_exit_fail_msg()
  kselftest: alsa: Fix the printf format specifier in call to
    ksft_print_msg()
  ksellftest: alsa: Fix the printf format specifier to unsigned int
  selftests: alsa: Fix the exit error message parameter in sysfs_get()

 tools/testing/selftests/alsa/conf.c       | 2 +-
 tools/testing/selftests/alsa/mixer-test.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.40.1


