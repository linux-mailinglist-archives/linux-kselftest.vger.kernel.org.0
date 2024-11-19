Return-Path: <linux-kselftest+bounces-22290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B29D29E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1151E1F21DE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28E71D0F68;
	Tue, 19 Nov 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiEN/RzP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBE1D04A0
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030708; cv=none; b=AS7xJ3BhxOJb5lXHbwo0c55ccXJs3pkitcC7jZz+hKZ9usr8HFa8ZQDsbMZq2cUBV+FWeA5ViP+c+0TxZx4e5/JFthWC4BU8MC8Y/KTVTbOZzDrfPknLm/ZkT3H9F2wc+FHfy1EyGGBekpxcWW0S65htAeE76+5MBo1PB9oH1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030708; c=relaxed/simple;
	bh=HfgzzhQB9Z8CbP30UBBQFA/8juWm49GyqBubPeAUIoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rECtgW5gRsI+gMUGOeQaB9Bs4IEBJ0bFejbQK/LCmtScNqA5XLg4EA2D0TvQqtniNoSfQyW0P1qKFhPVOL233wVuK4I4QZY79unkk49+Toa7BfHoHYI85+YPkz6wyJpBwIKyOHxkAApLt9P5CySXCRrA3q9im0UN1TQDvQB5wSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiEN/RzP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbbl+TXDo+t5kIfzQ14qJGOWt1RDAARb2PWsvxSVw1o=;
	b=SiEN/RzPBhaoePshtzNHAh7ZrXyujP/oIVqa2WZS2hNgRGZQIOyTMtrWCrxZHSui1bDXy8
	ZHsGxuES9OsCEaAVXrZ7ob/xiFwyLAi0bE0fGkD9ylVpFdtMLf3guBRrTKB4H72W4tZU+e
	YGJH7CEuzo2sJeIIXHof6940alkcdEI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-1WZ3p9jrPQW6G0U5yxmRQQ-1; Tue,
 19 Nov 2024 10:38:24 -0500
X-MC-Unique: 1WZ3p9jrPQW6G0U5yxmRQQ-1
X-Mimecast-MFC-AGG-ID: 1WZ3p9jrPQW6G0U5yxmRQQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E53F01952D05;
	Tue, 19 Nov 2024 15:38:14 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDE233003B71;
	Tue, 19 Nov 2024 15:37:59 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>,
	Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [RFC PATCH v3 09/15] objtool: Warn about non __ro_after_init static key usage in .noinstr
Date: Tue, 19 Nov 2024 16:34:56 +0100
Message-ID: <20241119153502.41361-10-vschneid@redhat.com>
In-Reply-To: <20241119153502.41361-1-vschneid@redhat.com>
References: <20241119153502.41361-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Later commits will disallow runtime-mutable text in .noinstr sections in
order to safely defer instruction patching IPIs.

All static keys used in .noinstr sections have now been checked as being
either flagged as __ro_after_init, or as forceful static keys. Any
occurrence of this new warning would be the result of a code change that
will need looking at.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
offset_of(static_key.type) and JUMP_TYPE_FORCEFUL would need to be shoved
into a somewhat standalone header file that could be included by objtool
itself.
---
 tools/objtool/Documentation/objtool.txt | 13 ++++++++
 tools/objtool/check.c                   | 41 +++++++++++++++++++++++++
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/special.h |  2 ++
 tools/objtool/special.c                 |  3 ++
 5 files changed, 60 insertions(+)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c3ee959b63c7..06fa285873387 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -447,6 +447,19 @@ the objtool maintainers.
    names and does not use module_init() / module_exit() macros to create
    them.
 
+13. file.o: warning: func()+0x2a: non __ro_after_init static key "key" in .noinstr section
+
+  This means that the noinstr function func() uses a static key that can be
+  modified at runtime. This is not allowed as noinstr functions rely on
+  containing stable instructions after init.
+
+  Check whether the static key in question can really be modified at runtime,
+  and if it is only enabled during init then mark it as __ro_after_init. If it
+  genuinely needs to be modified at runtime:
+
+  1) Directly rely on the underlying atomic count of they key in the noinstr
+     functions.
+  2) Mark the static key as forceful.
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 00e25492f5065..c1fb02c326839 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2056,6 +2056,9 @@ static int add_special_section_alts(struct objtool_file *file)
 		alt->next = orig_insn->alts;
 		orig_insn->alts = alt;
 
+		if (special_alt->key_sym)
+			orig_insn->key_sym = special_alt->key_sym;
+
 		list_del(&special_alt->list);
 		free(special_alt);
 	}
@@ -3605,6 +3608,41 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
+static bool static_key_is_forceful(struct symbol *key)
+{
+	if (!strcmp(key->sec->name, ".data")) {
+		unsigned long data_offset = key->sec->data->d_off;
+		unsigned long key_offset = key->sym.st_value;
+		char* data = key->sec->data->d_buf;
+
+		/*
+		 * offset_of(static_key.type)
+		 *                        v
+		 *                        v            JUMP_TYPE_FORCEFUL
+		 *                        v                    v
+		 */
+		return data[(key_offset + 8) - data_offset] & 0x4;
+	}
+
+	return false;
+}
+
+static int validate_static_key(struct instruction *insn, struct insn_state *state)
+{
+	if (state->noinstr && state->instr <= 0) {
+		if (static_key_is_forceful(insn->key_sym))
+			return 0;
+
+		if ((strcmp(insn->key_sym->sec->name, ".data..ro_after_init"))) {
+			WARN_INSN(insn, "non __ro_after_init static key \"%s\" in .noinstr section",
+				  insn->key_sym->name);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static struct instruction *next_insn_to_validate(struct objtool_file *file,
 						 struct instruction *insn)
 {
@@ -3766,6 +3804,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
+		if (insn->key_sym)
+			validate_static_key(insn, &state);
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965a..35dd21f8f41e1 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -77,6 +77,7 @@ struct instruction {
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
+	struct symbol *key_sym;
 };
 
 static inline struct symbol *insn_func(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 86d4af9c5aa9d..0e61f34fe3a28 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -27,6 +27,8 @@ struct special_alt {
 	struct section *new_sec;
 	unsigned long new_off;
 
+	struct symbol *key_sym;
+
 	unsigned int orig_len, new_len; /* group only */
 };
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 097a69db82a0e..fefab2b471bf8 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -127,6 +127,9 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 			return -1;
 		}
 		alt->key_addend = reloc_addend(key_reloc);
+
+		reloc_to_sec_off(key_reloc, &sec, &offset);
+		alt->key_sym = find_symbol_by_offset(sec, offset & ~3);
 	}
 
 	return 0;
-- 
2.43.0


