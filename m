Return-Path: <linux-kselftest+bounces-7847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78388A34A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6EE2822D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D814C582;
	Fri, 12 Apr 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acm9bYoT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B348148FE0;
	Fri, 12 Apr 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942617; cv=none; b=tx6gf3Q2nVXeSxVcV8GxYguw5LO2jRo7bW/cs1QVpK4LsRVweRaki0awd/uyCrS2Oy75iLOtbEhaGVQBoH/V9HwI5Vm0dPszVjPnP3vOpPOZ2RQqEl5C3hpcvqMpr1Ja6NX7GA/w63DC3v7oDdDZ/S8dAEDRuASF6aJVHWFkzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942617; c=relaxed/simple;
	bh=yqyc+7ewwXDVhEaxUfKDeqMwoxH+lQ2/mIs4ApRc4Zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCgLbBfJH6PokCuNI7540LG/KkTcrECqYQxwAiOKCy2Ye5h+d9xiuqYy2a2EVReXOLcJRkvqhIT7YEkmCfoPU3rE8Nb2g4FmR5124q+LFcUJeHAGowH1tPk9jdLCxjPDwXq3uxC88k565mp2GzaIqRLbDwJLsEJnwf6Uo+v27dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acm9bYoT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a523625409aso119723366b.0;
        Fri, 12 Apr 2024 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712942614; x=1713547414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ot0olxXSeXIO2wU3+DtYbAPYGgKtSJPOO0uR/BPdBs=;
        b=Acm9bYoT+FEWlgTay6OgvsgJcHP0EGvPn7eVeutXlEkkIl6FxqBsXsxvG3rLySztgF
         eDrlHSwr8b99uR23BdGI1EEcvSyPAFHqB4KkrzKM/GnkYErVJv91Utvoqbveq3v+3IF3
         EYath3scqbYIepvAm5YCNPf5dyHBYqJw+OsJMDwIl0IX8k7Tq8wFJNb74cL2vrbxgUhN
         +oQFex0gEvO4cJXlRltD9XuhtcNnJJ2NQm19U3Ot1F8LdU6xZj+LqdEc+rt+kJ//AMUF
         DSEX4bq+cmwmjUR7mYh8t1geRX5LUrCn8hqbWo01zuVQPyv/2K42/NxnsZoM0PexCO/+
         GBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712942614; x=1713547414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ot0olxXSeXIO2wU3+DtYbAPYGgKtSJPOO0uR/BPdBs=;
        b=VliAKJGpVukqE54Vrqd+A2QO0Tuhtjk4YAU6kOLHWKppVNjm56DOthFYhFRySdUTWq
         faO/BTajxLJpO8o2Kv9+1HXGXPt1PpjLw0gSMxHsNPDg8glhwbWKqIAxlkxbAZKXWDrG
         OgyA0vieXReEK39dsOPDmqPZKAXq5y+OUXCk6svHtLO3s3PV/nNCXX/yDauY8Bh4fCvZ
         +W0ukS3GSCRtRfFBg/mFbdQfuTWhgTOxfGUSFZqavv1D5nhLh7uaWxTPuqINj3Roq+rg
         fux7lESMaqZQtxMAKDJZ8YVBh0lTxKX/WOVp5oQaTCYHDGPyhZW5zBzYauXs+2qX4APo
         vinA==
X-Forwarded-Encrypted: i=1; AJvYcCXL2xlFFVsakdeg8rv3aTNd2xWJBgsanDGj2U+Qffj04EIHhUXfjRRcRBQZ2BqB6zLX6OueMJZ4WiK1tdeSSU24Tbcv0giMWN23Foik8/uP827im4SBhBphcewTtVxoh3xdix6o
X-Gm-Message-State: AOJu0YzbOpE94+5EBJm8MZcdwRQQNc/+ST+UFCopIkV4clQBPbpANHNw
	2uMZqjgMbp5jvp6M8GzMWANTN2aqceH/I/CasHY5hOUd2yYHhbW3
X-Google-Smtp-Source: AGHT+IFOCmtD+3DEW1CSVQ1cjkoImPqzXzg/TsfBSp8mVOC23bJIL9amD7dBnOLrpHAVPi30o6R1Yg==
X-Received: by 2002:a17:906:da0a:b0:a46:7794:2c00 with SMTP id fi10-20020a170906da0a00b00a4677942c00mr2108362ejb.40.1712942613552;
        Fri, 12 Apr 2024 10:23:33 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b00a517e505e3bsm2023940ejc.204.2024.04.12.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:23:32 -0700 (PDT)
Message-ID: <feacc31cee7270080baf291d854f956896493fe0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/14] selftests/bpf: Add function pointer
 for __start_server
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 12 Apr 2024 20:23:31 +0300
In-Reply-To: <eedd84f856fe2c9101ab4b7086276e4830370839.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
	 <eedd84f856fe2c9101ab4b7086276e4830370839.1712796967.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 09:03 +0800, Geliang Tang wrote:


[...]

>  static int __start_server(int type, int protocol, const struct sockaddr =
*addr,
> -			  socklen_t addrlen, int timeout_ms, bool reuseport)
> +			  socklen_t addrlen, int timeout_ms,
> +			  int *(*setsockopt)(int fd, int val), int val)

There is no need for setsockopt to return pointer to int,
the code could be simplified e.g. as in the patch below (on top of this ser=
ies):

---

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/=
selftests/bpf/network_helpers.c
index f6810bb54edc..30ac03322c61 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -80,7 +80,7 @@ int settimeo(int fd, int timeout_ms)
=20
 static int __start_server(int type, int protocol, const struct sockaddr *a=
ddr,
 			  socklen_t addrlen, int timeout_ms,
-			  int *(*setsockopt)(int fd, int val), int val)
+			  int (*setsockopt)(int fd, int val), int val)
 {
 	int fd;
=20
@@ -167,7 +167,7 @@ int *start_reuseport_server(int family, int type, const=
 char *addr_str,
 		return NULL;
=20
 	fds[0] =3D __start_server(type, 0, (struct sockaddr *)&addr, addrlen,
-				timeout_ms, (void *)setsockopt_reuse, 1);
+				timeout_ms, setsockopt_reuse, 1);
 	if (fds[0] =3D=3D -1)
 		goto close_fds;
 	nr_fds =3D 1;
@@ -177,7 +177,7 @@ int *start_reuseport_server(int family, int type, const=
 char *addr_str,
=20
 	for (; nr_fds < nr_listens; nr_fds++) {
 		fds[nr_fds] =3D __start_server(type, 0, (struct sockaddr *)&addr,
-					     addrlen, timeout_ms, (void *)setsockopt_reuse, 1);
+					     addrlen, timeout_ms, setsockopt_reuse, 1);
 		if (fds[nr_fds] =3D=3D -1)
 			goto close_fds;
 	}
@@ -195,7 +195,7 @@ int start_server_addr(const struct sockaddr *addr, sock=
len_t addrlen, int type)
 }
=20
 int start_server_setsockopt(const struct sockaddr *addr, socklen_t addrlen=
, int type,
-			    int *(*setsockopt)(int fd, int val), int val)
+			    int (*setsockopt)(int fd, int val), int val)
 {
 	return __start_server(type, 0, addr, addrlen, 0, setsockopt, val);
 }
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/=
selftests/bpf/network_helpers.h
index 543295230062..0f0f1803e0c8 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -56,7 +56,7 @@ int *start_reuseport_server(int family, int type, const c=
har *addr_str,
 			    unsigned int nr_listens);
 int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int =
type);
 int start_server_setsockopt(const struct sockaddr *addr, socklen_t addrlen=
, int type,
-			    int *(*setsockopt)(int fd, int val), int val);
+			    int (*setsockopt)(int fd, int val), int val);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, in=
t type);
 int connect_to_fd(int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/too=
ls/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 4fee4b343255..0c39170d543a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -97,7 +97,7 @@ static int start_server_lo(void)
 	if (make_sockaddr(AF_INET, "127.0.0.1", 0, &addr, &addrlen))
 		return -1;
 	return start_server_setsockopt((struct sockaddr *)&addr, addrlen,
-				       SOCK_STREAM, (void *)setsockopt_loop, 0);
+				       SOCK_STREAM, setsockopt_loop, 0);
 }
=20
 static void run_test(int cgroup_fd)


