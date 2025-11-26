Return-Path: <linux-kselftest+bounces-46539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF073C8B768
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C864E166C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19833C519;
	Wed, 26 Nov 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH/uuZpj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BC31B818
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182497; cv=none; b=M8eg6XOe2I4snFsFCmczMqVIqxB8vYM7Q8qNgK1kiOcYRQv6CXtQbHJSgNNodRrwA8KGD2XySF5o4QbUP8A9O312JlmutfCD5Rd4I5pZj70YJLOqslZQ6sg04FdIl0Tjd/YthPwELhKj4uwbHPSyKH0O3+xmCmGGZwAvxc2N+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182497; c=relaxed/simple;
	bh=jRr1vA2VhcAB7e6x+d+1Ejo2gBsTf4wkgPnm+WVpHKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWHp+5q5dkrq3nVNTuHK6n9mU74yxULIhaSHvAMR5TQwNBZadoymlXqmmTCuc2ZNdG0+uTYDKABNFukQcz2l7pg52y1NKYzcognx59eH9Yosnp5+8+7csQwRas4R4e0Tcu+HcNhrawdVXqX1o3ov5pn/lxnY8oqKRDA/IjLTraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH/uuZpj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-882475d8851so490646d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182494; x=1764787294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5AIJTSliCzft/R4MKMCKOoevolVdyRiQwHIZI0IpKk=;
        b=bH/uuZpjAyxYxNrlyozGu/vpiGn9Kb8mHvFW61dGx5LBxkd+ouBU28Ft9qWgHaHayp
         ZexdVzp3O9pY+FQGj9spKxtJZftEvGzwsJRSnkFP4BQmnlyYNyQtop6wnNNRd9bv+Pq3
         anarp6dkCdjp9EteP1wK/48Ytu7agJY3oSpgiXm5VylKZ7OMZj/TSQohQb+7CdW4szm7
         5xNyeto1aDh7z8T+rcTibMsJq4jvTSRkkbzkZfOPN3Rd4WCeBMxCDADjba2AHAwCdukk
         4y4SgSNrIcN1xRvMntOtj7PPLCTBmaQhlVVF98qNmkh/2x7lo0R6VmZWKhNAGcZvboDC
         IP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182494; x=1764787294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5AIJTSliCzft/R4MKMCKOoevolVdyRiQwHIZI0IpKk=;
        b=gFz6dHiJ+Gdf6UgOYbDkJGV4+vc0HjYZwu+ikj1bZ7RjF9h4ZtCb2jCxRANWL1NDOW
         OEDUDtRQJalnndiDsq3WQFtbnicroqGyYjExy6itvH2xZNr5daMTos7lDo/793nNgJlE
         vnQCYufNCMngSRGc83wJY0Zi/qjF6daNrq1GWa99s9vOyarq+BJhWcHKSWo/R2ae1dfL
         W4UsRZ3s+deCYDlBd/Q2DqATx6IFtR6FG14VO/XvvMBtOVtLYekGsjuuLXkb8pjgTBPL
         tHIJSVkSkxjosnmiJBjW12LkdTbDPZTLNUPxLBWCop9DrTH66NHzlm7xtOya9npk1ZeF
         FFVA==
X-Forwarded-Encrypted: i=1; AJvYcCVtTENaB0ErRGc9rjN+tIz4DMMYCXkrq0UXg44xB4s5e+T5P2SuKQIlWyxEMAON5xTItIARpSavaxaI+1rds/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkW8PeaatPHdUw70kiEnEKlyWtyknIj4zGUAQkFpCgcDxJCQZI
	TqQwt93jRZ26Lc2eQ2bZQHkYcLCn7a6214g6fiTXr6P28yVcU12gu6sQQEZcXgj4tbg=
X-Gm-Gg: ASbGncvOo8BMPdTFVuSyzGifwgMBa19FQZTUoqQgiYqDhVf1ZITeHfU0aeKYfk2lND4
	mq/jsC9Thg8XDLdWHPnFTvlBnN8EJwPJiNz2AEhudQsv8IhakqV+ICTa8q2UduJ95tnUFbDgN3R
	4YOkvM2zbYvBszFFfMr7jv9gAZUnDMMkO+uHjmMt0h+b77OEXIVKcPbv6p4Ev9f7SiGu1O4ajTv
	m+BI60I4Kd0+UcTnjqIP4m+y8OZoVMXLU091mLa1iF1snK+5HEpoKTuF9aen3+UKICEa89Dl9VW
	+H8/IFVdYabJc4lqJvL3Whu+q5jJ49ddHtL6FfFBD6sqGxJRhdHg6kWbU+yJVu3Rm2o9i7LNoSZ
	Jd0TFW4Ldw7POL9K1m2I4b38nSjRTWX9fJAq2nQJj74kok47LA5YUba5H7xhRNBTJ6tZLkwyprL
	UZIX+vi19IYFdQHw+6a2ggyjzd2Bt5QKAM0+x+c28iGqGETFVQQgTFrKIQPyuhkHT32E9ED3me
X-Google-Smtp-Source: AGHT+IHKOZzQGfkvDelDc1zjct1s7HRIYV1rQIM2VrRA7sLEUXmzMgwCEl/SerYIvu5apAHiLVU4xg==
X-Received: by 2002:a05:6214:768:b0:880:5279:98eb with SMTP id 6a1803df08f44-8847c5120ecmr280275526d6.44.1764182494055;
        Wed, 26 Nov 2025 10:41:34 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:33 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v4 2/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Wed, 26 Nov 2025 13:41:09 -0500
Message-ID: <20251126184110.72241-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Update DEFINE_FREE to use standard __free()
- Extend fprobe to support multiple symbols per event. Add parsing logic for
  lists, ! exclusions, and explicit suffixes. Update tracefs/README to reflect
  the new syntax

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c        |   3 +-
 kernel/trace/trace_fprobe.c | 209 +++++++++++++++++++++++++++---------
 2 files changed, 163 insertions(+), 49 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1e527cf2aae..e0b77268a702 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5518,7 +5518,8 @@ static const char readme_msg[] =
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
-	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
+	"\t		(single symbols still accept %return)\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 8001dbf16891..6307d7d7dd9c 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -187,11 +187,14 @@ DEFINE_FREE(tuser_put, struct tracepoint_user *,
  */
 struct trace_fprobe {
 	struct dyn_event	devent;
+	char			*filter;
 	struct fprobe		fp;
+	bool			list_mode;
+	char			*nofilter;
 	const char		*symbol;
+	struct trace_probe	tp;
 	bool			tprobe;
 	struct tracepoint_user	*tuser;
-	struct trace_probe	tp;
 };
 
 static bool is_trace_fprobe(struct dyn_event *ev)
@@ -559,6 +562,8 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
 		trace_probe_cleanup(&tf->tp);
 		if (tf->tuser)
 			tracepoint_user_put(tf->tuser);
+		kfree(tf->filter);
+		kfree(tf->nofilter);
 		kfree(tf->symbol);
 		kfree(tf);
 	}
@@ -838,7 +843,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_tracepoint(tf))
 		return __regsiter_tracepoint_fprobe(tf);
 
-	/* TODO: handle filter, nofilter or symbol list */
+	/* Registration path:
+	 * - list_mode: pass filter/nofilter
+	 * - single: pass symbol only (legacy)
+	 */
+	if (tf->list_mode)
+		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
 }
 
@@ -1154,60 +1164,119 @@ static struct notifier_block tprobe_event_module_nb = {
 };
 #endif /* CONFIG_MODULES */
 
-static int parse_symbol_and_return(int argc, const char *argv[],
-				   char **symbol, bool *is_return,
-				   bool is_tracepoint)
+static bool has_wildcard(const char *s)
 {
-	char *tmp = strchr(argv[1], '%');
-	int i;
+	return s && (strchr(s, '*') || strchr(s, '?'));
+}
 
-	if (tmp) {
-		int len = tmp - argv[1];
+static int parse_fprobe_spec(const char *in, bool is_tracepoint,
+		char **base, bool *is_return, bool *list_mode,
+		char **filter, char **nofilter)
+{
+	char *work __free(kfree) = NULL;
+	char *b __free(kfree) = NULL;
+	char *f __free(kfree) = NULL;
+	char *nf __free(kfree) = NULL;
+	bool legacy_ret = false;
+	bool list = false;
+	const char *p;
+	int ret = 0;
 
-		if (!is_tracepoint && !strcmp(tmp, "%return")) {
-			*is_return = true;
-		} else {
-			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
-			return -EINVAL;
-		}
-		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
-	} else
-		*symbol = kstrdup(argv[1], GFP_KERNEL);
-	if (!*symbol)
-		return -ENOMEM;
+	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
+		return -EINVAL;
 
-	if (*is_return)
-		return 0;
+	*base = NULL; *filter = NULL; *nofilter = NULL;
+	*is_return = false; *list_mode = false;
 
 	if (is_tracepoint) {
-		tmp = *symbol;
-		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
-			tmp++;
-		if (*tmp) {
-			/* find a wrong character. */
-			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
-			kfree(*symbol);
-			*symbol = NULL;
+		if (strchr(in, ',') || strchr(in, ':'))
 			return -EINVAL;
-		}
+		if (strstr(in, "%return"))
+			return -EINVAL;
+		for (p = in; *p; p++)
+			if (!isalnum(*p) && *p != '_')
+				return -EINVAL;
+		b = kstrdup(in, GFP_KERNEL);
+		if (!b)
+			return -ENOMEM;
+		*base = no_free_ptr(b);
+		return 0;
 	}
 
-	/* If there is $retval, this should be a return fprobe. */
-	for (i = 2; i < argc; i++) {
-		tmp = strstr(argv[i], "$retval");
-		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
-			if (is_tracepoint) {
-				trace_probe_log_set_index(i);
-				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
-				kfree(*symbol);
-				*symbol = NULL;
+	work = kstrdup(in, GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	p = strstr(work, "%return");
+	if (p && p[7] == '\0') {
+		*is_return = true;
+		legacy_ret = true;
+		*(char *)p = '\0';
+	} else {
+		/*
+		 * If "symbol:entry" or "symbol:exit" is given, it is new
+		 * style probe.
+		 */
+		p = strrchr(work, ':');
+		if (p) {
+			if (!strcmp(p, ":exit")) {
+				*is_return = true;
+				*(char *)p = '\0';
+			} else if (!strcmp(p, ":entry")) {
+				*(char *)p = '\0';
+			} else {
 				return -EINVAL;
 			}
-			*is_return = true;
-			break;
 		}
 	}
-	return 0;
+
+	list = !!strchr(work, ',');
+	
+	if (list && legacy_ret) {
+		return -EINVAL;
+	}
+
+	if (legacy_ret)
+		*is_return = true;
+
+	b = kstrdup(work, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	if (list) {
+		char *tmp = b, *tok;
+		size_t fsz, nfsz;
+
+		fsz = nfsz = strlen(b) + 1;
+
+		f = kzalloc(fsz, GFP_KERNEL);
+		nf = kzalloc(nfsz, GFP_KERNEL);
+		if (!f || !nf)
+			return -ENOMEM;
+
+		while ((tok = strsep(&tmp, ",")) != NULL) {
+			char *dst;
+			bool neg = (*tok == '!');
+
+			if (*tok == '\0') {
+				trace_probe_log_err(tmp - b - 1, BAD_TP_NAME);
+				return -EINVAL;
+
+			if (neg)
+				tok++;
+			dst = neg ? nf : f;
+			if (dst[0] != '\0')
+				strcat(dst, ",");
+			strcat(dst, tok);
+		}
+		*list_mode = true;
+	}
+
+	*base = no_free_ptr(b);
+	*filter = no_free_ptr(f);
+	*nofilter = no_free_ptr(nf);
+
+	return ret;
 }
 
 static int trace_fprobe_create_internal(int argc, const char *argv[],
@@ -1241,6 +1310,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	struct module *mod __free(module_put) = NULL;
 	const char **new_argv __free(kfree) = NULL;
+	char *parsed_nofilter __free(kfree) = NULL;
+	char *parsed_filter __free(kfree) = NULL;
 	char *symbol __free(kfree) = NULL;
 	char *ebuf __free(kfree) = NULL;
 	char *gbuf __free(kfree) = NULL;
@@ -1249,6 +1320,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	char *dbuf __free(kfree) = NULL;
 	int i, new_argc = 0, ret = 0;
 	bool is_tracepoint = false;
+	bool list_mode = false;
 	bool is_return = false;
 
 	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
@@ -1270,11 +1342,26 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	trace_probe_log_set_index(1);
 
-	/* a symbol(or tracepoint) must be specified */
-	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
+	/* Parse spec early (single vs list, suffix, base symbol) */
+	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
+			&list_mode, &parsed_filter, &parsed_nofilter);
 	if (ret < 0)
 		return -EINVAL;
 
+	for (i = 2; i < argc; i++) {
+		char *tmp = strstr(argv[i], "$retval");
+
+		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
+			if (is_tracepoint) {
+				trace_probe_log_set_index(i);
+				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				return -EINVAL;
+			}
+			is_return = true;
+			break;
+		}
+	}
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
@@ -1287,6 +1374,15 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	}
 
 	if (!event) {
+		/*
+		 * Event name rules:
+		 * - For list/wildcard: require explicit [GROUP/]EVENT
+		 * - For single literal: autogenerate symbol__entry/symbol__exit
+		 */
+		if (list_mode || has_wildcard(symbol)) {
+			trace_probe_log_err(0, NO_GROUP_NAME);
+			return -EINVAL;
+		}
 		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!ebuf)
 			return -ENOMEM;
@@ -1322,7 +1418,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 							NULL, NULL, NULL, sbuf);
 		}
 	}
-	if (!ctx->funcname)
+
+	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
 		ctx->funcname = symbol;
 
 	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
@@ -1356,6 +1453,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 	}
 
+	/* carry list parsing result into tf */
+	if (!is_tracepoint) {
+		tf->list_mode = list_mode;
+		if (parsed_filter) {
+			tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
+			if (!tf->filter)
+				return -ENOMEM;
+		}
+		if (parsed_nofilter) {
+			tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
+			if (!tf->nofilter)
+				return -ENOMEM;
+		}
+	}
+
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
@@ -1442,8 +1554,9 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
 				trace_probe_name(&tf->tp));
 
-	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
-			       trace_fprobe_is_return(tf) ? "%return" : "");
+	seq_printf(m, " %s", trace_fprobe_symbol(tf));
+	if (!trace_fprobe_is_tracepoint(tf) && trace_fprobe_is_return(tf))
+		seq_puts(m, ":exit");
 
 	for (i = 0; i < tf->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
-- 
2.43.0


