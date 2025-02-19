Return-Path: <linux-kselftest+bounces-26978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C0A3C2B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EC6188CF50
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483361F4194;
	Wed, 19 Feb 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AiPClfsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702E1E47A3;
	Wed, 19 Feb 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976788; cv=none; b=HjtZ1Nv+BxRW+Am17AR9yd2gk3/UDCnahHdKhdBjnEr5MZoVLClR7bQSm0OwZPrdhpMH7R8CL3q3QDXQRdw3xMua7JpTsJpjW4aCgXK3Yv7CbTuOev+47q+6JxhI9n0Ked88pNk6E8MGcIZk+m7Uy+zqfHtKyDOQpWX/Z1H4VSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976788; c=relaxed/simple;
	bh=xKZOw9hzrviAcvXKVZ1M5SSZtUleov7kmWdKELPA4Q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4/EDqT0hEfS5gjgj2HBDvRBeWiMI8kvnZTkJHkqIvv5IV6uhZZhL5l30IQ9oUT0LCxF2vHNj0sb2H1NgFDx10DQ6hSEBPKaX7QOuG9oQOf5bOfE7gNASyPaUkukw6tEsvJUbFLvnU1KXyZd1J+Ixy2HhI43sFi36Z3Yu3gW3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AiPClfsu; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C20D20454;
	Wed, 19 Feb 2025 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739976784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u+UDft4UpY9KBk40YrkVV1XuG+FD5zM2TE/VNfUf+w=;
	b=AiPClfsuSSXes2BKAC2KC+rwnDDlfrbieiZnCzo8nzDupE5WwvszjtTktRa0jq0qXvH6wZ
	jlX/Tyn6X0t+zxewjeHbw2NGCvGnJDaT7QlfRLREzMhKAwzlhPEXo/PSHCK8CddLARcdTv
	lnhkTNAyR/c0mYeungtXZgxT8XJ1Tp0oQazz8U8BGfxIO101Ehy5Kd1N3tlmrSON0Wxii5
	1dUFfpaQt9tVTIhp2Q0wbBTarx769N1eJ9WbWKCCqoxe4WISiHU+yuBkZfAYQ/N1Q8MyEK
	aMtR5LPMX+B/pHZDV30p3Y3yK5D1JaFpOfP42jF5VoxY05Hz+9R+WPidQjnUIw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 19 Feb 2025 15:53:01 +0100
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Optionally open a dedicated
 namespace to run test in it
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-tc_links-v2-2-14504db136b7@bootlin.com>
References: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
In-Reply-To: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhon
 hhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Some tests are serialized to prevent interference with others.

Open a dedicated network namespace when a test name starts with 'ns_' to
allow more test parallelization. Use the test name as namespace name to
avoid conflict between namespaces.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_progs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c9e745d49493e594b55d79ac26061b0466f9a039..0cb759632225d27ad8df7bc478bf1adb5651bf33 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1365,10 +1365,19 @@ static int recv_message(int sock, struct msg *msg)
 	return ret;
 }
 
+static bool ns_is_needed(const char *test_name)
+{
+	if (strlen(test_name) < 3)
+		return false;
+
+	return !strncmp(test_name, "ns_", 3);
+}
+
 static void run_one_test(int test_num)
 {
 	struct prog_test_def *test = &prog_test_defs[test_num];
 	struct test_state *state = &test_states[test_num];
+	struct netns_obj *ns = NULL;
 
 	env.test = test;
 	env.test_state = state;
@@ -1376,10 +1385,13 @@ static void run_one_test(int test_num)
 	stdio_hijack(&state->log_buf, &state->log_cnt);
 
 	watchdog_start();
+	if (ns_is_needed(test->test_name))
+		ns = netns_new(test->test_name, true);
 	if (test->run_test)
 		test->run_test();
 	else if (test->run_serial_test)
 		test->run_serial_test();
+	netns_free(ns);
 	watchdog_stop();
 
 	/* ensure last sub-test is finalized properly */

-- 
2.48.1


