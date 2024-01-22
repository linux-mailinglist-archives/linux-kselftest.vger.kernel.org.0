Return-Path: <linux-kselftest+bounces-3329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0021836CB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5338628A01D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE24D59D;
	Mon, 22 Jan 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmveBwGU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F43EA83;
	Mon, 22 Jan 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939467; cv=none; b=jiB2Pa+E1Nciyk+DE8HPB2ivjDYi/VIpZh9aeVx9Hzg7E2u1JAlON+XgJcMjFxFu3n94r8Sh/MHD0rnDkmtIKvOM4bl6NU9FeEsVS2N2TNzVtrgWY4CjxEUGBA1qDur5FwPFDxjBjkUeqmXqHBJAa01MWHd6G4wMYnjVQzp0s5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939467; c=relaxed/simple;
	bh=9NOW4PJJJHRMNdIzMEfidVAyIfbuRCPZbGomXALQm0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TjcWpxoZi3yxKb/hpj56HK05JZT2c6IhLzTxvP/kCrnSZiEsa+tEBVL2BeUsKKeYrp4AvOVnpsjcDB0quGlbNi0gj2IxbC3RZoPEAzauwkSmmijOy0d5gOFwc0zYlVdz0uC4WcNBtDy55ax2S+hDP17rCDSNys++rK/m484B9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmveBwGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BC7C433F1;
	Mon, 22 Jan 2024 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705939466;
	bh=9NOW4PJJJHRMNdIzMEfidVAyIfbuRCPZbGomXALQm0g=;
	h=From:Subject:Date:To:Cc:From;
	b=PmveBwGUz8JvHM7e6ofP1ebzsZpdb43APmUivPMUAd7D3BO2vFuia6u+dSSJPY3Ck
	 Xs1voI1XS4+rxqadPge+7SqUTTuUh1SJZ/ji26xOUDUVL+B0nbCNX3cFUpZ0mw1pfO
	 Vo1WdWzhODF8vxiymPkL5hydPDQflwoaxE4Nl5IU2Tsoomp70k5oH9k/f0Kn4FvtkT
	 ez2yu6DB8NQ9NT8FyiaU1yBEWuKKpy8ZfcgqgeAq8Lh8fJKM2/8Rd/S58Lb6rYGTX3
	 CaoskedoYo2ARCg98Wff9mU+J/05oX6vKz+u1m3eagWt0CGngQ5Qdnvy2CZ4iOUnq7
	 eIPkBP4lAUxWg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] kselftest/seccomp: Convert to KTAP output
Date: Mon, 22 Jan 2024 16:04:14 +0000
Message-Id: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6RrmUC/5WNSw6CMBQAr2Le2mfaV+XjynsYFlAf0BRa0jZEQ
 7i7lRu4nFnMbBA5GI5wP20QeDXReJeBzifQY+sGRvPKDCRISZI1dle0kac+cUwYWWs/L9ix0+P
 cBos2tQuqW1kIVZEqRQW5tATuzfu4PJvMo4nJh88xXeXP/tdfJQrs65qJqkLJTjwsB8fTxYcBm
 n3fv8+l4l/XAAAA
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9NOW4PJJJHRMNdIzMEfidVAyIfbuRCPZbGomXALQm0g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpIG/0Ays7HCrytmcrA21yoUdZu+RYOgOVqEfPuu
 xXq3ASiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6SBgAKCRAk1otyXVSH0KhYB/
 9uafPxDt7FR88b0KSa2blor4TZ957DpjYC1XeYc/N3BdmNmn+O+jEI8xAe9OQXGbVzWspfgyBOO/iY
 O9WZlsvNFZle2TC+YpqahqKZoFjK0Jaza+Hi4Auv4rS69XisXrS704R2rpnHupruftoJ802DZpdhY+
 ryqqby578Eb0ikADFCqrX3diOHE8Jj3aSkeOeLkMbq2qK3rJTUMIlPiwAVbSri0shbnqd3jATiE1dQ
 LtNefuMLrxHM+gXmvJtK5FgmxE/RzxLG+WrAi5PSWTyBPxHAk+GlRrn8boX7eRHHqKoiucZu+tOa3x
 2M23AbzDAj1Xo88LQZPuSRLl4i+6F3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the seccomp benchmark selftest produces non-standard output,
meaning that while it makes a number of checks of the performance it
observes this has to be parsed by humans.  This means that automated
systems running this suite of tests are almost certainly ignoring the
results which isn't ideal for spotting problems.  Let's rework things so
that each check that the program does is reported as a test result to
the framework.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.8-rc1.
- Link to v1: https://lore.kernel.org/r/20231219-b4-kselftest-seccomp-benchmark-ktap-v1-0-f99e228631b0@kernel.org

---
Mark Brown (2):
      kselftest/seccomp: Use kselftest output functions for benchmark
      kselftest/seccomp: Report each expectation we assert as a KTAP test

 .../testing/selftests/seccomp/seccomp_benchmark.c  | 105 +++++++++++++--------
 1 file changed, 65 insertions(+), 40 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231219-b4-kselftest-seccomp-benchmark-ktap-357603823708

Best regards,
-- 
Mark Brown <broonie@kernel.org>


