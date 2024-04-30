Return-Path: <linux-kselftest+bounces-9124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD98B701C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF411F21AB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637512C48B;
	Tue, 30 Apr 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zii2OQW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD95129E81;
	Tue, 30 Apr 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473813; cv=none; b=PQBlWZnQijXcpC8QMnpNXz1ZUPlZxk3oTgFkSIrCAvQQibAYa0PxjJyIREdhFP8Yte28F1jEa7QH81ShjhFji3HKUm7Z9UmGkLmzsNbrDL8kBAjxOxlFUaMYqrTkr3BmcgQf7I3F40sxyTr+tyy9laJ1lTduJr6+EX0qMZ5nFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473813; c=relaxed/simple;
	bh=pmPJ41wWRetcjAe+Ucdl6PaA5Nla2eyRnT5tyL4d71c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tW0XWcmyftrhMEdJQaHnWuuauLdP1RwzQVVd9SPjR4dsgeFbcSYjWctyYNcL/oImea6xUJyuwSws9qPGNiPuM/dNPc53XDHs9g4M19sOr50h2vpGmkRN8Sd3NKb92EmoHw3ZgWk2e+bAOH5c4L9ZMsaOfwvrPlRoa0h5xIf5rnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zii2OQW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEF0C4AF14;
	Tue, 30 Apr 2024 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473813;
	bh=pmPJ41wWRetcjAe+Ucdl6PaA5Nla2eyRnT5tyL4d71c=;
	h=From:Subject:Date:To:Cc:From;
	b=Zii2OQW7u80T2Qx3WpabNscbjTM1oC2mLsYNQCIN1yNXjSV3Y/0nw6slPH8k+j0E0
	 K4y+MSiO5V6Fbt63Gxxl/gdFL2+vyp5J1KqyHmPeiSvXHVgEIMCutyToy7ggpnfm6J
	 Lzy39aAUzS1PmTWNE8ZWYTwX0FSzYcKYmfphFi0cMl2pzdxYVIya3ponX7+MuZs/aQ
	 9JRgNzbK5Db+5GOtc4bx3Td+RgO44Y2lStEE7Y2O5EeO9A+v0s4BfJ5Lly1eFiX7GP
	 80oJEc1r0wJM5rofYLuQLJYxIE2PSi2ZePoiFyyrBISWbILJ7YerVWIn48eif8FhXX
	 C5ElXXwLXSgGw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next v3 0/3] bpf_wq followup series
Date: Tue, 30 Apr 2024 12:43:23 +0200
Message-Id: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvLMGYC/2WNyw6CMBREf4XctTW3L0RW/odxgXALjaaQljQYw
 r9bm5hgXE5mzpkVAnlLAepiBU/RBju6FOShgHZoXE/MdimDQKFQCc3uk2GOlpkJzpXUqKsTSUj
 zyZOxS1Zd4buCW2oGG+bRv/JH5Ln/10XOkPGukhKpbEslLw/yjp7H0ffZEsWOlLgjxYdU2DQaD
 Rp+/iG3bXsD5UhBwOUAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714473809; l=1120;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pmPJ41wWRetcjAe+Ucdl6PaA5Nla2eyRnT5tyL4d71c=;
 b=JBijTWQ4/ntor0BHc4BqUYpOGdwARsOol3Q76Psmfbc25fqiJ83J4Gg5rJ/mUULlLI/YR7Bua
 upTSshfDCSoCttL7Vy246aKkXk7HeH69gEZElkcfulDaNM8BAiYt5Zs
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Few patches that should have been there from day 1.

Anyway, they are coming now.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v3:
- fixed bpf_test module not being able to be removed, because the bpf_wq
  was never freed
- Link to v2: https://lore.kernel.org/r/20240430-bpf-next-v2-0-140aa50f0f19@kernel.org

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


