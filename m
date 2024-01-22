Return-Path: <linux-kselftest+bounces-3379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D0837C93
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 02:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7641F28CC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAD013665E;
	Tue, 23 Jan 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJN51Ni9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F331136658;
	Tue, 23 Jan 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969674; cv=none; b=hetXgYHW/WsGeOGe6MAKZCbagT5ejr5Xvsz5BiQrOnIKCs/jfuizRljsgRbl2qq4hTCDjA+JbcvJr4zR7TWKKS0K21W58lsAL9DUd+cOT+T4NAM/+8uZ8PqPiO57lGbJPq1lurd48b+a39D9nAMr1elkLbs52eAHsh+2jw529pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969674; c=relaxed/simple;
	bh=8ldTsHBR8+UfMAM9Ms8ceIPB+37tzxc7GRSf9YnjQDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4ZQtN+t1WpEY2cNPZPoq6x9Y8xVgZ0bScj6dJ5nJ9Py+G3jNuVbsThrMQyNjWn5ODPh6H7RRbdDCkJw3q7y/BJQp6kSeRzySF+Bpu5jq3XV6axxJf7ynSMqQ/SFbpTh+JHV17+clRxZZZa5lP1H6sfzlrYquIVI9tS0QvTBwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJN51Ni9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068CCC433C7;
	Tue, 23 Jan 2024 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969674;
	bh=8ldTsHBR8+UfMAM9Ms8ceIPB+37tzxc7GRSf9YnjQDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJN51Ni9B+a8VNDjAlYPFoclpZMk5EnvfuuL717Ddy1ut6wtJrhZzCwi1sdTvTi1/
	 f6xKFMoicuhEW2DRfUkFPiNqRKpJzmpPbHIt8hQ8Th2f+OYScUSCUelIxiTWrlAN7N
	 GSWV0lvLuSYVgoYH61aBuY2ophht1bDLwT7WoAaE=
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
Subject: [PATCH 6.7 372/641] kselftest/alsa - conf: Stringify the printed errno in sysfs_get()
Date: Mon, 22 Jan 2024 15:54:36 -0800
Message-ID: <20240122235829.600410402@linuxfoundation.org>
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
index 00925eb8d9f4..89e3656a042d 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -179,7 +179,7 @@ static char *sysfs_get(const char *sysfs_root, const char *id)
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




