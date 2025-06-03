Return-Path: <linux-kselftest+bounces-34245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8EACCE45
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B71A1680FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA91F1534;
	Tue,  3 Jun 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU95+xpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4D1C7008
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983027; cv=none; b=A4WMroKgeFPGI5To2ETIzryKxhJ6QGVUlzUpkETAcGle3+WKWoKpkFk5frYbjCVu4ATElY9wvOPDEDb6WRVB15JmkjD7ZUAu4o/ch7uLwzwwzXEDFxYu/gw6Rx8jCtN4Rw+Mh8Y4ivTdzXyI9f6em08RlGFR2lWQYEnDGIIG12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983027; c=relaxed/simple;
	bh=LSq1Zrw56AumBFKq27Q5NW6xhBDdOAOLocWQdbH8OdU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ThQHQ3wHMTyegSHguvxVs/0I3uX0JpidMvynxOq42Q3GsFQtvBIZBb59NqKNHJwbbnyOUyzm73I3Puhx8EFf82FczMY3aWV8hxauyfjlys+Db2xneSg7vyTCBvpAuD5shcxlzwfuwuUrqG+wdbokVvT3cBZivv67qbgvjCfaBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU95+xpV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b115fb801bcso6442031a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748983025; x=1749587825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XdGvj1cQxUVbbNGXsRB77TGd4irMv8Darz4oql5Hxko=;
        b=KU95+xpVXTLnt6jSsv8yN4Ip3yLw5zlw1x9ZHbvjg8e5cX3wzC7/IXzC1uZgbRf7R5
         WQKMBKP+kbtqtfWD3boUJVnjPtLmsDufLVyVz1jj84yore32RXD0ijgftGdbTfzGFCzu
         WdebXOt2dbvXQDZJ1lLn60VJXyPAA/zhCVGSdLZiIKKk5a0tTmXfnkred/B4g8HjhHYv
         C7atf3UDyx6cDyzP/6x1KGPNpsmRrUbrQ5UO+vACijSOaNIjKxIYLlaLexhFveLkVu5V
         SXk3iHcdIsXt7rR4CvcArkHJ0YExbONf/tylxoPRC6wvBEEKSN1sVY+wVOca0RzOlsk5
         zfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983025; x=1749587825;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdGvj1cQxUVbbNGXsRB77TGd4irMv8Darz4oql5Hxko=;
        b=bAaZcMlFgO6JOyXPOSBaEFe3oWZvbR9SAKTHD0d0k2FODJtzZpe7rRutaw1c/b1Bp9
         aLOlwW4l/35KSICiSd6edDwZXbR4Fr98JBPc+ND7T51MiDnNGcBd4H8Io1ONHMegRo12
         YIl2G3xDbvtuhnj5OICfeLERigqeobKu6jhi6bHZiAZr7rrTQDlAmFf+p546cH1oAmCd
         vG7PZnOcuR4Wo3PaI1BGfndE4Jh/SIGNtWGode9GkbC7jj6dWuPDAd9Bl2z6jLTsOKXX
         0fczhEY9jm/VPI+SQzqUOSa/rAlHojF/a7/q+2yAU9GUzKGwk7M6n0ASHNdQ6iYTjFZV
         UG5g==
X-Forwarded-Encrypted: i=1; AJvYcCXmqrAPfAbfwpFprimkBSXDrhfvbzCTOA7jowNas9IiO1GcF2EGnjlQnflCZdRbsc/NWUdgz3hDh4gBBm6/w6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6N9uWq6qddqqYwiYBNzHWp/DtWsj0fuw/Ef7fVCMBydHqniMl
	KKDH30pkfemki6gUmXw7X52xoBjHdmFtnEHyYGBn0Yzsg7x6t3XepnO0R1FKD/cRe5u0SxEoRwI
	mNmzBR+aj8B7tHTWQ6/OhWQ==
X-Google-Smtp-Source: AGHT+IFyoZssdgw6mwyoLhuvjYZl1FJuwhdlS8z8jBpyC7nZ2OWloNspU5hY2IYreVC+ogcveInlABkJyuGgIl5g
X-Received: from pjbsl4.prod.google.com ([2002:a17:90b:2e04:b0:311:eb65:e269])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5348:b0:30e:8c5d:8ed with SMTP id 98e67ed59e1d1-3130cd97024mr595140a91.19.1748983025599;
 Tue, 03 Jun 2025 13:37:05 -0700 (PDT)
Date: Tue,  3 Jun 2025 13:37:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603203701.520541-1-blakejones@google.com>
Subject: [PATCH v3 1/2] libbpf: add support for printing BTF character arrays
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
0-terminated arrays of single-byte integer values to be printed as
character strings. Characters for which isprint() returns false are
printed as hex-escaped values. This is enabled when the new ".emit_strings"
is set to 1 in the btf_dump_type_data_opts structure.

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
 tools/lib/bpf/btf_dump.c | 55 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

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
index 460c3e57fadb..7c2f1f13f958 100644
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
@@ -2028,6 +2029,52 @@ static int btf_dump_var_data(struct btf_dump *d,
 	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
 }
 
+static int btf_dump_string_data(struct btf_dump *d,
+				const struct btf_type *t,
+				__u32 id,
+				const void *data)
+{
+	const struct btf_array *array = btf_array(t);
+	const char *chars = data;
+	__u32 i;
+
+	/* Make sure it is a NUL-terminated string. */
+	for (i = 0; i < array->nelems; i++) {
+		if ((void *)(chars + i) >= d->typed_dump->data_end)
+			return -E2BIG;
+		if (chars[i] == '\0')
+			break;
+	}
+	if (i == array->nelems) {
+		/* The caller will print this as a regular array. */
+		return -EINVAL;
+	}
+
+	btf_dump_data_pfx(d);
+	btf_dump_printf(d, "\"");
+
+	for (i = 0; i < array->nelems; i++) {
+		char c = chars[i];
+
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
+			btf_dump_printf(d, "\\x%02x", (__u8)c);
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
@@ -2055,8 +2102,13 @@ static int btf_dump_array_data(struct btf_dump *d,
 		 * char arrays, so if size is 1 and element is
 		 * printable as a char, we'll do that.
 		 */
-		if (elem_size == 1)
+		if (elem_size == 1) {
+			if (d->typed_dump->emit_strings &&
+			    btf_dump_string_data(d, t, id, data) == 0) {
+				return 0;
+			}
 			d->typed_dump->is_array_char = true;
+		}
 	}
 
 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2544,6 +2596,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
+	d->typed_dump->emit_strings = OPTS_GET(opts, emit_strings, false);
 
 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
 
-- 
2.49.0.1204.g71687c7c1d-goog


