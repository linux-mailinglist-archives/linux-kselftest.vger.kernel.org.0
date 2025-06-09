Return-Path: <linux-kselftest+bounces-34484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72177AD2262
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D182188875E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F920FABA;
	Mon,  9 Jun 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfCRXUbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEF1A2C0B;
	Mon,  9 Jun 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482751; cv=none; b=bk9FbWv0CvbR8rRwCKDiSZzK0OWCmImIF/PUDrt+7CQMXry/S/c1ceZi1w1LdR+9GQwQa1CjHs99oYpMctoM/dmsh/NmPSIeI7vWzKwXvBUJssmRBPjHdXHLCcwLe5CtwaejfPzB3HQ/87TBbOWLJWoyaaaxWLBTu2cAdx8U3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482751; c=relaxed/simple;
	bh=ZlGXBtC6ZrZFPsq+ynuRGU8ta7/2vHtqg+uKCS3Bd4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drB1x5NaJQoO67Z687KjxcTsXpn9jxzCrhv+mnsjfJCFZcswATZq6qsTVKgeKSMmOfSvzX1iQjdAHp2tmwhENXCBp0g4zrDvnwWpB5scGkjOBNODc5X4/Jh71/0sIsdQA0MHQxl7pZCYXV4PSg+f3k0LCzvttWa0omyLLpuuggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfCRXUbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D31C4CEF4;
	Mon,  9 Jun 2025 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482750;
	bh=ZlGXBtC6ZrZFPsq+ynuRGU8ta7/2vHtqg+uKCS3Bd4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FfCRXUbIxZ1yChYr+LJFjCUG2Q5R7SmeGsW/yw3dW5wLy1kuvE0yaSvOChnnZpMCO
	 W61RUiwn9/C3zY2TYLm68cj87HROJ/EZyqtpA/5V36ND5tXWkCH+ET/5VFao7TjcHE
	 S4lcrFJB5WxNHo2TzP/2Gd6rUdYc6XeMzRfY/J0II+O5WuE6CMMprC7bfqC3bC+v4w
	 7bf3Q6z6o2TfQpOOXfPxBZeXhwbHiRttL9x5tbD4HyeyQlSHMjldJi8FFhIHagbHfv
	 8KS5RxT5rEDNMkHcM5/WENBfUjbbExFpM+BofhYETCBbw8IHPe1iTqrGezcZAWxwgW
	 67PBsM5Yyz0mA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 16:25:32 +0100
Subject: [PATCH v2 2/3] kselftest/arm64: Fix test for streaming FPSIMD
 write in sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-kselftest-arm64-ssve-fixups-v2-2-998fcfa6f240@kernel.org>
References: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
In-Reply-To: <20250609-kselftest-arm64-ssve-fixups-v2-0-998fcfa6f240@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZlGXBtC6ZrZFPsq+ynuRGU8ta7/2vHtqg+uKCS3Bd4w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRvz2r6SxCP4huYS9jkPSYPBOOariafPEGsrXVtPc
 XZnIrxSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEb89gAKCRAk1otyXVSH0HobB/
 9hffmWG8loihFaTVyD/cuxx9e0wo8M/WeQRiBK0zRTPnZ7kZlOdc3u9jqt7wxqapaQ32jE+wT981Rm
 t5lnYpYXmR+OuWraQQpvno1NYaXV9ZMFuiytxVHyOeGxcbSiL50YVqTUpw+jG2oA4uuHxjuf7ElJba
 T5OKQpd86uJ7tkUF/NAo59hxD8V7+H1hyFK8fDyHebCDzqae+M7L4xIUeq5Xj2g+nKX1lZCW5wEydx
 EOYq9tDpiHqK/glaVVFr39GMZxdi8bJ6I8LkS4ITJA2A5j18gxlsmccDwrARCnd5+uIlqK1Xm5BN7L
 yctD0C3AY9tZYbUcZ/Itxph1iSxiSu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since f916dd32a943 ("arm64/fpsimd: ptrace: Mandate SVE payload for
streaming-mode state") we do not support writing FPSIMD payload data when
writing NT_ARM_SSVE but the sve-ptrace test has an explicit test for
this being supported which was not updated to reflect the new behaviour.
Fix the test to expect a failure when writing FPSIMD data to the
streaming mode register set.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index c499d5789dd5..7e259907805b 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -301,8 +301,10 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 			p[j] = j;
 	}
 
+	/* This should only succeed for SVE */
 	ret = set_sve(child, type, sve);
-	ksft_test_result(ret == 0, "%s FPSIMD set via SVE: %d\n",
+	ksft_test_result((type->regset == NT_ARM_SVE) == (ret == 0),
+			 "%s FPSIMD set via SVE: %d\n",
 			 type->name, ret);
 	if (ret)
 		goto out;

-- 
2.39.5


