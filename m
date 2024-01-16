Return-Path: <linux-kselftest+bounces-3118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2582FA0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6523C1F26687
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312131752;
	Tue, 16 Jan 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaAd6KMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8F3174D;
	Tue, 16 Jan 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435122; cv=none; b=eFXIuTZMSdTbOH3johANei/yYa5lO9UTEuvVNGr+hhdJF7sMcFiUeZabbaaL+/duhFYXx7oMyriI36xL/7O5Lh6Q5M87lCYTt+sRDRb4bSn+WAexgQYGpfR5O8uGqH/FDrMR3/HZatOBJAMCCEdbL9P6woUBI3R50MbaeIoAcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435122; c=relaxed/simple;
	bh=f5II6spMHmfw04hjm9vJeC30SJ4ImhQNddFiKqENsMU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=OHUw4Jatmm4k1rV7/bQDfm2vJC5hX8wxcvIdMCdeRyvUeAQcIfSdYYueftdR+duL4ba18jNFnR2e6m5CDhC7nOzAa4c7BlaBkJK4Qb/jwfZJ75UWxXNLRPIDjGjCGzKo94mSgURpM1kaeSiEu55QeX+QXZioNMgdV+wffcf4QtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaAd6KMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F29C43394;
	Tue, 16 Jan 2024 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435121;
	bh=f5II6spMHmfw04hjm9vJeC30SJ4ImhQNddFiKqENsMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaAd6KMtbe7b/fN05a3/mFnOGrvy3n9sNOPkTlhBaclGWA7qCX1T6CV/IG7xASGEN
	 1r39VkpQnLrOKjWNA2M/4D4vhlyLabb7QTOIEQQRVXHasgmnFdvbD3d7q6i1yRYCQ+
	 eWXQvK4/UdYvGv9zlc/7ReHAjOZYfSaQFxdS8VbYKU1IjXOpmmi1+eOCOCLYW7KMRD
	 bae5CIfB7Qo/Fl2cGsbVGYcuEl9yFbmwjIrFn9ElaNHfH0LH4Q8lS+OAm74lGZ6mQh
	 j8qcPrCKtajcv3S10a9ti/xga7fMXix8BIlElI5V7sajnRFUvPhWNZMpRR03KGJPp/
	 IeiKDrCigqYfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	alan.maguire@oracle.com,
	iii@linux.ibm.com,
	lorenz.bauer@isovalent.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/47] selftests/bpf: satisfy compiler by having explicit return in btf test
Date: Tue, 16 Jan 2024 14:57:05 -0500
Message-ID: <20240116195834.257313-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit f4c7e887324f5776eef6e6e47a90e0ac8058a7a8 ]

Some compilers complain about get_pprint_mapv_size() not returning value
in some code paths. Fix with explicit return.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231102033759.2541186-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 2a04dbec510d..92080f64b5cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4766,6 +4766,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
-- 
2.43.0


