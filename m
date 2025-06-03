Return-Path: <linux-kselftest+bounces-34196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA82ACBF50
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 06:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F28169CB1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 04:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989DC1C7005;
	Tue,  3 Jun 2025 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ge0oo5IQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24282F42
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926105; cv=none; b=eFqB23NO3Ee3cry21Oc6kuPR5662+1vAXIO4pmYKMdWKRrrp4h3DrtzrFwM5FFIbdEOzk9JgAx+xIZCZRTu7QX7tabwRrMFKTA2VsBiu7WNHZdI1v+WLQ1akjp0Z8VLj2BYx4f2Zu6ba901yFA+RHhJZbTshEVhEP+Jj2Zs8CYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926105; c=relaxed/simple;
	bh=NllOIGpaByDvSmSbLrJYL5Gk4SUKoHcjdQDk9IHf0tc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YhkTyY/CtbsIM0eiYmn4JUMSL1bRZIVIGE/E/EPIDA2tYndQ/y7YNcXTsphwrTn844Vx1R0xZIDiWFgskNgVuzcogtdWEBVY3yWw9+bC/APldjxhvR+S1j8YVMk7S44qGIt45PMB5zSlgA5lrrP6gdDzLZnQjpe4BLcA+elmWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ge0oo5IQ; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2e8eaf0a2b1so4477015fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748926103; x=1749530903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NQovLzfFYqS8ULAAc1LRS+ATtBISGpWrZbU6Yt/MC+M=;
        b=Ge0oo5IQ4NsF64XNN9yobCOxWvoklaEit5OElhSuRH6UeUF7Tj/GSE8Drg4mCzkEfS
         58IRWMzosVlMHftEHeR8ksTesM/JmkrEWvKXfSXkRTgF5Q9flMvz+VUXiPbROpLnc1A6
         p2pnH4O1Lw9NhAWN/jADJKTX/EhffQ1dnQU9l64IERNaWKZ2XXCFQhbzmIIEo1WWcU2M
         yrmk9NlrIEtAxbz/z7RVrAjPM535DcrDVhPZtAJq9RTeaBvmCY645EAKPD5MCkExaOI4
         tQml00dU1d3+4lKalZWdVNVJZV4V/cuGeqk4Nmb5Cul6voS4fml0uTGF/RfoLre7Kqg1
         MaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926103; x=1749530903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQovLzfFYqS8ULAAc1LRS+ATtBISGpWrZbU6Yt/MC+M=;
        b=FKxbR7Mdppq4EPGkFCmiZxCbfWQni99DisfDw/9dxltIA6SmdOGCYsoTWPsEf2OTfK
         IZYNu8lCPQdI2xQBsnTLKKoCK2oQu27gbASQIS6BnIFZlu9V+ZNEF0yq/cbKopOrsdW1
         U5qeN0LgBCCe1GWA99EBA7HgbSsQoNXb+YKGt7iprwkmYjCCHqKo6dnHGSsDNMq9go+c
         zIRabMWYahYDJTNGm1t4QPSM1HILzaRwVsmchRafN+UdI1rUe5ZlH+OjIgsNJPKVOZfL
         yLHUvkkT7HFF7y5et7U8wTbkSz5Lynu8vdOU9UdfKMtgcAjOP7Z8OvORS7+1Jgca/3ZL
         a79Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp5cW6qiu6kwTDpRN7H4CusznGmO2O+PORUnZFk/pGDMEM9bckxU+i8oETkh9qVZ6/hzncoOWn22Qc/TD9TDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4XV8TVjQBiwZPM4NwJB8R5AGVItm0xdXIylTefPM3drPhQym
	sDnsVmwm+VFNLdzKdYKiURWBbw/X8cAALW+xgPY17hJOo6UDnoOAwFF5bmUQHQRVQAr/PxiRl2J
	pOon2E6jABttuQpIz3ur2LA==
X-Google-Smtp-Source: AGHT+IFIbl3uoV4l5J9b+gYBYAYxS0IF/Lwszpko4xEPrl37YlAgArfbXHX+mufmu2Lr7izvnMtwJQp1hAJW9Yhk
X-Received: from oabns6.prod.google.com ([2002:a05:6870:ac86:b0:2bc:6267:d082])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:7a11:b0:2d5:4f4:e24d with SMTP id 586e51a60fabf-2e92a11d025mr9741353fac.6.1748926102997;
 Mon, 02 Jun 2025 21:48:22 -0700 (PDT)
Date: Mon,  2 Jun 2025 21:48:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603044813.88265-1-blakejones@google.com>
Subject: [PATCH v2 1/2] libbpf: add support for printing BTF character arrays
 as strings
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

The BTF dumper code currently displays arrays of characters as just that -
arrays, with each character formatted individually. Sometimes this is what
makes sense, but it's nice to be able to treat that array as a string.

This change adds a special case to the btf_dump functionality to allow
arrays of single-byte integer values to be printed as character strings.
Characters for which isprint() returns false are printed as hex-escaped
values. This is enabled when the new ".emit_strings" is set to 1 in the
btf_dump_type_data_opts structure.

As an example, here's what it looks like to dump the string "hello" using
a few different field values for btf_dump_type_data_opts (.compact = 1):

- .emit_strings = 0, .skip_names = 0:  (char[6])['h','e','l','l','o',]
- .emit_strings = 0, .skip_names = 1:  ['h','e','l','l','o',]
- .emit_strings = 1, .skip_names = 0:  (char[6])"hello"
- .emit_strings = 1, .skip_names = 1:  "hello"

Here's the string "h\xff", dumped with .compact = 1 and .skip_names = 1:

- .emit_strings = 0:  ['h',-1,]
- .emit_strings = 1:  "h\xff"

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/lib/bpf/btf.h      |  3 ++-
 tools/lib/bpf/btf_dump.c | 44 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4392451d634b..ccfd905f03df 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
 	bool compact;		/* no newlines/indentation */
 	bool skip_names;	/* skip member/type names */
 	bool emit_zeroes;	/* show 0-valued fields */
+	bool emit_strings;	/* print char arrays as strings */
 	size_t :0;
 };
-#define btf_dump_type_data_opts__last_field emit_zeroes
+#define btf_dump_type_data_opts__last_field emit_strings
 
 LIBBPF_API int
 btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 460c3e57fadb..336a6646e0fa 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -68,6 +68,7 @@ struct btf_dump_data {
 	bool compact;
 	bool skip_names;
 	bool emit_zeroes;
+	bool emit_strings;
 	__u8 indent_lvl;	/* base indent level */
 	char indent_str[BTF_DATA_INDENT_STR_LEN];
 	/* below are used during iteration */
@@ -2028,6 +2029,43 @@ static int btf_dump_var_data(struct btf_dump *d,
 	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
 }
 
+static int btf_dump_string_data(struct btf_dump *d,
+				const struct btf_type *t,
+				__u32 id,
+				const void *data)
+{
+	const struct btf_array *array = btf_array(t);
+	__u32 i;
+
+	btf_dump_data_pfx(d);
+	btf_dump_printf(d, "\"");
+
+	for (i = 0; i < array->nelems; i++, data++) {
+		char c;
+
+		if (data >= d->typed_dump->data_end)
+			return -E2BIG;
+
+		c = *(char *)data;
+		if (c == '\0') {
+			/*
+			 * When printing character arrays as strings, NUL bytes
+			 * are always treated as string terminators; they are
+			 * never printed.
+			 */
+			break;
+		}
+		if (isprint(c))
+			btf_dump_printf(d, "%c", c);
+		else
+			btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
+	}
+
+	btf_dump_printf(d, "\"");
+
+	return 0;
+}
+
 static int btf_dump_array_data(struct btf_dump *d,
 			       const struct btf_type *t,
 			       __u32 id,
@@ -2055,8 +2093,11 @@ static int btf_dump_array_data(struct btf_dump *d,
 		 * char arrays, so if size is 1 and element is
 		 * printable as a char, we'll do that.
 		 */
-		if (elem_size == 1)
+		if (elem_size == 1) {
+			if (d->typed_dump->emit_strings)
+				return btf_dump_string_data(d, t, id, data);
 			d->typed_dump->is_array_char = true;
+		}
 	}
 
 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2544,6 +2585,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
+	d->typed_dump->emit_strings = OPTS_GET(opts, emit_strings, false);
 
 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
 
-- 
2.49.0.1204.g71687c7c1d-goog


