Return-Path: <linux-kselftest+bounces-32445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F87AAA2FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 01:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E96188AD73
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607BF2EC882;
	Mon,  5 May 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kumBR75k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391F2EC87E;
	Mon,  5 May 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483780; cv=none; b=t7bFxjdm4IG6WeiaU8HYmuI3kxLHu0vvOUFUeHBVt6YMPzriJzRPU6HVM4zIEVjSndSzMhElf/eDjSQSVvc+v12l9sdIVKYQrssCiNicC8zhhfJCXaLp7Hqawl1hgfz7DgRJHkFUlGhXiN8KYGAjybJ4L3k4NJA6sZmLd355DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483780; c=relaxed/simple;
	bh=/JP9CkKr1hl7Gb6uLBdRjMIuo5kAkP1G4k49v66SvGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpVgoY//tdkB+AoFixBPfRHRAno2n5XNy5PlmdWl4gCAGUdK0+xU5p5kIjz0SVEraUHjxoG3trOfsvmVObt4qH5qJwvdYQ9cJGwm+dzqCKdtnzuTIEkOvbbHPa1rIzH2pdbPam7JHqH3hz6p2peL+IES6ue6PBIDfMDg7ThJwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kumBR75k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D3CC4CEE4;
	Mon,  5 May 2025 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483779;
	bh=/JP9CkKr1hl7Gb6uLBdRjMIuo5kAkP1G4k49v66SvGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kumBR75kc3/jHWXDRycBwlOiyoHeGMbdJEJNVs7CuJMO2Fx8WFkG0cA2ogTknMcI8
	 GkOZSr7dsBYMlA5tKV7jmt/V+8AK47J2XF8szmD2GTvmIwND1ZAGLvWoaFV3wHNrZm
	 mvAD30coL3bXP/qIpdhlM9GgYtAU+PLKLlzGqygVhqZWfrcfTYeQxhfELD49wOquVF
	 F6lrjM+W8ppD1k/lJN8IL2xekTvjRhyK0lt2kGNuqTSy1i3K5Hce+pclxXvgNB289M
	 SZTVpjWp3ofgdI3icj3NdIMNKu3uYOfnbg0wQtQFIEkXJYk7LUfJXot32WaLd3IXEv
	 JYryeM/8Vbddg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kw@linux.com,
	shuah@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 215/642] selftests: pci_endpoint: Skip disabled BARs
Date: Mon,  5 May 2025 18:07:11 -0400
Message-Id: <20250505221419.2672473-215-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit af1451b6738ec7cf91f2914f53845424959ec4ee ]

Currently BARs that have been disabled by the endpoint controller driver
will result in a test FAIL.

Returning FAIL for a BAR that is disabled seems overly pessimistic.

There are EPC that disables one or more BARs intentionally.

One reason for this is that there are certain EPCs that are hardwired to
expose internal PCIe controller registers over a certain BAR, so the EPC
driver disables such a BAR, such that the host will not overwrite random
registers during testing.

Such a BAR will be disabled by the EPC driver's init function, and the
BAR will be marked as BAR_RESERVED, such that it will be unavailable to
endpoint function drivers.

Let's return FAIL only for BARs that are actually enabled and failed the
test, and let's return skip for BARs that are not even enabled.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250123120147.3603409-4-cassel@kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c267b822c1081..576c590b277b1 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -65,6 +65,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
 	int ret;
 
 	pci_ep_ioctl(PCITEST_BAR, variant->barno);
+	if (ret == -ENODATA)
+		SKIP(return, "BAR is disabled");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
-- 
2.39.5


