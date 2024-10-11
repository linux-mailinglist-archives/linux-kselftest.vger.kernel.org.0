Return-Path: <linux-kselftest+bounces-19563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD799ACB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 21:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7E1F22BAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F91D04AE;
	Fri, 11 Oct 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1rHam6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D61D0433;
	Fri, 11 Oct 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675188; cv=none; b=tokToSJvczxPpvflZh/bFgTIBS8t1l3YQhVFr5mhtl7dElhAOC2oNE5+gHDLeeTQ5aNviBoRHYFQJqJQJcs+AJbRDy5zYP8Y8UwcCpQFdoQrW+BilzzkvDqAQ/xMCAih5Q6mHS6mqVOk+0XvbTp0eCIiPwlVHI/7fduHkOnA6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675188; c=relaxed/simple;
	bh=Ds+rtLhrKjivgzwXwvlCGH6IUzyK3YJZdokxICABi5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqnS6DiPt3d5j7R3GFodoma8fa8xwRkAwxc/nCYUVxvKPi9nkxgAfb4VYDbvAoKkFMJvMMFgAGNdvEDAus+WN6WhdazS6P+LbNBelFQTrgwedysRrkX0cEcMPhtMkOBxrY0sY/zz2+wXiOpOj+pM/DhVh3QhNNz0qeR0v1JXXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1rHam6u; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e129c01b04so20565867b3.1;
        Fri, 11 Oct 2024 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675185; x=1729279985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdAnCzT1tEcd7rHqnIUWhK8S7C7ggzWXQDUDyBxWWgQ=;
        b=J1rHam6uQh3MKH2sYF4k+ZRdWxyV+VWUbA0k3b8E3BggfhLPamS6r4TIJXjxas49Ng
         nrofCdbO11r+oiGqTG2jKc3HLXSSZQ/5w9X2MOt/0ogbquZbh9ml1Oq5JFt6f/T27VDx
         9O712D0M7XzxDTgPTVGaqLliCMzlQWu4upz7FLLC9chu0VLGMrjSeGHMkXXr+err6pNa
         h1sVlSsmS9j/xpKpCfjHnNvnL4hgU6jIUtOxAk0ZaSUl0JkWBp8SyBAeJcNpZ00CE1go
         xGxwDoO0pGYRtEC9DAmJr/WQgJhOiCK0aTGPzLf+9fw38e1IMiDCnF3BGjoGvPL4saj7
         sAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675185; x=1729279985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdAnCzT1tEcd7rHqnIUWhK8S7C7ggzWXQDUDyBxWWgQ=;
        b=AHhEplAMlr5lr055ISKBgDf0p9mtCDNF9QaXbTLkZnHzcGv3RIssyCPUSEj2CX2bCF
         YZjCkAwvZOID6g84DNQj6tpnMlELm0HRMe4c/uYJpGRv6rle44xUU/SeAfiViVgxUk78
         yIb5BC4eBH06K6iOqr3aSS+PxYtNh8g47pqY7W/vfQLlUiU3oHKm3IJ3TY2mBMi0Ohk+
         A+E0UUTyHzkDUOOCm64iJEGus9Cd+FNzXVZ7MfdLNvdzjQ4TUKLuh41bU5hjPL+gCAOs
         v8as9/hjtZnJ/B5zUh9KnUMaibrWY1A+e+ealNc1Nu6nxMoBpYrlzgeK4we4izL8bl7K
         EwUA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/Zoj8DyZgY7TBdRKmpQfrhQ3oc8UNOec9YiDUldBO5odPbt0qWnX35OiNlTSqPDkx5fzd7J9@vger.kernel.org, AJvYcCW4d+thBAwDKoU9Dq04ZzKKzVRfI/AaJzzf6qGOi+XCSb/dCm7hW2VCN6AYgxql5z7vnsu14SiFW0pdoqZh5l1R@vger.kernel.org, AJvYcCWMhCCPl3pH9/kbEOskhoB3strQPhI1cEJFDwyzYSberJYqNMU7VSILAr72cW9X1GVZpDWhoI7rwOgry+oqmm9B@vger.kernel.org, AJvYcCWZ9ySKJk7vQgkuiH+PDAdBzRRgSS+p2bNHrmO2HUPLxGRtpZX8UEic3QXMgpIz4XI5kE/yorxoQTVOSwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5bZj8wnThxvYdp76hkXwe+CdjHveaZzEn/z3SWa9xdyunE5q
	jQ/sgrtAPrjnMUc9IqkViWPAP5FhK46TZQ/SwJqbTabJbqbWnKUC2HUDgujZ
X-Google-Smtp-Source: AGHT+IGxfrWyXC0QpDM2sh4vtw0dUvoTbJRseu/40lD+LrrD4Q1ucLOricYle+vETBE/3q0fDdDhGg==
X-Received: by 2002:a05:690c:45c8:b0:6dd:c6e1:7570 with SMTP id 00721157ae682-6e3644c0162mr7818447b3.34.1728675185410;
        Fri, 11 Oct 2024 12:33:05 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e332c6f3b6sm7199127b3.115.2024.10.11.12.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:33:05 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: bpf@vger.kernel.org,
	wudevelops@gmail.com
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
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
	riel@surriel.com,
	shakeel.butt@linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: add asserts for netfilter link info
Date: Fri, 11 Oct 2024 19:32:52 +0000
Message-ID: <20241011193252.178997-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011193252.178997-1-wudevelops@gmail.com>
References: <20241011193252.178997-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add assertions/tests to verify `bpf_link_info` fields for netfilter link
are correctly populated.

Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
---
 .../bpf/prog_tests/netfilter_link_attach.c    | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
index 4297a2a4cb11..5bf98ab2e17f 100644
--- a/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
@@ -26,10 +26,43 @@ static const struct nf_link_test nf_hook_link_tests[] = {
 
 	{ .pf = NFPROTO_INET, .priority = 1, .name = "invalid-inet-not-supported", },
 
-	{ .pf = NFPROTO_IPV4, .priority = -10000, .expect_success = true, .name = "attach ipv4", },
-	{ .pf = NFPROTO_IPV6, .priority =  10001, .expect_success = true, .name = "attach ipv6", },
+	{
+		.pf = NFPROTO_IPV4,
+		.hooknum = NF_INET_POST_ROUTING,
+		.priority = -10000,
+		.flags = 0,
+		.expect_success = true,
+		.name = "attach ipv4",
+	},
+	{
+		.pf = NFPROTO_IPV6,
+		.hooknum = NF_INET_FORWARD,
+		.priority =  10001,
+		.flags = BPF_F_NETFILTER_IP_DEFRAG,
+		.expect_success = true,
+		.name = "attach ipv6",
+	},
 };
 
+static void verify_netfilter_link_info(struct bpf_link *link, const struct nf_link_test nf_expected)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int err, fd;
+
+	memset(&info, 0, len);
+
+	fd = bpf_link__fd(link);
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_OK(err, "get_link_info");
+
+	ASSERT_EQ(info.type, BPF_LINK_TYPE_NETFILTER, "info link type");
+	ASSERT_EQ(info.netfilter.pf, nf_expected.pf, "info nf protocol family");
+	ASSERT_EQ(info.netfilter.hooknum, nf_expected.hooknum, "info nf hooknum");
+	ASSERT_EQ(info.netfilter.priority, nf_expected.priority, "info nf priority");
+	ASSERT_EQ(info.netfilter.flags, nf_expected.flags, "info nf flags");
+}
+
 void test_netfilter_link_attach(void)
 {
 	struct test_netfilter_link_attach *skel;
@@ -63,6 +96,7 @@ void test_netfilter_link_attach(void)
 
 			if (!ASSERT_OK_PTR(link, "program attach successful"))
 				continue;
+			verify_netfilter_link_info(link, nf_hook_link_tests[i]);
 
 			link2 = bpf_program__attach_netfilter(prog, &opts);
 			ASSERT_ERR_PTR(link2, "attach program with same pf/hook/priority");
@@ -73,6 +107,8 @@ void test_netfilter_link_attach(void)
 			link2 = bpf_program__attach_netfilter(prog, &opts);
 			if (!ASSERT_OK_PTR(link2, "program reattach successful"))
 				continue;
+			verify_netfilter_link_info(link2, nf_hook_link_tests[i]);
+
 			if (!ASSERT_OK(bpf_link__destroy(link2), "link destroy"))
 				break;
 		} else {
-- 
2.43.0


