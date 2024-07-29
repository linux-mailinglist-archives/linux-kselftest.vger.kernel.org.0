Return-Path: <linux-kselftest+bounces-14372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6493F0F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D913A1F21FAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1C813E04B;
	Mon, 29 Jul 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFrPp9dx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065013DDC0;
	Mon, 29 Jul 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245090; cv=none; b=U5oqUC/BPF7ZWcNfABrL+Zf5cqZNJQnYzpJxqteVUw2kDxF5b6QQxqbS9vrpiy0rglSGvTiCqEJYAKeHqAlAqKva+/wJLCG9rBXQ7KBGOZK8kW52XkY4UCPSuOV5FS+2ZKkPDjxDffpbSnLbIGUa88ONhZTZ0I5RUc+6YWer+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245090; c=relaxed/simple;
	bh=OcXxk0CIiELOuzTAgpqOy3sTWCmDOgat+/mD5MZ1xJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msbk+xkWRO3Utv65oPPbuDuiw9EiCOB0fQKRO9GFVMhWmbXRvb3gV5VHrUcv17WHh172Iw2buALqB9GWl4QNWgXznyrwXGLjNj64jSkE7n8Bc97IrDhEMPFq25ch7MNLF74kOegYa3Tf8Qk41m2Yjn91bqBE+5XR8SCogfabqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFrPp9dx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so1970553b3a.0;
        Mon, 29 Jul 2024 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245088; x=1722849888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ab7qTGK95IGxwGu7fOI+kWJZ+ROn9a3NpPs5CH6feo=;
        b=LFrPp9dxgH2NTaWlFdQlPWdKn18rlW0OIDTvEvYcE5dcxx2/j+ay2KOLCqXSl1GtzT
         m948xZcLiH07QLjNVzAjwrN+Rvj6NeEOpow7uA6MBAEmSHasaYWgxhsUjzY8p0NmkzjO
         uv6Zf5Hn7MdQm21nfYkAidG151CjPUFLgR3I7reO0VRFafgIIQAnlHfuHMD84RvYAe7j
         MLigwxFwOYAEQovXozx9bdiUqlVNOi01vkbUJgpO1OzRzFnrmeui2tKLHg5Lk0LTQlbI
         FXk99aPB1vMc6hPGaUiJeVCGY8Meo8pmvJKAXoi2Zb1dzkyNhaQFe9e5DfVciely77Yq
         LQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245088; x=1722849888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ab7qTGK95IGxwGu7fOI+kWJZ+ROn9a3NpPs5CH6feo=;
        b=IpbdGMdlx3LjKStqIwvfkoMxV4oFFbjjaI16BvGbh3LOW2ss/4igX7RjPl9LzZZyeB
         k0k+VlcMlsojHSSThmWQl82vEbkZjkw1WnK/4aAETcOmEfeMBfWfP7vCfzJM9BixwLhV
         /RNjKtLpWSdG8lmhbatdapHagyQIKfLujcZ0EqWDiN47usXqGhrSNAo9ngoiA0CnT/pU
         53/3NBpoWm/QXDfCaTYbn5iBqI5x3mGcmXBRSyzZv5sVzJ8TKgvi2rmRpeTHii7LeAsl
         rcQ+uBMdjmq30YsJUpCwGcQeUKUpo4icbxwTIQmDqcXfKeFsh6OSZ5bfgbyLj9rsQp9H
         wX0w==
X-Forwarded-Encrypted: i=1; AJvYcCUtHo/h9MNauaeBAQnImcQHpQ1PAeovijsq4Pq7XXkXX6cjQsIaE0wn7k6hp8BCt2/e40OkUurh6YWHjixuuJY0pKZbeLhRvWdGqwMAJ0VSWymX/wSuEGAlnIEXcEy6fDpBHHky23Ny
X-Gm-Message-State: AOJu0YwFcYFbqNP2avobl6uXjeafPWtAT6y91CsH/7EQD8uauKSlsfU6
	/8hWuYi1xK+ZIbK7VL/eKEX02WFeeV+XJ1+FswMch9WraxJStMKX3RcWngfi
X-Google-Smtp-Source: AGHT+IF2wnHsO5khzhMrlfvvjeTPT4ZCH5TdwIstPXUs2IuZbX4lw6WFDCqkVENe9qHFJaMoNJHuxg==
X-Received: by 2002:a05:6a20:6a20:b0:1c2:8cf4:7664 with SMTP id adf61e73a8af0-1c4a130d0aamr5895014637.31.1722245086912;
        Mon, 29 Jul 2024 02:24:46 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:24:46 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v2 2/8] selftests/bpf: Fix arg parsing in veristat, test_progs
Date: Mon, 29 Jul 2024 02:24:18 -0700
Message-Id: <392d8bf5559f85fa37926c1494e62312ef252c3d.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code parses arguments with strtok_r() using a construct like

    char *state = NULL;
    while ((next = strtok_r(state ? NULL : input, ",", &state))) {
        ...
    }

where logic assumes the 'state' var can distinguish between first and
subsequent strtok_r() calls, and adjusts parameters accordingly. However,
'state' is strictly internal context for strtok_r() and no such assumptions
are supported in the man page. Moreover, the exact behaviour of 'state'
depends on the libc implementation, making the above code fragile.

Indeed, invoking "./test_progs -t <test_name>" on mips64el/musl will hang,
with the above code in an infinite loop.

Similarly, we see strange behaviour running 'veristat' on mips64el/musl:

    $ ./veristat -e file,prog,verdict,insns -C two-ok add-failure
    Can't specify more than 9 stats

Rewrite code using a counter to distinguish between strtok_r() calls.

Fixes: 61ddff373ffa ("selftests/bpf: Improve by-name subtest selection logic in prog_tests")
Fixes: 394169b079b5 ("selftests/bpf: add comparison mode to veristat")
Fixes: c8bc5e050976 ("selftests/bpf: Add veristat tool for mass-verifying BPF object files")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/testing_helpers.c | 4 ++--
 tools/testing/selftests/bpf/veristat.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index ac7c66f4fc7b..c217e12bd9da 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -221,13 +221,13 @@ int parse_test_list(const char *s,
 		    bool is_glob_pattern)
 {
 	char *input, *state = NULL, *test_spec;
-	int err = 0;
+	int err = 0, cnt = 0;
 
 	input = strdup(s);
 	if (!input)
 		return -ENOMEM;
 
-	while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
+	while ((test_spec = strtok_r(cnt++ ? NULL : input, ",", &state))) {
 		err = insert_test(set, test_spec, is_glob_pattern);
 		if (err)
 			break;
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 11ec1190d582..1ec5c4c47235 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -785,13 +785,13 @@ static int parse_stat(const char *stat_name, struct stat_specs *specs)
 static int parse_stats(const char *stats_str, struct stat_specs *specs)
 {
 	char *input, *state = NULL, *next;
-	int err;
+	int err, cnt = 0;
 
 	input = strdup(stats_str);
 	if (!input)
 		return -ENOMEM;
 
-	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
+	while ((next = strtok_r(cnt++ ? NULL : input, ",", &state))) {
 		err = parse_stat(next, specs);
 		if (err) {
 			free(input);
@@ -1495,7 +1495,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 	while (fgets(line, sizeof(line), f)) {
 		char *input = line, *state = NULL, *next;
 		struct verif_stats *st = NULL;
-		int col = 0;
+		int col = 0, cnt = 0;
 
 		if (!header) {
 			void *tmp;
@@ -1513,7 +1513,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 			*stat_cntp += 1;
 		}
 
-		while ((next = strtok_r(state ? NULL : input, ",\n", &state))) {
+		while ((next = strtok_r(cnt++ ? NULL : input, ",\n", &state))) {
 			if (header) {
 				/* for the first line, set up spec stats */
 				err = parse_stat(next, specs);
-- 
2.34.1


