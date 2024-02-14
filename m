Return-Path: <linux-kselftest+bounces-4668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A880854FF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38971F2B44F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D71272C1;
	Wed, 14 Feb 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwuavARF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035271272BC;
	Wed, 14 Feb 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931180; cv=none; b=qbsjaG8HbPpqGEqQpyPOg0f1/f0iF0FG5dou+g4mxPO4OovAl37Xl4zrfQKJ2M6WELZexCEYpOBV+qfmiHSFolJLkNx/MYBhGHaq+cPMoKnlzQlNaY4Djc2Op1zZ3upj1vnHrRAkiqrwPMTTOAXY+5ti/vUBvPxoU53jZU23i0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931180; c=relaxed/simple;
	bh=DWfwQbRXjVrD14SVINGcgMqWHxYUtxveD0dIZGefNe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQ/J66KsTazjDVy37hiloOGdOcW5hM2f2Iz1UYwQlqc685YSDsQ7HFVazlRC0tsq4I4QSsH1WJrFMtB+iz4QGsaIfTNXiOKZpfh8ID45gFdS29ts5ANazUzbyogBKbhdotdDpQHzBF1vC0fl7ZsSXm5BNFROfmGRoioTzq0cfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwuavARF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F5EC433C7;
	Wed, 14 Feb 2024 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931179;
	bh=DWfwQbRXjVrD14SVINGcgMqWHxYUtxveD0dIZGefNe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WwuavARF9I4Kdb+4gH2EMa1VpbiqZ7jEt5VqMfxhR415jxzUl69jx8RzI7Zj/sJpv
	 iVtRtXzlQjrLr8w4Cjp5DAdY+RrgW5xtBg4JfWrrkkddtTLvdQXm1uMeGHhNhxW6KR
	 FgN+LrCZjHJcm4P9CNrW2jnKK7b4yM8ijgGc+YM9OHhXPkqS54W/bL5gZ9G7g36dlS
	 P2rDXwWaNxF2pJ8TfaZ9Y+kQMJqm2WG0+fWzK9q5ZC9InbIZzTSYQI+hwIVo/0gOZd
	 qYRPDQwjyImkvN0l/dAvDa9EvIOi2VDYLHMabLLzLceoi/48pQIRnkb+SOdAPYUFBa
	 OrhogM1VX11CQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 14 Feb 2024 18:18:38 +0100
Subject: [PATCH RFC bpf-next v2 09/10] HID: bpf: allow to use
 bpf_timer_set_sleepable_cb() in tracing callbacks.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hid-bpf-sleepable-v2-9-5756b054724d@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=2187;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=DWfwQbRXjVrD14SVINGcgMqWHxYUtxveD0dIZGefNe4=;
 b=SWDa0TnPBLVOiw7xrbgzrI8gf6Q6gEt3YUt/IUl1nisfdqR0LGrlAAsx9WOkI9wfLB5WdB3Ei
 sUQwYt8/cYdC/He9YxXi7bmTJb/e+Yrfb3r3OEFYB1DjGlTehEb7Wk0
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Export the sleepable kfuncs we have on HID-BPF in tracing bpf programs,
but with the condition of being used in a sleepable context.
This allows to use the bpf_timer when used in a sleepable context
through bpf_timer_set_sleepable_cb() and initiate work from a device event.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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


