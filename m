Return-Path: <linux-kselftest+bounces-14091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D36593A44F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0987E2823E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E6158A2C;
	Tue, 23 Jul 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcnn9IhT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658E158A1F;
	Tue, 23 Jul 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751737; cv=none; b=gkEBpjPAncb06vZ34hYuoEYuVglczlelHVy1zZ4YNGg2TEI/aoZ5+yoKkKTr4Ur1T/QpmohmMuGi7EstAO+uSLBJnSP0jkC5oPM4iG3mxQkEQRMves2L04jXw+mjD4FVURwwEiL9MyW82jC9AvkpqdorUa2gy7ftOa0VxcWtt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751737; c=relaxed/simple;
	bh=rbkwpDTz7JUQx62sDw+oVHWEAHwrQR6OSjMfDq8ibHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdVYIdQDO1mUzH7Yze7uwz9R/TauPU5j1ZC7lqhWD97HZhuVZOQ/ZpBW0tNt8TWXH+4Dt6IboiWOcfFubBLKMyZ8vOMj9HBZ4O6fqhjRsj8aGHY7OMK0q4pDZh6Eor9PVGaloGjlcYk1Zz3d3gASghjFgtuT4oaWft2niqVSNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcnn9IhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1147C4AF09;
	Tue, 23 Jul 2024 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751737;
	bh=rbkwpDTz7JUQx62sDw+oVHWEAHwrQR6OSjMfDq8ibHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xcnn9IhTdV53G/ModhKEbQDSMUV3IFkwy/yGYYDE9kTYWzH+NKESUgfHTeSBaF2PA
	 INgnXoXgFauT0VhOjjf44CPcadvYnf/Lf1N/sggNx3nhdTu9MRmi6cjJZHskhVy4y1
	 MOw36NYA+6zAf7m/YezM6LtoFWkyGvVXVXYpfjC4xWHD5vRpvmfZ75P2fcuAcdVrEg
	 t+J5YvFydLedgEm0E4h51YYtH4Vtg06ESLH2fLsJ3yskl/T0oPutJNWWjg1VNMAm9d
	 tqxONYyWG76pPvQjjcP9eTFpmNvTWuvWaDo0mdbn7CD7ToIrBi+NiSri89kiOeoMdo
	 yR4b1cvsCRB8A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 23 Jul 2024 18:21:54 +0200
Subject: [PATCH HID 4/4] selftests/hid: add test for attaching multiple
 time the same struct_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-fix-6-11-bpf-v1-4-b9d770346784@kernel.org>
References: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
In-Reply-To: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721751728; l=1182;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=rbkwpDTz7JUQx62sDw+oVHWEAHwrQR6OSjMfDq8ibHU=;
 b=o462OkArDDHfVpI/bdKYU9U7nW92WlKzPZgakCpKBG595M3fkFpL0MBDj7Q3DYupX34eM8L0o
 PnACh9AIlBWA6Af5Rpki97NcuxJx12ghILHimKeeiXmKcCLHndejuh4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that we would en up in a bad state if we attempt to attach
twice the same HID-BPF struct_ops, so have a test for it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 9c935fd0dffc..75b7b4ef6cfa 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -694,6 +694,24 @@ TEST_F(hid_bpf, subprog_raw_event)
 	ASSERT_EQ(buf[2], 52);
 }
 
+/*
+ * Attach hid_first_event to the given uhid device,
+ * attempt at re-attaching it, we should not lock and
+ * return an invalid struct bpf_link
+ */
+TEST_F(hid_bpf, multiple_attach)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_first_event" },
+	};
+	struct bpf_link *link;
+
+	LOAD_PROGRAMS(progs);
+
+	link = bpf_map__attach_struct_ops(self->skel->maps.first_event);
+	ASSERT_NULL(link) TH_LOG("unexpected return value when re-attaching the struct_ops");
+}
+
 /*
  * Ensures that we can attach/detach programs
  */

-- 
2.44.0


