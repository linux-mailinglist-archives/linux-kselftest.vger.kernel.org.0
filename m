Return-Path: <linux-kselftest+bounces-5184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9ED85E305
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110941F2597A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B15823D9;
	Wed, 21 Feb 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYcRtqq0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F181731;
	Wed, 21 Feb 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532729; cv=none; b=kXNjRZV9UnFldf5vEVqUg5mxZHww7si2xBv0qub3WW2W37TzCpxZA4M5aZCYsUJ7Ic9LPEjk0chheEm0i+GJ0N0iraPiVpIS//Gch55iZeK7kHTjWYqp2Lm+WAg/9MJ7HIQX+TREbU4Kd6tcS7pMSB4iSb64yLzsQIzn+ehLyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532729; c=relaxed/simple;
	bh=R3G29V1nYqPfReSpGBjXHcB6eUKOdQPJgoZsK67W94g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMG3r/gfXoh1Wb/j555WRckKzEguhTU4NpKkhdIO3JVDIAciF586RYDbZKrUn9CxqvRCREr7l+MKFiOmpQ9nEWUhF7mUO94E6Jb/UzgZBy3KUvu6sQxyCCyZCcK35ZIxQfexT6tmcFe0rsVVe3P4sg8LpaK0gP6haQk8Ie41AiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYcRtqq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7080CC433B2;
	Wed, 21 Feb 2024 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532728;
	bh=R3G29V1nYqPfReSpGBjXHcB6eUKOdQPJgoZsK67W94g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nYcRtqq0BYleLMWVme4nWxcvJm//247pjMWOUnYH8ciU/DCq/xWp9PU1gmDacqs6N
	 vg6+GFYqpPyR3fKPLyU5KzPuzlB6gMrkfvmyZS7fswB52lucDTMBh8dGt1ZwniUtbl
	 RriSFP9Ru2NKl4gSiMPQSRSixwhXs6y+HxX5ZuueaLlj3EXO6i++mFHkjF0xB3BWZI
	 IvK5GkwjKWms4gdC3nz5uKoM1wBmNz8ngPdxQrQqTilwOnmLO6tpZreVlUmv1Ppeik
	 qzI23UglSDKXsXIyHCcL5F6hXHfVoYy+OTT42qX/Y/avQD/uNCW/ILNUiHG0b42RZC
	 1gwrofyKYw0fA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:17 +0100
Subject: [PATCH RFC bpf-next v3 01/16] bpf/verifier: allow more maps in
 sleepable bpf programs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-1-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=1061;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=R3G29V1nYqPfReSpGBjXHcB6eUKOdQPJgoZsK67W94g=;
 b=Sj7ipK1o5q96wXkl7PmldN0CmFbJdrMyNtyHoJiZuX1EPDYejRzCG4iBxZ+OSDYpD5UptXfDe
 Y71xE1UhYqMC9qmgMnDcBIxYAtpJT7wWm68sYByi26265cLilYCfRIg
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

These 2 maps types are required for HID-BPF when a user wants to do
IO with a device from a sleepable tracing point.

Allowing BPF_MAP_TYPE_QUEUE (and therefore BPF_MAP_TYPE_STACK) allows
for a BPF program to prepare from an IRQ the list of HID commands to send
back to the device and then these commands can be retrieved from the
sleepable trace point.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

changes in v2:
- dropped BPF_MAP_TYPE_PROG_ARRAY from the list
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1dc53..88e9d2e4c29f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18022,6 +18022,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
 		case BPF_MAP_TYPE_CGRP_STORAGE:
+		case BPF_MAP_TYPE_QUEUE:
+		case BPF_MAP_TYPE_STACK:
 			break;
 		default:
 			verbose(env,

-- 
2.43.0


