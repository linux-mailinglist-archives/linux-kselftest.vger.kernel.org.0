Return-Path: <linux-kselftest+bounces-11482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0309010DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92A5B22182
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98717C7BC;
	Sat,  8 Jun 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hURxL6Y2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078B17C7AE;
	Sat,  8 Jun 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837310; cv=none; b=tMpzryp15xPA4i0QSMYJXJeWQ9UMX1NH6kPRcxd9LJI9nfV14RPl1xK73RA0Axq6bB2T40v4MxVKFkAVCzEyg+3rB1rbrn9FTcKpgiMOtyMUbNdUX/5B/AEHDolWfkqRtXeKIvs7mPcUH5wgu07kq4jbmHOBQEDDYGZEAbce2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837310; c=relaxed/simple;
	bh=L4CYU4n+T+6E8bgHr6bJqE2mTuITTQLAF8wrCeVIKd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7DMcjB3CNaLdF7YJGkGvs/U92TNuG0bH6o9WpZJu/2JLhdw1NMon+dxh5LSJP3nTz/xu4M9AVorAPSl+8b8iJkHdoTiJCn5kzkiE6FZf22DYFWLvGt+FNLVccKzYzGlFalLzp0v5GSKh56GDNwU7aUB1Q8zPqqDO4RTw6kMnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hURxL6Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF3BC4AF09;
	Sat,  8 Jun 2024 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837309;
	bh=L4CYU4n+T+6E8bgHr6bJqE2mTuITTQLAF8wrCeVIKd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hURxL6Y2YzJLFkBryk39+BRq0xjbHHfoNsqDV+8gIcNMJEeQBp3h+HxdmF5sRIWWs
	 BjPkEPX1yxcQr3puxh2p2QJQEX+F2TH/9M8MMVuYBOPxcvRiygdZyBt6YpjjqNqOxc
	 duBmQ93OwBSKpWTl4OqSD8RvURj2GRtldNeRVeSrWqN9KqyqIa2S/13WaYY84KpGfG
	 kfxtU6blcHFvZzYVM3tRm5JhSUGtIub6uSSRhKxKE+qkMuI7jCEKp6XYKIDqqv8V/Z
	 4YkC/7ZNoOHhB8HaqUn+JMTAFRI5GYke64U2VXb/gVXxGkKuueWXnCQegzX7jdyhCF
	 LZxK5Ft2FACMw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:24 +0200
Subject: [PATCH HID v3 12/16] HID: bpf: Artist24: remove unused variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-12-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=845;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=L4CYU4n+T+6E8bgHr6bJqE2mTuITTQLAF8wrCeVIKd4=;
 b=fckHWugzyfy+gR4/x05n4t1rKyJFCApWnbtapRom03hX/4BB38MXmaqMkKdt3Akb6q0D8KpCn
 3X6yLewsqT1DrDKbQtqKAiQuLErMkYyuO8LqmEEVUz0okULythft8+n
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

warning: unused variable ‘tilt’ [-Wunused-variable]

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

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


