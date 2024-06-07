Return-Path: <linux-kselftest+bounces-11407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE0900921
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513F01F224CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A8919FA8B;
	Fri,  7 Jun 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPZ0ja05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19119FA85;
	Fri,  7 Jun 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774148; cv=none; b=lSlS9GWsyCsbNiEYlrWYztkh1eh0rTpdeKC9MwxaFSnL+LOnyCPU/1JqVpOTk0ifFBMR4emjMpCTPGdE6egfnWz3lHlLFKZs+8wZ7TqLYWLnuT9tcXr3+3Ebtec8QkTmP7FR7n6R1ZilfxItcjtysH+diJCwE4IkcsXl3dttc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774148; c=relaxed/simple;
	bh=TtjyZ/izg+s9HXVd8EhQE8xSZuzHQYiYlGm/WW0aymA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9Jch0O9SNU+gxPhORp4/g49EOzuKpQ4FUpd5kdCP224zb1pIc/FpptJz/ZHqoWwi5pYaui8iHv5MQ+imaPnaacD6xznD1T+HWrE4XWIaP0Y32n+d6tf0i3OtSDN0Xbx2rg5VLwYX+Lt83U/f+uh8mD0P8h3VHWSllwlsz02Zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPZ0ja05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA758C32786;
	Fri,  7 Jun 2024 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774147;
	bh=TtjyZ/izg+s9HXVd8EhQE8xSZuzHQYiYlGm/WW0aymA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UPZ0ja05QtmDgRLLETpxWuONT3qYlLc/0TVjFhi9psXo2qi5+pJcv2+U33z8gH/2Q
	 +iq1UFI1OiFDw+KL/7uJv62a8VaTkw1V74dks46JMx5fF3r8Sey0Hrw8sQvgANiINP
	 K+DvMtWO/YcbhIlzT00K2qKTdfvVnk1BlJp6IM8EadITbUWNzG6ZoSv/oGiPIVwQrY
	 vj0PJ5VVonMlG7zuzSZhss60T2Pb7sJYiswWVPyUJ3GwOQsPDp3Xs8PrUn+cgVGGAi
	 m512CL6y4BmT+gEpndtQ+dV6ddDWqQf7Lnf6iPzvuEo0CauLKfhgwbJL79ZlMjTP36
	 y/fojj0QeQ2RA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:35 +0200
Subject: [PATCH HID v2 15/16] HID: bpf: rework
 hid_bpf_ops_btf_struct_access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-15-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=4063;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=TtjyZ/izg+s9HXVd8EhQE8xSZuzHQYiYlGm/WW0aymA=;
 b=SyH9GsXkta7A7y+QVmvqG72PU58wXxiqMvqZ9USgw55CKUCYzUJn6mpzt7PEszglWcf6ZRQEx
 F3iRL5e3ps1BpLy/fEu2fVGSTVmyQh+A43CsXwxD2vaavxqnZzCHWHu
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The idea is to provide a list of stucts and their editable fields.

Currently no functional changes are introduced here, we will add some
more writeable fields in the next patch.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 91 +++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 056d05d96962..944e6d91a36b 100644
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
+#define WRITE_RANGE(_name, _field, _start_offset, _end_offset)			\
+	{									\
+		.struct_name = #_name,						\
+		.struct_length = sizeof(struct _name),				\
+		.start = offsetof(struct _name, _field) + _start_offset,	\
+		.end = offsetofend(struct _name, _field) + _end_offset,		\
+	}
 
-	type_id = btf_find_by_name_kind(reg->btf, "hid_bpf_ctx",
-					BTF_KIND_STRUCT);
-	if (type_id < 0)
-		return -EINVAL;
+	const struct hid_bpf_offset_write_range write_ranges[] = {
+		WRITE_RANGE(hid_bpf_ctx, retval, 0, 0),
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


