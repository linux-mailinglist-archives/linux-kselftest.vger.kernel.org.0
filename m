Return-Path: <linux-kselftest+bounces-44283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C06C1B3F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05AF45A29DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA033B6F8;
	Wed, 29 Oct 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qQfLr74r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626233B6C9;
	Wed, 29 Oct 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745966; cv=none; b=uqhe8EcFK83uF99oay+5IVHJ15mfZHBGIRXqIiQ5brEXVRZ7nR/V+0bJfrZakZuP1WxmVR5mbDh8zfMfWlEjLZvpfRme53ftaMPnZ5zDG31rSrN4jLrNh3/jiPYSzFYoUuUiHea4aMLJe9zGDisYBrFz5ryczoAlyFi4LeRH7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745966; c=relaxed/simple;
	bh=NmnFd273B1++/96Wgc9NGu0f7rRSh30SrDhu6B794fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZxk+pzJBH4mIU6HVHe7rCbRImvPY+MGdBP3mJpYyer04X6UsW6JpYZuBD8XFaaXfkzufMcZUBGL/5ekDZAlEnqSW9VfNzUK5EN1RGcJHeuelkX/G8pWUhzM2wEW/piCzbROVpDhHeDY0BBR0OyWT1wuT+9hUtVAKS6q7QtTyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qQfLr74r; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3668B1A1748;
	Wed, 29 Oct 2025 13:52:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0AF66606E8;
	Wed, 29 Oct 2025 13:52:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2ABDA117F80F1;
	Wed, 29 Oct 2025 14:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761745960; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t78orrvBumS1q2Y+FbZ/Ic91n45UYCSTBLa81LdYwMs=;
	b=qQfLr74rFcjUcwwGXLlFXOjhKusVZp18GFrXSRoXTl0v8lma2QsAQliMwEhY1svcwW7fM2
	/DKJAJgO0rh2vSOxBlpqOFm9fcKouLC7ELoWBR0BgtX/k5dN5EQydUHZi5Pak1YDwEK4Ft
	Pf8kfryVuLvhfFsOKB3IUAsp3spMy++KdiGFsHIqka0Wx7pNirAmuyF+kjnX3MU8MQxSNr
	X6yXia408R62O5Q08kIQA0K8r9X7/gZpOtOQ0gzYuoh8Kt5LpwDQ0e6hKb6gtRNH8gTKhi
	NXWSkO6LJuElTVP71a2dtFhwsVdRZZuvT5lJbEHqD2nG1DgaOqL7YTv6Tm7sQw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 29 Oct 2025 14:52:24 +0100
Subject: [PATCH bpf-next v6 03/15] selftests/bpf: test_xsk: Fix
 __testapp_validate_traffic()'s return value
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-xsk-v6-3-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
In-Reply-To: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

__testapp_validate_traffic is supposed to return an integer value that
tells if the test passed (0), failed (-1) or was skiped (2). It actually
returns a boolean in the end. This doesn't harm when the test is
successful but can lead to misinterpretation in case of failure as 1
will be returned instead of -1.

Return TEST_FAILURE (-1) in case of failure, TEST_PASS (0) otherwise.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 679491b6b9dd80ccb2b92729141fb8715b874c6d..8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1725,7 +1725,10 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 			testapp_clean_xsk_umem(ifobj2);
 	}
 
-	return !!test->fail;
+	if (test->fail)
+		return TEST_FAILURE;
+
+	return TEST_PASS;
 }
 
 static int testapp_validate_traffic(struct test_spec *test)

-- 
2.51.0


