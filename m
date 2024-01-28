Return-Path: <linux-kselftest+bounces-3670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8383F53A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B63282581
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C931DFF0;
	Sun, 28 Jan 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deyGJfrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A81F94C;
	Sun, 28 Jan 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706442291; cv=none; b=ke8PlE+Gky+VL7mcVRQ9xVpiPQcbMjUdAMBQv/OdnAsOgCiE/DFRGEjG14yNVDNFbmDVqicJI2JnUSNez/XBXHYTgQNVC2sfZV/rf+jOEe+Ad2vZsjUa0gJFRncpciJlQplgV4DxGc0nUldFIirOqTezKx3MzHwbtXoOmPik3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706442291; c=relaxed/simple;
	bh=u8Aj3gtAQLtB9BxxUH3S3N3EO2rh3wpV5SKl06IufwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WlvsqBb6L28ODi/dnDd91Aywvkt2uQsU5Pf2oC21rUFEBRmifl+x1CIKp0L2ghlcICTIUlBaU+Ma1wLhhuHXGiJdie7o63xrG+J0SjhjuTTBg+siY4fhd9Y2oZJlj/bRBBQ5IaNWQFI8LAtrD1B6OC4Tv3aFNjnJYRQEQQM4qNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deyGJfrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370F0C433C7;
	Sun, 28 Jan 2024 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706442291;
	bh=u8Aj3gtAQLtB9BxxUH3S3N3EO2rh3wpV5SKl06IufwM=;
	h=From:To:Cc:Subject:Date:From;
	b=deyGJfrhiMt8SfdNtnZ1GnsfqGKX+H7v6WeM1BmNHD8O+tLakr6aFFO3pjj464nvu
	 dqjjTpRnZ+S2sR5x1mW8uORWM7B5e1R3wvIMhGYEx573WtP36jKmghrM6Sg423MH63
	 dE+EAuirXsV03oKPdItEcHCjV/8/BsyabO5bPcf7RDt5iD0cXMs/xX/ZKsy/CQ9IPc
	 6b5zIzNj/7AQIdrJEGE1rPmOcMTM/Nd7N7/lp36XEEWQuwY+Eve3OO7Obq3iCC1QEV
	 Kyq/4wsVJEnIboJ5DA/AGiruDEdX8rN4jXi/HetKsfVp8t/iZ+Kpe37yN/StEmsjjX
	 6hqTo2U+vatvw==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v2] selftests/bpf: Drop return in bpf_testmod_exit
Date: Sun, 28 Jan 2024 19:43:57 +0800
Message-Id: <5765b287ea088f0c820f2a834faf9b20fb2f8215.1706442113.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_testmod_exit() should not have a return value, so this patch drops this
useless 'return' in it.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - rebase on top of latest bpf-next/master.
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8befaf17d454..6f163a0f1c94 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -619,7 +619,7 @@ static void bpf_testmod_exit(void)
 	while (refcount_read(&prog_test_struct.cnt) > 1)
 		msleep(20);
 
-	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
+	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
 module_init(bpf_testmod_init);
-- 
2.40.1


