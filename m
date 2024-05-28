Return-Path: <linux-kselftest+bounces-10786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB88D1CA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B82286CBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE821174ED4;
	Tue, 28 May 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4pVrrGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F5174EC2;
	Tue, 28 May 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902144; cv=none; b=JewKQ8116Qv6yP1cfqGyZXSWJvEe0KAqYtSfirogQpyzVOMGaJV2C46ETlN/lMHUOgGWI1BlC094J1G2TLgdcl+iAHFiqEDwsN160+Qu/gOcFOzoJpk0yYcokXjRXOxn8BcB/TGfDxSOTDUWtBCSJdnxAY5sS94VxE75Z1VNxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902144; c=relaxed/simple;
	bh=eowKlObErurap8texC0IeDebTUGtflcKm/yE3YPRDsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QICpFCewiEEozN7na2fg3APDX63VNPYrftR+E3zNL4bfUa7LYN8n+uotq25YDYvLLKHj8DbIqMkJY2PjpQKUVnEoLe+to54xW5oV7QWi7+VNWb7juZuNcRKya9p1ncoDnW0ZsmOXGQmK3kMXaRx8MpznH85vKmT/sFDjWosn2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4pVrrGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6292AC32782;
	Tue, 28 May 2024 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902144;
	bh=eowKlObErurap8texC0IeDebTUGtflcKm/yE3YPRDsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l4pVrrGMR+eaVZ650RASvdPqk5Qs6N42cWpsfR2nnawaAJiiMFgdrRT93DRUf/NI+
	 upH8s1Xi09lDAbY/rtQ+L0dmSHGf5JBpNUFHq7OABcSPyZRN4kGawzac80CFzsE8Iq
	 jKN45764pVJGkTLy99ycPSxigRdDxBjVUP/baIb00fJdRvnRop2NRkvJzr2i0tM0Nb
	 QnKPYfEeZq4ywEt5XxswykkrHOwWjAbHNOtbbWk9u96TIDsMn3721Q3VqzqdwManl7
	 HZ5ig7wE6G6R4GumGn45oePa4hcNanuz7W7D9UsPVTYJ3/N3ki7DKqNrMBiSf3saxs
	 gi82dpAA0N8CA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:50 +0200
Subject: [PATCH HID 12/13] HID: bpf: Artist24: remove unused variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-12-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=798;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=eowKlObErurap8texC0IeDebTUGtflcKm/yE3YPRDsM=;
 b=Ls5lwnz+jdJM1LWEGdDwN8HduhTcE/XsVVk3I0en9UjFVNudj1VbmZx8GyvMr768n45DRHogi
 pge7gg0uxd3DYz6If4EJeIPwRU1A0itz7C8bO30e4WJuYE1ZBLerFdz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

warning: unused variable ‘tilt’ [-Wunused-variable]

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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


