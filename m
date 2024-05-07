Return-Path: <linux-kselftest+bounces-9595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DFE8BE425
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB8E1F22645
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A621C8FA0;
	Tue,  7 May 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA3mioI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD31C68BE;
	Tue,  7 May 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088002; cv=none; b=RRi5rgoDB4LgBrjWQ2lhtCf3xXdOLXs6+GjWS6Pv11drViiPUZ8SbiDLRT8/9KdPTiFm118fSO93lR3ew6+Vgv/wDb9Rf67vyv68z/svL6nBC+umtde6VKm4dIBR2lbqFgPQRFsIC2tATxmyRDOkUqNEu2FqxtP3ITDCumWJezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088002; c=relaxed/simple;
	bh=0dEsk9xVdvoDP5+magmILPSKFXyPAEcbBanwvUnwrlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5G8iwGCMIRY1m0qhLCZ2Iny2fO6BjtFn+CQi6ga03irCJfic8rDrXdX2FQCo+vssXslZQBRzhh7VKGjYesnpuhKQd59jJn3QCVvIYLis6NZmF55pp7itEkT7+9vXM4tLB6XtYc9QZTlZzau71FmpqvhC3VOOJO976RyaE+fqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA3mioI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A7BC2BBFC;
	Tue,  7 May 2024 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088002;
	bh=0dEsk9xVdvoDP5+magmILPSKFXyPAEcbBanwvUnwrlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nA3mioI81UV3xgoC8RpC4Mu22zpMCKXYRlU/M0cIBQxJS5NYL2ihjDXIYn5pt0i5z
	 cRFdDyZ28oIdOewfMakPEPhAYRiOP8MF1xPPMMc+FZ1sRWu29gcvhoBahZAyjQxNLN
	 P6KN4YOvqktZPl5Xf/OST/2vejSVcJEyxfSYpsu0B1oM1H67Eg1qmsQDDVE3oGJobm
	 5ViRnwQXDxq81GQMwb39d/IBoZCuAQcOsJZTa6J9pN39UT+2sNF0njN7Nn9Kniw5//
	 eMB3XuK6tRhI9v5MLYyGAlHin7SfLGuLjq9cTmZMg2FMUoFpBoZwcMxV6X2J8qdkcv
	 4OyFUh2ogaSNw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:33 +0200
Subject: [PATCH RFC bpf-next 5/8] selftests/bpf: rely on wq_callback_fn_t
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-5-b4df966096d8@kernel.org>
References: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
In-Reply-To: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=3917;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0dEsk9xVdvoDP5+magmILPSKFXyPAEcbBanwvUnwrlY=;
 b=VNx/k5glZWhQsEmI/jClMdqC4UnM4gt56GY1CihI90O1YgryD8UCunolfxq3F1C4/J6ijV/H/
 ZehySth33UECpOr7dY8Uh+dje+SWyor08VqDO+p7JMprnY5wk08PIgt
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The type of bpf_wq callbacks changed. So adapt to it and make use of
wq_callback_fn_t.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 tools/testing/selftests/bpf/bpf_experimental.h  |  3 +--
 tools/testing/selftests/bpf/progs/wq.c          | 10 ++++------
 tools/testing/selftests/bpf/progs/wq_failures.c |  4 ++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 8b9cc87be4c4..0a35e6efccae 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -494,8 +494,7 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
-extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+extern int bpf_wq_set_callback_impl(struct bpf_wq *wq, wq_callback_fn_t cb,
 		unsigned int flags__k, void *aux__ign) __ksym;
 #define bpf_wq_set_callback(timer, cb, flags) \
 	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 49e712acbf60..c8c88976baca 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -52,8 +52,7 @@ struct {
 __u32 ok;
 __u32 ok_sleepable;
 
-static int test_elem_callback(void *map, int *key,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
+static int test_elem_callback(void *map, int *key, wq_callback_fn_t callback_fn)
 {
 	struct elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -83,8 +82,7 @@ static int test_elem_callback(void *map, int *key,
 	return 0;
 }
 
-static int test_hmap_elem_callback(void *map, int *key,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
+static int test_hmap_elem_callback(void *map, int *key, wq_callback_fn_t callback_fn)
 {
 	struct hmap_elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -114,7 +112,7 @@ static int test_hmap_elem_callback(void *map, int *key,
 }
 
 /* callback for non sleepable workqueue */
-static int wq_callback(void *map, int *key, struct bpf_wq *work)
+static int wq_callback(struct bpf_map *map, int *key, struct bpf_wq *work)
 {
 	bpf_kfunc_common_test();
 	ok |= (1 << *key);
@@ -122,7 +120,7 @@ static int wq_callback(void *map, int *key, struct bpf_wq *work)
 }
 
 /* callback for sleepable workqueue */
-static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+static int wq_cb_sleepable(struct bpf_map *map, int *key, struct bpf_wq *work)
 {
 	bpf_kfunc_call_test_sleepable();
 	ok_sleepable |= (1 << *key);
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 4cbdb425f223..3d87ccb8286e 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -28,14 +28,14 @@ struct {
 } lru SEC(".maps");
 
 /* callback for non sleepable workqueue */
-static int wq_callback(void *map, int *key, struct bpf_wq *work)
+static int wq_callback(struct bpf_map *map, int *key, struct bpf_wq *work)
 {
 	bpf_kfunc_common_test();
 	return 0;
 }
 
 /* callback for sleepable workqueue */
-static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+static int wq_cb_sleepable(struct bpf_map *map, int *key, struct bpf_wq *work)
 {
 	bpf_kfunc_call_test_sleepable();
 	return 0;

-- 
2.44.0


