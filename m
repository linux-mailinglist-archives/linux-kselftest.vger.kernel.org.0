Return-Path: <linux-kselftest+bounces-43183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD9BDE7A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB25A504004
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EBF31CA42;
	Wed, 15 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o75juOVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9113191D0;
	Wed, 15 Oct 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531483; cv=none; b=FOtlybe78W5Tm+5yDqfCyLIAIcuVdSx46SYoTc4msDu7ZbPWmNVCEAnhUCKrjKsgL6Lph+WMUpD+LDLv7MjVIHclWda6tzMIPPTNv8XMd8y9L/5hUerEJ1eaF0JRVuuSt7eqi/SIK2zllpXUEnjREZok5GR5knEoKCQ7AvN8Q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531483; c=relaxed/simple;
	bh=ljQ+s359Zv/axxlgqUOol2/tN3Ll1JsFrzUKQGJE4tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoxebRRPrEmX8sjX/mldhga8lEzZjFW/M3Cth0TXxOkRjTBTTX75CV6Mcu4vO+mcbR5YYQwiuNh+sm3YXZa9QKIk5mOvvzXwJTqVdN+rZjH8An/y1IzYctV4s2MnJSjfmmOFW5PhuzunodAoTgoSRvdkYbVIqdvLkAyLEDYb2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o75juOVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6323C4CEF8;
	Wed, 15 Oct 2025 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531482;
	bh=ljQ+s359Zv/axxlgqUOol2/tN3Ll1JsFrzUKQGJE4tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o75juOVKDrvvBIjPDw81lV3H1WAFgTlE4t5DzJFt4OASYHHV4/5iN/nNUle3HdM4X
	 Cvl6UP7jZ7LP2A3azmFuJA1ICZ4+aDN8mw1Oftg+MDQwUwlBaeGT83IBX/FZdagnsj
	 ySdXRT1/irYwJGZZBV7N771qXqH8hkfjzzbxjasbtERFmwvmVySL//uBj2pc9SKMIe
	 DNFqwZCxRy9fsds+Thrl+2UOkvwsMbz1Wx7+iBwtQoGHtqxnvE87SUGKPCcwRGZ6wD
	 IjoKgemPWHiHZQxggFiV/FbLkN07VLFTvzIJRCspZJ43EkGvsW+x86/MxAGBpID8sx
	 363clTVl2ndng==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:30:52 +0100
Subject: [PATCH v2 3/3] kselftest/filelock: Add a .gitignore file
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-selftest-filelock-ktap-v2-3-f5fd21b75c3a@kernel.org>
References: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
In-Reply-To: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=464; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ljQ+s359Zv/axxlgqUOol2/tN3Ll1JsFrzUKQGJE4tg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75QPpZZeKHnnOBTayy3oIgBNtlFRM5ubC/yfT
 IH+dTzgBMyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+UDwAKCRAk1otyXVSH
 0O8OB/9gqMZTy8WlYrnDsWyO00sEyByOqiqwRhOlmr9cGDPIxlXVr6g7SDIiR34tgO5Pfdhx6YY
 dIN6Dps/bLEiOU49WpCzS42GwZ++8Q8w3Xo+D5EX5tNkuWHXtEhkWozp6KctPHoGQvwQHK3nJWO
 1DrHzDMm5lUbrKkzk4hMraEZ1+ecA9vIsNNK+b61DRXag8iQpYOY4OKjbKHYhXVkQSeDaI9sK0n
 OhJdEw9bRu4UvFTnWUFQIRio1zQdee49tpg0p4af0+ncvHXhXXgSs1Kdw2nVvIr8eG3L77CYxfI
 3eHtc+Wrg66PgIqAcucx+0zSENoOcEECuOuxzL+D7setZs//
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
2.47.2


