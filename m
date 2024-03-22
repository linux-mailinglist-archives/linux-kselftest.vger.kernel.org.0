Return-Path: <linux-kselftest+bounces-6498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF966886F35
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E30EB225F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998251C4F;
	Fri, 22 Mar 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8mpk85h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7956B7B;
	Fri, 22 Mar 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119416; cv=none; b=Kv1V9KsCM1KH652oGag19KhIPMr5v3GahUgqgDupW3moaOXcH1g32wZ/RQMduSK/drZd4IKw/2gYOJh9BRWtWngkdfc20zPiFrfs1hnBubJ5jw4fJ0ULVEOd8Mrw/FJH/oZdtCXNh0MAJetsMWn5d2hn/zdgiJjXOCP0ps6Z4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119416; c=relaxed/simple;
	bh=vvcMMFjG5GlCThTfv7SXso8l5e+ux65ma8ApUCkSOHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKmPVL0LC1k2nVOjDANgBbksIhwUO/viJpobClvJCUoLTyvfD3IuVg/8IugOqjDDpYMrekZWlTA1SDsH4pxo9Pbr/F48llpa7w/r/4I6+j0Fg3ZTu0+jrJHHRL9w5LgWfkwSsyNuAvNjYrlMrdpXlyZO2f9ylC7fnZxIhVH+vKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8mpk85h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665E0C433F1;
	Fri, 22 Mar 2024 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119415;
	bh=vvcMMFjG5GlCThTfv7SXso8l5e+ux65ma8ApUCkSOHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I8mpk85hXRss+R8i2gXxxFOsDqOYG0mtd2p5p4SB84xPbA6l4hUDQ27oH6IZMeBdy
	 mZ/+kGgZqFKTNzDpRszecA2zoxyMp9JRdjcFGbuYKS9aqDr5ed2jKrfiqdy8Cpx/ua
	 QkBWBZi0E1AdjKPQxKsplDY6HmLeONLuPtG/7fCQU6smr/xyy4A2/EwwfTViguTTJe
	 RRj8UXFqn7KbxQpht38UadZ0o+mxLsFUc5kDICTh+youh+PyFv/lYdnM3Qr2beVpTX
	 lrfXRoWJgu2E6G0hKaILKeXindO8nBX+8UJKUidCqqnSw/3DWZcMtKe+YlzRPIgh8M
	 i5JYzZAfZCBmw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 22 Mar 2024 15:56:25 +0100
Subject: [PATCH bpf-next v5 5/6] tools: sync include/uapi/linux/bpf.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hid-bpf-sleepable-v5-5-179c7b59eaaa@kernel.org>
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
In-Reply-To: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711119393; l=1053;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=vvcMMFjG5GlCThTfv7SXso8l5e+ux65ma8ApUCkSOHw=;
 b=HFZ4puNseC91PGSVc8hE260eA1bEkVF+e0PLZJNk8u/6iEQBcX42+fDat+TkXCBdu4nnWCMID
 pugXjS1OCnYAXELD4L/VDbhDH5cNUn2eZkbkIqeQLco5nJO7olTjeJn
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v5

new in v4
---
 tools/include/uapi/linux/bpf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c42b9f1bada..b90def29d796 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7461,10 +7461,14 @@ struct bpf_core_relo {
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
  *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
+ *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a sleepable context, with
+ *       no guarantees of ordering nor timing (consider this as being just
+ *       offloaded immediately).
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
 	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
+	BPF_F_TIMER_SLEEPABLE = (1ULL << 2),
 };
 
 /* BPF numbers iterator state */

-- 
2.44.0


