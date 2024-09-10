Return-Path: <linux-kselftest+bounces-17572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BE972B08
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 09:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2431C24213
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CA185950;
	Tue, 10 Sep 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMvXBmn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398901849D9
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954128; cv=none; b=FlyeKtaZPas+YSnM0BUCaplqE6kG59nL1BsL4OngbiVTaEhAHIyOVrcMcJvSX2HaM+6ygruyZN35pCriGfU9FlVeHf5DVSJpfkVNXzjisatBfKAsuNhBrvK8c7pf92JY5FDFumi+ak23jkPHMQt8hlVURNVXmuDKYPhB8mx6+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954128; c=relaxed/simple;
	bh=Qyl+jeM29UcIUIpBkMaXSrvyQbplQx2dePM9hleo3fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QTc7Wywg7/QGMqOIG4cLkyhk5Sqkod28spT3AEiV3wchb5Xh/a0d0E+d/cZZ8U72zJBc+8H0UKr09c4pL27fHdFlqWTjaDlsKXOdn+M3oAPgajshOd5ej4eh6UzwcbztK7qPAFMYgJo2/7Qw4pqqqXGvlTsKpNqQDttFWxPAP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMvXBmn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725954126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuOGAWKRYAVrkFr1NxQHAvJfBsIuxorao5YMycZLxA4=;
	b=UMvXBmn8SzRaGIHUSWmfuIZ/1JctGV5jM1YFtz+TV+NGoIjCKpm0dC3YB16fIsbTXrtpof
	yDQtxIuKDW/DPBLOBy+fypv19pvqL67OYdRiuL+1kfhEuXTDRNRSJhcEmOTO9981iI4Z3E
	l3yjDnD2RzsWs/bXOkddKy4aXaPiFXE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-c3Z2ywIVPSGc1VWjZwqBRw-1; Tue, 10 Sep 2024 03:42:04 -0400
X-MC-Unique: c3Z2ywIVPSGc1VWjZwqBRw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a92ab4dd0so22999666b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 00:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954123; x=1726558923;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuOGAWKRYAVrkFr1NxQHAvJfBsIuxorao5YMycZLxA4=;
        b=L+YMseb1Fqt9Eh68roS3Yt/lttVLLJDLO9ah8n5407QGAQFHE7s5AjD/pVk2iD/ecB
         s9raYXa32k7day61ZWqU4A68bwuJ4nqne7QnkOHrX5WQvIdyhk1Oc6je5OLa+aC4aQ6O
         ApUYWX1dnZeMiwLhvAFHbwqztC/bZSXOiRxu9xRkksreQpbStLdocmPE9dCVtLrEOcxe
         D9XSHeNdlXJhpErfa59e4PtQ/Marwg+wB6FsVFyM5YeCN+gwP2dFv3TbijzLXTi5BNLX
         rDor34A8dOA8etO4/Zv81Bo4XHDNMko9XRIlScRtEGx6FR6QnQn1tJL8AQ+pkk9Zxq9/
         CckQ==
X-Forwarded-Encrypted: i=1; AJvYcCX53Kjy07gkd3Szq6GFS8FOSOJsXsHSlqMVlHte5YHFt+AFt/1pDDD0Cv7KZIoMczvgzXLEsuIXTZZhrOUZH6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqyXKutJyZRZljrJFpmWUXeqCRoWftYkBGDMihYKA1Mlq7cXy
	WQlYO0nzlYvOZl/+fNsmGobjyWD9WpQaOnVVcASMKUEX/HwbxogK1rmsAhUZHndcroQ55AidXMX
	Nl4GAMQYUXM1fnlrYSZB0tePOVgoTDlRJtbiQFnHPyA7fn/g2Xc0ZImbqNtZVnrCXrw==
X-Received: by 2002:a17:906:d555:b0:a86:9fbd:5168 with SMTP id a640c23a62f3a-a8a885be012mr934459466b.10.1725954122687;
        Tue, 10 Sep 2024 00:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlH0u6x8kCMDvPcDbginVMnhXO4lApiSQpceWmr1sBGfZmmYznkDhVeEEVWw9Lf1VtTtVaBw==
X-Received: by 2002:a17:906:d555:b0:a86:9fbd:5168 with SMTP id a640c23a62f3a-a8a885be012mr934451466b.10.1725954121495;
        Tue, 10 Sep 2024 00:42:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf03fcsm438718266b.162.2024.09.10.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:42:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 18BC7152C346; Tue, 10 Sep 2024 09:42:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
 <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 linux-kselftest@vger.kernel.org, Florian Kauer
 <florian.kauer@linutronix.de>
Subject: Re: [PATCH net v3 2/2] bpf: selftests: send packet to devmap
 redirect XDP
In-Reply-To: <20240909-devel-koalo-fix-ingress-ifindex-v3-2-66218191ecca@linutronix.de>
References: <20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de>
 <20240909-devel-koalo-fix-ingress-ifindex-v3-2-66218191ecca@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Sep 2024 09:41:59 +0200
Message-ID: <87seu8dkfs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian Kauer <florian.kauer@linutronix.de> writes:

> The current xdp_devmap_attach test attaches a program
> that redirects to another program via devmap.
>
> It is, however, never executed, so do that to catch
> any bugs that might occur during execution.
>
> Also, execute the same for a veth pair so that we
> also cover the non-generic path.
>
> Warning: Running this without the bugfix in this series
> will likely crash your system.
>
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> ---
>  .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
>  1 file changed, 108 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> index ce6812558287..3da45f719736 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <arpa/inet.h>
>  #include <uapi/linux/bpf.h>
>  #include <linux/if_link.h>
> +#include <network_helpers.h>
> +#include <net/if.h>
>  #include <test_progs.h>
>  
>  #include "test_xdp_devmap_helpers.skel.h"
> @@ -17,7 +20,7 @@ static void test_xdp_with_devmap_helpers(void)
>  		.ifindex = IFINDEX_LO,
>  	};
>  	__u32 len = sizeof(info);
> -	int err, dm_fd, map_fd;
> +	int err, dm_fd, dm_fd_redir, map_fd;
>  	__u32 idx = 0;
>  
>  
> @@ -25,14 +28,11 @@ static void test_xdp_with_devmap_helpers(void)
>  	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
>  		return;
>  
> -	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> -	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
> +	dm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
> +	err = bpf_xdp_attach(IFINDEX_LO, dm_fd_redir, XDP_FLAGS_SKB_MODE, NULL);
>  	if (!ASSERT_OK(err, "Generic attach of program with 8-byte devmap"))
>  		goto out_close;
>  
> -	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> -	ASSERT_OK(err, "XDP program detach");
> -
>  	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
>  	map_fd = bpf_map__fd(skel->maps.dm_ports);
>  	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
> @@ -47,6 +47,23 @@ static void test_xdp_with_devmap_helpers(void)
>  	ASSERT_OK(err, "Read devmap entry");
>  	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
>  
> +	/* send a packet to trigger any potential bugs in there */
> +	char data[10] = {};
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .data_in = &data,
> +			    .data_size_in = 10,
> +			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
> +			    .repeat = 1,
> +		);
> +	err = bpf_prog_test_run_opts(dm_fd_redir, &opts);
> +	ASSERT_OK(err, "XDP test run");
> +
> +	/* wait for the packets to be flushed */
> +	kern_sync_rcu();
> +
> +	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> +	ASSERT_OK(err, "XDP program detach");
> +
>  	/* can not attach BPF_XDP_DEVMAP program to a device */
>  	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
>  	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_DEVMAP program"))
> @@ -124,6 +141,88 @@ static void test_xdp_with_devmap_frags_helpers(void)
>  	test_xdp_with_devmap_frags_helpers__destroy(skel);
>  }
>  
> +static void test_xdp_with_devmap_helpers_veth(void)
> +{
> +	struct test_xdp_with_devmap_helpers *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	struct bpf_devmap_val val = {};
> +	struct nstoken *nstoken = NULL;
> +	__u32 len = sizeof(info);
> +	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
> +	__u32 idx = 0;
> +
> +	SYS(out_close, "ip netns add testns");
> +	nstoken = open_netns("testns");
> +	if (!ASSERT_OK_PTR(nstoken, "setns"))
> +		goto out_close;
> +
> +	SYS(out_close, "ip link add veth_src type veth peer name veth_dst");
> +	SYS(out_close, "ip link set dev veth_src up");
> +	SYS(out_close, "ip link set dev veth_dst up");
> +
> +	val.ifindex = if_nametoindex("veth_src");
> +	ifindex_dst = if_nametoindex("veth_dst");
> +	if (!ASSERT_NEQ(val.ifindex, 0, "val.ifindex") ||
> +	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
> +		goto out_close;
> +
> +	skel = test_xdp_with_devmap_helpers__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
> +		return;

This should be 'goto out_close'.

-Toke


