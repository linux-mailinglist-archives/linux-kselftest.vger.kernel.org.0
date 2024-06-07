Return-Path: <linux-kselftest+bounces-11404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6645900914
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42671C230BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323019E7E3;
	Fri,  7 Jun 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmq5Pl0C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1F19E7D8;
	Fri,  7 Jun 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774141; cv=none; b=kXHywN5eZflyJF8UUyXzJkjjxRI8YeGeRkeA5yxrvP8mlsHx8B2yn1vNGCg+hoICkmYM8VSW0RCLg5KM4kIzYONgRLBiI0YTczUuZwEjJOj5EOACgMsquTJAIMbvH/NU+8uT3oG0sYMFkQFf2RS/KEE7WBBLxv7PSgVoKCJfqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774141; c=relaxed/simple;
	bh=vVyzyvVkmRdnk5AZGhbemmG0KO/W4ktaONqcGrBO074=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKvZZHyGWNgOXn+iTpTCCx1Yk/r4xbt8QfSScI5V6RfWUMcBB9++n5Xmh9Okk6iB25rPUtQQ0/O8dwM5BsxOw170MstpXR+ITCukQdlxn/OUErgX0Sk+ix/ZSj2sZCnM8+7geATmZx0MeZs5h1DFhgXxEuSTAzO72wfqB9BoqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmq5Pl0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9288EC3277B;
	Fri,  7 Jun 2024 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774140;
	bh=vVyzyvVkmRdnk5AZGhbemmG0KO/W4ktaONqcGrBO074=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mmq5Pl0CYs1S5RHDdAnefKssxOniHC13gDSqGu4o7pplygYD4E62IuEwdyWOOH8sv
	 M5Q6KOMg+MONaYPUtjOTx635Ln7avrhgkGXewKXJOlmiZDHha0XrCoPfEp6DHoDhqv
	 5hF98/j+sbCkzDCqnJfJGS6iqN6n6y75/DPgNCTdv5ZBOY6wkPiPLBBg2sIwuu6ML+
	 mgBMY2IWfzl+eAmrvvs9aOFjqxNtTox3Eobe5FTOJeIVC5kCOwOK7JIePzlw0CjLVi
	 4A9rHJUJxb6rhJqXL7mibVW/P17jHYYnOGmcngDsb4hyfLQI73GHmoe7NR3fuKMGI8
	 6hortFnuBfXTg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:32 +0200
Subject: [PATCH HID v2 12/16] HID: bpf: Artist24: remove unused variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-12-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=825;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=vVyzyvVkmRdnk5AZGhbemmG0KO/W4ktaONqcGrBO074=;
 b=ffmXnz8K3nBmqSxpppROlw4V0QAiXmc+E5EPEMZJQt6xuIG5e80oVk9NxvVt4A8StQr/3Gi6s
 uGngugEbwycC67gcQrkxt0hcfuDAhq1/2wUXIp+3ZEuGcLtvjOMnN8O
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

warning: unused variable ‘tilt’ [-Wunused-variable]

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
index bc0b85c38445..d4d062c3a653 100644
--- a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
@@ -158,7 +158,6 @@ int BPF_PROG(xppen_24_fix_eraser, struct hid_bpf_ctx *hctx)
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
 	__u8 current_state, changed_state;
 	bool prev_tip;
-	__u16 tilt;
 
 	if (!data)
 		return 0; /* EPERM check */

-- 
2.44.0


