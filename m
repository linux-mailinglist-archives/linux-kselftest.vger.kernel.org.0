Return-Path: <linux-kselftest+bounces-34483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC32AD2260
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7546B7A357A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C84204866;
	Mon,  9 Jun 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB2Alc9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11199200127;
	Mon,  9 Jun 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482749; cv=none; b=EFzLkGi/e5OqEotytYJeImn+5ZAX4jVgQSU9pibTMbxaXc7tZp3AY8Zu+lpdJPdpWAvm3CvtfTRdYudtJRQthTAmtb0taEGfnq9TdY4Gc4fIFUlc/sN52cbcfx3SNNOxa18W0w5edRgXVswobG0wrMzuty59N5M1jBmh2Hwl9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482749; c=relaxed/simple;
	bh=0XvmPjJQR7GdmY8bifJX+/OPNAGchVnpSVOg0Ynw/hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAfAX9apSBtlFl6aW7PKerfpCpII3OlMsRXw2MRmOKQoBXbxWfRRGPnwBs64VIWTMSHjxIbUgRk6HN5+C4MowPJxfqST4puDjTnvJy8cLjzEul6qX9ohDmVyOC2Dm5/w5042SebuDwZOGAcCgpzqYWjkdsiSWY6aaBnHTEsnyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB2Alc9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6249C4CEF0;
	Mon,  9 Jun 2025 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482748;
	bh=0XvmPjJQR7GdmY8bifJX+/OPNAGchVnpSVOg0Ynw/hw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VB2Alc9h9ofvFautWvVGr6zhs5wI0pxCMwa6FjC5Y3B6nylibkae4ycfmzYsXhHds
	 U0iYgT1scDPsJyzQBo07wF0CwDFILV0VqoNwveCiY1PyOJ0K3fDBMjQc52J+ocieRl
	 r7hk3WcIe8ykftcu2ym1nrj2iG4C18X0Swrppz/zLCvaEErZGB13D2D8gEdwKdmqRC
	 EfYojwVaIgGPlWEwt1Toj4IXb5VMYj+s457idHX6SINIv+B7k69czsnHBye/Is0+Kt
	 f7eXrsaThIxdbVUVQQx/5UbTZmsnvLbljSTNRiYYjfDhTF8KT8p3SJx/HL7MvSY7tL
	 Gmdg+7R/LcIjw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 16:25:31 +0100
Subject: [PATCH v2 1/3] kselftest/arm64: Fix check for setting new VLs in
 sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-kselftest-arm64-ssve-fixups-v2-1-998fcfa6f240@kernel.org>
References: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
In-Reply-To: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Dev Jain <dev.jain@arm.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0XvmPjJQR7GdmY8bifJX+/OPNAGchVnpSVOg0Ynw/hw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRvz1HvFjZh0TWsWq/B3VR/96WBUHgp5g7DOSqW7j
 vgL1a3CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEb89QAKCRAk1otyXVSH0LFiB/
 9iVdf+kZHuwxlWLaxeChwbE/CWPxsCDOdrC0r3jrlPTpw+QYcGf957Fr6y2kblsgHNqJr5L71g8HQS
 41Aj+qaGKzHE7D9pCOkmqv4qb/r8lQ/77cQa58l8patM7tozVojjwb8Jix/3Z+8dme+sHL87XqkUyM
 N0JSpqOFV2nehDAD8MnW0oA5gAbdGH+bDbYm9jUugPgefL2ZcMWpRvPYXfmHe1m63fb36jvsbWfyCW
 ekQXmDZ2ydKgdX3SmN8d+4AGY4S3tbLgw4UPJNemvj+fd8uZam3BdKZR/mrPh/cf1vWUele5gZQe1J
 78NVkcLheymTr/C9YWez5hZ/HtKkY8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The check that the new vector length we set was the expected one was typoed
to an assignment statement which for some reason the compilers didn't spot,
most likely due to the macros involved.

Fixes: a1d7111257cd ("selftests: arm64: More comprehensively test the SVE ptrace interface")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 577b6e05e860..c499d5789dd5 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -253,7 +253,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
 		return;
 	}
 
-	ksft_test_result(new_sve->vl = prctl_vl, "Set %s VL %u\n",
+	ksft_test_result(new_sve->vl == prctl_vl, "Set %s VL %u\n",
 			 type->name, vl);
 
 	free(new_sve);

-- 
2.39.5


