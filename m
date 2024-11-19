Return-Path: <linux-kselftest+bounces-22281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477E9D29BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7281F23895
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDC1D0413;
	Tue, 19 Nov 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9NxGyMv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AC1CF7C7
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030582; cv=none; b=PvORG7NVhDRa979DeDYZELnvMz2oZXAXLBvd0U+gjk5mwb23MfL19jffYAKWXukDBmGA0gYPzjYSbnPG/VNHGA9IPf4jBw2TyyyYR6F6+u2Lu2H1xBOFn50GcZje3hTqRtecsDomAU7/UOVXQ4jmgSqal7IOSrkRp5rplZxz4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030582; c=relaxed/simple;
	bh=//juTrReR5RY2EXL4SOSTJ2NFApUk9waFhwjwwTnX5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiCFs40V5oV1gga0pcJeAcfLevah7RaYOBtUEs0kUi3Sx8i0U5cYKvY7BeEff6HCdCinR9osVFg7a/3Ibk2mvEg/IExX9zi08ExKghqWe8hc6XSq7ICaZB6hbwtBPy1XBQI7YtcQEdy9ZyOLdKJnNkbMn8c2Y4VW/a2+3TVLYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9NxGyMv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gaKqKMKlmwETWNmgCjaiOWIlMUIKbL1+CgbCwZ0tnA=;
	b=B9NxGyMvPu5laG8kmc8nos1ko2+aOBw54wa1PDN+1NFaMku1IBdJ19hGgziMZnWPrjbtut
	6w6JFsX/tlWEuJcZU+6O9ufmRiB626TljiqZmsZicbTLwn5Vt/QqgaByiT5xNYP8/JwAUj
	vrl64a6+pO79TMBzWhBuGyYe+6zj9Mw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-9WS2Ju2dPyC3J89ZBnjLFA-1; Tue,
 19 Nov 2024 10:36:15 -0500
X-MC-Unique: 9WS2Ju2dPyC3J89ZBnjLFA-1
X-Mimecast-MFC-AGG-ID: 9WS2Ju2dPyC3J89ZBnjLFA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A8FD1955F2B;
	Tue, 19 Nov 2024 15:36:07 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70AC63003C80;
	Tue, 19 Nov 2024 15:35:51 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [RFC PATCH v3 01/15] objtool: Make validate_call() recognize indirect calls to pv_ops[]
Date: Tue, 19 Nov 2024 16:34:48 +0100
Message-ID: <20241119153502.41361-2-vschneid@redhat.com>
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

call_dest_name() does not get passed the file pointer of validate_call(),
which means its invocation of insn_reloc() will always return NULL. Make it
take a file pointer.

While at it, make sure call_dest_name() uses arch_dest_reloc_offset(),
otherwise it gets the pv_ops[] offset wrong.

Fabricating an intentional warning shows the change; previously:

  vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to {dynamic}() leaves .noinstr.text section

now:

  vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to pv_ops[1]() leaves .noinstr.text section

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/objtool/check.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6604f5d038aad..5f1d0f95fc04b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3448,7 +3448,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
 	return false;
 }
 
-static inline const char *call_dest_name(struct instruction *insn)
+static inline const char *call_dest_name(struct objtool_file *file, struct instruction *insn)
 {
 	static char pvname[19];
 	struct reloc *reloc;
@@ -3457,9 +3457,9 @@ static inline const char *call_dest_name(struct instruction *insn)
 	if (insn_call_dest(insn))
 		return insn_call_dest(insn)->name;
 
-	reloc = insn_reloc(NULL, insn);
+	reloc = insn_reloc(file, insn);
 	if (reloc && !strcmp(reloc->sym->name, "pv_ops")) {
-		idx = (reloc_addend(reloc) / sizeof(void *));
+		idx = (arch_dest_reloc_offset(reloc_addend(reloc)) / sizeof(void *));
 		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
 		return pvname;
 	}
@@ -3538,17 +3538,20 @@ static int validate_call(struct objtool_file *file,
 {
 	if (state->noinstr && state->instr <= 0 &&
 	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
-		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
+		WARN_INSN(insn, "call to %s() leaves .noinstr.text section",
+			  call_dest_name(file, insn));
 		return 1;
 	}
 
 	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
-		WARN_INSN(insn, "call to %s() with UACCESS enabled", call_dest_name(insn));
+		WARN_INSN(insn, "call to %s() with UACCESS enabled",
+			  call_dest_name(file, insn));
 		return 1;
 	}
 
 	if (state->df) {
-		WARN_INSN(insn, "call to %s() with DF set", call_dest_name(insn));
+		WARN_INSN(insn, "call to %s() with DF set",
+			  call_dest_name(file, insn));
 		return 1;
 	}
 
-- 
2.43.0


