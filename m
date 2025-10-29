Return-Path: <linux-kselftest+bounces-44292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E733C1B3AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715B65C22A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E8350D53;
	Wed, 29 Oct 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KLDapSPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161D34FF65;
	Wed, 29 Oct 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745994; cv=none; b=Emj3i70JfBhCR0SVJRWvDfmOS80KKSI6bTx3iG9/8NmsMfDczOKYSwaQ00vjiPmfWgIFpTz5e0MdmbcuenIRXUEsSeKg2v4a+8NPwR+kkAVkhv+AlryWHxQ04TtUpIsAQw/Ls0J7fLaVSZebFBELCBfLkewhIGYHhcpclCCrB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745994; c=relaxed/simple;
	bh=i6tvyT3HeQHgZFGaqaMNEa+sxOzLO4PwlSxdaTbHzYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byGLW3Mfv3UeAkl5kkz47dUlOGBEWkwQ1AjENw0vvlzVnXY1WOTSpMGw6dXlHK8X+3j3dLSC21OfzNSLak0knXc7HIuKDGzIbQSfdBHv2DrtUB6uRXdkDNofkTPISGtN8P6fm11MZ4iSi3HM+zJ02swywv5nstzIEtnAxH8A5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KLDapSPL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4E7641A174A;
	Wed, 29 Oct 2025 13:53:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 237EE606E8;
	Wed, 29 Oct 2025 13:53:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86192117F80F6;
	Wed, 29 Oct 2025 14:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761745989; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QiRKufBHvQpmJwKLnrkextSnGSsnCJs7BLMNg+4LYZU=;
	b=KLDapSPLDC8T97IxfY2RfqV/UGpZoYNgAriC29HDhZ7YYyOLgpIZxzBPfs21Qpy194Rint
	AtRnq3oJdLE4C5YYdxYTw42O/5HyqKvTpybgfXJ4fAtm2G10vCDpDflLSfIcSw1+pUnUOt
	dg1vd5mOGxETMoiQZAbXIPt5q9nGc4I5jAAWMeXEv9JL9ojf7cdXQWsmVWH+9zbSXH/Xwg
	IAq0wfN9slY0kNYYa/mX0W85ufLlCVQc8PWloOVRDbZmYyMGRQ5r6ytzwURBgVE+JwepM9
	4u7lkhmUPNlDQn4Mms6Mhd4WKp0dGLrirkcKpfcTRiWw81Bb6bdKZlkVFu1UkQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 29 Oct 2025 14:52:33 +0100
Subject: [PATCH bpf-next v6 12/15] selftests/bpf: test_xsk: Don't exit
 immediately if validate_traffic fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-xsk-v6-12-5a63a64dff98@bootlin.com>
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

__testapp_validate_traffic() calls exit_with_error() on failures. This
exits the program immediately. It prevents the following tests from
running and isn't compliant with the CI.

Return TEST_FAILURE instead of calling exit_with_error().
Release the resource of the 1st thread if a failure happens between its
creation and the creation of the second thread.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 2c392d5b9f30145cf7b0ea8a49990f1673bef6c9..18a6ce648461de1975aa25997a22c77cecb97a76 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1772,12 +1772,12 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	err = test_spec_set_mtu(test, test->mtu);
 	if (err) {
 		ksft_print_msg("Error, could not set mtu.\n");
-		exit_with_error(err);
+		return TEST_FAILURE;
 	}
 
 	if (ifobj2) {
 		if (pthread_barrier_init(&barr, NULL, 2))
-			exit_with_error(errno);
+			return TEST_FAILURE;
 		pkt_stream_reset(ifobj2->xsk->pkt_stream);
 	}
 
@@ -1791,8 +1791,11 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 
 	if (ifobj2) {
 		pthread_barrier_wait(&barr);
-		if (pthread_barrier_destroy(&barr))
-			exit_with_error(errno);
+		if (pthread_barrier_destroy(&barr)) {
+			clean_sockets(test, ifobj1);
+			clean_umem(test, ifobj1, NULL);
+			return TEST_FAILURE;
+		}
 
 		/*Spawn TX thread */
 		pthread_create(&t1, NULL, ifobj2->func_ptr, test);

-- 
2.51.0


