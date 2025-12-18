Return-Path: <linux-kselftest+bounces-47703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F946CCB95F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 12:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 760793065E20
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8465D3164B4;
	Thu, 18 Dec 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4jQESNo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E03164A5;
	Thu, 18 Dec 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056693; cv=none; b=lgWpWjZxFz8oMp+JxxsDHCcs7ANzVuHLEXbipttmitipeo0AvUaZlPuU9p9sLelb/XpHR510akG0hULIWEc77YUSrq3HIC9vJfd7LBMH7Q1pvA7VBis2D5r5gkO6kxMfL2s9oWhUSx6OmmIJPA84q00HaEdXclMSwF46/tIwbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056693; c=relaxed/simple;
	bh=Fd1XevUti5siz39tfguTapy38Yaj6svZHWG+xHmOHVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jS7T94jSwCPLJi/G3z9XrjrVu/xRh9Jd55Jfo8hb+atp6+/djt+0MmtzB1UpOnXJIfyBIQR+tsYtvjeZ6pvUy7qfGPaHp2vJzzREca8G/llKyPsVbUZP+c/NCkfXuz5Q3b66DG2Z3jgMLrz3PQcw4vUXh0uyNdmJ+0r1jAOKa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4jQESNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C2DC116C6;
	Thu, 18 Dec 2025 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766056693;
	bh=Fd1XevUti5siz39tfguTapy38Yaj6svZHWG+xHmOHVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s4jQESNokWgJgTx2FJb55al/IKWoLgCjwM1bqgJJQsdf3znID+jQtiA3ZII4I7Wlk
	 7MQr56QrVgiMXRj5wxNHWJn3aPNyafcy0zr0nMlFQ2X8B0Rzd7KuSl3nI0io64zIeW
	 UrR1TFACN6E4Hch5iyYHA4Xm6RynQRw/7dxu3FOQmEGwKW9/L/kS+865TYePmFiXdL
	 kqhpDdTtEohLtRviP1djjj++sthRcIiuJ0NKTrDRvdaLlcsoC2iLnl0pAgg1v+a7om
	 TeII2nxaem+CbS4qDiuH0aF/nDrzP/kHBQEPxSYljYCenLnsZ3YsSyzGUs9ss0P+W2
	 rdRiW+9BdpdrQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 11:18:00 +0000
Subject: [PATCH v3 1/3] kselftest/filelock: Use ksft_perror()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-selftest-filelock-ktap-v3-1-62acfea940dd@kernel.org>
References: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
In-Reply-To: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Fd1XevUti5siz39tfguTapy38Yaj6svZHWG+xHmOHVE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ+Lw5le3NghYKb0VoezuYR5Mfyi210r3+HrCX
 rB2fsjw61SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUPi8AAKCRAk1otyXVSH
 0HtrCACF8ls903dx4oQlZAwSuDP2jYi0vKDFOl5JJMdKVriROawm4ASM8SvOwHuqRDL1MEa/GCg
 vo0MxSNY02KlJ31rsg8tYU9QIBoM2KtG+cbd57UnCDBeK2r2MYU3e9YbmG5SRPd0azCuaDy/g70
 Q0qwcl/Ekhue6hE23Af8ELs9+jStNyCND2yur0mXDHAc9x7ZB511kLcTwarhsA3T1jsWmuOIoKk
 loJa+ExWmy+MLvRge3clcDT2cVWUvYUcOg9tp/9hzgQIJNZpWdIfqHoLQASlrxHdmY285XmgidI
 Fu2cw930r8zRiRP4TvqrsM4pMjwFw0u02/K+pqBggpZwESTS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ofdlocks test reports some errors via perror() which does not produce
KTAP output, convert to ksft_perror() which does.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/filelock/ofdlocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index ff8d47fc373a..2d3b06ce5e5e 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -16,7 +16,7 @@ static int lock_set(int fd, struct flock *fl)
 	fl->l_whence = SEEK_SET;
 	ret = fcntl(fd, F_OFD_SETLK, fl);
 	if (ret)
-		perror("fcntl()");
+		ksft_perror("fcntl()");
 	return ret;
 }
 
@@ -28,7 +28,7 @@ static int lock_get(int fd, struct flock *fl)
 	fl->l_whence = SEEK_SET;
 	ret = fcntl(fd, F_OFD_GETLK, fl);
 	if (ret)
-		perror("fcntl()");
+		ksft_perror("fcntl()");
 	return ret;
 }
 

-- 
2.47.3


