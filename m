Return-Path: <linux-kselftest+bounces-11669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD1903799
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 11:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2596228A272
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E84F176AA8;
	Tue, 11 Jun 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ2kLVPU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3317625F;
	Tue, 11 Jun 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097250; cv=none; b=KkRPb51o4hOXaKH0H3ggZjz4driduJIQces3acggbL8DcoaC3FIJ73zFermpBDEQqq30WtsRUysuuFwC+qeybPzbL5mmHuB/L3UqJWoqKcMvOPCtxVTsGMzq4845pFnGPNeuzkZPYX9CtCMLr5OGhkrCNOsUd9TIAlZ8BIkErOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097250; c=relaxed/simple;
	bh=VWF2BN3M74sWgL4r0nHVKCmPDvs57NQeQDcbDpP5OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syps506hIc52Y7MKUNXKhTJGM4/4isZCIrtDwDCLXyXHATs+763x9w1lm21upnqb6a5ezGBo3Yg38VTxmbJ0L8ug4iDeu6DNrwEjuWdoBTOaxuNO2V8zCGa22FTFcnnbMJaCRzRuYt86nV7/i3PWNnOCGT+WK8EZmieT+7BuJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ2kLVPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797AFC2BD10;
	Tue, 11 Jun 2024 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718097250;
	bh=VWF2BN3M74sWgL4r0nHVKCmPDvs57NQeQDcbDpP5OYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZ2kLVPUiamJO4LB+z77wLYTVv+v3VraBW/u+gAsNhHG/ActUp1et+OsVEyDz34cR
	 cbShcphc/reNow5ZpTBmVeKB2l4q1ZJ/ABDCsK/Q48AqhqQjfq8rwZJjw2Jmimxiah
	 z8Pj28WGQZkz2b5w2LYVMvqV02narhxaKk6iw+AkgeOPaLCer4+kcAuux/jKhQyO/I
	 98yR78dZCj1RKovDfPk+4HhExDVWhIRGRN7XyTSlsU6c/NjPl9Dxlo6t6yW6ruUABB
	 1Axf5wzxawQqOPYrRaO+x+IHXkHZpSoGuc4D4uxFBvS0c7R/0P+ejV6aaCKp0ivvoc
	 bEsLGOak71gTg==
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
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 2/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
Date: Tue, 11 Jun 2024 17:13:35 +0800
Message-ID: <dfbbec2d3144d8fd1022fa8326d53a3e511d63cb.1718096691.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718096691.git.tanggeliang@kylinos.cn>
References: <cover.1718096691.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
it to set file status flags. If O_NONBLOCK is used as 2nd argument and
passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
3rd one.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_sockmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 9cba4ec844a5..99d3ca8e44bb 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -604,7 +604,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		if (fcntl(fd, F_SETFL, fd_flags))
+			goto out_errno;
+
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
-- 
2.43.0


