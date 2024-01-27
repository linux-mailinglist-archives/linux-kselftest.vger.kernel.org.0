Return-Path: <linux-kselftest+bounces-3658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435583EC91
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B880E1F23584
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C63E1DFD6;
	Sat, 27 Jan 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En8x5KzE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45187F;
	Sat, 27 Jan 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349809; cv=none; b=bMdg1QL7yVFO2Y6fYv0vPPbbwhTNOzpk6G91CCUzT2SxZ/jS0whiNm03HAPqAst2Cpmkayb02e0vE6EgHjUhWOC2kCPqz9ZgkzFH2Ej3tE5c1H/xBIoUCrFwTDV3IdPFLOK6QoYmK+Ro5JeNVXe3os/ApXu6/6XKkWtH+eryKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349809; c=relaxed/simple;
	bh=JD/FK08isb12TQ57IyIfcPGvJ0V0uXlxGNjHA8K6p3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrbVqiW8PcEzu6+i6reLlyv9pIqwpJj+QaiDjr8w/ZnVXlVGH9ndQwqyfiFe/QysqIzRRXtlijNWAEgtyyG6rlbpMuLJkyBNrQl/dkS7Jss7DfCzXSaYOvOPlg2kMdtAPbgG0EDKrzEAjOP+WzVf0QJKaEaG/N18U6lnMprRado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En8x5KzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282BBC433F1;
	Sat, 27 Jan 2024 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706349809;
	bh=JD/FK08isb12TQ57IyIfcPGvJ0V0uXlxGNjHA8K6p3A=;
	h=From:To:Cc:Subject:Date:From;
	b=En8x5KzE9PKN0LD3yevfu7DY7FvyRRDW+WGc43qoxUDL2/vWxn3uTNH4qkTj8EltY
	 sTk2UNFIZcNuRQuL4l7I26wYvK2E1XOpwI1M8JtDxXqkzWh7RggAYDUIZT5RW0h0Yk
	 Cy0s6RF1DkWoPbSPByFETy3tcK8xPFM2bdVH1D0MOMsogVWEqnHL6qckjE+7H07tYJ
	 6ZU8BUmRh+BmbF/DvEYw7xPLt4LplmpPdM8f2c5HwzdkF0WCO/sI1GrXRWyC0Y4FUj
	 q6SBDqpD7JTZFYmpoKAZoZOIjbtkrtzy6KAf76VmmxefJctD2gwU4ChORmYY1LHQYd
	 BP4KeGk1U31cA==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [bpf-next] selftests/bpf: Drop return in bpf_testmod_exit
Date: Sat, 27 Jan 2024 18:02:29 +0800
Message-Id: <fb088aab7eee941cc6018249a47f60b0871141ea.1706349508.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..e75e651f1337 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -544,7 +544,7 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
-	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
+	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
 module_init(bpf_testmod_init);
-- 
2.40.1


