Return-Path: <linux-kselftest+bounces-9119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF5E8B6E8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC18DB22599
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FBA13BC3B;
	Tue, 30 Apr 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWdbJMSN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321001292CE;
	Tue, 30 Apr 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469782; cv=none; b=b3BjnmAZQ8CbJbPRadG9nsP3IphLTQEAbVL70RLCqYA4orbYgS3FeF7l3f0w4Z+oa9XThuDhSE+u7ABqF+YNsxj+gImQzUI3VTzA2ANQlQ4jUNXD7nR/4ZHTtfUAcmY3UgUcLasOK3hv0yf9VmLLHZW+kPcUAnr/Q61nD5/fw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469782; c=relaxed/simple;
	bh=isV08BGQVxr2m6vFfC6FVBJx7wJ01ixie6zpVJy6Nww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=exipB1+IaqPuMc3MQhJeQk1CEywxgcg+goiPJbPjhUMNBPclJNl3nlnGznqUF9Gr5orWII7lFO/hm7uD782LyveerxsjJldId5rP8o+ydxbVKRNWmDkN7xBb0iJI5ACMwB6o/D6r6Q829dN6e+peUxJnusrXsdkKMvNoSgONLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWdbJMSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57949C4AF14;
	Tue, 30 Apr 2024 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714469781;
	bh=isV08BGQVxr2m6vFfC6FVBJx7wJ01ixie6zpVJy6Nww=;
	h=From:Subject:Date:To:Cc:From;
	b=hWdbJMSNu/Jski0Z/rYuSDjGrusG+nFcwzTRw8LAr93g2NfuxPTq7m2j2iLlI0FrY
	 cN1un9FocW9SHa/fWYJwaadUnuTo795rn7AUh7jsSxrdjVIUHZLHAJGaHymHyYXAEU
	 U3SBVvqcpXTKm7IcER9DU3WU1sgVAKHuTbFzlW6qzmSnZVQDg9AQ/SaRze6d7sJvbi
	 H2u1U37P7snoBAH7TB5MJafNBvZTaiwYTrcp4+vLVBe12ZwAgsulj65lFQ3W7eKZq2
	 LPvFG+upTuFqv5Pj9ZMBbd2XDaoMKL9FRRnjlVsbH//DaDbuHjaCin9+xgef+xDGnq
	 zYAi9UEb0s5TQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 0/3] bpf_wq followup series
Date: Tue, 30 Apr 2024 11:36:09 +0200
Message-Id: <20240430-bpf-next-v2-0-140aa50f0f19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIm7MGYC/23Myw6CMBCF4Vchs3ZMr0hc+R6GhcIAE00hU9JgS
 N/dytrlf3Ly7RBJmCJcqx2EEkeeQwlzqqCbHmEk5L40GGWccsbjcxkw0Lai0dpZr3xzIQvlvgg
 NvB3UvS09cVxn+Rxy0r/1D5I0KtR9Y62iuqudvb1IAr3Ps4zQ5py/lUfDHqEAAAA=
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714469778; l=921;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=isV08BGQVxr2m6vFfC6FVBJx7wJ01ixie6zpVJy6Nww=;
 b=mmDCYkonQ+6v4TD35B1xiAiFVlmwP/3ZsFb7uVnF46y3C8omyoXJZ3rG+7NY66XbHrJ/hdCTv
 u3Ash7+GLVJAG9skLfNKX0Kh6wo1RyYeqUG1tK5OBAYU4HHmzML/Lsl
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Few patches that should have been there from day 1.

Anyway, they are coming now.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- fix wq in hashtabs not being freed (and static call not being used)
- Link to v1: https://lore.kernel.org/r/20240425-bpf-next-v1-0-1d8330e6c643@kernel.org

---
Benjamin Tissoires (3):
      bpf: do not walk twice the map on free
      bpf: do not walk twice the hash map on free
      selftests/bpf: drop an unused local variable

 kernel/bpf/arraymap.c                       | 15 ++++-----
 kernel/bpf/hashtab.c                        | 49 ++++++++---------------------
 tools/testing/selftests/bpf/prog_tests/wq.c |  2 --
 3 files changed, 21 insertions(+), 45 deletions(-)
---
base-commit: 1bba3b3d373dbafae891e7cb06b8c82c8d62aba1
change-id: 20240425-bpf-next-2114350587e3

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


