Return-Path: <linux-kselftest+bounces-13310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A21929F94
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 11:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCC91F21024
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32796F2E2;
	Mon,  8 Jul 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMYeFVuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DC41C69;
	Mon,  8 Jul 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432388; cv=none; b=X6jU11t499SkhAYUkOKgVF8w1XjbS0xLviK6sRNlRvrymSAeDvNaKCBvr36Gx/5wdOSsWDkqC1pDw2VKeqrcSoXex2aeuRwYGOgWdMHQpyBQAi0NSgPMJxmyu2adJs2WUS1a03s45zw62z3Va2B/hcmRV/LeP5JqZXvOoWq05Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432388; c=relaxed/simple;
	bh=R4JCUMq0nvMUjPgcMs28nWk88L/aq+LilOIE9cTIVIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mlQj402WO5k13v181XCrq8fjVHvfRI2HvBjP5juRN8+pTIth4u5VgXgJK7R1bMlY9G4/jMJGy4JXucA3sw3Gpfdlu9HQF88TAZk91ole60ioLB7HOfEvlGbzTDPphetSqONAj5rPDCWRdjeKCIb/+Yh4WJPIUrcGjgG8iojzsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMYeFVuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D65C116B1;
	Mon,  8 Jul 2024 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720432388;
	bh=R4JCUMq0nvMUjPgcMs28nWk88L/aq+LilOIE9cTIVIw=;
	h=From:Subject:Date:To:Cc:From;
	b=GMYeFVukaLAm9vSidZS0JonvJFjxyKU21bzBznSMOc79OBRMHAbAs8bBcBbUFLr3S
	 ikf8oia8YAbxZIagsy2QRf/prO5dJJ4/Gfkp5aUnaNxaeOWEEFKa6fUDK9lTwBdE8k
	 ZD/j6nAtmnHRabCVXBf1wGB3mbFyhi6b7H8DaDyJYE4Ae5oLND8w8gxjrS/k+N1D8p
	 PxiyMsnSsDJMhEdSDVGrEqKZzSFLLUI/YiskNGN8YQRP1qkIOTgCzljv4rH3AnFOqf
	 nwXx3SdrJtUi0V0ltkR0ZjOcNRVlB4O/P2N4zgUj28ZVIzWNPRdPx+XNvH914jdcyG
	 XtXqqdjsfQAng==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next v2 0/2] Small API fix for bpf_wq
Date: Mon, 08 Jul 2024 11:52:56 +0200
Message-Id: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPi2i2YC/12Nyw7CIBREf6W5a68B+rKu/A/ThdBLSzRQocGah
 n+XsHQxi5MzmTkgkDcU4Fod4CmaYJzNIE4VqOVhZ0IzZQbBRMN61qI2O37eqFk3qF7LulM15PL
 qKZsydAe5arS0bzBms5iwOf8tD5EX/z8WOTIcuGymi1A57e1J3tLr7PwMY0rpB5YQWzOnAAAA
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720432384; l=1361;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=R4JCUMq0nvMUjPgcMs28nWk88L/aq+LilOIE9cTIVIw=;
 b=yYNdy+yxhRkmeBtdBabhj0v1tQg7f92v2ti8nQ8A47i12wgd/DsX4GuVn7T2nPKHUszos4QJP
 TSn7QsykxglBQReTalkZmM0kimrpuk9+akBWkoN8Jsj+E25VlxFD366
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I realized this while having a map containing both a struct bpf_timer and
a struct bpf_wq: the third argument provided to the bpf_wq callback is
not the struct bpf_wq pointer itself, but the pointer to the value in
the map.

Which means that the users need to double cast the provided "value" as
this is not a struct bpf_wq *.

This is a change of API, but there doesn't seem to be much users of bpf_wq
right now, so we should be able to go with this right now.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- amended the selftests to retrieve something from the third argument of
  the callback
- Link to v1: https://lore.kernel.org/r/20240705-fix-wq-v1-0-91b4d82cd825@kernel.org

---
Benjamin Tissoires (2):
      bpf: helpers: fix bpf_wq_set_callback_impl signature
      selftests/bpf: amend for wrong bpf_wq_set_callback_impl signature

 kernel/bpf/helpers.c                            |  2 +-
 tools/testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/wq.c          | 19 ++++++++++++++-----
 tools/testing/selftests/bpf/progs/wq_failures.c |  4 ++--
 4 files changed, 18 insertions(+), 9 deletions(-)
---
base-commit: fd8db07705c55a995c42b1e71afc42faad675b0b
change-id: 20240705-fix-wq-f069c7fb36c3

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


