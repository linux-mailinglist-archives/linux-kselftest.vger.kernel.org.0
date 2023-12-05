Return-Path: <linux-kselftest+bounces-1163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71844805A5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A610281FF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C55D8F4;
	Tue,  5 Dec 2023 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqyb5YMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590A4174B;
	Tue,  5 Dec 2023 16:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD1DC433C9;
	Tue,  5 Dec 2023 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795094;
	bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jqyb5YMtNSsewilq3YgjUOLKB+5TZZxOhPMYtacsADuHV8SBMnhdKtzSjTyhHZzEm
	 oHXzvNzWcQ35s5gb0XHhcwYsPuCIfmzAWUOjxccMbJ7aLMNYNu7h5m7yhO69cr6X8t
	 LsO6yW8ieiimIM9EXiu1nACFt0WA42BnELODdvKRUqRokUjAT/C5ykYMeifPEIqOBW
	 mIYJ54EZGqaRkHnYm0SqWHEbfLZ0M3trtrhBndFjMptqvobpIvoDWlQ9L2I03m/Cc+
	 5Wh2CroQRUBi4vwTtvYR6gBzWxLVb/qKP15pjJVdEWF2Zt2yeRzVQmoSGbJNUieP+I
	 Z810MDLonuF4w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:05 +0000
Subject: [PATCH v3 07/21] arm64/sysreg: Update HCRX_EL2 definition for
 DDI0601 2023-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-7-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TuD6frcSkllH1UYYR40YWIjqreDBRNueDypCOq
 XjYki6OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7gAKCRAk1otyXVSH0BxSB/
 9+aykVaLXXkovSxvPoWNp/dLjsV1+Cm+xxFo/z24bos92b6gHOP83wnIEddgbLtyoJtveduZ+hsSeY
 ZvnCX1wUSAZLjZhpk0cj+8IlJE+GzQjGOBch6dmNJyy6GxvrkJ7rgbtuzUcPbRRKC1awZTD+zZbthm
 deDPd8ar/7eFE3e+/XV6heK4bWGNaXJWPHZin6myifMPB5U5pES0DduUMSnGzZiFqX8Qg6jGZqOB29
 BgYGCxIQOyEwNsIHOblnca6qoeB9K3jKV+u6VV3dz4NqhWWYFSmOor2/jrtkJKriL0HyUcNpUb8NKt
 M2wHrXrpV/8B2oTE7OBLn+RVW6XABe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines new fields in HCRX_EL2 controlling access to new
system registers, update our definition of HCRX_EL2 to reflect this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index eea69bb48fa7..0b1a33a77074 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2412,7 +2412,9 @@ Fields	ZCR_ELx
 EndSysreg
 
 Sysreg	HCRX_EL2	3	4	1	2	2
-Res0	63:23
+Res0	63:25
+Field	24	PACMEn
+Field	23	EnFPM
 Field	22	GCSEn
 Field	21	EnIDCP128
 Field	20	EnSDERR

-- 
2.30.2


