Return-Path: <linux-kselftest+bounces-10029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822808C2A32
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0850D1F21734
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B945000;
	Fri, 10 May 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xN4OQJyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF814437F
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367774; cv=none; b=hHJbKFanLwqKOVeT2c1qQSDyEh9mihoGqrjvEFlTBTi3dvIsKX35u/kBf18Msyvpq6fc9sZ27s/DBg0uSQVHNOdXu2LrQdYG0Hb0Oj3yaNFooFpcqnwxckoICuPvGIQxDINGNY3EmMDtj+OgsII9IwnlESxvgi0iKn3pAAp2vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367774; c=relaxed/simple;
	bh=CPTzIBpBUMDgBprW3FRQVaROSgqLJTrjamWR+lIU0sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUgkgMPrb4REQMEkWJqFvEafYFc6TYgFrKiQQlGOFMzUmUJvv8R63HO78hnpHFJrFd2jWSMSe1u5IM9HSAe5hKfrooK89kGPFFBTZ6nv1f0PqL5Go48TDG14TjmE7N4cctPybe6/pCdeeMwnrvZDE/pAHFd/ewCS/HsCleg0sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xN4OQJyp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2ef746c9so38201547b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367772; x=1715972572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoKZu7FZgzkdLv629hKI87WkJfhZQjotIWuGv5B/Cm8=;
        b=xN4OQJypMIExhTlAPVeAtmPCre2oK1uMnBVNDALS+Vir2sjFJTwHL2eANSl0gOtePU
         wgwr4HQDu+H4tb/4lzuWXDBpBATOHg/pku727yK63VMC1AJWO3wV1R4wd5JyOrwCY+jv
         LB2gnpstIQc5ataNHm6+0vWEAY5B0FfpZKWSXZlPZMk0MczcH6twvxT9lJXAOSnixFJt
         b5oGKB5EoPZgtiosifiPOK97P6/fElAsGs0PIW8c0nYHuOM60jglMBwkoGsCBw4D4kv2
         G5d5QgGMvaD0US2Xj6m+p6/piUdX1XE+JOalGOu7l2QbRl+6ZjJaLeFY6QQJDmo+nstO
         pGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367772; x=1715972572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoKZu7FZgzkdLv629hKI87WkJfhZQjotIWuGv5B/Cm8=;
        b=IxN2i3JOGIZMhpp81J8A7TRGRRuqLa7ipYIE0MVCLEoy7bHd9a0X48EHiYlj0oDnJf
         4/um3FvMadvO2+l7XOTQSP2sJYPUHAJ9G27hGH77eVgAd2y9SDCOoaeDgwthXvzGZXxb
         0HdGMHlQaeSPSsSWBKMGKiYgZIAZ//BSmBPHucOyD1+dSI+wgDi8mUhsMRyRYNNdCI/J
         mg7z3lIJYHubTebLEjJh7RqfCoIKMM/OSNferYBR6vyxuZ7+ySFHAdahw3SrSW0M1tID
         AePbkgS0I8tJsZ7eJOT8IC6zn6DWlCTYrwOhmU/WDnjdL0ImdPwqIVB4aYWIjsv8zRIJ
         XmAg==
X-Forwarded-Encrypted: i=1; AJvYcCXifzu7JIpAhuvk55WJB4Wrx29sX7gS6w9YRyeQViirb9t+Z+Oo10GL73mHds7aJ58QZhXCLCvP6mVQCkPeSj2io666NPU86XyvdNDQyUrq
X-Gm-Message-State: AOJu0YxExcG0bSQg9pJiC4MrRNc2lp1mghJ5PwPn9aRNp/6lN4jY8/KH
	uo4n0jdE8nQKBqqeCvTTVNTIPCMrNPq0kJEi1UeYD7XhkwD73vw2AgG0LOq0Ro971P1c/C+baA=
	=
X-Google-Smtp-Source: AGHT+IEzqsv0+Z1rtmghpikg5OpL+lKefbf5yyB9MFM/+SQZBhusfveAkbNpX69yPBPhna6O96DHKJxyVw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:690c:338c:b0:61b:ea08:111f with SMTP id
 00721157ae682-622aff9d4cdmr8889747b3.6.1715367772166; Fri, 10 May 2024
 12:02:52 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:19 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-3-jrife@google.com>
Subject: [PATCH v1 bpf-next 02/17] selftests/bpf: Use program name for skel
 load/destroy functions
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation to migrate tests from bpf/test_sock_addr.c to
sock_addr.c, update BPF_SKEL_FUNCS so that it generates functions
based on prog_name instead of skel_name. This allows us to differentiate
between programs in the same skeleton.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 96 ++++++++++---------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 9c709c33f8899..039c3e38e1bc2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -357,7 +357,7 @@ struct sock_addr_test {
 };
 
 #define BPF_SKEL_FUNCS(skel_name, prog_name) \
-static void *skel_name##_load(int cgroup_fd) \
+static void *prog_name##_load(int cgroup_fd) \
 { \
 	struct skel_name *skel; \
 	skel = skel_name##__open_and_load(); \
@@ -372,7 +372,7 @@ cleanup: \
 	skel_name##__destroy(skel); \
 	return NULL; \
 } \
-static void skel_name##_destroy(void *skel) \
+static void prog_name##_destroy(void *skel) \
 { \
 	skel_name##__destroy(skel); \
 }
@@ -396,8 +396,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: bind (stream)",
-		bind4_prog_load,
-		bind4_prog_destroy,
+		bind_v4_prog_load,
+		bind_v4_prog_destroy,
 		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
@@ -405,12 +405,13 @@ static struct sock_addr_test tests[] = {
 		SERV4_PORT,
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
+		NULL,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: bind (dgram)",
-		bind4_prog_load,
-		bind4_prog_destroy,
+		bind_v4_prog_load,
+		bind_v4_prog_destroy,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -418,12 +419,13 @@ static struct sock_addr_test tests[] = {
 		SERV4_PORT,
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
+		NULL,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (stream)",
-		bind6_prog_load,
-		bind6_prog_destroy,
+		bind_v6_prog_load,
+		bind_v6_prog_destroy,
 		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
@@ -431,12 +433,13 @@ static struct sock_addr_test tests[] = {
 		SERV6_PORT,
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
+		NULL,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (dgram)",
-		bind6_prog_load,
-		bind6_prog_destroy,
+		bind_v6_prog_load,
+		bind_v6_prog_destroy,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -444,14 +447,15 @@ static struct sock_addr_test tests[] = {
 		SERV6_PORT,
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
+		NULL,
 	},
 
 	/* bind - kernel calls */
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: kernel_bind (stream)",
-		bind4_prog_load,
-		bind4_prog_destroy,
+		bind_v4_prog_load,
+		bind_v4_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_STREAM,
@@ -463,8 +467,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: kernel_bind (dgram)",
-		bind4_prog_load,
-		bind4_prog_destroy,
+		bind_v4_prog_load,
+		bind_v4_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -476,8 +480,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (stream)",
-		bind6_prog_load,
-		bind6_prog_destroy,
+		bind_v6_prog_load,
+		bind_v6_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_STREAM,
@@ -489,8 +493,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (dgram)",
-		bind6_prog_load,
-		bind6_prog_destroy,
+		bind_v6_prog_load,
+		bind_v6_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -504,8 +508,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: connect (stream)",
-		connect4_prog_load,
-		connect4_prog_destroy,
+		connect_v4_prog_load,
+		connect_v4_prog_destroy,
 		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
@@ -518,8 +522,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: connect (dgram)",
-		connect4_prog_load,
-		connect4_prog_destroy,
+		connect_v4_prog_load,
+		connect_v4_prog_destroy,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -532,8 +536,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (stream)",
-		connect6_prog_load,
-		connect6_prog_destroy,
+		connect_v6_prog_load,
+		connect_v6_prog_destroy,
 		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
@@ -546,8 +550,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (dgram)",
-		connect6_prog_load,
-		connect6_prog_destroy,
+		connect_v6_prog_load,
+		connect_v6_prog_destroy,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -576,8 +580,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: kernel_connect (stream)",
-		connect4_prog_load,
-		connect4_prog_destroy,
+		connect_v4_prog_load,
+		connect_v4_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_STREAM,
@@ -590,8 +594,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: kernel_connect (dgram)",
-		connect4_prog_load,
-		connect4_prog_destroy,
+		connect_v4_prog_load,
+		connect_v4_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -604,8 +608,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (stream)",
-		connect6_prog_load,
-		connect6_prog_destroy,
+		connect_v6_prog_load,
+		connect_v6_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_STREAM,
@@ -618,8 +622,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (dgram)",
-		connect6_prog_load,
-		connect6_prog_destroy,
+		connect_v6_prog_load,
+		connect_v6_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -648,8 +652,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg4: sendmsg (dgram)",
-		sendmsg4_prog_load,
-		sendmsg4_prog_destroy,
+		sendmsg_v4_prog_load,
+		sendmsg_v4_prog_destroy,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -662,8 +666,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sendmsg (dgram)",
-		sendmsg6_prog_load,
-		sendmsg6_prog_destroy,
+		sendmsg_v6_prog_load,
+		sendmsg_v6_prog_destroy,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -692,8 +696,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg4: sock_sendmsg (dgram)",
-		sendmsg4_prog_load,
-		sendmsg4_prog_destroy,
+		sendmsg_v4_prog_load,
+		sendmsg_v4_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -706,8 +710,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sock_sendmsg (dgram)",
-		sendmsg6_prog_load,
-		sendmsg6_prog_destroy,
+		sendmsg_v6_prog_load,
+		sendmsg_v6_prog_destroy,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -736,8 +740,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg4: kernel_sendmsg (dgram)",
-		sendmsg4_prog_load,
-		sendmsg4_prog_destroy,
+		sendmsg_v4_prog_load,
+		sendmsg_v4_prog_destroy,
 		&kern_ops_kernel_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -750,8 +754,8 @@ static struct sock_addr_test tests[] = {
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: kernel_sendmsg (dgram)",
-		sendmsg6_prog_load,
-		sendmsg6_prog_destroy,
+		sendmsg_v6_prog_load,
+		sendmsg_v6_prog_destroy,
 		&kern_ops_kernel_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
-- 
2.45.0.118.g7fe29c98d7-goog


