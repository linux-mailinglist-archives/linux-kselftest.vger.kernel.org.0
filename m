Return-Path: <linux-kselftest+bounces-13238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D6928A0B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A051F23B7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD21553A2;
	Fri,  5 Jul 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niGFGSvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FF14EC7C;
	Fri,  5 Jul 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187111; cv=none; b=cfkLMeUPHDfMV2vYbNPLSGPxadjNomVccM4mAhnWM43Y7Lck/uJieJITQthTMowGuIO8LeJrPQ0ZkZO/nREnVsnF2RUPSjtb4cvtG/CHuMQwjYZAeOmPOWo5xFEZPiPsRNWQJU+4dAfHMCeSQJA35+qT1ZSbqdXGmdbZ4+VlV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187111; c=relaxed/simple;
	bh=0w8gvKjTu4tdLutH6R1DbAV/uEOlEmQguROzVLf15Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiR0gWMpDxNmY0e8Vm9TtoA7OfZyTsL59s8Ya06lxp2kX4lYa7+CQ1XRxY5G5wPICg1CMwxpMKy0xJsR/iejggJMY4MEpIOHCUYBfMgRV+cnvNUFo3TIGQ0IihWLD04WS8Giv/hlzRV1UuqmCflND79F38bKRwdjrHkqUnrRo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niGFGSvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B039BC116B1;
	Fri,  5 Jul 2024 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720187111;
	bh=0w8gvKjTu4tdLutH6R1DbAV/uEOlEmQguROzVLf15Us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=niGFGSvpUROr4Y+0qkweYq6nbGjtzNOQX4itzKYWRN0TJYMDwD6Mj0hK4XZd31PHr
	 ADMjYJz32dgy3g3xCj4TyOiCaB9BbcCCwRIXFbWQAiCK7mc3XAdsamGpCODduW/JtL
	 S6UJWaAuldVUH/P/c/m1zYIjNQwdnLiUa/ihXnX8aqEvizUpoAZleOE59uwsSC+JaZ
	 sDgzEfd9zwzEPi1BcwL2AWFrmq3R8f2581PZsVhmjnay4ijIuC7tsysNnp3bz3cFpY
	 ilGn7TPvrkqBcxq+xDo8BGZ+y2ldZha7i2MZ0Fu+GshGHxid3KxcP6l+N9u9ajaqzw
	 7AeZP4A0uBckw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 05 Jul 2024 15:44:53 +0200
Subject: [PATCH bpf-next 2/2] selftests/bpf: amend for wrong
 bpf_wq_set_callback_impl signature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-fix-wq-v1-2-91b4d82cd825@kernel.org>
References: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
In-Reply-To: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187099; l=3534;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0w8gvKjTu4tdLutH6R1DbAV/uEOlEmQguROzVLf15Us=;
 b=lAPZdY5puQJIW7UV/1AUcyD5sKak0ZlKALEl1x3U4dmG+Owm2K/da9Y7ZpDqfeYHnQy4jnwLe
 gOipma6E+S0Anqp2RYp/Lel36KVkxn5z/wUDuuCTYHh4/9x2s9gUTHi
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

See the previous patch: the API was wrong, we were provided the pointer
to the value, not the actual struct bpf_wq *.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h  | 2 +-
 tools/testing/selftests/bpf/progs/wq.c          | 8 ++++----
 tools/testing/selftests/bpf/progs/wq_failures.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 49e712acbf60..e5ac0df59b86 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -53,7 +53,7 @@ __u32 ok;
 __u32 ok_sleepable;
 
 static int test_elem_callback(void *map, int *key,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
+		int (callback_fn)(void *map, int *key, void *value))
 {
 	struct elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -84,7 +84,7 @@ static int test_elem_callback(void *map, int *key,
 }
 
 static int test_hmap_elem_callback(void *map, int *key,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
+		int (callback_fn)(void *map, int *key, void *value))
 {
 	struct hmap_elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -114,7 +114,7 @@ static int test_hmap_elem_callback(void *map, int *key,
 }
 
 /* callback for non sleepable workqueue */
-static int wq_callback(void *map, int *key, struct bpf_wq *work)
+static int wq_callback(void *map, int *key, void *value)
 {
 	bpf_kfunc_common_test();
 	ok |= (1 << *key);
@@ -122,7 +122,7 @@ static int wq_callback(void *map, int *key, struct bpf_wq *work)
 }
 
 /* callback for sleepable workqueue */
-static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+static int wq_cb_sleepable(void *map, int *key, void *value)
 {
 	bpf_kfunc_call_test_sleepable();
 	ok_sleepable |= (1 << *key);
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


