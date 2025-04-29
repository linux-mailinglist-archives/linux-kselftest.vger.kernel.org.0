Return-Path: <linux-kselftest+bounces-31835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B9EA9FEA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF57462CF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C42126BF7;
	Tue, 29 Apr 2025 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOaF0xhJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88977E107;
	Tue, 29 Apr 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888184; cv=none; b=OflwaZnFliDhhYG3HbXfS3DC8dZs2wBqU2Y9SXVx5c2rtPFP3A8EJDAh3/nw3K2o6s9GKUspeRM/Nc3acOFQZ3F9zDEBR/6ZfTsoY2rQISdDm9qxcFx+q5jtr3FONiLdP5LKbY0npw6rmuiS9JzSdphwaLmh2HmggJ33LzWXe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888184; c=relaxed/simple;
	bh=UGHLeiApJf7V1C8ImguoPGkGXxAG1MLhiPDBuTxIWCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVm8QJgQDD7BEre5OZjQvkyzaFIY/iKrya2/3aWJAmQAU9sSZETylkwDnBs5TSvA+dtSv9luaisWmXfYMyfwBg0naLTn8m1Hkbec6+cmC+Q6XWR+T2YNVym3JQ9e0MdegGRoGu6EYfPJopKeFcmo+krw+zGVVuZepHRQKG/EydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOaF0xhJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so5689518b3a.0;
        Mon, 28 Apr 2025 17:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745888182; x=1746492982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtB+mT0E8TIrbKFCUfN6M50HTfM9YyB2DMZzb9JngOs=;
        b=WOaF0xhJ1LUbDMEqIG0qeuxtwOWMP5omy5if+8BPU5qaIGk4Jcnq2F2ij9y2whaLLY
         C7kE8lJhGn1wv8ZKwiL/68MYJlUEkpE+pfBTGd8/8irZ4naxCaCU+mQ5sJjpB2k/PZy6
         JFynKoBSoLPXPt0ja94K3l2cBwyzahADs3vCvVgIxjrWCyMk9+PC/5LPhAfjCjnNvX1Y
         lG/K/wZ5B+I+hdDv0N1SSHqRFFCQ0GQAxYZAF6DGyAfbU+lXLDg3N06oR+5QrVc6msUN
         r8DX9E58x+gZ40JXCLg5hQnDqZ1qCEUFkJq1PAOrV4+0pjB/5JQWtddaKuQCX0KD87aY
         yTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745888182; x=1746492982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtB+mT0E8TIrbKFCUfN6M50HTfM9YyB2DMZzb9JngOs=;
        b=b9NKNvuQqADUpkZEHot+MdNwmyeBVpu8OWf/Yzc2OJPAFDq7M4QhC2MzSTGB/FNk5R
         0tD8/OGhRhaafwMqRkhyEwzbZNpHhAD+HvBiNIDbiE3nK/3ktg6KtYOuePvcxldUqeEn
         GzwVaXrpVEY0lAje6DdWZ+xXv1rkElVPuJxSZeL6iu2glpXr+hxWXACyAHpZyUJpBxMy
         98hFxjuO20Tw6neF9rH6OIEH+alWnwsMMX5SueYLyeI8LXt2Vj4BXodOWV0z2o/x1SUd
         WKMIV2BbvCicfQWvw3iH2wRlvRZwly+d6gWXuBtFYCGcCEKDqoIi+FRmylNXAU3VUHu1
         Zcog==
X-Forwarded-Encrypted: i=1; AJvYcCU+1gLxNgYj0bCrGIKKV5XcuvFyrOgAdIo4lGNFwjeU6cTVRfNriBUuhKLYsowVDTbWgzehvmlDWc1lgpco@vger.kernel.org, AJvYcCV63mgyK0YbS1tnfGFkz8dYUKuB92vAuA5AzF/E9DTqjue6NYXW0RK9yiBpHdetY6Ai5wb07jwDNGAhKHNAYTmO@vger.kernel.org, AJvYcCWzvYxz2YMPdiJa7mFqvcQqhOIbaf6dTqdhfyZN05l5I5Jj8pjJQXianBVb2gqTU30laStJJ6uR+PI=@vger.kernel.org, AJvYcCXZPll0sn0UGZVvlGK1VJC+KWSu4tqadp34/ONR3NYr+xiPBqIubmXjluStqfSW6MGDguEWplDE@vger.kernel.org
X-Gm-Message-State: AOJu0YytJT+U940XxRMA0tTUzKmvyyDsVBiRVVW+ozVob3f686GzzBDZ
	xPyckdpzoJTl5LrF3715M4nqWKyatHwXmC+X7k3jbll6eh+FrvJU
X-Gm-Gg: ASbGncvWg9WtpmOXOREyr4QYv+THFuO2HlOFYvQgBIo/fjETd2qB8pjc9PTuT9CA/I3
	SYNcKRQqeT/ngAEfcOwWeb1JoRqtCZMCXInf8paV9ZiqLAH5ZfzxeI/4iem7rOTjCX2wYjyGYyO
	841LKMEhGrbMpeO4DkLV9eJ4y08l5HheXsgU30OJBhSn+PKJROE0LhqZWDYa3WIh6RvWbGrcf7y
	VkGL+KOuY5s4mTM4XxKkpxLVS0NguzrfSlEBQVQDVtTwWpSV42kVkqNPOvy6itHwXaw5Les4KOg
	Q1QfyUqAAhCW5/q4kpU7ufW8RcoANnd2x4lDL8mmVUWL
X-Google-Smtp-Source: AGHT+IH0mSCIzf4YRTszhlxszcJ5ZHkUQ+VCosBGzav/EA6LiA9LnwUdkxmQ5kQYAzOP/f/ImW8wjw==
X-Received: by 2002:a05:6a20:9c8b:b0:1f3:383e:7739 with SMTP id adf61e73a8af0-2094f670068mr1713198637.7.1745888182032;
        Mon, 28 Apr 2025 17:56:22 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faded634sm7990861a12.73.2025.04.28.17.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 17:56:21 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:56:20 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Introduce a new kfunc for
 sockmap
Message-ID: <aBAjtATRrVNegYjm@pop-os.localdomain>
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
 <20250428081744.52375-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428081744.52375-2-jiayuan.chen@linux.dev>

On Mon, Apr 28, 2025 at 04:16:52PM +0800, Jiayuan Chen wrote:
> +bpf_sk_skb_set_redirect_cpu()
> +^^^^^^^^^^^^^^^^^^^^^^
> +.. code-block:: c
> +
> +    int bpf_sk_skb_set_redirect_cpu(struct __sk_buff *s, int redir_cpu)
> +
> +This kfunc ``bpf_sk_skb_set_redirect_cpu()`` is available to
> +``BPF_PROG_TYPE_SK_SKB`` BPF programs. It sets the CPU affinity, allowing the
> +sockmap packet redirecting process to run on the specified CPU as much as
> +possible, helping users reduce the interference between the sockmap redirecting
> +background thread and other threads.
> +

I am wondering if it is a better idea to use BPF_MAP_TYPE_CPUMAP for
redirection here instead? Like we did for bpf_redirect_map(). At least
we would not need to store CPU in psock with this approach.

Thanks.

