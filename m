Return-Path: <linux-kselftest+bounces-98-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D87EB24A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2DB20AC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8441235;
	Tue, 14 Nov 2023 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOS8KG4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7E4122C;
	Tue, 14 Nov 2023 14:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C02C433B7;
	Tue, 14 Nov 2023 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972580;
	bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YOS8KG4fVO3sjgOMo+FAHn64GDHolFxDFhb3NYUj8fzUzQFNPjlDg30ZmOYpBnAru
	 tG/OfUrOJlx0wulfw2zaVlpNjhOWdeaYuZSk1y5WKKBWKQzEkSinYWQGr84FgvntA5
	 0BVpix+CA8Afc0bEK1SKV53obyaPXfYfAFzJUUHmJaQCyLZwa/IOZ6FhHIqupvjtzE
	 YyOZ4jwEYRZ4XVKVafGt9toXiX4onS80XbKSKL4aHwfL1hQTJl09B+dJl8qQMYfRWw
	 JMD11WTO3b9xoSuP3rvFBMYZsuAd1cMab0AgrmbwOWl6qDrDwwcfT4rP9HYcjwXTO2
	 nxQSCKgoFAOvg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:35:02 +0000
Subject: [PATCH v2 17/21] kselftest/arm64: Handle FPMR context in generic
 signal frame parser
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-17-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WihBluov0BrNbZHj3lKU43suw3FpTrP5aceS3k
 ldFYx6eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFogAKCRAk1otyXVSH0DttB/
 0ZeHEuPXQopSQOn9tAF87i1SQZ/RrZwyxmPptMZxx7JsE7Dw7ko8FabbYbQyX235VU7PY/xaM3E2dq
 b+hbNedb5201bNO69pYHsDRwZhLvCWOeKTHuTuFUF1B2Fco9O19BN/OgD6iTJ9ccvA+EOh/nA7wtb+
 //J11V+Zuw580IfZ5fBSZh77Tqp/53Jo8HzGrd1IozgeHTkQUVevtC4U+AOvXMS7sx7w3S+t85qLZV
 IDB9PbMAo0L/fpAQb+1NIkEbKiY1WlfT+viZJ978DYMdGUe/QtfwRq5mmPAWY1bXtl3ih4zkhVhT5h
 62BCjQdiqLITLvKYF5yOZf0D5qM2kO
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


