Return-Path: <linux-kselftest+bounces-22394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C479D49E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 10:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D761F2251D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826A1CFEA7;
	Thu, 21 Nov 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9yWuJye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C251CD1EE
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180967; cv=none; b=iccLwqrSWKSAY+WPm3Z93KFVdfugE5iXgGwLNMGW11UkmB0mHryjGKPX+9HhXjQO+YEA+rHxInIGkwByMwkBP4ZQyS7oblkIlAxHcKxMpJbmU8dieIHUCy+ke0MYtvrmkt+qlFnpCYCDqzwtCQfb041RaEjbmtvGQ8iew19nrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180967; c=relaxed/simple;
	bh=IvkNi9MB9Gz+9logpWHPs9ebHF4rDxj4KcN9SKM0J3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbJD2J5pKgBJlYy8D2jfJPOafVZJ7xFNEE8whJXaRx4A9rDzxx2M6aKjzAo9H2sXl4uXpJS+WSeuxAzKP+jUrB14NxwERTUzkoK9cLKjRd912nAinNq3/Zd3XpqxN/lKZtAsALhjGK0mm89U5uT1uJz8j3PhONorLgol4GyNQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9yWuJye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ib0sSUsurO82uUHQHx2yt3sntw+yckXm2URc0dpDKg=;
	b=P9yWuJyeCSrr8f23/JIKQxIPohwbq1G0Ffc428jII790vlsiaQP8TBDlW7HQsB9KJZYOXc
	p/l1fjdVIaTq6Q9WEYgAwfv7nWDbOXLVRbWsbmKEc5Rt4GFaho3fBvXNdCuPerAldwhVYx
	H40fq/HRQgZJQeeq0/oI1TCexT6s1Tc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-ac1ESauSMqGJTWIPhqNGpA-1; Thu, 21 Nov 2024 04:22:42 -0500
X-MC-Unique: ac1ESauSMqGJTWIPhqNGpA-1
X-Mimecast-MFC-AGG-ID: ac1ESauSMqGJTWIPhqNGpA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa2099d0114so172124866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 01:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180961; x=1732785761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ib0sSUsurO82uUHQHx2yt3sntw+yckXm2URc0dpDKg=;
        b=xKz9kGoHmOyCcjtRoLudRV2zmu4n2+OzIkORfOppHJSdbo5tkboUiP0b5ZMd8GvJpN
         E7b8CBCI8mXTvyDzKSd9H4fuOoNnN31uFX+0T5cMlJiEmo+o8uELa+ArFbpKyy8wtDx8
         mWVGZ3YYOUN0SSGmzRIWu5BfuAZ0TntCRsZuwSSB3JjKZwpKjH37M0kawAy3qidfE6DZ
         KvTPhUSMBTSy06RFuI4Ep8jQEAiORkE4YS15l9oMIOSy6BJVA8aOB1XnFzUKGeLNC+Nz
         asgm+Mrj8GOlQgp7rvO+8NL/dEnJE60r9sFbSv0+ei3GL7idNzOLJtMZKTU/NW2PhjdM
         zTgA==
X-Forwarded-Encrypted: i=1; AJvYcCU7gD8hFq2np7NdeE5newaEeQUZAEYPf6cJo6RaJMhz9T/d9pTNMZcu4tj72rgUyzOSIT8wcN3OYa2a7krX284=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZFQ3a7UwiyhNpINtYpVZvU8uN1a6J019JSWAFPkW6RMrlZUh
	EfHwLlfCH3weKmvBmIIOY3yeU6k1bzooBiQ6ilx0HpLhXZ4rfLsWJyhuKZujX0cam+4CY77sKkM
	7RqsD0HBLHd0a+6iojR7DuLMovkzwCFlo7dR3/u2O634lIIjSsI7M3eXohUU/wbY0rg==
X-Received: by 2002:a17:906:4fd4:b0:aa4:cd1e:c91b with SMTP id a640c23a62f3a-aa4ef969ef9mr248993066b.7.1732180961481;
        Thu, 21 Nov 2024 01:22:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEk0q5Vdg3xAj2kuDWsfXimxNkzbgnZ/hzB33Foag073HTmnVH6K258Cxw5HfZC3jrA/MlmA==
X-Received: by 2002:a17:906:4fd4:b0:aa4:cd1e:c91b with SMTP id a640c23a62f3a-aa4ef969ef9mr248988066b.7.1732180960769;
        Thu, 21 Nov 2024 01:22:40 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4152c49sm58523866b.27.2024.11.21.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:22:40 -0800 (PST)
Date: Thu, 21 Nov 2024 10:22:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 4/4] selftest/bpf: Add test for vsock removal from
 sockmap on close()
Message-ID: <c7d37htqscjjzhgauc4v3iwpncbencvacaphvo7sr7snb3cvhy@eego44ccc2no>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-4-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-4-f1b9669cacdc@rbox.co>

On Mon, Nov 18, 2024 at 10:03:44PM +0100, Michal Luczaj wrote:
>Make sure the proto::close callback gets invoked on vsock release.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> .../selftests/bpf/prog_tests/sockmap_basic.c       | 31 ++++++++++++++++++++++
> 1 file changed, 31 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>index 21d1e2e2308433e7475952dcab034e92f2f6101a..c502e1590dcc1d8b06c82673e060839479d99590 100644
>--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>@@ -108,6 +108,35 @@ static void test_sockmap_create_update_free(enum bpf_map_type map_type)
> 	close(s);
> }
>
>+static void test_sockmap_vsock_delete_on_close(void)
>+{
>+	int err, c, p, map;
>+	const int zero = 0;
>+
>+	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
>+	if (!ASSERT_OK(err, "create_pair(AF_VSOCK)"))
>+		return;
>+
>+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
>+			     sizeof(int), 1, NULL);
>+	if (!ASSERT_GE(map, 0, "bpf_map_create")) {
>+		close(c);
>+		goto out;
>+	}
>+
>+	err = bpf_map_update_elem(map, &zero, &c, BPF_NOEXIST);
>+	close(c);
>+	if (!ASSERT_OK(err, "bpf_map_update"))
>+		goto out;
>+
>+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
>+	ASSERT_OK(err, "after close(), bpf_map_update");
>+
>+out:
>+	close(p);
>+	close(map);
>+}
>+
> static void test_skmsg_helpers(enum bpf_map_type map_type)
> {
> 	struct test_skmsg_load_helpers *skel;
>@@ -935,6 +964,8 @@ void test_sockmap_basic(void)
> 		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
> 	if (test__start_subtest("sockhash create_update_free"))
> 		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKHASH);
>+	if (test__start_subtest("sockmap vsock delete on close"))
>+		test_sockmap_vsock_delete_on_close();
> 	if (test__start_subtest("sockmap sk_msg load helpers"))
> 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
> 	if (test__start_subtest("sockhash sk_msg load helpers"))
>
>-- 
>2.46.2
>


