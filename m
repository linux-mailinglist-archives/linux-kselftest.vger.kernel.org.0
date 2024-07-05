Return-Path: <linux-kselftest+bounces-13243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AF928ADE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 16:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599EDB23FEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E82154C12;
	Fri,  5 Jul 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5lor6aD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF41BC43;
	Fri,  5 Jul 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191024; cv=none; b=ifXV7xT6AxImerSZbLcdujgatuWDVikKrLGzaEvBPCCpkC0+jN3V2G3cpbrgZe/cTeWfXBXRadbEUR12vH1edDvuzmNEF95ehw3x0766V/VL+Ms5Rfhl26d4Ba5T4vVzMV1V+3H/ze+9f4YIi9hbgPpqvqeP3HsSAPPW2OdnJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191024; c=relaxed/simple;
	bh=1sW3ARW4FehAFUh4r3PgasmMUHkKJr5S+XqwNiRcCVM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UGD+GJ9f+IUSp2hRiaUUsRssgoSNGXOH3qpk78W/UAGcWXRTDtCx+vZtrNBXg86Sd7TV2zLW4XGKXVT40HxlKYph57baYUnmUM6MphENGjvgICMvz05vKNerUQmWpVlnWo+AsBdy4OnvDCTNuo7n8Y50IY3qv1qagbFmlPBPrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5lor6aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1721BC116B1;
	Fri,  5 Jul 2024 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720191023;
	bh=1sW3ARW4FehAFUh4r3PgasmMUHkKJr5S+XqwNiRcCVM=;
	h=From:To:Subject:Date:From;
	b=J5lor6aDk1eKDktFyvnbwfi8eB1Xn15wUbnl9qq/uqWApgNrmUEV6xubp9FfoDfHq
	 2pdZ+Ym2WcFSPS5QXh4KLrYLWc3XokGZ6idIdPPJ+RdQZQVjEJ45wn8ah7hGufUWrl
	 Ni3juLIiX/ChVgcIBYM5UQggVCRiXBGNlia4ZvfqTnMzmu6CK6+XzgXwezrzEX7Gw9
	 LOtnH9mY9VDzZyzOaYe5z+0o8uG+/xabhS+IxAeEltwbF8TseG2b9Gmd0tooKRIODX
	 AdHe8m8egpsvyQA1QdidrS7wT7jF9yNFK0PtOHZ1Suww00Zk5ggetU8cQ+l8eMPqki
	 Wblb2F3+PY93w==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
Date: Fri,  5 Jul 2024 14:50:09 +0000
Message-Id: <20240705145009.32340-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fexit_sleep test runs successfully now on the CI so remove it from the
deny list.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index e865451e90d2..2bf981c80180 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,6 +1,5 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
-fexit_sleep                                      # The test never returns. The remaining tests cannot start.
 kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
 kprobe_multi_test                                # needs CONFIG_FPROBE
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
-- 
2.40.1


