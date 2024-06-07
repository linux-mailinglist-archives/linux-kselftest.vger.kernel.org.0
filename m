Return-Path: <linux-kselftest+bounces-11406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE690091D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBA21F23084
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189A19EEDF;
	Fri,  7 Jun 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZMKOQKW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAB19EEDA;
	Fri,  7 Jun 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774145; cv=none; b=dCK/25Cf9JWqEo5wVVhwqyqVpyKDtlMEPZXugMOcn90UStRmKq1iqCM7Z1CC+oDFIx2Powrm+fYS+TUvvVEVI52pNCZFJMqCj7vW8HKEfkVRLq55RCcCtldm/NDedGLzAZN+jP0uMfOBucDYA4b3n0uvzLgaX8x7xOMvmc499iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774145; c=relaxed/simple;
	bh=V9BpG0glzaU293GPkowV2J/PIKCZJtxwMnj04QbVtz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVTlnYIXVJY6FSbI4maB0SPZbH3IFMSvPSwiH/sPN6JhaytLfIMkimQOlloRAmMptC1cA8uG83LF6QjvO3r/B4Qop2m5xdEEmpPiUnIdLNKr8MWhxuyOtLDRArcyyGDFUI17bSwFUvSf7ukPID3F8LXemhYjmFULajUHOJhxH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZMKOQKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68993C4AF0C;
	Fri,  7 Jun 2024 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774145;
	bh=V9BpG0glzaU293GPkowV2J/PIKCZJtxwMnj04QbVtz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pZMKOQKW5L2/3m0LPCihpfvMlsLIvEFolqJY5whVQllAdkpptHTCaaI8a391WPXrI
	 ZIebgpXdPWlxb4mCJfxZeBOTGRLJr0lTRm912l6EzCjIK0PM8Vct6BzWidg3lqLiyA
	 Rmi0CpjgJCYjEpxAp6PDn/6HNA9wetWhJX5lfSSd8Dp3VnJJlC2gzdR9lVME6LwT01
	 ASgUe7lBlx1Tuo4tpORxrugtve8w/S82TsdQ52ZlBSIu73JgNOX5AbGixSndhPPcwG
	 JUKyhGCv63TEGLT5Qi+HzgQyTJGTu7g5rbOFVvTvGmuU5Fmn7QF8OlslFMqYejVkFB
	 3ZQdh/VnTRrAA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:34 +0200
Subject: [PATCH HID v2 14/16] bpf: allow bpf helpers to be used into
 HID-BPF struct_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-14-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=845;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=V9BpG0glzaU293GPkowV2J/PIKCZJtxwMnj04QbVtz4=;
 b=SUaxVZou+t3AUr6wxjcOx6XBdpkcx3mPr1lWPTdxDJniGoU03Vx24FCwLvjM3CzHj8uUETN8X
 5BUAEJgedJpDQ10K2E5b8DAzCrbvG+ONOMWZKH45xKDFJMpHsVRD4eh
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Without this helpers like bpf_printk() or bpf_map_update() are not
available, making anything but change of bytes impossible to do.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 9192c66cde20..056d05d96962 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -89,6 +89,7 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 }
 
 static const struct bpf_verifier_ops hid_bpf_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
 	.is_valid_access = hid_bpf_ops_is_valid_access,
 	.btf_struct_access = hid_bpf_ops_btf_struct_access,
 };

-- 
2.44.0


