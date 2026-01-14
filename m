Return-Path: <linux-kselftest+bounces-48983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B91D21874
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F72F30879BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5863B8BB8;
	Wed, 14 Jan 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erf8d9oF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C63B530D
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428844; cv=none; b=LnLM2SJyykTuoJ1HJ6ViCbOQzFgRiSZOEH6kJg//A5XuFKt4gknphI44xDonW35AP2o7T3+x6QWPcTdFwgBDClziNJdPMIepRrP3EuFlHDK8Q0uaGien2ukT0gVR4svTDdtX3YVmXR4nJHWt42q2M3ETUMDN20CWTiIjLtxot5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428844; c=relaxed/simple;
	bh=Frl8g7gPNJZnVuF1cortnAJ5yPmXpbnchhHZccoy5S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTwrrSByI5xUOkMbdzj6C/FaUgDLQHJJTci1P1qgq4B+H0LyQIYyB6iBGFYFIjTilcRavTIbSPNxygzt+en3aHmTAYj1ikyF1iDjsf2tSGKMzREPgaaKin0Ix2TL17RT2iazsSnNlpoZiNTvlEKpEg41fk1wt1BHGHaNrZTubEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erf8d9oF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c52c67f64cso32083585a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428825; x=1769033625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gG/T9PvlN7aaWKP3v8uvJnzLqAaoC9Sf8EP4s01LO0=;
        b=Erf8d9oFtq6hQp6TsprMFlAAV1Rp4tW/kqQykHoOoyI5xunoLIPFIqPXZ5i3ILFtBF
         q5Gt+QRNqs29RFYUr0kvQcqHbiu4nw/umjhIKNk2V1a4/BdQ0xTuJ6XCA3e/91vpahVS
         gOLh0PvCdJoJPoKf4MAR8nvca9eV63Ca46gGxNq7Sln3dpNI87bBKR3roy8NlhHKtjog
         rLxMyNXLoCKq+7c8UCh1nzANmsqiuL36JNqEv9LTfL6BM5vQiCQpIhLeneaLZD5p3Aks
         1L/ainQw23HM3nVDwVfPw0Qmo92Om/EmrvViLBWt2Bv0FDwStI81fA47g/giKbJHbOEx
         pKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428825; x=1769033625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gG/T9PvlN7aaWKP3v8uvJnzLqAaoC9Sf8EP4s01LO0=;
        b=poze9FXpSBciQXF5FrHTB3Wj4ZYZhmg+UqV0+7Yig3EI/dLce4gI/aBfzfmxbx/qjK
         Wgj6ZS2MoJhsUQMm/ek6ZW8RB9XK6ZL3yaTFv88q4zrn7itCAh6VDJqyegPshQTrPgBR
         itSKZXML/TcLo3fyU+GBIfUl9d+wOS+FCSmeL/EMyoRU6OTiXfFI6raxJS/fY4cRJVGK
         GKKe1y7OqkpbJDjDgGI6hBXDVcepqyOxtBEfScMKYEnhFGJU8HbSLSAS87P80vlFMwv9
         A43FCWDuyNkcvTjeX5DNKCgkD7EgYlc/xhHeYUV+fNEmWrzA+NJut4Ls0/JBZAZJagtG
         s65w==
X-Forwarded-Encrypted: i=1; AJvYcCXm/h4GJ0pPftmXgVFYM2ExYkH9ao8fCnKfOY/MkFvT2kqOvJIHfXSMsQi+mPMBKtcuD0yYLn7tBMcZDuZdSgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/022DTLDwHW4Wt/PeVGYJOZWVIMiEStImOffDqeLmzPXgNqB
	vFQXyKmBDIpbPzwNBqxq41eQvbuxIRcoxsvIlvUEyNX5dXE2jRsgnS5g
X-Gm-Gg: AY/fxX63E9Ay6U7VlhP4T688+dCRG9D92zM++FcWVQGoSzC1QQPIr6ajj7tXjpmKacm
	lsb8U6q6p5eGttK1LeJEnsQ2wQc7QOQ0pZS45q+EmvZAm1927BU2bpSf+Cyq1PmZxuMoMatuGjw
	LAGEisBxslDKBpG83pdo3goP27Iq9Age1JYwvh3HNPdePPIGJXIx4rkpYimjgoZ/3kacOrgw/5M
	8fBCGw8yCZFduTDK1rWeIg1JZkwna3LVfaR31+tJ/ZijO5XRX4apUtHPLGZsoQV6+tsKj60dDqI
	9E+ZXqo6qe+83nBL8EJTWtQ0193rK7S4jFV7wfZiL3q/Dgzixm72Vf/14/OtxDazUQ41L0MqJ7n
	0LIhXypHqGQogwzjvX1otuSvntI140SDcHVFnzWNr/0ddNUwjDAN10477dsdNBzjVI7q12ZjlhC
	rw/C5s8q+ZNzWoeA/jg0+GNdcgVUSoFeDC+a8iUTqVF1H34hYW/CGkH9qxHVLFpFlNxJoSYbI=
X-Received: by 2002:a05:620a:708a:b0:8b5:222d:ce3b with SMTP id af79cd13be357-8c52fbdce95mr670335885a.52.1768428825363;
        Wed, 14 Jan 2026 14:13:45 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:44 -0800 (PST)
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
Subject: [PATCH v5 1/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Wed, 14 Jan 2026 17:13:38 -0500
Message-ID: <20260114221341.128038-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
 <20260114221341.128038-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 kernel/trace/trace.c        |  4 +--
 kernel/trace/trace_fprobe.c | 49 ++++++++++++++++++++-----------------
 kernel/trace/trace_probe.h  |  2 ++
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 10cdcc7b194e..73b59d47dfe7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5578,8 +5578,8 @@ static const char readme_msg[] =
 	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
 #endif
 #ifdef CONFIG_FPROBE_EVENTS
-	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
-	"\t		(single symbols still accept %return)\n"
+	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
+	"\t	      f[:[<group>/][<event>]] <func-list>[:entry|:exit] [<args>]\n" 
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
 #ifdef CONFIG_HIST_TRIGGERS
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 5a2a41eea603..1663c341ddb4 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -187,16 +187,23 @@ DEFINE_FREE(tuser_put, struct tracepoint_user *,
  */
 struct trace_fprobe {
 	struct dyn_event	devent;
-	char			*filter;
+
 	struct fprobe		fp;
-	bool			list_mode;
-	char			*nofilter;
 	const char		*symbol;
-	struct trace_probe	tp;
+	char			*filter;
+	char			*nofilter;
+
 	bool			tprobe;
 	struct tracepoint_user	*tuser;
+
+	struct trace_probe tp;
 };
 
+static inline bool trace_fprobe_has_list(const struct trace_fprobe *tf)
+{
+	return tf->filter || tf->nofilter;
+}
+
 static bool is_trace_fprobe(struct dyn_event *ev)
 {
 	return ev->ops == &trace_fprobe_ops;
@@ -847,7 +854,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	 * - list_mode: pass filter/nofilter
 	 * - single: pass symbol only (legacy)
 	 */
-	if (tf->list_mode)
+	if (trace_fprobe_has_list(tf))
 		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
 }
@@ -1188,11 +1195,18 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
 	*base = NULL; *filter = NULL; *nofilter = NULL;
 	*is_return = false; *list_mode = false;
 
-	if (is_tracepoint) {
+	if (is_tracepoint) 
+	{
 		if (strchr(in, ',') || strchr(in, ':'))
+		{
+			trace_probe_log_err(0, BAD_TP_NAME);
 			return -EINVAL;
+		}
 		if (strstr(in, "%return"))
+		{
+			trace_probe_log_err(p - in, BAD_TP_NAME);
 			return -EINVAL;
+		}
 		for (p = in; *p; p++)
 			if (!isalnum(*p) && *p != '_')
 				return -EINVAL;
@@ -1225,6 +1239,7 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
 			} else if (!strcmp(p, ":entry")) {
 				*(char *)p = '\0';
 			} else {
+				trace_probe_log_err(p - work, BAD_LIST_SUFFIX);
 				return -EINVAL;
 			}
 		}
@@ -1233,6 +1248,7 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
 	list = !!strchr(work, ',');
 	
 	if (list && legacy_ret) {
+		trace_probe_log_err(p - work, BAD_LEGACY_RET);
 		return -EINVAL;
 	}
 
@@ -1245,12 +1261,9 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
 
 	if (list) {
 		char *tmp = b, *tok;
-		size_t fsz, nfsz;
 
-		fsz = nfsz = strlen(b) + 1;
-
-		f = kzalloc(fsz, GFP_KERNEL);
-		nf = kzalloc(nfsz, GFP_KERNEL);
+		f = kzalloc(strlen(b) + 1, GFP_KERNEL);
+		nf = kzalloc(strlen(b) + 1, GFP_KERNEL);
 		if (!f || !nf)
 			return -ENOMEM;
 
@@ -1261,6 +1274,7 @@ static int parse_fprobe_spec(const char *in, bool is_tracepoint,
 			if (*tok == '\0') {
 				trace_probe_log_err(tmp - b - 1, BAD_TP_NAME);
 				return -EINVAL;
+			}
 
 			if (neg)
 				tok++;
@@ -1455,17 +1469,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 
 	/* carry list parsing result into tf */
 	if (!is_tracepoint) {
-		tf->list_mode = list_mode;
-		if (parsed_filter) {
-			tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
-			if (!tf->filter)
-				return -ENOMEM;
-		}
-		if (parsed_nofilter) {
-			tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
-			if (!tf->nofilter)
-				return -ENOMEM;
-		}
+		tf->filter = no_free_ptr(parsed_filter);
+		tf->nofilter = no_free_ptr(parsed_nofilter);
 	}
 
 	/* parse arguments */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9fc56c937130..b8b0544eb7cd 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -494,9 +494,11 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
 	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
+	C(BAD_LEGACY_RET,	"Legacy %return not allowed with list"), \
 	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
 	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
+	C(BAD_LIST_SUFFIX,	"Bad list suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\
 	C(BAD_GROUP_NAME,	"Group name must follow the same rules as C identifiers"), \
-- 
2.43.0


