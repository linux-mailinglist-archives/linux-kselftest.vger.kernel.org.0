Return-Path: <linux-kselftest+bounces-22224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48D9D1E65
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9126A282557
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2113213E;
	Tue, 19 Nov 2024 02:47:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278AD33F7;
	Tue, 19 Nov 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984425; cv=none; b=VX9zzWeib73T2h5HjCF33asUwru7VxlG9xVLfZznwikTfKQ/MuFi91MlX0tS7cA4M+UKSbrk7gtM6MhNWqQPd1AOw1BoHyCnNsIUgfk6YbYlFVtRopKir0F1LFWXEBziIuYIAKvJIleqtwfxVh/9zRAmA8KFY0T54I9JnjXdndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984425; c=relaxed/simple;
	bh=l7EGQCVzS8e+Cm9uLnOIk+DQliZX4oyPru3AsAUlqBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZyATknYAylfGvaMhqKh6KTpdqlTykxbMwnYEoM0akTGgPx+m75DhktF2pRBb+1JDRjYyx8sAdELNS06ICzKzWvcEFPuA9pENpzeHExEEHQ/KTw9DrKjJASsKxlqdwNk7Fcy+M0oPuOBWShZmAnPFvP7BVpxfjsI7hPO5U+Mdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8673bfc2197e-819c9;
	Tue, 19 Nov 2024 10:46:59 +0800 (CST)
X-RM-TRANSID:2ee8673bfc2197e-819c9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6673bfc163b6-0b1a5;
	Tue, 19 Nov 2024 10:46:59 +0800 (CST)
X-RM-TRANSID:2ee6673bfc163b6-0b1a5
From: guanjing <guanjing@cmss.chinamobile.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	dxu@dxuuu.xyz,
	antony.antony@secunet.com,
	cupertino.miranda@oracle.com,
	asavkov@redhat.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v1] selftests/bpf: fix application of sizeof to pointer
Date: Sun, 17 Nov 2024 11:18:38 +0800
Message-Id: <20241117031838.161576-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sizeof when applied to a pointer typed expression gives the size of
the pointer.

tools/testing/selftests/bpf/progs/test_tunnel_kern.c:678:41-47: ERROR: application of sizeof to pointer

The proper fix in this particular case is to code sizeof(*gopt)
instead of sizeof(gopt).

This issue was detected with the help of Coccinelle.

Fixes: 5ddafcc377f9 ("selftests/bpf: Fix a few tests for GCC related warnings.")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 32127f1cd687..3a437cdc5c15 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -675,7 +675,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 	gopt->length = 2; /* 4-byte multiple */
 	*(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
 
-	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
+	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(*gopt));
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.33.0




