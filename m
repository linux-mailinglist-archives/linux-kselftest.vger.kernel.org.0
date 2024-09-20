Return-Path: <linux-kselftest+bounces-18157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A0497D204
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE0928405D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79C4D9FB;
	Fri, 20 Sep 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2k/a3VL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D318C31;
	Fri, 20 Sep 2024 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818576; cv=none; b=Kxf5ZPhzul74Ejw5EwJBp75BRVFlc/SNgYgTT7Ro7n8XlY4QDzN3ESekZgidC61rexzJGnZMToGpNK7KwzoSxFSgXfdC6adbse2wUsKcngoiDkiVeRrqZ0qH1YU28+JxNXysvEZlEgLGSAAMGKbGFRbGUqqqc0g1sBlRrmSAxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818576; c=relaxed/simple;
	bh=UdR7OY0xFoG+tfXspehd4joUISB06hU7m5FYvKAtyB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPIzJL9wDhynvPEZbsRT9GLqe9fLGfHJlBAHvTFHYpbX/u9ELTiGjwHeUayACYt+f1ySk528OVvDaoMB57uqpa5WQFJVSUQmoFIiAK7ypOtculiRMPlOPVgbN82KBE1pAvXDmB8cmtgCjMkyIzc4CVdfAMrTkAouQ1ZCJgtia8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2k/a3VL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068bee21d8so18958635ad.2;
        Fri, 20 Sep 2024 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726818574; x=1727423374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abGv7ZYxKC/o8Cd72GEqYyIVpQ7Se9j4BfOFM0A9UgM=;
        b=g2k/a3VL3gPpETSxnkAhbEy7ORquWj9VVeZn1DZ56vgEGFY4u67s0Etnt1lYYCwv0C
         b2ZGGqYJHPKmzWTjZIsBCAqXL6qD7CpQa0p8Yl4WB5WLJkljVwKszyLgBmzBBo0zwY66
         Mg8++wr5eHmCkK9UpXq2HOnEQBuIMMZWnGkX34Ytsp46aPA03yP7tSjctmTfibCIvM1z
         bwhOZERcFOe6yeOLQnlrv0EEc3J72zjhS/rNJt0Xt7UXklYhUP6hJ/xDYVM5MUixH31w
         PKT64ruV3ja0AnDaTE+ByzNQC4Sq2oyuVWO4gDfJOW6G8Z+NnDbPsCqBsZUfCaSaty1C
         L2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726818574; x=1727423374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abGv7ZYxKC/o8Cd72GEqYyIVpQ7Se9j4BfOFM0A9UgM=;
        b=weM+fOdUsK2Q5yEt2F90sw6vTVJQgzGnNT5cM/qVZp8YGIleAwyw9aerCDchYTXw3Z
         Y1WdrNaw5jqjr6X69A2HF5sFG4XXbeW5tLYASdEUhDQiHpgOYfHmV7k7E3iIH/z4CLCw
         3J2t8HUNG2BD3ouv82D58MYTxs7Z6MIbdKYJ0vfGhbNDmNhzlSjMQ6VCM8rAHmn5TeAK
         x6pnxBhnVDJrgf3E1j/1TCxDpku6Un5HthJH+9+S/diECxgnL8Z7ZYj65STXUiQfyGhk
         t5SKmH8NBHyL44aEKBO4QGlijZqzrOmEg4aXWuDN4jEgvk3CCaVnXy6G7Ca2HYOZIMhf
         4NqA==
X-Forwarded-Encrypted: i=1; AJvYcCVTIiMGYVhtS0aqHHNXij5nBpODb4vYB18M3zOIb7CQxH69UgD/gYWVMv+Zwjb+XRHIrFQZPgfKO2nOc1sYqXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75ZyRkAWzdXTCWOFJNJPxN/AA/6bOW6pmJpecbcD5rIXvc4s0
	Wny/p8gxRch+5wiCAR5Mw7IOEvjEgz7GPMo6LGk62zmyvXxDcwaH9XwdpQ==
X-Google-Smtp-Source: AGHT+IFxw2kpBYI7gwi/oRlUejiutCiyxd2492vAazSopvummxjAcZ7MfI3jXDBI3KyuOcoPb9NAtw==
X-Received: by 2002:a17:902:f788:b0:205:7829:9d83 with SMTP id d9443c01a7336-208d8447bacmr27622115ad.38.1726818573799;
        Fri, 20 Sep 2024 00:49:33 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fe8sm90481625ad.68.2024.09.20.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 00:49:33 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v1 1/3] tools/resolve_btfids: Simplify handling cross-endian compilation
Date: Fri, 20 Sep 2024 00:49:11 -0700
Message-Id: <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726806756.git.tony.ambardar@gmail.com>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially, the .BTF_ids section was created zero-filled and then patched
with BTF IDs by resolve_btfids on the build host. Patching was done in
native endianness and thus failed to work for cross-endian compile targets.
This was fixed in [1] by using libelf-based translation to output patched
data in target byte order.

The addition of 8-byte BTF sets in [2] lead to .BTF_ids creation with both
target-endian values and zero-filled data to be later patched. This again
broke cross-endian compilation as the already-correct target-endian values
were translated on output by libelf [1]. The problem was worked around [3]
by manually converting BTF SET8 values to native endianness, so that final
libelf output translation yields data in target byte order.

Simplify and make the code more robust against future changes like [2] by
employing libelf-based endian translation on both input and output, which
is typical of libelf usage.

[1]: 61e8aeda9398 ("bpf: Fix libelf endian handling in resolv_btfids")
[2]: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
[3]: 903fad439466 ("tools/resolve_btfids: Fix cross-compilation to non-host endianness")

CC: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 60 ++++++++++++---------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d54aaa0619df..9f1ab23ed014 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -90,14 +90,6 @@
 
 #define ADDR_CNT	100
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-# define ELFDATANATIVE	ELFDATA2LSB
-#elif __BYTE_ORDER == __BIG_ENDIAN
-# define ELFDATANATIVE	ELFDATA2MSB
-#else
-# error "Unknown machine endianness!"
-#endif
-
 struct btf_id {
 	struct rb_node	 rb_node;
 	char		*name;
@@ -125,7 +117,6 @@ struct object {
 		int		 idlist_shndx;
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
-		int		 encoding;
 	} efile;
 
 	struct rb_root	sets;
@@ -325,11 +316,30 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
 	return 0;
 }
 
+static int btfids_endian_fix(struct object *obj)
+{
+	Elf_Data *btfids = obj->efile.idlist;
+	Elf *elf = obj->efile.elf;
+	int file_byteorder;
+
+	/* This should always succeed due to prior ELF checks */
+	file_byteorder = elf_getident(elf, NULL)[EI_DATA];
+
+	/* Set type to ensure endian translation occurs, and manually invoke
+	 * translation on input since .BTF_ids section as created disables it.
+	 */
+	btfids->d_type = ELF_T_WORD;
+	if (gelf_xlatetom(elf, btfids, btfids, file_byteorder) == NULL) {
+		pr_err("FAILED xlatetom .BTF_ids data: %s\n", elf_errmsg(-1));
+		return -1;
+	}
+	return 0;
+}
+
 static int elf_collect(struct object *obj)
 {
 	Elf_Scn *scn = NULL;
 	size_t shdrstrndx;
-	GElf_Ehdr ehdr;
 	int idx = 0;
 	Elf *elf;
 	int fd;
@@ -361,13 +371,6 @@ static int elf_collect(struct object *obj)
 		return -1;
 	}
 
-	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
-		pr_err("FAILED cannot get ELF header: %s\n",
-			elf_errmsg(-1));
-		return -1;
-	}
-	obj->efile.encoding = ehdr.e_ident[EI_DATA];
-
 	/*
 	 * Scan all the elf sections and look for save data
 	 * from .BTF_ids section and symbols.
@@ -409,6 +412,8 @@ static int elf_collect(struct object *obj)
 			obj->efile.idlist       = data;
 			obj->efile.idlist_shndx = idx;
 			obj->efile.idlist_addr  = sh.sh_addr;
+			if (btfids_endian_fix(obj))
+				return -1;
 		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
 			/* If a .BTF.base section is found, do not resolve
 			 * BTF ids relative to vmlinux; resolve relative
@@ -706,24 +711,6 @@ static int sets_patch(struct object *obj)
 			 */
 			BUILD_BUG_ON((u32 *)set8->pairs != &set8->pairs[0].id);
 			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
-
-			/*
-			 * When ELF endianness does not match endianness of the
-			 * host, libelf will do the translation when updating
-			 * the ELF. This, however, corrupts SET8 flags which are
-			 * already in the target endianness. So, let's bswap
-			 * them to the host endianness and libelf will then
-			 * correctly translate everything.
-			 */
-			if (obj->efile.encoding != ELFDATANATIVE) {
-				int i;
-
-				set8->flags = bswap_32(set8->flags);
-				for (i = 0; i < set8->cnt; i++) {
-					set8->pairs[i].flags =
-						bswap_32(set8->pairs[i].flags);
-				}
-			}
 		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
@@ -748,9 +735,6 @@ static int symbols_patch(struct object *obj)
 	if (sets_patch(obj))
 		return -1;
 
-	/* Set type to ensure endian translation occurs. */
-	obj->efile.idlist->d_type = ELF_T_WORD;
-
 	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
 
 	err = elf_update(obj->efile.elf, ELF_C_WRITE);
-- 
2.34.1


