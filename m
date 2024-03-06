Return-Path: <linux-kselftest+bounces-6027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0D8743B6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15BBCB21F71
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52025776;
	Wed,  6 Mar 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnB4Ac/y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A2381C7;
	Wed,  6 Mar 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766946; cv=none; b=aV22QUnWko3ZNMvC88u2W/cOkDkrMAlVd5gzM9HN5Ed1nEZJmp1z0/lNngoFH/FcNIgr/Xg9uABKANHZzcKNa0MOZfwU+f54pklAY5lxYTBwJZd6IxhabyQ/yHgk2gSnjxltDwVLR4V02/up5sn6Z50Potrcz+r32FGXbqkHiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766946; c=relaxed/simple;
	bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJLuocatKQ6Wi/JAZCWNwogwBKE8LyWMzrLr5NQ0DwwZNIFUEzLaBwXdUcO0afQtIv4QaznJK4kesK7fMiz8Gl89M8+gnlxp53xiN6eTUZkdJf6xBsZf5GICLhIeb0U9b9RnWcf+inL0H5cGAwav8P+qsRhKkkT3hz9Q1hCUoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnB4Ac/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B89C433C7;
	Wed,  6 Mar 2024 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766945;
	bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CnB4Ac/ymUxrY7BXIh0slKHJz0lz/Ew9kn55bqXq9V/edlTXPTXBeEpzh/woc05kb
	 frZOe0wVc2SG1AvuUiIlf/dSMZhkDCLz6qCeSMfzLbtrBWSG19c5IWnsvV2yB2T0SC
	 9D3pSsvdcL4OOFpwV5YmJLHg21CyZYpGhrzfOrAv3jm7iUYVpLY9ULOgMi932wCgPV
	 05lYdWpqwd5W9DvDQCO1Ll8JpABae005XTw5GrcDx6ype2ezbBlslEQqi8Wml4dHrs
	 29ZZFAiJE+9u/w7TwYFFrclisgsoRq2w7IuLjMYrcsdRWnFikBCYkvxUR9FjrFJLZT
	 asFvQTMOuha5A==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 23:14:52 +0000
Subject: [PATCH v5 7/9] kselftest/arm64: Handle FPMR context in generic
 signal frame parser
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-arm64-2023-dpisa-v5-7-c568edc8ed7f@kernel.org>
References: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
In-Reply-To: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkGqB3St0Q35SY5Yf2y9zWdVT0cyTrbfazaUP4h
 /LMINsmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5BgAKCRAk1otyXVSH0D7tB/
 4jj/rDoSKB0G6bzNl7LApoc8nn07H35j+ZrlxRwKr6eaZwtLC/thFA/LdeJgS2P8hPg81kq4c5/fOt
 05B95w27vmGToNdyLAA0sYqtXAiIuEy89geE66nc3vRjdiR/cldy9I1Z9srXoYfw+UYB50lwo6Lnp3
 tRdAAOYj2XnwLx7qHtpaiGM5Cj3RQV5SL6zQQZx4iWA0lE6+e0TxPTE/OEodO+QSbceURZDpyYBUzQ
 OTgrS/hBkfmksa8NksVJt1uwNfJfbMJi/6Wl7I8Nu5jtCv5HX1RclzpSeQBZd2vLBAySuBMZ8VP8Ve
 UcaCnS9I2iT2hhwSXV+MndO+/vsNwi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Teach the generic signal frame parsing code about the newly added FPMR
frame, avoiding warnings every time one is generated.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 8 ++++++++
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..674b88cc8c39 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -209,6 +209,14 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			zt = (struct zt_context *)head;
 			new_flags |= ZT_CTX;
 			break;
+		case FPMR_MAGIC:
+			if (flags & FPMR_CTX)
+				*err = "Multiple FPMR_MAGIC";
+			else if (head->size !=
+				 sizeof(struct fpmr_context))
+				*err = "Bad size for fpmr_context";
+			new_flags |= FPMR_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index a08ab0d6207a..7727126347e0 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -19,6 +19,7 @@
 #define ZA_CTX		(1 << 2)
 #define EXTRA_CTX	(1 << 3)
 #define ZT_CTX		(1 << 4)
+#define FPMR_CTX	(1 << 5)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.30.2


