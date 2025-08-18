Return-Path: <linux-kselftest+bounces-39245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA5CB2B17D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E214E034F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D53273D8F;
	Mon, 18 Aug 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZySEk4xA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C9273D6D;
	Mon, 18 Aug 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544813; cv=none; b=TzRQZ2Scfqav7ttcTB4Un5/aSqgR5URCOm9YPfojhw8Gsv20S/jnE70g7DqfFdkhw0i75O0s2BVoxHQMx111tD45VxBjM/rRo+tnrTg5hmNFP6w4E03WW9Hbvt0dcEl6ucyMZxHodQvumj25+vR3GAyoIdscB8hcB9/m8q9cJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544813; c=relaxed/simple;
	bh=UIyD6T/Att6HWql2FUpdhiw9nKqscWGtcj6+j3splj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DClAvWTw6FyhblxyKnwTliBT/5p1Wdok52/8cg6PZfhepuLY4DWrA+Ynq9xgaLkD54s1K1UPkvvONySs0NMs9YLSjEC81PlaSLIGlUQHed5FfOkuojWKbPJvwpKJEIqttF4m0cHMgBcXF3RlsO2fz0LCpEiupbGDEPzWrzzaFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZySEk4xA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E83C116D0;
	Mon, 18 Aug 2025 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544813;
	bh=UIyD6T/Att6HWql2FUpdhiw9nKqscWGtcj6+j3splj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZySEk4xAoVh88qf7EReL6doUzKMDBwGXYhsA5SSIDYrg5QO8Km+TrwWP5FFXXIBII
	 F943KRvDCkhuH2XBY7vVUfeh7aYSSDwnADjRhzPyv5fUVwqkDR8e70DrdMgNEYxkmW
	 JxkLaJoTLRc9j9CzlbKhdooAVYytgJ8UHJuK/ToJ6w9XBmGjhpzbXDt2VrQkiyl8AN
	 lGgKY9HKf6LU41GofP8nxhKhj1879KqVcsNiP1L+yDBEyW2XOHnTw0X7jlRJs2ocAT
	 kZn/wFZhtZEiwYc6wvBejJqwZTkI5b0x6tFj+vOiQPQKmWdLUoGm3XULUOZuS6kKDX
	 05hI/F8zMNe7A==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Aug 2025 20:19:35 +0100
Subject: [PATCH 1/3] kselftest/filelock: Use ksft_perror()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-selftest-filelock-ktap-v1-1-d41af77f1396@kernel.org>
References: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
In-Reply-To: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UIyD6T/Att6HWql2FUpdhiw9nKqscWGtcj6+j3splj4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo3zoqe9k1QBWDSGDtsg5qfSKu+IenQmx9m1go
 weD+H3r6k2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKN86AAKCRAk1otyXVSH
 0MY4B/9JgfufAiiJwmjSbsiLrHMgHvOZOZr9rheMNNqaiBEXqHYYSdnS/qCNyiUg51wnks/YJ7I
 I1LwVB1pwZhcIBIsRUj2n3iKSd/IfIGESTrqn6cExo4lGrktsQNkk7g6ksGeZt/DYRsyOk/fr8q
 kGOaaRatGC33tc3Wu0FsWG7WM1sg7iknz6KRISUA/IqpHck2eh4t05bc7D6PajrhYQQEoCTEdUv
 WP54ZLes7GJAS0eW93cc/l/rhcadRSp1Ed4ctDffGURclWRkRyGJS9CcdXyZNJXdy8JXIOJegAb
 6hIglnKEVl3wxqytt4J2q7YBfjL/dp3qPwUUocZUAWhnvckj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ofdlocks test reports some errors via perror() which does not produce
KTAP output, convert to ksft_perror() which does.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/filelock/ofdlocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..a59fbe6aca14 100644
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
2.39.5


