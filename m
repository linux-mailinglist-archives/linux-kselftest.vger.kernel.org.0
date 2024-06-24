Return-Path: <linux-kselftest+bounces-12539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11672914120
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03112837E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC9D272;
	Mon, 24 Jun 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i52dzCmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFCC8FF;
	Mon, 24 Jun 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203697; cv=none; b=gubX+OxQfYzdXhJm/2TBehHpTg7W3ePL/+2TQMZ1CD94n/xsxPMtJ3rVmudT+h0khzXZ8cL86lwDiTLgqxSrv7ByWCMM+ciqF2ARleDK4FKwLjD4VrOtXDk+ydc1gpjxlm+cMfoGRuIllyF8pJsVc3XmNRYt0CRI+BwMfrvh8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203697; c=relaxed/simple;
	bh=77ptUYc9mTzaKoAWPDm8Ub6GybZslnYg2gGWI2kKJhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARaqXdTlg8jOjCVJlbbRYDmh7z7lO6rp2mZnuzmve+pewH/YQ73GuehuA59FAx+LsWbaoZQWiAE82eB9CxVcYhwinHY4OglL0wxKSS5YugsQ+HClFcw6JFbQh+pVvG1UC59mN96SL2elI9sYPBeC0gAkyedMAiMkG8aJUvNKDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i52dzCmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F7FC32786;
	Mon, 24 Jun 2024 04:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203696;
	bh=77ptUYc9mTzaKoAWPDm8Ub6GybZslnYg2gGWI2kKJhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i52dzCmCLBOPDBxDPD5M+wzykLF0Ajq4LDMaZeUP/rZuXgUcOBnVjzg982lmZEwu7
	 hwT19bAwOfnkr3vX+GCEHoV+cTGPMraybEbYdqstlyr3yTUlvQevKqv7/H51D4tYP/
	 EDlaT2NOKXWKUWQ7HQEMlMGmUr1E77HlTybFgswUhcbCgRzAWyoKJ5nm4878tLAExx
	 sw0g5Y7Y0PuOp/qlzUcDG/07TgJv5v5ojS6ZilRNFSevRMdqROWT2a+SIGHSTzgaSd
	 MPnvggzGoEmCCSMQox3tSLsTZJejSbJHnUz1/IYqLNmpFJ/cYA7zHRTh5OWjypFG5I
	 YDZwe6+29Cjdg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 5/9] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Mon, 24 Jun 2024 12:33:52 +0800
Message-ID: <956fc734ac44a0b458b8819960cce2ee5a03dea1.1719203293.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Server 1 fd should be closed in the error path when update_lookup_map()
fails. This patch fixes it by goto "close_srv1" instead of "detach"
lable in that case.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..de2466547efe 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -994,7 +994,7 @@ static void drop_on_reuseport(const struct test *t)
 
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
-		goto detach;
+		goto close_srv1;
 
 	/* second server on destination address we should never reach */
 	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
-- 
2.43.0


