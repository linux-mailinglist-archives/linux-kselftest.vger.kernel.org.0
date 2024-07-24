Return-Path: <linux-kselftest+bounces-14143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372CD93B05D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5F828510A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6415884E;
	Wed, 24 Jul 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="A2VLeIan"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F615687C;
	Wed, 24 Jul 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820832; cv=none; b=ZWci4KDlsNpfxZwoDD1aSN+f8z/Y6zFkY1Sn1fgLajr5j2ZItslXKS6a/GZM2uWz+bjX2vrYBsxJ5tE2W/wdDmSf8NScPo1pSuM5+qHpYsP7pCu3AcsDQqI0+A1+d539wKvjQ496jho0V2DzNmqRAdZ3Lx/Fjk+DSBdYAf4e1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820832; c=relaxed/simple;
	bh=YtKGjVmznTaP+uG+xNnwv2w/Omxd9HhwCtFydYbreGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WomBn+z2f8VIGZiJE6lBq4DuK8PamcJbua0uYKgJpVS4hAPRhNNL8igod6AZ5Ngqm+qHKy2P+tF+80XtmknpCLeiwGF6c8HT0hvokUnuXUPchLJmOjmKVmmTzWiLsTauhsd+I9rQ6s9pNGeO3Wj8bFNmSPZYCnrIEK4HpSAQNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=A2VLeIan; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFW-006K1D-SR; Wed, 24 Jul 2024 13:33:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=li0JujrPpPpO/xAc8QiZ65BoP8NJpRd+3obwcRQIRXc=; b=A2VLeIannLvlKeIbbeUZXHmKXF
	cPa+vI+HbrikfEDlQs48lfVnyOXcXuUu5Bt5+bqo0wvBrNpM5lQi19kV44A9kAvNAffysCgIWPK6Y
	s41+PH181jf/MT27I0nxWG3pEY9YcAAnkwmtw0RA6DQv1aqcfDKh9HRkr3867hLXy1BTD3MAbEhZI
	ETbUnc1gqnSgScsSrSb/p5ItxCc3O9dUd+JFUvkBX2ozpKDfGTJ+LorK6I8y7zuPON5/ctFxmwtwk
	6uMdYf8ULTOpIn9KfJMSGS1swDS1h6ryeRDHgERypLJ+NMEf+Vmuiv3uYZUYJgk7njh4wMT7R4/1Y
	+DqZAdEQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFW-0004y5-GE; Wed, 24 Jul 2024 13:33:38 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFN-00EK6H-TH; Wed, 24 Jul 2024 13:33:29 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Jul 2024 13:32:40 +0200
Subject: [PATCH bpf 4/6] selftest/bpf: Respect the sotype of af_unix redir
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-sockmap-selftest-fixes-v1-4-46165d224712@rbox.co>
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

Do actually test the sotype as specified by the caller.

This picks up after commit 75e0e27db6cf ("selftest/bpf: Change udp to inet
in some function names").

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index ea2faacd146d..7ed223df5f12 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1706,11 +1706,11 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	int sfd[2];
 	int err;
 
-	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
+	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
 		return;
 	c0 = sfd[0], p0 = sfd[1];
 
-	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
+	err = inet_socketpair(family, type, &p1, &c1);
 	if (err)
 		goto close;
 
@@ -1758,7 +1758,7 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 	int sfd[2];
 	int err;
 
-	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
+	err = inet_socketpair(family, type, &p0, &c0);
 	if (err)
 		return;
 

-- 
2.45.2


