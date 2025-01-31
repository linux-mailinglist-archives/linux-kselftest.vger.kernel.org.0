Return-Path: <linux-kselftest+bounces-25466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B7A239DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9108C167EEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3516155A25;
	Fri, 31 Jan 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IHaElLR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6113A3ED;
	Fri, 31 Jan 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308111; cv=none; b=SicEb33oX/rL01xWy7Upa9dpRdvACqR9N+7A/j/z9qQYlhK6UdZ61GrHjCGnoR4N69hPYoIypnQfhXAk5LdUiN7qlbJ2MeCiJj1GAXwKPwJrMkXXyBPjNEggfz6H5llaaJvbdWVzE6sEvid1x24fJkrRFcfk2t9ciVBmMrMBQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308111; c=relaxed/simple;
	bh=eVAbdytB3sNDr0gfqwT5O4MjAtw6BtYeMJi+x/eLs+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlpg1zvimOgJE0aaC4G6Vc0jc+PCzU+/cGK8rrvzBT68oJVS2HXT2JI/lCqVaXhN040XrJJ7SuO4oblKU16T0Cs78/Zl69ja9STxnzQ0Zc3mjgPZt84XLvm+d7IXvmQoqEKgk3tejLQ0LgLwVhP0PTmdyrGqfwD8uSvBlq9Zkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IHaElLR+; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15D9D442D7;
	Fri, 31 Jan 2025 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfsuKpt/REntW+rb73QvVUp0ruIrtd1BeJHvRvFSCTo=;
	b=IHaElLR+UZOw44JRxAPaxj63cd3N+sMaCS8J2PyuUfWpqbImJlWxHQxsUcx2T8pxRrAY9U
	4PMbNtrM5nijI+2DCYl2finGka6ovb6IzajVmPxE3y7oMTo2+BVEAN44RFUQo624YESv0U
	Yhaxv6Y9m1DoESkPphJLKQTDa4th+HpTGR3GxGlpVf7d523tLqOyTPL6hBwS5DBaDWOaEv
	FQxaoW4PDWbHt0A+Iff+gWuLwT8cxrvm8k6548huHhtfYiVt1qHP2AoY9u2qRLPsVsQxrI
	uffPr6HUNzpgez7PN4RPUbbLbAHYuH4r7JH+l+SftDc9GTycbsz1QbGNe8riVg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:40 +0100
Subject: [PATCH bpf-next v4 01/14] selftests/bpf: helpers: Add append_tid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-1-970b33678512@bootlin.com>
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
In-Reply-To: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

Some tests can't be run in parallel because they use same namespace
names or veth names.

Create an helper that appends the thread ID to a given string. 8
characters are used for it (7 digits + '\0')

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 17 +++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 80844a5fb1feef2ff73c2f0293e52495803ab769..a4252e000428415a7a1eb906d857038facd91735 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -446,6 +446,23 @@ char *ping_command(int family)
 	return "ping";
 }
 
+int append_tid(char *str, size_t sz)
+{
+	size_t end;
+
+	if (!str)
+		return -1;
+
+	end = strlen(str);
+	if (end + 8 > sz)
+		return -1;
+
+	sprintf(&str[end], "%07d", gettid());
+	str[end + 7] = '\0';
+
+	return 0;
+}
+
 int remove_netns(const char *name)
 {
 	char *cmd;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ebec8a8d6f81e9d079a3b087127a37885c656856..9f6e05d886c544aa2db4be164a4acdeddd394aee 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -98,6 +98,18 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 int make_netns(const char *name);
 int remove_netns(const char *name);
 
+/**
+ * append_tid() - Append thread ID to the given string.
+ *
+ * @str: string to extend
+ * @sz: string's size
+ *
+ * 8 characters are used to append the thread ID (7 digits + '\0')
+ *
+ * Returns -1 on errors, 0 otherwise
+ */
+int append_tid(char *str, size_t sz);
+
 static __u16 csum_fold(__u32 csum)
 {
 	csum = (csum & 0xffff) + (csum >> 16);

-- 
2.48.1


