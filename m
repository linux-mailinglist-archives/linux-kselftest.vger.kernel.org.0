Return-Path: <linux-kselftest+bounces-13312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B26929FAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D77BB29B6C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B878C6B;
	Mon,  8 Jul 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAnVfzvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D178B4C;
	Mon,  8 Jul 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432396; cv=none; b=iJf/E/3nRRNwPlYAfY31/CHBLsGcSwvYurPtwSedOEauuv5S2MAMNKwx3/xJDa9lGXMUMeSjpEMZFK25JQdaaBZty+2NmLQAl0oYlHR/n6QQrjHvnQuHlb5fCJQg45xv5Roo7SWnsBf23+NT4ghP+dD1tuRJz6iNnfg1Fn2ipFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432396; c=relaxed/simple;
	bh=Hc+wCGdfuoRlwbB3DucDaka6bSZJEuGgzM8L4Qcwlv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpKkNVPBqDLcdsfz60inrDZ0EmZQvfFnotdYkSCp50nNrRvoO9KqCd8chCaqBwuGxg26z9UZX2RuL/g1HHXpBjUn09MHjIJAGrUQlv83hB5daHuv0Kp/5nItzuoa3I/rwSQQ6UU8h/d2qNlpesv1XR2WKmlTJywNRpttV7it7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAnVfzvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9869C4AF11;
	Mon,  8 Jul 2024 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720432396;
	bh=Hc+wCGdfuoRlwbB3DucDaka6bSZJEuGgzM8L4Qcwlv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TAnVfzvqNg/T75RwhNUorfBLlcl7ygOwaGjkmoxb6826qusb0M0XqP0oWqC8vbSk2
	 rckCU6pvoCweyTASFKvGaSLXmEa4dPJsPb0RvmT+9sga6GiXoK1V9ko0ofTvD2gNQN
	 XtGEyqKqaHQc4HJLXHlirJrItdKmzYD+JTJa3hot/64giM9bOMi5mV2Tq2xrYEE8Ig
	 0sTrIITuDSgu170kEZ7v+2bZXSrQUgGcD6aqgxbSvxGZc9JpgfkVkd7jTfzy4zTCbP
	 nG9HIwFYvxSS+xXfiASPOdcv0/NPTMdCOK2QJDfkFEt1Z5VhdePykTDusnE4bGigJt
	 lL6UckQ2XZPnQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Jul 2024 11:52:58 +0200
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: amend for wrong
 bpf_wq_set_callback_impl signature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-fix-wq-v2-2-667e5c9fbd99@kernel.org>
References: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
In-Reply-To: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720432384; l=4146;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Hc+wCGdfuoRlwbB3DucDaka6bSZJEuGgzM8L4Qcwlv8=;
 b=Y8m9/a5ocBeDa+NmLXIIU+COidOvwwjZdwTSS8F4IfgEyToR5gAv/vbRyM4Ccw4VlWUBmp5GJ
 M7vHLH2/MOwA9rWLDJUlyohFwA3+JO4ZPDpBTZVjQo+fXyP+sKW/iF9
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

See the previous patch: the API was wrong, we were provided the pointer
to the value, not the actual struct bpf_wq *.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- amended to retrieve something from the third argument of the callback
---
 tools/testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/wq.c          | 19 ++++++++++++++-----
 tools/testing/selftests/bpf/progs/wq_failures.c |  4 ++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index eede6fc2ccb4..828556cdc2f0 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -552,7 +552,7 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+		int (callback_fn)(void *map, int *key, void *value),
 		unsigned int flags__k, void *aux__ign) __ksym;
 #define bpf_wq_set_callback(timer, cb, flags) \
 	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 49e712acbf60..f8d3ae0c29ae 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -32,6 +32,7 @@ struct {
 } hmap_malloc SEC(".maps");
 
 struct elem {
+	int ok_offset;
 	struct bpf_wq w;
 };
 
@@ -53,7 +54,7 @@ __u32 ok;
 __u32 ok_sleepable;
 
 static int test_elem_callback(void *map, int *key,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
+		int (callback_fn)(void *map, int *key, void *value))
 {
 	struct elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -70,6 +71,8 @@ static int test_elem_callback(void *map, int *key,
 	if (!val)
 		return -2;
 
+	val->ok_offset = *key;
+
 	wq = &val->w;
 	if (bpf_wq_init(wq, map, 0) != 0)
 		return -3;
@@ -84,7 +87,7 @@ static int test_elem_callback(void *map, int *key,
 }
 
 static int test_hmap_elem_callback(void *map, int *key,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
+		int (callback_fn)(void *map, int *key, void *value))
 {
 	struct hmap_elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -114,7 +117,7 @@ static int test_hmap_elem_callback(void *map, int *key,
 }
 
 /* callback for non sleepable workqueue */
-static int wq_callback(void *map, int *key, struct bpf_wq *work)
+static int wq_callback(void *map, int *key, void *value)
 {
 	bpf_kfunc_common_test();
 	ok |= (1 << *key);
@@ -122,10 +125,16 @@ static int wq_callback(void *map, int *key, struct bpf_wq *work)
 }
 
 /* callback for sleepable workqueue */
-static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+static int wq_cb_sleepable(void *map, int *key, void *value)
 {
+	struct elem *data = (struct elem *)value;
+	int offset = data->ok_offset;
+
+	if (*key != offset)
+		return 0;
+
 	bpf_kfunc_call_test_sleepable();
-	ok_sleepable |= (1 << *key);
+	ok_sleepable |= (1 << offset);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 4cbdb425f223..25b51a72fe0f 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -28,14 +28,14 @@ struct {
 } lru SEC(".maps");
 
 /* callback for non sleepable workqueue */
-static int wq_callback(void *map, int *key, struct bpf_wq *work)
+static int wq_callback(void *map, int *key, void *value)
 {
 	bpf_kfunc_common_test();
 	return 0;
 }
 
 /* callback for sleepable workqueue */
-static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+static int wq_cb_sleepable(void *map, int *key, void *value)
 {
 	bpf_kfunc_call_test_sleepable();
 	return 0;

-- 
2.44.0


