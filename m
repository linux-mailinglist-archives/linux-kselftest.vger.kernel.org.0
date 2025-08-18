Return-Path: <linux-kselftest+bounces-39247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9BB2B182
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CFB4E14B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8A2749EC;
	Mon, 18 Aug 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef9b0Seq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567862749CE;
	Mon, 18 Aug 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544816; cv=none; b=HdzL5yy7Md9ozYvh85Fwx5buqPg+1ZB4KTunxq454zO33E4nSjbD+/Wq2J1JkkhfFxadRma9ghRPyI+tsaxsk41w2axL8PFYu+7/OroRFazb0DYMlTNb+Y4acnAsCCUO+t7+tZ9jYBsUdwPi3VqekyVO7aRO6q1VduQs0NDg35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544816; c=relaxed/simple;
	bh=+poCgBhUgppZ/6n7MeaajfyLcNeQlq0KWUa5GzL6rNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m81pH8EkHoSqxRqioK9clXyfXBstU6KvqOHkZNp8GKQV3ZJDHd0pmAwnYrzmXvamDNVzt5esYWQR44+sQLjEwUNTG9tlJdOaRYjVm6+IXj7EsSqjKzzyiW5xvN8zXmQkBX4bHfQTRxT1HP8VldUJ962HnTbYvTXQzLvejw3/blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef9b0Seq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C66CC4CEF1;
	Mon, 18 Aug 2025 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544816;
	bh=+poCgBhUgppZ/6n7MeaajfyLcNeQlq0KWUa5GzL6rNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ef9b0SeqfHKrYd+g9Hnn77FcLpCGHobz34wyKpVVXZp5bY5vDvbXV9gUfD3YF512x
	 s2Amd827aoV+joPSiJJOa2whVyIBdTiNfzYMF1aOzB3WaUGc4tYFEFvlbdW6O6/WOj
	 k5DAywpumC5+ghqN8d3rVjByIhPFZIG0rnezuXor3y1iSCXg4TIIPYS6hc5dibfM7R
	 y/o3qf8tF1M05BEEf17JBL2qgCvOB/UXNGgmVFLXeekmoecYuacDVKo1yis1i0rGbF
	 MM5KCvM09nsKEjzH/tE3+w8/lc5WVuKU6byw8P2cYSD6ONbX3rpasVYgE53wu5U5HS
	 DADKscVHCGzNQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Aug 2025 20:19:37 +0100
Subject: [PATCH 3/3] kselftest/filelock: Add a .gitignore file
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-selftest-filelock-ktap-v1-3-d41af77f1396@kernel.org>
References: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
In-Reply-To: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=464; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+poCgBhUgppZ/6n7MeaajfyLcNeQlq0KWUa5GzL6rNI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo3zpop9yyrLO4hLCaBxqcWaoP7VzDocqeGl2/
 SFtE6NwiTyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKN86QAKCRAk1otyXVSH
 0GbuB/9H6JsvnWGHzmuBnqvCTKXXzTUsVsnPAB4CkxhgGGXaL5PJUqWqWRSsrgGReZQlZOMHHkV
 d2K0+ToXJSVXtN4A8rjIukguDeRE5yO6n+NuCuxJ5y6OwJXOAhd5tjyUCofEjOe0/AslEec1duT
 x0TQXDhfi9GRPUMMOavd3+vedhDLsq0c/tcx0RJhrlnvhDwLqbGk6Aeam9PlJOn40OVm7kIewEH
 FJLj14I2THenD2iEx1a9+Ub2r7ehnxAZZmwtmsEYK+piKDRkAFlmrm6drp+C61M7EFpdsDchEbD
 xGcV9/tKHsgIpuJ7o1U88QtHn5e+V7H1QtFILoutuC4Wp+qK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Tell git to ignore the generated binary for the test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/filelock/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filelock/.gitignore b/tools/testing/selftests/filelock/.gitignore
new file mode 100644
index 000000000000..825e899a121b
--- /dev/null
+++ b/tools/testing/selftests/filelock/.gitignore
@@ -0,0 +1 @@
+ofdlocks

-- 
2.39.5


