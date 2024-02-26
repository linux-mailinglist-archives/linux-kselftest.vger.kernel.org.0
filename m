Return-Path: <linux-kselftest+bounces-5419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3E8668FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3C31F25361
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2131BC37;
	Mon, 26 Feb 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3ZzynE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D616419;
	Mon, 26 Feb 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919898; cv=none; b=mBf3a4FxZ3Qb2D1Jio79HNzT9on5vDxF/wuFQX+N4re+B2Sf53VoaDkixkMcSy6Xn34XYeBhJHQ6XTuk5naLTEIBQljnjYZmwLn/3o8G+wuRDI+L8ekhuOLMRxAu1jrqNOCNVhD6fqynjIm8+BAT0d0tJANSdMJ3tFne7lenWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919898; c=relaxed/simple;
	bh=yieHy5vPyZ9GKnhIfdK7wI+syqv8Xn4pjv7kN2Wdqk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nq1SKm6nNltKpTIrMoiXyWeZWOaJ3P+RbnBgEh3ALOt/Rz7ek4x83q6kX+jhxF0ygFtZVoMli3iCIyt4EILKFQGB3xKMm0MT5V3XtzDgZM6m2p9XHizVQonCLoxIDyaeUWn8vPKZbHrev+0fCptiMiJ0IkDSVnPomJlHVCXxPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3ZzynE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E842C433F1;
	Mon, 26 Feb 2024 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708919898;
	bh=yieHy5vPyZ9GKnhIfdK7wI+syqv8Xn4pjv7kN2Wdqk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3ZzynE+v7LpBzCgMWZPcw0UDhWswpioBb4Sc4MMVrT/cTBhCJ39K5UMoLxFYW6rq
	 Lq3aQxX/c3V1k1Ic7/J7vpBzm2jUUgTCol215wK7nq/5JlWNOoclyfL15PQPyUM6dB
	 80pVMe6OEdGZ9BvyK8zxfnP8JySCEsmn9BxeWLDLL5uv1VlO49kerQ4Hur2qD+QeY3
	 HfKU+dE16DFIiHFTcIFlHFGc1yEqkwa78ZV9OlAcgZHOEIjJQKDVlOWeOCOitu5art
	 9Mj6+BU9admaFDa865FDsP8DS1mXr5w+bVb5YwPWJF+fM0qeImQDmHn/mT5TAK3/1x
	 rqDhJ/DslWTXg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/7] tracing/probes: Cleanup probe argument parser
Date: Mon, 26 Feb 2024 12:58:13 +0900
Message-Id: <170891989362.609861.10050404696043440555.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170891987362.609861.6767830614537418260.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Cleanup traceprobe_parse_probe_arg_body() to split out the
type parser and post-processing part of fetch_insn.
This makes no functional change.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |  230 ++++++++++++++++++++++++++------------------
 1 file changed, 137 insertions(+), 93 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 34289f9c6707..67a0b9cbb648 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1090,67 +1090,45 @@ static int __parse_bitfield_probe_arg(const char *bf,
 	return (BYTES_TO_BITS(t->size) < (bw + bo)) ? -EINVAL : 0;
 }
 
-/* String length checking wrapper */
-static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
-					   struct probe_arg *parg,
-					   struct traceprobe_parse_context *ctx)
+/* Split type part from @arg and return it. */
+static char *parse_probe_arg_type(char *arg, struct probe_arg *parg,
+				  struct traceprobe_parse_context *ctx)
 {
-	struct fetch_insn *code, *scode, *tmp = NULL;
-	char *t, *t2, *t3;
-	int ret, len;
-	char *arg;
+	char *t = NULL, *t2, *t3;
+	int offs;
 
-	arg = kstrdup(argv, GFP_KERNEL);
-	if (!arg)
-		return -ENOMEM;
-
-	ret = -EINVAL;
-	len = strlen(arg);
-	if (len > MAX_ARGSTR_LEN) {
-		trace_probe_log_err(ctx->offset, ARG_TOO_LONG);
-		goto out;
-	} else if (len == 0) {
-		trace_probe_log_err(ctx->offset, NO_ARG_BODY);
-		goto out;
-	}
-
-	ret = -ENOMEM;
-	parg->comm = kstrdup(arg, GFP_KERNEL);
-	if (!parg->comm)
-		goto out;
-
-	ret = -EINVAL;
 	t = strchr(arg, ':');
 	if (t) {
-		*t = '\0';
-		t2 = strchr(++t, '[');
+		*t++ = '\0';
+		t2 = strchr(t, '[');
 		if (t2) {
 			*t2++ = '\0';
 			t3 = strchr(t2, ']');
 			if (!t3) {
-				int offs = t2 + strlen(t2) - arg;
+				offs = t2 + strlen(t2) - arg;
 
 				trace_probe_log_err(ctx->offset + offs,
 						    ARRAY_NO_CLOSE);
-				goto out;
+				return ERR_PTR(-EINVAL);
 			} else if (t3[1] != '\0') {
 				trace_probe_log_err(ctx->offset + t3 + 1 - arg,
 						    BAD_ARRAY_SUFFIX);
-				goto out;
+				return ERR_PTR(-EINVAL);
 			}
 			*t3 = '\0';
 			if (kstrtouint(t2, 0, &parg->count) || !parg->count) {
 				trace_probe_log_err(ctx->offset + t2 - arg,
 						    BAD_ARRAY_NUM);
-				goto out;
+				return ERR_PTR(-EINVAL);
 			}
 			if (parg->count > MAX_ARRAY_LEN) {
 				trace_probe_log_err(ctx->offset + t2 - arg,
 						    ARRAY_TOO_BIG);
-				goto out;
+				return ERR_PTR(-EINVAL);
 			}
 		}
 	}
+	offs = t ? t - arg : 0;
 
 	/*
 	 * Since $comm and immediate string can not be dereferenced,
@@ -1161,74 +1139,52 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	     strncmp(arg, "\\\"", 2) == 0)) {
 		/* The type of $comm must be "string", and not an array type. */
 		if (parg->count || (t && strcmp(t, "string"))) {
-			trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
-					NEED_STRING_TYPE);
-			goto out;
+			trace_probe_log_err(ctx->offset + offs, NEED_STRING_TYPE);
+			return ERR_PTR(-EINVAL);
 		}
 		parg->type = find_fetch_type("string", ctx->flags);
 	} else
 		parg->type = find_fetch_type(t, ctx->flags);
+
 	if (!parg->type) {
-		trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0), BAD_TYPE);
-		goto out;
+		trace_probe_log_err(ctx->offset + offs, BAD_TYPE);
+		return ERR_PTR(-EINVAL);
 	}
 
-	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
-	if (!code)
-		goto out;
-	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
-
-	ctx->last_type = NULL;
-	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
-			      ctx);
-	if (ret)
-		goto fail;
-
-	/* Update storing type if BTF is available */
-	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
-	    ctx->last_type) {
-		if (!t) {
-			parg->type = find_fetch_type_from_btf_type(ctx);
-		} else if (strstr(t, "string")) {
-			ret = check_prepare_btf_string_fetch(t, &code, ctx);
-			if (ret)
-				goto fail;
-		}
-	}
-	parg->offset = *size;
-	*size += parg->type->size * (parg->count ?: 1);
+	return t;
+}
 
-	if (parg->count) {
-		len = strlen(parg->type->fmttype) + 6;
-		parg->fmt = kmalloc(len, GFP_KERNEL);
-		if (!parg->fmt) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
-			 parg->count);
-	}
+/* After parsing, adjust the fetch_insn according to the probe_arg */
+static int finalize_fetch_insn(struct fetch_insn *code,
+			       struct probe_arg *parg,
+			       char *type,
+			       int type_offset,
+			       struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *scode;
+	int ret;
 
-	ret = -EINVAL;
 	/* Store operation */
 	if (parg->type->is_string) {
+		/* Check bad combination of the type and the last fetch_insn. */
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
 			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
-				trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
+				trace_probe_log_err(ctx->offset + type_offset,
 						    BAD_SYMSTRING);
-				goto fail;
+				return -EINVAL;
 			}
 		} else {
 			if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
 			    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
 			    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
-				trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
+				trace_probe_log_err(ctx->offset + type_offset,
 						    BAD_STRING);
-				goto fail;
+				return -EINVAL;
 			}
 		}
+
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
@@ -1244,9 +1200,10 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
-				goto fail;
+				return -EINVAL;
 			}
 		}
+
 		/* If op == DEREF, replace it with STRING */
 		if (!strcmp(parg->type->name, "ustring") ||
 		    code->op == FETCH_OP_UDEREF)
@@ -1267,47 +1224,134 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		code++;
 		if (code->op != FETCH_OP_NOP) {
 			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
-			goto fail;
+			return -E2BIG;
 		}
 		code->op = FETCH_OP_ST_RAW;
 		code->size = parg->type->size;
 	}
+
+	/* Save storing fetch_insn. */
 	scode = code;
+
 	/* Modify operation */
-	if (t != NULL) {
-		ret = __parse_bitfield_probe_arg(t, parg->type, &code);
+	if (type != NULL) {
+		/* Bitfield needs a special fetch_insn. */
+		ret = __parse_bitfield_probe_arg(type, parg->type, &code);
 		if (ret) {
-			trace_probe_log_err(ctx->offset + t - arg, BAD_BITFIELD);
-			goto fail;
+			trace_probe_log_err(ctx->offset + type_offset, BAD_BITFIELD);
+			return ret;
 		}
 	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 		   ctx->last_type) {
+		/* If user not specified the type, try parsing BTF bitfield. */
 		ret = parse_btf_bitfield(&code, ctx);
 		if (ret)
-			goto fail;
+			return ret;
 	}
-	ret = -EINVAL;
+
 	/* Loop(Array) operation */
 	if (parg->count) {
 		if (scode->op != FETCH_OP_ST_MEM &&
 		    scode->op != FETCH_OP_ST_STRING &&
 		    scode->op != FETCH_OP_ST_USTRING) {
-			trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
-					    BAD_STRING);
-			goto fail;
+			trace_probe_log_err(ctx->offset + type_offset, BAD_STRING);
+			return -EINVAL;
 		}
 		code++;
 		if (code->op != FETCH_OP_NOP) {
 			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
-			goto fail;
+			return -E2BIG;
 		}
 		code->op = FETCH_OP_LP_ARRAY;
 		code->param = parg->count;
 	}
+
+	/* Finalize the fetch_insn array. */
 	code++;
 	code->op = FETCH_OP_END;
 
-	ret = 0;
+	return 0;
+}
+
+/* String length checking wrapper */
+static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
+					   struct probe_arg *parg,
+					   struct traceprobe_parse_context *ctx)
+{
+	struct fetch_insn *code, *tmp = NULL;
+	char *type, *arg;
+	int ret, len;
+
+	len = strlen(argv);
+	if (len > MAX_ARGSTR_LEN) {
+		trace_probe_log_err(ctx->offset, ARG_TOO_LONG);
+		return -E2BIG;
+	} else if (len == 0) {
+		trace_probe_log_err(ctx->offset, NO_ARG_BODY);
+		return -EINVAL;
+	}
+
+	arg = kstrdup(argv, GFP_KERNEL);
+	if (!arg)
+		return -ENOMEM;
+
+	parg->comm = kstrdup(arg, GFP_KERNEL);
+	if (!parg->comm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	type = parse_probe_arg_type(arg, parg, ctx);
+	if (IS_ERR(type)) {
+		ret = PTR_ERR(type);
+		goto out;
+	}
+
+	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
+	if (!code) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
+
+	ctx->last_type = NULL;
+	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
+			      ctx);
+	if (ret < 0)
+		goto fail;
+
+	/* Update storing type if BTF is available */
+	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
+	    ctx->last_type) {
+		if (!type) {
+			parg->type = find_fetch_type_from_btf_type(ctx);
+		} else if (strstr(type, "string")) {
+			ret = check_prepare_btf_string_fetch(type, &code, ctx);
+			if (ret)
+				goto fail;
+		}
+	}
+	parg->offset = *size;
+	*size += parg->type->size * (parg->count ?: 1);
+
+	if (parg->count) {
+		len = strlen(parg->type->fmttype) + 6;
+		parg->fmt = kmalloc(len, GFP_KERNEL);
+		if (!parg->fmt) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
+			 parg->count);
+	}
+
+	ret = finalize_fetch_insn(code, parg, type, type ? type - arg : 0, ctx);
+	if (ret < 0)
+		goto fail;
+
+	for (; code < tmp + FETCH_INSN_MAX; code++)
+		if (code->op == FETCH_OP_END)
+			break;
 	/* Shrink down the code buffer */
 	parg->code = kcalloc(code - tmp + 1, sizeof(*code), GFP_KERNEL);
 	if (!parg->code)
@@ -1316,7 +1360,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		memcpy(parg->code, tmp, sizeof(*code) * (code - tmp + 1));
 
 fail:
-	if (ret) {
+	if (ret < 0) {
 		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
 			if (code->op == FETCH_NOP_SYMBOL ||
 			    code->op == FETCH_OP_DATA)


