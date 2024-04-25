Return-Path: <linux-kselftest+bounces-8859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C378B2358
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C7428AB75
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D214A60F;
	Thu, 25 Apr 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpIzGoKf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1B14A604;
	Thu, 25 Apr 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053574; cv=none; b=SAn26BdrTDPIj0tDPBDNouKmRdwVkTE97HsGVWBFr5iEogoh7J144MTHen0uArwOrB4NnWSPTuhCNMEo2xU+r2pI1EwcvqAXunoPRfle9oQUWTfRNt4XC9gBb96yEU7m/04kBvOt/2VmJVq+KLvdyN3aUi9vf4t1Y/IVvo2vz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053574; c=relaxed/simple;
	bh=mvQkfgZuYmY613uCDbNKQpDIm4TePVAqpmobfYU+0So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZ2Kv9yvgenoeDm3U9Rx27q7ypn6AHuCx3Jo0Nv7QuzwfOCJKWK3Hp4vNeYvcXjq9gM04U8Qpo7MJ945GrHU9GBSLDtCA2fc4NSMVhdb2QmQzwaTG2aoTgbqAjgWgabxexdfGBVmVpR7fgiIm06OXEkyyFMYOBUVdOgGGEmqPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpIzGoKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6714AC2BD10;
	Thu, 25 Apr 2024 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053573;
	bh=mvQkfgZuYmY613uCDbNKQpDIm4TePVAqpmobfYU+0So=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RpIzGoKfMwG9Sy2keGCgECx5MrqT4aUQq3SLROhwFRMMU1zg9No7S3PBUQvGHdQRA
	 IxMWAJ5nq16lXH9J5gcTDpu694NH+a5fblNnshkkiFxGjge+FDwdvPpZIewvYfmSJD
	 gPVBpxNIraFliMqaqtEO/TPma90jQsFmdHw6Z2xwfeffTFW6FFpGlrMMOtdkZYfFZZ
	 9a+B6VuSA2DRpg/KyacJF0BHBm0bWhsTi+E5T1gTTauBlqAoh+gwwc33Nb6x9lsrfR
	 QdF2P2ajcsrJZEEw+8mCJY4yRu/uXGdrSCWwHW/CSK84lrPkYwWtyADXPuhvtjq4Jk
	 3REvTRA8PSAgw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 25 Apr 2024 15:59:14 +0200
Subject: [PATCH 3/3] selftests/bpf: drop an unused local variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-bpf-next-v1-3-1d8330e6c643@kernel.org>
References: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org>
In-Reply-To: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714053558; l=693;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mvQkfgZuYmY613uCDbNKQpDIm4TePVAqpmobfYU+0So=;
 b=ANTc6jeClzDBFOPpM80AN3a7UfMY3nh1T6nvJC96+/nDJNEFJLTR8q8OMZORC7QiGHNIOe/jA
 EvcXmz5JKKqCyA6GVB45OLYFlnnZ5pO8cgPAoDysHyH10c1lsM8O5kC
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Some copy/paste leftover, this is never used

Fixes: e3d9eac99afd ("selftests/bpf: wq: add bpf_wq_init() checks")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index c4bacd3160e1..99e438fe12ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -36,7 +36,5 @@ void serial_test_wq(void)
 
 void serial_test_failures_wq(void)
 {
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
 	RUN_TESTS(wq_failures);
 }

-- 
2.44.0


