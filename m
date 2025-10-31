Return-Path: <linux-kselftest+bounces-44499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D3C23B35
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07EEF4F55A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A83321BE;
	Fri, 31 Oct 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ijmFjcbf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B32E0910
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897911; cv=none; b=OeU4VXcsQ9kR1SOCayTVAw0RVynMeESMnKXAxXXJHcQKZuV7jWDj6InPBKyh+6phYTjSWLCesDbYv/w3SRLSZRwzp+J1vvXQKjuOsqxOiPCZs6UitHASi0Qsw2VA1cVxaFc3iGmQ1KZWXGcRa3ZgHb0KYxRAZmCtW5O3zSiG3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897911; c=relaxed/simple;
	bh=15E47hyvmQPrJWkj4LYQAs5VLKJP00bGmfww35DXTcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6sPHP/zkkMh/OQOTvUj+fAmQ2MCqWCey9eJDNEYQjI0z5PsDb1OHB49M0e4nn3LeJ4O4tod0HtYAIA0ecGVlwGeYTDl39jX8cA1if1/SDUiGhXWiSEcX3jJGJA4AVBQuYDbCQ8SZUwn3s1Z+xDhRYc5qtH57/95VoH+eU1uIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ijmFjcbf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 191F9C0E94F;
	Fri, 31 Oct 2025 08:04:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92C0060704;
	Fri, 31 Oct 2025 08:05:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 793131180FB58;
	Fri, 31 Oct 2025 09:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nw7naf5mx2NiW6CLXgmCEx5KgfTcyto6pFTnj3WONc8=;
	b=ijmFjcbfFXzOc3EtJtbd1oPaWiS4+xQwcyyPoeULHd14NO98Js68hmN8IQCSKmiuhVmxAf
	Hdu9gh5kGo6cgExYzAVgLpsMTQIoLRL5/ExsygA3Z7m2/pUo+4lAUbeUCbb49eJekHAwy6
	09Kx/ZOq4FeSt/s64ROItXlUf6ev1f+byqEkF6Qo46xMNPxeg8vYwtIAQKW0BRKcEDRK1p
	5wtI3bnl+BHNsFxGT4yDNLjjHgUkbHhMPdq2BSj/IVRWl3MlmeJZu0dzlI2S/W/3CjGcXM
	c5TeWwJiptHkrikUYTZg/dIxduxtnAetCiKrvxHYjj2aO/BXjSkBrPJsYQGKUA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:43 +0100
Subject: [PATCH bpf-next v7 07/15] selftests/bpf: test_xsk: Release
 resources when swap fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-7-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
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

testapp_validate_traffic() doesn't release the sockets and the umem
created by the threads if the test isn't currently in its last step.
Thus, if the swap_xsk_resources() fails before the last step, the
created resources aren't cleaned up.

Clean the sockets and the umem in case of swap_xsk_resources() failure.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 84b724731e26d0c7e67131ec1bd562e223d3d09d..8fe75845d7a6aa5342229fa419fcbaa411ae9e70 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1866,8 +1866,13 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	if (swap_xsk_resources(test))
+	if (swap_xsk_resources(test)) {
+		clean_sockets(test, test->ifobj_rx);
+		clean_sockets(test, test->ifobj_tx);
+		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
 		return TEST_FAILURE;
+	}
+
 	return testapp_validate_traffic(test);
 }
 

-- 
2.51.0


