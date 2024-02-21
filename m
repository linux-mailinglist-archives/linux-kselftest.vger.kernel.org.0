Return-Path: <linux-kselftest+bounces-5197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A4685E351
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D831F237EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925585C44;
	Wed, 21 Feb 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRuFjLOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975782D6B;
	Wed, 21 Feb 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532787; cv=none; b=lp6r3Mla9YeMsxmbE3As/eSfO9S9tF25oE0ScHlBQcYqiygio/DwXMTrA0cC+VZLu/ywGRX+bHmQMhnp0Cft5n5ZiD+Wa8z7lk/d45S8NTDGTMbQN9Ee/51hutCtki/XXcVfCdRxILFgOLiwUTHgzDc0Vvyfw35S2lkRBWsufCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532787; c=relaxed/simple;
	bh=aOeYWbBo6BBRgng3mWTrVA3C2orudmt4XB516sHxv3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WtqziC5hk67sj954vTOTgIxR1U9j6g2EaN7OPhIE5pyNCK+A5IxGvp5mB+Fzfwcr9hw+rpnUQV2cS3FZsAxjjCFMBaMpqV+vGb8np5gGz/lnIJ1iWZSv3+8rt2DBWdQBj/Z0abbgEcLaccQCtK6dwJeNhG4NH4KwVB2VZqr6kFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRuFjLOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DEEC43609;
	Wed, 21 Feb 2024 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532786;
	bh=aOeYWbBo6BBRgng3mWTrVA3C2orudmt4XB516sHxv3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CRuFjLOz/oP9LGG+DScB65m5dNy1A6QCZ1/OvkXlvdRUIXEZV6/gwerU/2EOSHT4l
	 p0q77VyVFVPTMftWeWMr/mW0huGodOw35WDnRdeLbfS69eL8ke1nfNk23OvUJmPZFz
	 LZdECWQBTZedf8QDjGziZQz2Wnp5D6G7N7/R0Gipm7WvKYSxfnW4RmVn6QzF7FRJPm
	 YLc/C2cR21IaHUjGiYpGVvRIOI5eYxfGu6+hl35cutkdk8E0eGhTsuhpNQ99NO9F2z
	 vKI1odmAjBN56jZ6z+vpV2xp21JGNW2hYxltVoTWgDmH3wng3VUJO98k0sFfs86ymb
	 A3vX4C/JmUJXw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:30 +0100
Subject: [PATCH RFC bpf-next v3 14/16] HID: bpf: allow to use
 bpf_timer_set_sleepable_cb() in tracing callbacks.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-14-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=2207;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=aOeYWbBo6BBRgng3mWTrVA3C2orudmt4XB516sHxv3U=;
 b=5c6iFAL0ghfRa0CQ+I5WiS8W3VZHjDLOLVCvDikeugMAA26k2NejVsty4Ye8iMtnIQGyGpWAe
 kxEB5meSPzqCYxWaCyomP6nK9/TqKeiFZNYnSvFjr5lFPycq+ARmIK5
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Export the sleepable kfuncs we have on HID-BPF in tracing bpf programs,
but with the condition of being used in a sleepable context.
This allows to use the bpf_timer when used in a sleepable context
through bpf_timer_set_sleepable_cb() and initiate work from a device event.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

new in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index e1a650f4a626..275f2057c48d 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -544,6 +544,11 @@ __bpf_kfunc_end_defs();
  */
 BTF_KFUNCS_START(hid_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
+BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
 BTF_KFUNCS_END(hid_bpf_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
@@ -566,11 +571,11 @@ static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
 /* for syscall HID-BPF */
 BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_attach_prog)
-BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
-BTF_ID_FLAGS(func, hid_bpf_hw_request)
-BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
-BTF_ID_FLAGS(func, hid_bpf_input_report)
+BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
 BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {

-- 
2.43.0


