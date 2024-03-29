Return-Path: <linux-kselftest+bounces-6878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C0892135
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 17:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526DA1C22D38
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913105B1E6;
	Fri, 29 Mar 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIza9N1y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F794A0A;
	Fri, 29 Mar 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728361; cv=none; b=qNQX41RLDACmE/CEzYXmQA5Dpz8EDXGmAH3sFWO/FHZLb0H/B4yHa4BgsYUxiuyYr3R9dvcNFM0G0xLaGPjZyUNhUwhNyk3A0zAC6tXzIcFV8TdJ0UXsDtUtn/Qy9sql5E7YCtQXPU30dtWqsLsdr87muyW1BN5Z9uZi3MmqQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728361; c=relaxed/simple;
	bh=xAO0MOQRzEEHjfZUz8OrPjqUg3u4o2CfCpy2srumAxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A31sncvEAaknn9JCVhfpMPHE5xXRA2Pkr8zXciDpsrSVc0jJyhD5Cn8lhsl/03yy8hkDXGx64d8Z0PwlY8FhgVkwns57h4Xx8qLXvScJwpSE9KMI5viozQv6qXRIQ70NhQMjL1QUJtsi4I2Z9zO36mABnpuOApb4NIGhcm1tx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIza9N1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F24C433C7;
	Fri, 29 Mar 2024 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711728360;
	bh=xAO0MOQRzEEHjfZUz8OrPjqUg3u4o2CfCpy2srumAxk=;
	h=From:To:Cc:Subject:Date:From;
	b=dIza9N1y3l9JKIw6+LpZ03JLXJS88OxCXzEFA4tXyE8deP2YTqiF6Ix/CqO5d4L2u
	 9XG5OhZ9A+qUaoAhklw4xJywfW0gFRtFOWXn2eFG+L4noEJYXrimNTA5HF78yHniyE
	 rQ53xhtD+ZEEbeDsR+bKBJjHeslW3TmVkoxHHRpsqjoAZVdxJvJPOThIUNiVdT9/N8
	 myuE8F4mpu5h5N7muxqm5mofNcGanBiOyP6HgQiWpDGIcP2AyQP7B3FuklFAY+vZVD
	 cwR8KJ8kH7HUa/BAdygNIf2nFLf5qfecP/f9ZQu0+All7aRRoFLgimv6WiRRLOdT9Q
	 DPJsk6zX8JpIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	jbacik@fb.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: reuseaddr_conflict: add missing new line at the end of the output
Date: Fri, 29 Mar 2024 09:05:59 -0700
Message-ID: <20240329160559.249476-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdev CI runs in a VM and captures serial, so stdout and
stderr get combined. Because there's a missing new line in
stderr the test ends up corrupting KTAP:

  # Successok 1 selftests: net: reuseaddr_conflict

which should have been:

  # Success
  ok 1 selftests: net: reuseaddr_conflict

Fixes: 422d8dc6fd3a ("selftest: add a reuseaddr test")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Low risk and seems worth backporting to stable, hence the fixes tag.

CC: shuah@kernel.org
CC: jbacik@fb.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/reuseaddr_conflict.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseaddr_conflict.c b/tools/testing/selftests/net/reuseaddr_conflict.c
index 7c5b12664b03..bfb07dc49518 100644
--- a/tools/testing/selftests/net/reuseaddr_conflict.c
+++ b/tools/testing/selftests/net/reuseaddr_conflict.c
@@ -109,6 +109,6 @@ int main(void)
 	fd1 = open_port(0, 1);
 	if (fd1 >= 0)
 		error(1, 0, "Was allowed to create an ipv4 reuseport on an already bound non-reuseport socket with no ipv6");
-	fprintf(stderr, "Success");
+	fprintf(stderr, "Success\n");
 	return 0;
 }
-- 
2.44.0


