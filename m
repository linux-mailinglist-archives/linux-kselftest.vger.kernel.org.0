Return-Path: <linux-kselftest+bounces-11751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C67904EFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8964B1F24CE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317F116D9C6;
	Wed, 12 Jun 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE0+tbvW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044832AEE3;
	Wed, 12 Jun 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183975; cv=none; b=gf3dTN+vTKR6ZdnTPf3Bp9OeldBPlpoB+H6XzFKt6/+T0LE/djLa2s0Jvl29w4RgPS8IsE3gZ3ImtwkZKHMHDBwJ9004yB9elzGcFVMO4D3P8gyWriwyDrpdbRdxK6WEabHBkUhmDucQrC+HGM5pxsfJp5NocJpfxJljCXhzGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183975; c=relaxed/simple;
	bh=VWF2BN3M74sWgL4r0nHVKCmPDvs57NQeQDcbDpP5OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUERAZY0Kp7nBi5HoJ3Djtvb1+w2ALGhQMPLg3W757wgprRSz8rzqmKa7ryeckk5iUxKf13yk2UYPeFnrk1pbRKIbzzPbIC1bD4DQil8hubYM67mC2xxTyFkdpNTNJKZUJW/x88LsykxBfI82st5JhGHd6HJ53gQm0IV6azwoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE0+tbvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235B7C4AF48;
	Wed, 12 Jun 2024 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718183974;
	bh=VWF2BN3M74sWgL4r0nHVKCmPDvs57NQeQDcbDpP5OYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JE0+tbvW0j09JGIOaGiJqVIXDw22trEwQWoQp1DZrucwJbpk9i3ecI1z6nknrbee7
	 Snc9xO/vHP9RIGSZKy/T3ycP1ENXlaPr9+lr4VcdLwLP3D2mYQpGOV4ejo9ocqBb+w
	 A5RdWYF0w498tf+elYvXPPVzfAUjppUfPacpCqZEfUCASLfl8I+WC4iIysj+MykTO9
	 MtOpZO+ChidNQXfTmUPebdpYoXW9w/XLjw63rn/PyoatC5/p96DrW3D/kzsnu8ZyEW
	 g+HFiqTBcJM6S5xdd+iZOASF7xaZNyAMCdGD0ncGMkFWWsqp+5IpI6QNLGK+l5qB/6
	 n/fd56Dy9dQig==
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
Subject: [PATCH net-next v7 2/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
Date: Wed, 12 Jun 2024 17:19:04 +0800
Message-ID: <783f589f00b91ae3f8812a736fd64b4eb4251364.1718182183.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718182183.git.tanggeliang@kylinos.cn>
References: <cover.1718182183.git.tanggeliang@kylinos.cn>
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


