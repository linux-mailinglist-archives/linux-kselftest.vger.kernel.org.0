Return-Path: <linux-kselftest+bounces-4661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B46F854FD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D9628DEF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8E85271;
	Wed, 14 Feb 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSMJnCBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B085268;
	Wed, 14 Feb 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931153; cv=none; b=Ce5JUzlmeQU+vgRiAJ83fLpL8rhA3A1/7LMd6TPwGDEILyKG5QtnLNeJRrDDdsvbk4DnIl189wwQ8/VT0nu7Pgt6+OB1MT8tSYiFyXLEl5kdheGSsZZL3ptci9sS5JjqL0HgRUHG2IQVJ/ZFAyZCSdJWItBP27+PYwwXeUC31WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931153; c=relaxed/simple;
	bh=4OdGUm9HFmtkn3vsq7JGFZKzQ/ITmuIGwj3G26a/QyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXKlWwhG5pILVnym8bJIdZ+rYP6s1mVMaOeTLAlOVGqPeyt00l4v9lmKKaY1ofoEbFuuNiTSA8PcaXNwOwvtnM1/LUxmF7B+Qf+HQrpqKZqXDKfWOCgf3fuww5ziisoqlT8JCeBzKHujnc7OLSPWsvMuhjHs3MMHkSZtAb8YkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSMJnCBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D826C43609;
	Wed, 14 Feb 2024 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931153;
	bh=4OdGUm9HFmtkn3vsq7JGFZKzQ/ITmuIGwj3G26a/QyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gSMJnCBho8MLq6HzBArgTrzpXHh3JvSoM1We081wZJHl7DcWe/piB3tfHYotLdPrL
	 Lc1Tr/q0BQMqwX44lHF27ViFqWkv3bEeJV9em6Sy4MF2w0m29s1XPPeroi6rmJ+/BW
	 kEimX8BLv/6EAgVcn74JbpLEvlcPipp+OR5BiBL95d2Z9FSnn1FM++LpGHi3//Txw8
	 dVbzOCnJe1JCbYHIVJsFKn1Xj6WMmqj/18Pnh7YxK8ncjkkHW9fuU6kSDuF7weCxZa
	 v5w7OAcbxXR9PYiz+W4nJIx0aeiZu8+XE+5FtJWFud+Ln5QFvTS1JRE498kew1isXw
	 0VVNHr5xM0aug==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 14 Feb 2024 18:18:32 +0100
Subject: [PATCH RFC bpf-next v2 03/10] bpf/verifier: allow more maps in
 sleepable bpf programs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hid-bpf-sleepable-v2-3-5756b054724d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=1041;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=4OdGUm9HFmtkn3vsq7JGFZKzQ/ITmuIGwj3G26a/QyQ=;
 b=dqAI9nNqZJJSqL1WxlTEU41LIngJOXojPXunu816A7LhAL2wmgZqVLf71TIxKkD5v/TcP71l1
 hyjLr7LL//CCJVyUI9mpcxpa840MSYCFWcS5Hpa7K/HzuzIprCpUJ0u
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

changes in v2:
- dropped BPF_MAP_TYPE_PROG_ARRAY from the list
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67da3f7bddb5..cb1266566b69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18094,6 +18094,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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


