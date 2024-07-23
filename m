Return-Path: <linux-kselftest+bounces-14088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BE93A443
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A66A1F2333A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6121B1581F5;
	Tue, 23 Jul 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj48lKrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E31581EE;
	Tue, 23 Jul 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751732; cv=none; b=a3/zmsT0YggcTGGh5HzpKppNQkcaRSbi38d1KZbAF5T0xm/qTFgzkEtKZC7yvMdHjgd6gIUroRtYM+JDZnjCezhfcBSfGNU14ucnPtRp4dPqt58SgVOwSSxTFmcdR1Lp4RpwdcCQvpbBC+oro4IsvsVBbsBG7addwlermvtMi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751732; c=relaxed/simple;
	bh=w83YxVgebjmRwK2hKe6lEH7ZBsSGFING/dCqjGaSXbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxiqYJRB9QlwskXyIvN+4+UcPdQ65WR9m3r5CfHFfD/lWe3XBfrRNdK/yt4n1W39pvjxCNBnKVIBAjS34a4Ihgzqj4l6eJw7rEtK3hB4mGXgjlf5f6Yq6fYTLsPfBtQN+xQVMzHulPVPPwiXVQms4OOB8CVik1qGk+gMY8Eonuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj48lKrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0BEC4AF09;
	Tue, 23 Jul 2024 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751731;
	bh=w83YxVgebjmRwK2hKe6lEH7ZBsSGFING/dCqjGaSXbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oj48lKrMyxJIfMgOLgxvdcYvz9ko48mIBSR2XmtGov6RFVzmfjRsJvVrLGAeBZSlF
	 u1ug4qxaPrrEUu6UrtIzmEq+Jq80snBSi8Y3vxH8X9dNepwFYYAzrq/4cuxMFd/y5H
	 h8TNCdY7ZmKyvrymKDTiGthNzkXkCh4zYm8SpPXkUv2G3Jsbnl6+NKelSvXe6NjRQS
	 anwoLJsvAmgb9Etai21y6O/eMMLg9NnHGmaMcTj/cg2cK6b++9NpTbIu8EWiJIMdY8
	 0J41/Qwbz/3qpJ4Z/FX8mq3m7+NFCQkal5LeoJ4fHC7AncQ1vVyFOgED2+WHFuTok8
	 FmJe47JGjoHww==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 23 Jul 2024 18:21:51 +0200
Subject: [PATCH HID 1/4] selftests/hid: fix bpf_wq new API
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-fix-6-11-bpf-v1-1-b9d770346784@kernel.org>
References: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
In-Reply-To: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721751728; l=1863;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=w83YxVgebjmRwK2hKe6lEH7ZBsSGFING/dCqjGaSXbk=;
 b=doRFw8hjh+OkurziZd/FmudQDjyJR2WhorOSi+P/YR87yVYtzz9LI7uShTJHSUpmg7OQAq0Hs
 feyiQrXg6sxDgrgkapb6OAv55gm4F+jtlm083u6UESvNS5mLtPUwHsY
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Since commit f56f4d541eab ("bpf: helpers: fix bpf_wq_set_callback_impl
signature"), the API for bpf_wq changed a bit.

We need to update the selftests/hid code to reflect that or the
bpf program will not load.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid.c             | 2 +-
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index ee9bbbcf751b..5ecc845ef792 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -455,7 +455,7 @@ struct {
 	__type(value, struct elem);
 } hmap SEC(".maps");
 
-static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+static int wq_cb_sleepable(void *map, int *key, void *work)
 {
 	__u8 buf[9] = {2, 3, 4, 5, 6, 7, 8, 9, 10};
 	struct hid_bpf_ctx *hid_ctx;
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index cfe37f491906..e5db897586bb 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -114,7 +114,7 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+		int (callback_fn)(void *map, int *key, void *wq),
 		unsigned int flags__k, void *aux__ign) __ksym;
 #define bpf_wq_set_callback(timer, cb, flags) \
 	bpf_wq_set_callback_impl(timer, cb, flags, NULL)

-- 
2.44.0


