Return-Path: <linux-kselftest+bounces-17424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EC596FCA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247BDB26408
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A181D61BE;
	Fri,  6 Sep 2024 20:24:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6713D251;
	Fri,  6 Sep 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654274; cv=none; b=RUEKfSKyy0Uv8nllFt6FQ5b0OyYn+Q+Tzmd23eNAu+1H3rKgTZCW2STNafJAxeuoFE0v5EWOxoIoUsLZ7cigS3AIvAPe2XWtz7F44LQy+gEQt7fna1csllOAg2ZU3clAUh98l8ZvywOwwj4phr9QlnbSMQI2OiAiBKnWDAOJOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654274; c=relaxed/simple;
	bh=jfXwEMIyOFbvNSGK8wfH4x/0ilT6Vwp9K8KNooX7VdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isex9E/1gti9jG+/VPgtKOQSX9nd5EBCBolLQoi32cf52ycT26V9midH2pVFbTorINwA1iHWMpjQIu7QZa/BKlZ6GzlndjbLLz9PXnTooIDnKxKCinU6uv+uNSm90ODQRMcxHkUrZhW+eZszKLfOww0Et8ipQfpkuXMKYqfHByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1672407a12.0;
        Fri, 06 Sep 2024 13:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654272; x=1726259072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSbi6dM4OZPilshyK6QPgYGxC4Yeo1GjN7m6drG40AY=;
        b=iP8oSVV8BqlgKwvz1T3n2MxFvQgVS82PwGU/mrK25npjgDpvH9aa98a6DdnG6dG6SS
         GZYLUgnQFeduCgF+bNYxnJGOS0e4Yn9cOr/bfFM7352nejVpm3YogpWq1TPdzO5UCO3G
         n9xpoWk4ex0PuVTZZ1PlboxtWrQltZ3gLZMmuIiyJEyhtL3YN26kqjO2K+9u8mjgnLPH
         OCOSRfecRAJl5CtPAoQYB5MjmEktclL5PId9cNG1mfvnBpn2wjoFnjxsqyyEGXrsaShp
         VYLr2rzPPKBHAgpYqQtRVj1sqY251aAQhn2PVbaMKg2YL3gHyUFuevIWHJHDF9yz+AhN
         rcPg==
X-Forwarded-Encrypted: i=1; AJvYcCUqYeZz7tMShV6Gnd9U01fVuttP6b0ntmPDr/JmYbSo8Ie82LUDuPtn3H1X7AI+QLwMFpY=@vger.kernel.org, AJvYcCV32Tq0Eb9TdFNWsiw28xLZ9oPbQsUC26u4/CWvwARY/iKVgBCo9tFUiPN4lRdMT+snnsJN7RH5AnKSHA1+@vger.kernel.org, AJvYcCWO8p7hFN0QsadzzsLgsYZizdJ255eebkZa2iIrhpq+Lk9VsNlZwCXABwl+x/5GiGbidmaSjP2OUI5+VHtHg8mr@vger.kernel.org, AJvYcCWvVsJv3AcQD0sgutmOMYhnGUSerA965Pv4d+VI53suezAm9K+vj/hMv5NXIEfskG+WpDoftgcx@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiCEqkO1ZWoYYqhiSperuDJhUgM70GhajUuYk0N2SN8qKlD1/
	VY9wHdlv/6nd1cPzsVO+7mQCHmAYRtixe8/jnedIA2RZ8N3MroM=
X-Google-Smtp-Source: AGHT+IH2CSru0wQMPbWy2AelMMQpCWm4/s2mJM25XT+w0TpO5N8IBxT6IatEFp0qvbY8weei9UVsQg==
X-Received: by 2002:a05:6a21:150d:b0:1cf:1218:f87d with SMTP id adf61e73a8af0-1cf1d1b5c06mr4159288637.39.1725654271872;
        Fri, 06 Sep 2024 13:24:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778520e90sm5229695b3a.36.2024.09.06.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:24:31 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:24:30 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] bpf: selftests: send packet to devmap
 redirect XDP
Message-ID: <Zttk_hTqQ-1wFTtI@mini-arch>
References: <20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de>
 <20240906-devel-koalo-fix-ingress-ifindex-v2-2-4caa12c644b4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906-devel-koalo-fix-ingress-ifindex-v2-2-4caa12c644b4@linutronix.de>

On 09/06, Florian Kauer wrote:
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
> index ce6812558287..c9034f8ae63b 100644
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
> +	struct test_xdp_with_devmap_helpers *skel;

skel needs to be initialized to NULL ....

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

... for this goto to not do test_xdp_with_devmap_helpers__destroy(garbage)

pw-bot: cr

