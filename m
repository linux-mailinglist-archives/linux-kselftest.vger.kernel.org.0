Return-Path: <linux-kselftest+bounces-3366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E68374E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A048E1F27C95
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A047F49;
	Mon, 22 Jan 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYDk/qTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4B47F44;
	Mon, 22 Jan 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957705; cv=none; b=ilm2AguQrFfkMHpkyjV2n7Ij6CfudVOo6tEGJSCN+gbgXAR549eyTp0NaN1rUpnoni663zzFfgx/W5F8t7s5Hp+wWR32h1qGoivqYQPkulMZLpQn2ZZtRx6qosFzym3E2GZd/3Tlw8dINxDqErynYdB/fZZdCAmwv1aMNv0T4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957705; c=relaxed/simple;
	bh=x0Jy8C6TAh6LqyiLvnL2mux6L8/DDB6WSuNHGAgnn94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fYT9Rfg652bskAHUtCSV86QSkgCmYaABRcus3L5ejHqyTz7zPOO+v7cyLmXlim//T37sNwST7eXiJUeYn6WH3maWP+2Brty/ELn1mhK5337TXV2H0GANTDLeQaGZLn2+uLAmiCz9JuNgxKZ+Kh8FaiadMUDCotmWky2MQbWTG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYDk/qTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2EBC433C7;
	Mon, 22 Jan 2024 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957705;
	bh=x0Jy8C6TAh6LqyiLvnL2mux6L8/DDB6WSuNHGAgnn94=;
	h=From:Subject:Date:To:Cc:From;
	b=bYDk/qTOpASvu642sidXVMdmofgixM70PFGkfS6SfcPaEXx679N3mGMDW9m8ekVz/
	 Xha4rcwQ80CikpCzQ4D4mBFmys4iulF/O8t/DwrJWV1lenFxWI5BFaNm8rwwwSpSGl
	 G6JaaKedu36XRt6FyijHIhWW1DDPixo8bMIU40gkqBoBD00k18tFAo8GOaV8yDtRza
	 4T1eP1GmACs25nHxVknr0RjiUUjPlGvmOlwi4kgxXVeMMYrrvLiLFGNZd83Q/TpJ0V
	 zy9S11JuPbyajITKxTzjjj6mvRpt3ypEDnYyRFZ5ld3048lFQStADtF6DquCxTdOv8
	 UbV4AB3wq3M8w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/2] kselftest/seccomp: Convert to KTAP output
Date: Mon, 22 Jan 2024 21:08:16 +0000
Message-Id: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDZrmUC/5XNvQ6CMBSG4VshnT2mPUV+nLwP41DgAA3QkpY0G
 sK9W0gc3HR8v+H5VubJafLsmqzMUdBeWxNDnhJW98p0BLqJzZCjFChKqFIYPI3tQn4BT3Vtpxk
 qMnU/KTfAsKgZ5CXPuCxQ5rxgUZodtfp5vNwfsXvtF+tex2kQ+/qfHwRwaMuSEItMiorfBnKGx
 rN1HdsPAn7QlAvE31CMqKJGyJwUqVR8odu2vQF9CGAmLAEAAA==
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=broonie@kernel.org;
 h=from:subject:message-id; bh=x0Jy8C6TAh6LqyiLvnL2mux6L8/DDB6WSuNHGAgnn94=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrtlEhS/57HUUTEDja9J6qPYiqCHOXY07VzgZ0SNG
 ME0drnqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7ZRAAKCRAk1otyXVSH0GfWB/
 4+cIOt0hHvWZkdmoZ+bcw1UFGe5zFh0nEwzC1ypiwsvHsyTmXlk5Z3pqMr+zV0o9f60l1SFuyB6alT
 Vx7RnQ/EtYnzhnxWXB22KyVYvUs2Zl3F/yk2Yn128OwLPWNG8X7XNTpYoaSNTVUXJe5PGj8BQtv6AD
 aVDIAEAvQhv2qWK7vsJA2vrF7wG8AH9P87XJo1Zs/ZTeETb8dJ/YkvYzKdAtLm5OG+rnzzKr+2EUMA
 KyVb+qmJ0iqNzp39KpOl4hKsfrBHc+VLBLa3BupUTinXpxEvzHrZKgTlQaLsrH0ZLu8mEXIW0FsP6i
 TTDc4B7ZA382Mkwgce/iZAL/zuveDz
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
Changes in v3:
- Re-add signoff.
- Link to v2: https://lore.kernel.org/r/20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org

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


