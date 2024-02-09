Return-Path: <linux-kselftest+bounces-4414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DD84F5CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41B41F23143
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B73C46B;
	Fri,  9 Feb 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIc98VEK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6B3C466;
	Fri,  9 Feb 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485224; cv=none; b=dFZAuGQ449zAK26t+w+S5R4sBojYGDZ2kmJFiQpXKctswFnQMyMfbqNFeCP8CgCqa35w+4o06Dt69GoLjdXvHD6gAimKdp6+ehpVF//XKMyGM/6gUCbbdsrmSrmqV1t1zDqOGTjnGklURcx32wcy23fo8r12seMnJ5AZuUPuYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485224; c=relaxed/simple;
	bh=aggtpyZ7nek3MZgtSL3z0MIgLr9QD1bEIGZyyyntbxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7crNCm3HAZJzjQ7gYOYralr7DEpM7ibbnxSNZlZOR4b6P7Jq4q3Pto9jazS42oxII9nMNDtU8DY040QkdBRO5x00AEB791412ybiasWEAeVaPVK0zR8UPNVl40czNRJILukkyV3DPuTxEAHjT6yFWBDuV8RE4i3gVVJVyf6yls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIc98VEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DD4C43394;
	Fri,  9 Feb 2024 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485223;
	bh=aggtpyZ7nek3MZgtSL3z0MIgLr9QD1bEIGZyyyntbxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MIc98VEKq8ZDUCNTdyy2g1SBEH8q7/pxZ1YshsTUTa3jDv1BQrGHl62pEAlh88wXz
	 mnkNnYwJzASe3uwcrZDHhpqAXN8iCpqLYbV3S9+/tWcq1hOrau7T2BbwruJNsQf3l5
	 iKd1F8EnF3GptJoBToHzDbSd0WuUC5I61Q40PQac3lRSN09wrlQ+tKOTuqOQqsyDEw
	 7FCbg/ardaf3hNjJMree2VC8+FOhxVopxXiajn1oQKlqLyEz2UXLKLxXyFsxkyyNkL
	 JaVYUaaGtsUyaTHNat+bRnPSDj9S+aWH3D73wmoY1+ULUBZmP/HBOYdFeWGxANIABt
	 kWTZnXe6XsMAQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 09 Feb 2024 14:26:37 +0100
Subject: [PATCH RFC bpf-next 1/9] bpf: allow more maps in sleepable bpf
 programs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-hid-bpf-sleepable-v1-1-4cc895b5adbd@kernel.org>
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
In-Reply-To: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=1146;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=aggtpyZ7nek3MZgtSL3z0MIgLr9QD1bEIGZyyyntbxw=;
 b=d+t4wgMQWZy/S6Wfo//ND8tfS7Mtbe7J5QL0nBRV4rQPp3M8dQfY4Y56bXuggZdkfNZlUY8QU
 XMzXtFxJO5lAZmEF6x+JBhOoxriCFeU9J/Kw4yOAW3GEBE+W/oJW+Wt
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

These 3 maps types are required for HID-BPF when a user wants to do
IO with a device from a sleepable tracing point.

HID-BPF relies on `bpf_tail_call()` to selectively call the BPF programs
attached to a device, thus we need BPF_MAP_TYPE_PROG_ARRAY access.

Allowing BPF_MAP_TYPE_QUEUE (and therefore BPF_MAP_TYPE_STACK) allows
for a BPF program to prepare from an IRQ the list of HID commands to send
back to the device and then these commands can be retrieved from the
sleepable trace point.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..3cc880ecd3e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18028,6 +18028,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
 		case BPF_MAP_TYPE_CGRP_STORAGE:
+		case BPF_MAP_TYPE_PROG_ARRAY:
+		case BPF_MAP_TYPE_QUEUE:
+		case BPF_MAP_TYPE_STACK:
 			break;
 		default:
 			verbose(env,

-- 
2.43.0


