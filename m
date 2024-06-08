Return-Path: <linux-kselftest+bounces-11486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB39010F4
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69536B22DFB
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F617DE0D;
	Sat,  8 Jun 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnGemssx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65917D8AB;
	Sat,  8 Jun 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837319; cv=none; b=e1nSkO9nYdaWHDb58/xIrfcV0hmuPOLgrsJaIzeUlcRaZmIhnU0dVTAzJvFsB9yuTaATIf2amj+nc/FFGk5O2wG3QVoSJkEkrUt9ZCc9hmrmOM2xE5/Nm03xtq9c9Agl4uqRN+0chOkWL74uHMcNQ7OPtqhEZm7+CBhX5IgYBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837319; c=relaxed/simple;
	bh=YHolCvF3jA/DQGyy5jN6lFObu+rIHNuOu9Dmy3Vod3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAWuIfFrgPMtDd82JCM4NYweVN+JMXxDNs7ImURdwFWxd/YrHTbnxEDC9VLrA+ttRytoELiXp+n0x2+KTa4WU6kF/4I5q0XSHUlMAMZQl++YeBOKiil/s1Gm18ohF4PjoZXeDuvdeJJ94p/F2t8kDTmio0gJfFe7HK7oQWVxb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnGemssx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194D5C2BD11;
	Sat,  8 Jun 2024 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837318;
	bh=YHolCvF3jA/DQGyy5jN6lFObu+rIHNuOu9Dmy3Vod3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LnGemssx+z+2K25Xw92Vk4C+ubNIsAfaEmFEbd0Tik3oN5d5gYJMkWvjaNImlQatE
	 R2bP64tn3V8FknJxybCEobkZbtFtgb8mOQX3v7Lkxd2iIJFemsXckHrbCq/5OtB7Yv
	 mFBKw3tB+ImpWCwAoZVyymfKyTUIZVCz8V1HVG9CZlgYGIbXRu03A1iHlq7DzXpwRy
	 mlohtUSJsomVheW16NDYB+NbUJl7jrRjjMljtGsYR+8D/I3k6ricVI9XwzSHUCu0TF
	 e1MBSPZBeJcCchnXe279kZ8wGRsZHEzMWFedMEbmpQlh6vUjfGexyePkHSxRp42lGB
	 ok7vhLH3VXtLA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:28 +0200
Subject: [PATCH HID v3 16/16] HID: bpf: make part of struct hid_device
 writable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-16-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=1694;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=YHolCvF3jA/DQGyy5jN6lFObu+rIHNuOu9Dmy3Vod3s=;
 b=CdyFQFSOvnA/Vvz1fzchBiZjuEjZvhWbXkEF/tt9wXTyR9zjNA+HozZMMQG0RO/2vF20g01sT
 n5qq7W2nfvgAHvK0GUkqigT7+e1KxJDjF0kSVu9OT9JFxIZKpXZ7bCL
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

changes in v3:
- amend for new WRITE_RANGE API

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 3 +++
 include/linux/hid_bpf.h              | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index b14eccb121e0..e28cca78e1f5 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -74,6 +74,9 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 
 	const struct hid_bpf_offset_write_range write_ranges[] = {
 		WRITE_RANGE(hid_bpf_ctx, retval, false),
+		WRITE_RANGE(hid_device, name, true),
+		WRITE_RANGE(hid_device, uniq, true),
+		WRITE_RANGE(hid_device, phys, true),
 	};
 #undef WRITE_RANGE
 	const struct btf_type *state = NULL;
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 1b4cc1b2c31d..65d7e0acc8c2 100644
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


