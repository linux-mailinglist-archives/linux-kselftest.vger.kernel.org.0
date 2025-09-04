Return-Path: <linux-kselftest+bounces-40725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098FB43032
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 05:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF14485EA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAAD1F5852;
	Thu,  4 Sep 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OuZntu0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC31531C8;
	Thu,  4 Sep 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955166; cv=none; b=VL9cO0SKkTjVWl1oBpLgc3WkabEqwofYx0T1cW/pV8jgR1yDdHqX07UMSDgSRr814wKp0BsL6M9PUQ93XESCfOi1ROiPjIFm8uPcMqDtyjWD5SxLgkrkgRqoESt0L1ZXz59XuyrJ0lFlmZ9X1QC99RYf2IUF0/BoMlZE2kLU5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955166; c=relaxed/simple;
	bh=TCplaLivpsgO5O1Gpk8MsE19UljvHJYz3rTrnUbprTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPwIGVUENfnxFpkWZIuGrTwnYUmvAfuac72K+dOeEMfadIaHvvn4V2+0ox49RfqmcizQagbWQvvNOrvUUMBXaSwF8aFzcJu++NSiRmTkJNL5L299tMKGQ8UKkDx8uqSM4mzZQzmUdXl1cG7eEYLdev8dwURkrKSnLd+smcRVMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OuZntu0O; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vM
	r8Zn+QBkVOqpSD8yR0N3msyzmuU8DQJtgE4c32H+s=; b=OuZntu0OYC43Qp/DvQ
	WiQITAFDtwA6N0Xl78nd4yKwHM1JyaO2QzNIDAYLbfFgnHxD9kh4YZM/Ti5pabcD
	R1nieVNB2lm2xtMflUnfpE5olkbBlu5IITRlD2KJZZRfOyvJTfH9vJfqiZX3l0yo
	NzOw6P7TozFPlvWnlfu3RAPw4=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnFzr5AbloGrivGA--.61543S2;
	Thu, 04 Sep 2025 11:05:34 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] libbpf: remove unused args in parse_usdt_note
Date: Thu,  4 Sep 2025 03:05:23 +0000
Message-ID: <20250904030525.1932293-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFzr5AbloGrivGA--.61543S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw43Kw4rXw17CrW5tryrJFb_yoW8trW7pF
	9rW348AFn7JFZ5uFs8JF4Fy3yfKr4ktrW5tayxA3s7tFW7Wr4qqF40kF9YkwnxGa4kJF13
	Z3yYgr18KF47GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBcwy+iGi4-H+MmwAAsN

Remove unused 'elf' and 'path' parameters from parse_usdt_note function
signature. These parameters are not referenced within the function body
and only add unnecessary complexity.

The function only requires the note header, data buffer, offsets, and
output structure to perform USDT note parsing.

Update function declaration, definition, and the single call site in
collect_usdt_targets() to match the simplified signature.

This is a safe internal cleanup as parse_usdt_note is a static function.

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/lib/bpf/usdt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e5eeac0b0fa4..deaea4bd13a6 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -581,9 +581,8 @@ static struct elf_seg *find_vma_seg(struct elf_seg *segs, size_t seg_cnt, long o
 	return NULL;
 }
 
-static int parse_usdt_note(Elf *elf, const char *path, GElf_Nhdr *nhdr,
-			   const char *data, size_t name_off, size_t desc_off,
-			   struct usdt_note *usdt_note);
+static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off,
+			   size_t desc_off, struct usdt_note *usdt_note);
 
 static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, __u64 usdt_cookie);
 
@@ -637,7 +636,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		struct elf_seg *seg = NULL;
 		void *tmp;
 
-		err = parse_usdt_note(elf, path, &nhdr, data->d_buf, name_off, desc_off, &note);
+		err = parse_usdt_note(&nhdr, data->d_buf, name_off, desc_off, &note);
 		if (err)
 			goto err_out;
 
@@ -1143,8 +1142,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 /* Parse out USDT ELF note from '.note.stapsdt' section.
  * Logic inspired by perf's code.
  */
-static int parse_usdt_note(Elf *elf, const char *path, GElf_Nhdr *nhdr,
-			   const char *data, size_t name_off, size_t desc_off,
+static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off, size_t desc_off,
 			   struct usdt_note *note)
 {
 	const char *provider, *name, *args;
-- 
2.43.0


