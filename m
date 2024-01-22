Return-Path: <linux-kselftest+bounces-3341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC358836D3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F7A2858A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858836A01B;
	Mon, 22 Jan 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPfXlTUF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C556A017;
	Mon, 22 Jan 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940931; cv=none; b=ieaTMMeyGHVQmPZu6U9mau2dOWfFxWgOfoz523Ba2Uh4TQ/wrJehDqWE2aP1h4Uw2T9RuE/al4/PCKL59TqaE8gXYVdXl9Sg1ExiHxmCUmiopcjobmR8PjTmbjOMfYxsSirot82kLIe1tnKuqpEfE1r/yO04rNVhC3RlJjImMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940931; c=relaxed/simple;
	bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXXhbHDBcKfSYCE7ODVXmfzjZBCfHZCr7mQU2F6sAx+h5+6f519XyNXi/G1br/pb1oicpmqQ3PvwJSyXfEtq3FJTjK97++Ll1sxW1bzZ5bX+WmTlWp1mcpvEhFXymIEFJX56tgN1Hr5xI2UR3f11FOYbeMB/cAXA04DMIco/20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPfXlTUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2453BC433A6;
	Mon, 22 Jan 2024 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940931;
	bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bPfXlTUFm4KYxT3WBpuMukYCOJiw6izF8UmYirMIMqtFSye7twQ/Py/1keI8SYY6K
	 3XUJkcZRuvE2rojGeCVD7/LpFNv7PSU2h7bla7FJgxV9YZHHIHfrSoKNuSBftoXSaZ
	 gowUq3JJm4VyTBAMatx4yb6m9h+gN0TB2cC4QQc861mvAgSYK3+sEFGwafTFO8hzPJ
	 LfeWTR3jz+K2cvJhn3OyxQv2DfTgWxFbbqsNn4FumtrWQbwKY4Ydc60hskdM80TDo2
	 yu2wvraLhYh5clxvXzE4ibbbdqJil1axC4Srf9PqD1xbU3PYJRqF8i1E/O/FuOrQI8
	 zLkPnsDzOFP5Q==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:10 +0000
Subject: [PATCH v4 07/14] kselftest/arm64: Handle FPMR context in generic
 signal frame parser
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-7-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jvyJQ++Epw5Vr3/tG/z6+6Y9vzI/cjN2rH2C/CkHcMI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpeg0bctcgOlhaw2famtpkwHB6mOsIaAFQCEpqqk
 mYNnMo2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XoAAKCRAk1otyXVSH0I98B/
 9kEOAc/fsEItpSuI1JVVl6A/zNCnaKkf/XnxSI4fyiHZJDxhRImWWnrNaCFHXVJOFA7OEr116x4eCH
 qdJJ57RZjtg30fwXCIWfkCv/5nFiRH95Sn/QJzXGyxXJ+mP4vm/Rp8nfWSpYwFLx/vqZI8BRl2HNN5
 N7ZIOfT4HUg1giVy6dOMU8brfyXTq39OkqKyhEpfMhuOsBDYszqCCxecsoWGMg1nqUZ05Og6HQ4Vby
 uZMM5u4qDrMZ7KUjkN1kMqick5hfmhPwamt5PNbMz0541jAWYaf2q6r29vsnyqciTuAP7kYQZMnsgd
 4R+mj6TQE1y7XJsDj3jntfneiAdW2D
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


