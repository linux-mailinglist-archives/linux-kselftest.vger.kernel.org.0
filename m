Return-Path: <linux-kselftest+bounces-11408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB2900928
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52761C22058
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795A11A01BF;
	Fri,  7 Jun 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgmVNW8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1D1A01B4;
	Fri,  7 Jun 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774150; cv=none; b=RXEDAoJtkkpOoNvAdDwpLWMuAUozTp00Bjsk8FnDvCXEKxJL3aIprf3LN7EMEWZW1hP8Mbu5e8bEZ5jOuNq23ypMOQ33cEv2siVLDzn4kwhWrOuEJwycRW5Z66nuQNQP/tnR+WOhG5v/8gogFAU9YteE8LYGqG/0BsFs8I3VMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774150; c=relaxed/simple;
	bh=19seXFGbiAkxbo+NZHKMcYfBUtAeq/ulfefjwHuSoZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOYICOEg4SC+Ws4gEF/JCy6CouCXk/jxaV0AZ7BLItPoV61J4W0KLui05JzC1DzgNGDJtQkWe2UVMTGzufLwZOKgETjFubPXP+mNyBwldO+tE5jMYB7ahmqBDxxvPSGjjf5pyF6kIJdEE6qKJ9jOqe/9hN/uVVrtotWxC4owrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgmVNW8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177EAC2BBFC;
	Fri,  7 Jun 2024 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774150;
	bh=19seXFGbiAkxbo+NZHKMcYfBUtAeq/ulfefjwHuSoZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TgmVNW8afj36k/PFucIKm4wSkJ0wT6uIZ9wryBj66eNic1wapQ93QglWnjUm0Yy+f
	 cVQutANVWh8Wi2rL14pXnIZIPPgJhf8C8dNTW8hnPBv2dLCekapSGofbI0tfP/1bNb
	 TcNQsa5EtevZT83EPDaND05UztNHrxSz2kI5JszcY8AXwv8t/DlOXp4pWWdRLtJHdX
	 hpYsKDpiJW7docSudPyfjTYUFxKXtHXqvLesYZlShZGk5QdGouLydjLKxZKQztVb/c
	 42Cz/BE5ZTB/EgboJlLwRFJ7frVUIoOBhsFHIhqa5h+i6bPhVKrXiSE7XeMUDTr40l
	 I5RYyWfr1I8Fg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:36 +0200
Subject: [PATCH HID v2 16/16] HID: bpf: make part of struct hid_device
 writable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-16-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=1759;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=19seXFGbiAkxbo+NZHKMcYfBUtAeq/ulfefjwHuSoZc=;
 b=zhnQpCROcnvr89ISnDPYEYndFo9rbiyiAbgUDd7dF4leBcVaODleyUtOiep9224qku8mSx+8N
 Y5lOv8YiE5tDVGQQcRaU8w+sgToskNEYh9M/ZWX7LBI6CY80q1bUMJv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

It is useful to change the name, the phys and/or the uniq of a
struct hid_device during .rdesc_fixup().

For example, hid-uclogic.ko changes the uniq to store the firmware version
to differentiate between 2 devices sharing the same PID. In the same
way, changing the device name is useful when the device export 3 nodes,
all with the same name.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 3 +++
 include/linux/hid_bpf.h              | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 944e6d91a36b..14a4c64ae242 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -74,6 +74,9 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 
 	const struct hid_bpf_offset_write_range write_ranges[] = {
 		WRITE_RANGE(hid_bpf_ctx, retval, 0, 0),
+		WRITE_RANGE(hid_device, name, 0, -1), /* minus 1 to ensure \0 at the end */
+		WRITE_RANGE(hid_device, uniq, 0, -1), /* minus 1 to ensure \0 at the end */
+		WRITE_RANGE(hid_device, phys, 0, -1), /* minus 1 to ensure \0 at the end */
 	};
 #undef WRITE_RANGE
 	const struct btf_type *state = NULL;
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 88ab4925bdaa..ff30cbc0a090 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -43,7 +43,7 @@ struct hid_device;
  * ``hid`` and ``allocated_size`` are read-only, ``size`` and ``retval`` are read-write.
  */
 struct hid_bpf_ctx {
-	const struct hid_device *hid;
+	struct hid_device *hid;
 	__u32 allocated_size;
 	union {
 		__s32 retval;

-- 
2.44.0


