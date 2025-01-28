Return-Path: <linux-kselftest+bounces-25282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15502A207E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F83A7CC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32A1A0B08;
	Tue, 28 Jan 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ForxzpHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B119B5B1;
	Tue, 28 Jan 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058265; cv=none; b=PqtKJvcuL/elHQD7i8dxQUwhonrecgRBfYsN0p30nVBhdx7pP606rFwi8ce3qIWx/mBDjrBLdztw8OKE6YidOZhe6zH8A/bTczVxLsRBNfNpqFGc1kBXtEOkFmE7EB40nulWJjR8+5q+ezJYBOOHGV+TdGfEsU3elHefIygobHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058265; c=relaxed/simple;
	bh=t07squ0lDsXeFgcpolq3+T/g/jj9OSHHyenikbPH2hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuGfPqc9ok94ZtQw+L+mmYC24X7R45IfT9zmef25WRxQo3/CPofYIcSaxGfIdDF4WguOZWQj+1oKynvE36rbeLbCN+YLLnCvE/3n8amT4vROYZodmAADRDn9cBJOsMFHhMHmCXO2w5m13nQWCBg3mQZVfv+pJodB8xphFT7k1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ForxzpHk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 410871C000B;
	Tue, 28 Jan 2025 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVYXgJ2eM3z1P05IsjA/nxBu6ly6wOhvQAnq4IfFFgQ=;
	b=ForxzpHkFSxMFdOZTISE3mttGtm+1hJfVG16AywTUpFKc4W5KB4vBP4EIo6t2Yc/lG+sSq
	nIXWPeDTsXSJZRxbApYlOxCK48BW+0v5KyEO92shTM49r2Dokt+VKclX4bR+B2/lCKOCZH
	UuVT656uRAgxLBsmRRaAguhaISHpKvuqvxAWiE3HqoiHzfDmOxtzPVe6Sh8kb+HTCrBoDG
	Zgted1TyJK8rtM4lXTA/FIg52th8nCt6UgeU1cN6z6+/9k4cKBSO/3shkzRFQe9zqogbAS
	0uOBKqYFy8V4QYA8uA9xUHeIOFvCqVPVVLkLa3kWOgsx3BOOszuAURJ+Iyun4A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:25 +0100
Subject: [PATCH bpf-next v3 01/14] selftests/bpf: helpers: Add append_tid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-1-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Some tests can't be run in parallel because they use same namespace
names or veth names.

Create an helper that appends the thread ID to a given string. 8
characters are used for it (7 digits + '\0')

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 11 +++++++++++
 tools/testing/selftests/bpf/network_helpers.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 80844a5fb1feef2ff73c2f0293e52495803ab769..d2ff7521aaa696ed04d8f1308394b4c01c1c038b 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -446,6 +446,17 @@ char *ping_command(int family)
 	return "ping";
 }
 
+int append_tid(char *str, size_t offset)
+{
+	if (!str)
+		return -1;
+
+	sprintf(&str[offset], "%07d", gettid());
+	str[offset + 7] = '\0';
+
+	return 0;
+}
+
 int remove_netns(const char *name)
 {
 	char *cmd;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ebec8a8d6f81e9d079a3b087127a37885c656856..b2451dd00594190e1dcb58498d70dd80c0e7c51c 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -98,6 +98,16 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 int make_netns(const char *name);
 int remove_netns(const char *name);
 
+/**
+ * append_tid() - Append thread ID to the given string.
+ *
+ * /!\ the appended thread ID is 8 characters long
+ *     so the input string must be allocated accordingly
+ *
+ * Returns -1 if input is NULL, 0 otherwise
+ */
+int append_tid(char *str, size_t offset);
+
 static __u16 csum_fold(__u32 csum)
 {
 	csum = (csum & 0xffff) + (csum >> 16);

-- 
2.47.1


