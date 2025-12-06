Return-Path: <linux-kselftest+bounces-47225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0EECAA846
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D47B300FA3D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52132FBE09;
	Sat,  6 Dec 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmHhnHMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47680239E7D
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030359; cv=none; b=qushJ71A4C0BsuT1iZswsLxXTRAbk7lt2IqhEKEMMqB8peBkkwKr2yUW62AlT/7W3LNcOGKrwFe3cxA/OJRFVLpG6yvltZ2oiPbjTG5SuGmi40xeTB7jOG7jNXpFCKLVKW1h/sjEXij7P3I64h+lsiWx/osSULLbp6apEin1a3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030359; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKml10v1FPa/py21wFMYPkeiaPglDhtwPz3S2uROxLH18SeO9FKeQF3iQNvn3yn9pnfYm/DO2xA8TtieeRxtbM6mud0UaPbVrzXL7+lmI3hF1ZW7fnkHSGizXclMwGtFt/6MVsu/hQYJfqmnYeYcZQRQpo5hSpPYsyoFHYUI8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmHhnHMJ; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640f2c9cc72so2826209d50.3
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Dec 2025 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030357; x=1765635157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=GmHhnHMJtWXo5n9JfVX7awchSCfxN0g9ni8gmCegbPDs/e53eS0IOAmVGEuZot+rSa
         JV2GtmuVczlxmjS8CQCGvkN0JjMqGlIpo0RNGgQXztIsMZYYCkRFcqJDlnWSmfl5URtc
         zloliAFuImbfZqC2o07VWMhrYcucQrnnQ8+Tdoe0Ng7KkNrxEai8pByu5PLmaJr1vkTl
         v96uNKBpGlt7n7yflVkrYvwdHn6ruQMDVDjoM1wqwFb71AR9JA4LgljVUePly0p8x5vd
         0kfBxp0ivJijzhOwD7GqNSrQpf9h9qlnapG0OLtpWe4NAde6qhE15/z0NR0jHeA9+E+b
         6xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030357; x=1765635157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=sFtNYKv8EilxD7F+9F3CgVx9LR0MEs4asx8j5I5a9j2UEygz5L1gNe1GcyCsb1WcMM
         tQbla32sqDZ0wvteSKoOo/Z/j8MQjW9u2amUDMSTB/X4V3BGDM7glt0qQ2rC8SrdebpR
         cbqvKzwLSo5QSjqmm7jZ+f536TmtNrCLqv2j9TtN2jKdzfZe7jZn6AIpDnwWKuktz1RV
         elS0XEwW2yIGIdm9/vhDlJ85Aa0hKLbA6xZ1iGQQrrq6gmiIZl8OVu08113stfeB6KfY
         SwT18dHoIcrwMk5hO3HjVazHmp3Tf6YVZ2RfYeK2K5UYrphjeZsPesX/GE+qSAhNR27s
         keYg==
X-Forwarded-Encrypted: i=1; AJvYcCXdM5VKcpxGpTcbGKjEhBfPiSDYiwvGXkoWp+Bkp02XHiuEh2Mgpv/9UBkstZwh9Csk5wnXUuOoWyFFzUL7Ses=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GsaHO1N1/uDufpmcOfvJSSCjPM5EBOk9ndhCu61Hpci9zIXw
	pTDZNjjS0f/904qKzdqMlOt8SCkAQWwIR3Uc5k7hpS6QzbJ89+0Yv/Re
X-Gm-Gg: ASbGnctumd1CUxhpnZ8P35k6ZEzs2ky9rGLn4N+TqMvPi4Ow0RJYQZQZL6uckK9wDlp
	r7HR8z8++WjL27C/z7nUN74iiU6fNu2ikz8yM9LeMC+jKfvv4uOWatsD5ZXlIkyjPbGzknrPIIn
	j9OPNyRba1yJ6YMez54v+AIFz2QNWUFh7jToVI18YnlVddH0eG4x4o17k5DvI1eLlYI7xonigoW
	5EYUE4nbeRM6KmjVFO7vylBmKwhJd/aqW2NDzoUSLvrY3nQasXQMP6dUMQDZhE6ShI2ft/CsjUE
	WK1F0R5vJ7Ner3LshRFd/+pIzbU5d3qzcMBXLQp7jMZPzFS3irlEXQXLgXcV4HEAN03z3ifzbzy
	KGMpM8Pnor8HmWOE9t1rqOyTrEWl0y9HZJz7aK32D6WiAHrY3PmPt6usIBOPeDhwUpnxW8NWILr
	Ak4VrUgkKQGzVqrpDRhD2urW83lCiSYsCou0e1KNba6q7xTeYbvUvnRhU/NG0PNQ==
X-Google-Smtp-Source: AGHT+IHuF83mFXlkaMu6oHm6oMBi8mfMFdfNONlXiyds7RYNVDtirN1s6Te2e+85GpStdEubYV2j5g==
X-Received: by 2002:a05:690c:64c2:b0:788:181b:869e with SMTP id 00721157ae682-78c33c171bemr42202787b3.40.1765030357161;
        Sat, 06 Dec 2025 06:12:37 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm28038027b3.3.2025.12.06.06.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:12:36 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v5 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Sat,  6 Dec 2025 22:12:09 +0800
Message-ID: <20251206141210.3148-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251206141210.3148-1-electronlsr@gmail.com>
References: <20251206141210.3148-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0


