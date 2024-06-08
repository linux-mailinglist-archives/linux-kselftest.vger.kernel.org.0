Return-Path: <linux-kselftest+bounces-11485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD89010EF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CAFB21DB9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3717D8A3;
	Sat,  8 Jun 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxaO+UXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431E14286;
	Sat,  8 Jun 2024 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837316; cv=none; b=I7F+4BVUZSqOUNkELOW8CA8c66QEIQG1SwZUEmB9AWgC+URvTsX+26tnpPctO2sQcG4frbcRBeb2tBemTdCXjdR1C7hVcMSJ4e4j9w+BurFOEEEcHZvZeTz7Euvhnu0591kDyDJeOhu8OH+yRxkrOaI1XqUBR6TVJC9j0Zld/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837316; c=relaxed/simple;
	bh=HIrrmyaYgI3pACH+lmgDvM1+uBik3+a//vxGZcnQimg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwD7ZuhRXLqKB8qjNFGxEBUrVEGjZ6R1FV8LjSwT96zccJie7sEy7ixPebi4kjoDAGa11qlZUukZh6njxaOa2Yl4DHaS4kguWqyi6+KbXifaoY0eHcxli/3uNf9jC+RN+siHkOHRd1hVswHal3l+TqPflBEx5lsFsxg7PiLf4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxaO+UXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB21C4AF07;
	Sat,  8 Jun 2024 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837316;
	bh=HIrrmyaYgI3pACH+lmgDvM1+uBik3+a//vxGZcnQimg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SxaO+UXDrTYRXcNH1lKaNZcThkDz/kaDxJZlwGVL/OGtNnTfgWxmkw41XdYdf0Ebb
	 jsuRYuQfHXY/7SALbzLZhklF0rKo5fANbNUccxh07bX2n7l8Gb1VMHRNAnlMYmQ+B6
	 6hJHoGepPHc5tniZuodQi7lRriIIBp7d49T0+5OS1JHcO9HEnvVZOwyTLIxEPhchFo
	 yZhjzR4Bryqky5W4ccCH9embWD+VVjwsfiSBxQxUAb8VVjiJdcUZ1z1EGLpox7weGY
	 AU5LM5DzhkgE8uRcp/ppmupjBEnFFe/TSkDOq9pmORc/Vh17PVkfYnPzjPK91jPdly
	 tsHv8j2HcieeA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:27 +0200
Subject: [PATCH HID v3 15/16] HID: bpf: rework
 hid_bpf_ops_btf_struct_access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-15-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=4130;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=HIrrmyaYgI3pACH+lmgDvM1+uBik3+a//vxGZcnQimg=;
 b=NMPE52ezcZipQcLjtnuDHX9D3HBCIFlM25VOGZTCC3fbQOZriKVwUTwVgtsbFvNMZYiLKLY/U
 cfBz6WfyaFIBxTLOrnghBmcCiq35Y4Ftrwyln8R0yVPHiTAT9UGA1ar
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The idea is to provide a list of stucts and their editable fields.

Currently no functional changes are introduced here, we will add some
more writeable fields in the next patch.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v3:
- rewrote WRITE_RANGE macro to not deal with offset from the caller side

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 91 +++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 056d05d96962..b14eccb121e0 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -16,6 +16,7 @@
 #include <linux/hid_bpf.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/stddef.h>
 #include <linux/workqueue.h>
 #include "hid_bpf_dispatch.h"
 
@@ -52,40 +53,86 @@ static int hid_bpf_ops_check_member(const struct btf_type *t,
 	return 0;
 }
 
+struct hid_bpf_offset_write_range {
+	const char *struct_name;
+	u32 struct_length;
+	u32 start;
+	u32 end;
+};
+
 static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct bpf_reg_state *reg,
 					   int off, int size)
 {
-	const struct btf_type *state;
-	const struct btf_type *t;
-	s32 type_id;
+#define WRITE_RANGE(_name, _field, _is_string)					\
+	{									\
+		.struct_name = #_name,						\
+		.struct_length = sizeof(struct _name),				\
+		.start = offsetof(struct _name, _field),			\
+		.end = offsetofend(struct _name, _field) - !!(_is_string),	\
+	}
 
-	type_id = btf_find_by_name_kind(reg->btf, "hid_bpf_ctx",
-					BTF_KIND_STRUCT);
-	if (type_id < 0)
-		return -EINVAL;
+	const struct hid_bpf_offset_write_range write_ranges[] = {
+		WRITE_RANGE(hid_bpf_ctx, retval, false),
+	};
+#undef WRITE_RANGE
+	const struct btf_type *state = NULL;
+	const struct btf_type *t;
+	const char *cur = NULL;
+	int i;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	state = btf_type_by_id(reg->btf, type_id);
-	if (t != state) {
-		bpf_log(log, "only access to hid_bpf_ctx is supported\n");
-		return -EACCES;
-	}
 
-	/* out-of-bound access in hid_bpf_ctx */
-	if (off + size > sizeof(struct hid_bpf_ctx)) {
-		bpf_log(log, "write access at off %d with size %d\n", off, size);
-		return -EACCES;
+	for (i = 0; i < ARRAY_SIZE(write_ranges); i++) {
+		const struct hid_bpf_offset_write_range *write_range = &write_ranges[i];
+		s32 type_id;
+
+		/* we already found a writeable struct, but there is a
+		 * new one, let's break the loop.
+		 */
+		if (t == state && write_range->struct_name != cur)
+			break;
+
+		/* new struct to look for */
+		if (write_range->struct_name != cur) {
+			type_id = btf_find_by_name_kind(reg->btf, write_range->struct_name,
+							BTF_KIND_STRUCT);
+			if (type_id < 0)
+				return -EINVAL;
+
+			state = btf_type_by_id(reg->btf, type_id);
+		}
+
+		/* this is not the struct we are looking for */
+		if (t != state) {
+			cur = write_range->struct_name;
+			continue;
+		}
+
+		/* first time we see this struct, check for out of bounds */
+		if (cur != write_range->struct_name &&
+		    off + size > write_range->struct_length) {
+			bpf_log(log, "write access for struct %s at off %d with size %d\n",
+				write_range->struct_name, off, size);
+			return -EACCES;
+		}
+
+		/* now check if we are in our boundaries */
+		if (off >= write_range->start && off + size <= write_range->end)
+			return NOT_INIT;
+
+		cur = write_range->struct_name;
 	}
 
-	if (off < offsetof(struct hid_bpf_ctx, retval)) {
+
+	if (t != state)
+		bpf_log(log, "write access to this struct is not supported\n");
+	else
 		bpf_log(log,
-			"write access at off %d with size %d on read-only part of hid_bpf_ctx\n",
-			off, size);
-		return -EACCES;
-	}
+			"write access at off %d with size %d on read-only part of %s\n",
+			off, size, cur);
 
-	return NOT_INIT;
+	return -EACCES;
 }
 
 static const struct bpf_verifier_ops hid_bpf_verifier_ops = {

-- 
2.44.0


