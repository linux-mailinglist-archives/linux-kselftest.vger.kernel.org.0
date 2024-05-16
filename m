Return-Path: <linux-kselftest+bounces-10300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1348C7972
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E4B233B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8014D6FF;
	Thu, 16 May 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6rXecEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C414D43B;
	Thu, 16 May 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873282; cv=none; b=tzVtF7STrC3TgSqbbVFQLyZiW/O7I83g/fj8ENFEE3b/g6G6IJK9thMB6z7C0V2bZ+uBRZkyYzoPIaNrHXU07mWr6sEOwKBcomTau0Zj/wa4Xe8peS2iqOcezns6ifTtpIjkbUMwMoV+mEFX5aJ9QktV1dwzsgPao+z8mn/PnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873282; c=relaxed/simple;
	bh=SXE6O+oHIddD6pG7s3b7eDz3xjBZ6UcMXN9xDAZYMyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GqXDTX36PjTyIU1aK4PzzhYoBEAHg296bXQyD52BzBfwpq02kIgpuFtJRhf1GAeu7BeviuIQr76hdMDQ1Cel9WYO8UbUjumcmBU0i3g7WM9XLnPIBkgL6ylCPorQUzKFin05dAHgiK8lBtbSqGfr+LGw8Lpjrzs7m5AcSenQS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6rXecEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C3EC113CC;
	Thu, 16 May 2024 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873282;
	bh=SXE6O+oHIddD6pG7s3b7eDz3xjBZ6UcMXN9xDAZYMyU=;
	h=From:Date:Subject:To:Cc:From;
	b=L6rXecEITy/6+ODRXq7YXTjKfZqb9y9NjOWWrM1qpxCvYl6gvrxs0gIG9sUlTUvHU
	 N68n9ScuhH8yBcZMEDSp3zduI7DTnxSShV9zOCorrDXZYe2Z3aDD7oQBJezvzJv0Hr
	 iTyupgohmzGtjgua9NY4rAtQCLT3IluJjxq6jtqlGPjAmdB+1PILjl9hWY8ZOowTnE
	 I4JK7efU9zBof6Yp3pPU9ivPoKgiDwTR6bT8mgkzYYfg72OXhcD3amdqUVoB7S70zn
	 Z4fB0zCNpBtQpiIW+OahBSeEy+TvQ4c+ZBXAkThMkxtXW1SZZ5P2Zil46AgMBD1zBE
	 nlccvkr4pIhww==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 16 May 2024 16:27:33 +0100
Subject: [PATCH] kselftest/alsa: Ensure _GNU_SOURCE is defined
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOUlRmYC/x2MSQqAMAwAvyI5G0jFpfgV8VBs1KBUaVQE8e8Wj
 wMz84ByFFZoswciX6KyhQQmz2CYXZgYxSeGgoqSKlPjoryOB+uBo9w4hRN1O+PAaI33nsg25Cy
 kfI+cjH/d9e/7Adth6olqAAAA
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-sound@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-f3d47
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SXE6O+oHIddD6pG7s3b7eDz3xjBZ6UcMXN9xDAZYMyU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmRiX/9x1tdwjJ+WIougt2pxJwJRNDHaY3WKX7ZVta
 tzaafrCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZkYl/wAKCRAk1otyXVSH0Ag/B/
 wMrz08LCQDCftmtnukIUc0v2DAGIqoW8APGwN2DsWqfxdhNbQamdvCc9YxkhcWo1AGQMMyLxrgukpf
 //9bkf9MaNYjjaCrV2V4wf0LyWJB9JmTMpWjUA1AGT3mFNnI+nmpTrdX70BxNDXHZYSISJsjbUbzRG
 pC0KZ89D4tZVoOB28+dPGib8/na/8X5nuPbF1Exf4bXdCWeSsz1+B+PEhm5wp4P9mHlRalrNfHxfZY
 1oDo6kw8FsI+E7r4RfSRycplAWMYV0pY17seq//hck0C9Kn+aDdqA67tBu33wjFTQv+r0xJQAKHsbd
 R1rDLME3Tx6FtNorKInZaIB9YfWAEe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The pcmtest driver tests use the kselftest harness which requires that
_GNU_SOURCE is defined but nothing causes it to be defined.  Since the
KHDR_INCLUDES Makefile variable has had the required define added let's
use that, this should provide some futureproofing.

Fixes: daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 5af9ba8a4645..c1ce39874e2b 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-CFLAGS += $(shell pkg-config --cflags alsa)
+CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
 LDLIBS += $(shell pkg-config --libs alsa)
 ifeq ($(LDLIBS),)
 LDLIBS += -lasound

---
base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
change-id: 20240516-kselftest-fix-gnu-source-81ddd00870a8

Best regards,
-- 
Mark Brown <broonie@kernel.org>


