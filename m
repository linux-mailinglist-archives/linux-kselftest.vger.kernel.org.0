Return-Path: <linux-kselftest+bounces-45944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90AC6C5B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 03:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0B1F82C792
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421282857F9;
	Wed, 19 Nov 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCPAIoOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E21F0E29;
	Wed, 19 Nov 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518780; cv=none; b=DTrIZBIAS6KADmBnO6TAAJZP274z18Q9jg9M4Jg7+yCpqXafQJYiyXLjxtull0ma/0lrXZ2g68tLbITlpUek+MpzDkyAUNnvsXSl/MAwif25lJQ22aFxk3ED0RNpLEgfnsmZXMSUJ3Bh72YR2Lr8YwZfDnaD2vpiwDVdVB8M2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518780; c=relaxed/simple;
	bh=r5L1/Q/k/uedwluJ5VJgAYCi+wmAM6JWFGKQTIjpSUY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bSC0kd++f7cparqbfYI1EOEDLHOjA3A5AZK3JOUCjwCJ6LvEbWxsnAWkbhU+YOd7xZtotGx4Yw4qw+mhGrf/w0VAWByq1VvdDgDjpA4W4WcWpGlcIWca0snPIB1pUnXbBUPfuzjUfAhGz4kom7g97ooyw2EzN94k66Q2KsM4pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCPAIoOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA15C4CEFB;
	Wed, 19 Nov 2025 02:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763518779;
	bh=r5L1/Q/k/uedwluJ5VJgAYCi+wmAM6JWFGKQTIjpSUY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DCPAIoOJSLMi4FmnMqskKe8EdyEYbJIB9hGyWz2qiCrTwgkT7zdJ30VHLCukc++BA
	 onD6w/3UT5zSVato/En8ON6C5sgBD8KvgJMapI1W6qq4kw73xEblN69oSbXa3EKoNX
	 JHXkV/7Ark080xqGyoKkC6eXQq6J4I5rH1jbN8DzeiPLrfyPZ/cuDZGFYHX8L4EO4i
	 ytxF8nSdpVCUgszzZ5e4Zr3q3kzRBJKjbNlGAnzdyQUl9oHK/FIx1JXLQJ4aozRSAy
	 pQCBd7ypxiUAvwUuoTha2tMAOOBfp1DKIZnsd8FlDP/nBOHQSFft2cWdJmHxJVUbUw
	 BHgwM6F26X3TQ==
Content-Type: multipart/mixed; boundary="===============8277338526258858474=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb8b9352ae1c7174e7be81d16fb8cb880b72cb48c76f11c634aade79a601d176@mail.kernel.org>
In-Reply-To: <0017945a4297a296c87a65d62cc4bd9948f6c20c.1763457705.git.zhuhui@kylinos.cn>
References: <0017945a4297a296c87a65d62cc4bd9948f6c20c.1763457705.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 2/3] selftests/bpf: add memcg eBPF struct ops test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Nov 2025 02:19:36 +0000 (UTC)

--===============8277338526258858474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> new file mode 100644
> index 000000000..3f989bcfb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c

[ ... ]

> +void test_memcg_ops_double_attach(void)
> +{
> +	struct bpf_object *obj, *obj2;
> +	struct bpf_map *map, *map2;
> +	struct bpf_link *link = NULL, *link2 = NULL;
> +	int err;
> +
> +	obj = bpf_object__open_file("memcg_ops.bpf.o", NULL);
> +	err = libbpf_get_error(obj);
> +	if (CHECK_FAIL(err)) {
> +		obj = NULL;
> +		goto out;
> +	}
> +
> +	err = bpf_object__load(obj);
> +	if (CHECK_FAIL(err))
> +		goto out;
> +
> +	map = bpf_object__find_map_by_name(obj, "mcg_ops");
> +	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
> +		goto out;
> +
> +	link = bpf_map__attach_struct_ops(map);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +		goto out;
> +
> +	obj2 = bpf_object__open_file("memcg_ops.bpf.o", NULL);
> +	err = libbpf_get_error(obj2);
> +	if (CHECK_FAIL(err)) {
> +		obj2 = NULL;
> +		goto out;
> +	}
> +
> +	err = bpf_object__load(obj2);
> +	if (CHECK_FAIL(err))
> +		goto out;
> +
> +	map2 = bpf_object__find_map_by_name(obj2, "mcg_ops");
> +	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
                         ^^^

In test_memcg_ops_double_attach(), the NULL check is validating the wrong
variable. The code retrieves map2 from obj2, but then checks map (from the
first object) instead of map2. This means if bpf_object__find_map_by_name()
returns NULL for map2, the test won't catch it and will proceed to use the
potentially NULL map2 pointer in the subsequent attach call.

Should this be checking map2 instead?

> +		goto out;
> +
> +	link2 = bpf_map__attach_struct_ops(map2);
> +	if (!ASSERT_ERR_PTR(link2, "bpf_map__attach_struct_ops")) {
> +		bpf_link__destroy(link2);
> +		goto out;
> +	}
> +
> +out:
> +	if (link)
> +		bpf_link__destroy(link);
> +	if (obj)
> +		bpf_object__close(obj);
> +	if (obj2)
> +		bpf_object__close(obj2);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19486904708

--===============8277338526258858474==--

