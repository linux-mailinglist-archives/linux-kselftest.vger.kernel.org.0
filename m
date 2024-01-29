Return-Path: <linux-kselftest+bounces-3683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597C83FEE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 08:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352D01F23CFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FE524CF;
	Mon, 29 Jan 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca/26MDX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD1D524C4;
	Mon, 29 Jan 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512169; cv=none; b=QbPRs3C/KsfzZJFv7Macmt/SC8W8YPcLAjjQX0Q4ziIrT+H4Eox7JxXB0wNimTUh3c2872ci4QjkkSzK3ciJwvPdt6QAXFfLaPgtbwc8WMQ0cdRxFtwUKdN1TZgMeRRLui49NMnUUXYZAwshqrf1i66xRerdvU1LtvMKtSfcsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512169; c=relaxed/simple;
	bh=+381f8EYJCTjcjt+MiKdcCGuBgs7cYIbIsmEKIv6bds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzzK3zYhEHS2sVDyaoFpobsNR+jeB80a7YzNlt93EqY3JS6Yx7SkhQDoynu4JT1QbkgxiGELQ1y3Jmr1RTh8hubQWUycWRV3wXFc+fMsSV21ul+xzhdAOTji7px4c6K1wvx0/2QfoeRMTWtA9obC++WDzcfa6jC80S+eiMVyOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca/26MDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5156FC433C7;
	Mon, 29 Jan 2024 07:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706512169;
	bh=+381f8EYJCTjcjt+MiKdcCGuBgs7cYIbIsmEKIv6bds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ca/26MDX4T/qszXOnPWX+m9GqFZsM18y4JA1KnQWXSXupaLCKI1qdWuGvdVN76JvZ
	 zxImdfunMgPvV1te6RmXlRfKw4fXBJMtYFrl7Y9Sq8Fsoenqu3ExYltmw88WJce9ZR
	 drKd9EFeBwUYI90d6LY3ZNCe7t2e9hN8TIMoIDOekx6NBwmBuK28soIdCj7yjrFfnG
	 sSfjpycIayicI+S89BGnycL/m+9Fe93O2ASGaITdQBnmbt6ldOxu+HHaCjMl6wRXrM
	 AxfeOLBRYX2XuCdSYSI4kuNTsBK0mpSxXAGhXV8oQwJnoKXGR3N2G4Oa7UKtadh8lf
	 T/GoWeaLgUKnA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Make install target copy bpftool
Date: Mon, 29 Jan 2024 08:09:16 +0100
Message-Id: <20240129070916.1639008-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129070916.1639008-1-bjorn@kernel.org>
References: <20240129070916.1639008-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

bpftool is required for some test_progs tests. Make sure it is
installed as part of the install target.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c3c5b85f7dae..ebbb40ef5702 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -749,8 +749,9 @@ override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
 	@for DIR in $(TEST_INST_SUBDIRS); do						\
 		mkdir -p $(INSTALL_PATH)/$$DIR;						\
-		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;			\
 		rsync -a --copy-unsafe-links						\
+			$(OUTPUT)/$$DIR/*.bpf.o						\
+			$(OUTPUT)/$$DIR/bpftool						\
 			$$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FILES_GLOB)")	\
 			$(INSTALL_PATH)/$$DIR;						\
 	done
-- 
2.40.1


