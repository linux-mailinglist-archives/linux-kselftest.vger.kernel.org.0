Return-Path: <linux-kselftest+bounces-2171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E1817E34
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 00:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6153A281161
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1E74E0B;
	Mon, 18 Dec 2023 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwFSCxq+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FB1D14D;
	Mon, 18 Dec 2023 23:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8325C433C7;
	Mon, 18 Dec 2023 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702942779;
	bh=OcRwwaGGPxRicGDvk46gVxGH6DVGcgRe9WWBzbdRGGM=;
	h=From:Date:Subject:To:Cc:From;
	b=DwFSCxq+IoCWYsleB/Bj3cyZYXmVUJ1ld5+sAbfQOmHgN+6bEtEUc0IOowBrzcpYQ
	 lgQZWWjZPabP6jsPQKNHOCPdOpDVXjaC2Cpa4bhV+DBcvV/VdJ8QzEQproTRmdihVm
	 Rx5NYYn9v+JprVYNzfdOMOKVAk6Tn2+NKJeFV6zp1/4jN7Ogk+yw5omG/dE5WJVAnc
	 qIoxYEwqTY5q4XFBWeU0m+kUYtJ6aVUZZ+0mKxS5QLV2vIG3G4QktQDU8S3PA4wS99
	 6qNXijpCaEZ3AzkOtqo8LEI/viRbEgdXdYaEP5DnmdFDDhrG17TMeauqRaZOlZw/p4
	 H1naZ3K+7raLQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Dec 2023 23:39:32 +0000
Subject: [PATCH] kselftest/arm64: Don't probe the current VL for
 unsupported vector types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-kselftest-arm64-vec-syscfg-rdvl-v1-1-0ac22d47e81f@kernel.org>
X-B4-Tracking: v=1; b=H4sIADPYgGUC/x3NQQ6CMBBG4auQWTuJrRWDVzEsmvIXJyKaGdJIC
 Hencflt3tvIoAKje7ORoojJZ65wp4bSM84jWIZq8md/cd5d+WWY8gJbOOq7DVyQ2FZLeWQdysS
 3LgS4LqY2ZKqVryLL73949Pt+AGmRVcFxAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OcRwwaGGPxRicGDvk46gVxGH6DVGcgRe9WWBzbdRGGM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlgNg4KHZ2pT1ckQPky4CBUbPiGTOrGmXr2vzLyyfh
 S9O7o+KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYDYOAAKCRAk1otyXVSH0CWZB/
 4xFWcfFuKsRc3GM3Qca5XgAyj0mt0s2/BrDYnFcb6qZH74/ugBfR8JbCLlQgHwDWRYpEanyvckehrj
 VCuySg5d5xRuouwJQOeq2uvvFPruFGWSn3vluFrqtyX+gaAewnoWVyZGhrcZiFVbBVruAYrQUuJjB5
 zbkJwMgbYD9E9O6nzsYXiHmxa3x22hWlzXzzvu7qRySXs3SMr8xZQJacWjcLMSGDsMx13laMv94yB3
 h/34XnAMtOvmHkQbFV353HWh5nWmCMNtcyWd6T2/C8hZFSca2m8uUgrB1QeA+CfZtQxZ8vG4X/4Vm6
 AB/1jC/675E60GZmemgC7CrthdsKC/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The vec-syscfg selftest verifies that setting the VL of the currently
tested vector type does not disrupt the VL of the other vector type. To do
this it records the current vector length for each type but neglects to
guard this with a check for that vector type actually being supported. Add
one, using a helper function which we also update all the other instances
of this pattern.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 5f648b97a06f..ea9c7d47790f 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -66,6 +66,11 @@ static struct vec_data vec_data[] = {
 	},
 };
 
+static bool vec_type_supported(struct vec_data *data)
+{
+	return getauxval(data->hwcap_type) & data->hwcap;
+}
+
 static int stdio_read_integer(FILE *f, const char *what, int *val)
 {
 	int n = 0;
@@ -564,8 +569,11 @@ static void prctl_set_all_vqs(struct vec_data *data)
 		return;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vec_data); i++)
+	for (i = 0; i < ARRAY_SIZE(vec_data); i++) {
+		if (!vec_type_supported(&vec_data[i]))
+			continue;
 		orig_vls[i] = vec_data[i].rdvl();
+	}
 
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
 		vl = sve_vl_from_vq(vq);
@@ -594,7 +602,7 @@ static void prctl_set_all_vqs(struct vec_data *data)
 			if (&vec_data[i] == data)
 				continue;
 
-			if (!(getauxval(vec_data[i].hwcap_type) & vec_data[i].hwcap))
+			if (!vec_type_supported(&vec_data[i]))
 				continue;
 
 			if (vec_data[i].rdvl() != orig_vls[i]) {
@@ -765,7 +773,7 @@ int main(void)
 		struct vec_data *data = &vec_data[i];
 		unsigned long supported;
 
-		supported = getauxval(data->hwcap_type) & data->hwcap;
+		supported = vec_type_supported(data);
 		if (!supported)
 			all_supported = false;
 

---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231215-kselftest-arm64-vec-syscfg-rdvl-7944e19ac64f

Best regards,
-- 
Mark Brown <broonie@kernel.org>


