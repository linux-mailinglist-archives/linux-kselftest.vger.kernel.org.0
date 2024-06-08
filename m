Return-Path: <linux-kselftest+bounces-11484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AFE9010EA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B173B22CF8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9917D369;
	Sat,  8 Jun 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmGw4jqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13F17D353;
	Sat,  8 Jun 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837314; cv=none; b=Jo2DGSNi1cxdmM7+IRLtSrFzG9hocHX8orIV2DyEyGzO4UYJSFPUgluHO5LV7FQH1OyuLl+Q1PKAAp14vuI5JBltQvzX5Zf2I8KpzFJ2XkNoXfRQKdvfE47Ism1xeJ4IC8miGqCXg7qkhY4lpHjp1G3EyQwjX9a890bh434OFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837314; c=relaxed/simple;
	bh=764BpJJ+0RLPa1xYfm3CFomwnOdKd7B+O2p4oCLJSr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNjrK7rPlL+LXSj35k3496AdKgKvw0xXm1oHalgeGScGL13EkphGFXFX9DfdPvNrCuwQM7PttkhMIooSUq+d8LdX+G5Xaq/paUGfjlY4GPsbq4nqQn5H5IPvzZqN9rRbj2UQwitJXR1Yw1ECKiSWKrsjhzqtd5M+kVzmT49ONvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmGw4jqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A2C2BD11;
	Sat,  8 Jun 2024 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837314;
	bh=764BpJJ+0RLPa1xYfm3CFomwnOdKd7B+O2p4oCLJSr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hmGw4jqyeZX9gecOAZcpA9hmMobqBFmqa8gADRChp1F6lyxiomcPQgildieiDIeHi
	 79C4RbLHmTT6Jt2pfFwn2lo4hi8tzqYrnTswAd2sdpksuEurkiwRMev9axRvgUf9+W
	 Q+uxgTSag9NQP1LmwMCnwhkOtdGY24J0xRu4Lou5OiwwfDmHML2lVRskAGYNNbeQ70
	 AmgjKvebEiwn89xyCAwF8Sp425/z0u4dNo1I/N07aOnhbpLpmiQlJtvTEk7VpOwN5G
	 5F7XXT+fUNsa/GuEveL0L6axBaDojTBhQImTCeZTczCtGNfneYLzMWc4SBG10PPo+j
	 AWlJSoElkXMSA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:26 +0200
Subject: [PATCH HID v3 14/16] bpf: allow bpf helpers to be used into
 HID-BPF struct_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-14-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=865;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=764BpJJ+0RLPa1xYfm3CFomwnOdKd7B+O2p4oCLJSr4=;
 b=V0vyUFFgCONMp6lGmOJ7JyItCEU/faMXE1HkrIoGTlhdEetexQxlAgu8tl/Kg7y59HfFCltvk
 uvu3DakWhr+B6kteKAMVA0Q2w3qVEKoQ22jQJhXz/gsdmyhGPlybtYH
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Without this helpers like bpf_printk() or bpf_map_update() are not
available, making anything but change of bytes impossible to do.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

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


