Return-Path: <linux-kselftest+bounces-27196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205BEA3FB09
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04910173414
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87648215F79;
	Fri, 21 Feb 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC5RwDqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C46215F7F;
	Fri, 21 Feb 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154496; cv=none; b=rlbJBL8NPC5OVovXUZv+j2QRIRCrBHrqTG1K8JuYCDrPQcSbR/7rCRDq3UfFgRNVbuOLfbrI5qeWWvnKzgXXAptJW910oZG0Ev7/MhWRTkT7qr8nPmu8bh9LOTiBVTDGpJCIiC2/QkUSF/D1vRrAgjatpvTWD7vi4OJLTqh9Vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154496; c=relaxed/simple;
	bh=Mwb/+mIr9sIX1Vh/JjcDwlfuWKiF8GcXc20i7qJ1zco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2/zsqpuZxT2/rrCN7LtNNepqZWwLE8zQyQb7eYe/cqaTZ6P/DwOYZ9e2xZsYEJjR5Vwf25tZw1XoH2yR8atBCPJCIT3HAteyOGZOJKvIlnWyw3ORYBXKPdFWz+dVs15G6UJZ+fQJaR+r8o73rnE4eIspLmraCCIO4JgUeN6tdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC5RwDqf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22128b7d587so45464895ad.3;
        Fri, 21 Feb 2025 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740154494; x=1740759294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRw10QmKS+pwaQiTD1eJol1DMaMXwa3QEswpCoiMVg8=;
        b=dC5RwDqfrNNXICUHQjpS74W8u4rTYbongzm2rw/IGp3a8zR6rJ9/lrYxzs0ugWzoKY
         1RKPy6xZRkeEZSofKw6obno+Yc266XH59HEuixZSNC4KUc2iARQR3rMdqgBVqTMsC/td
         PDy8lLR2PMpwjftnll2u9U+yggWXq77Gf6Cr+o1RCQvyvUTiGr5RNAyg7JdhA2CnR6LH
         T4wlIy9oAgH4sAM/WPGSfMCW2nfRoeyjYuMEbFluWaggIkNUw81Crf7kK650Z0+OcLcZ
         zlgVjyAMOF9thHSA+5T4y3rbX17D9/rePwnFUWGAsyW5kMw2b8Gi5scF0XPyzXgoDc4Y
         wxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154494; x=1740759294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRw10QmKS+pwaQiTD1eJol1DMaMXwa3QEswpCoiMVg8=;
        b=TxImKnXKvftJNqlyGK/+JuhLGBLUvA5XE6a7RLgfAdt5iQ9ZVaVWC7xEhwYMRS1nSq
         DJZ94zqLwHgchTMItvKajWL22zq0TFgPGAA5yJMip2MqX0qE5diGvE8wGgRi0NOe9HD3
         MunBN6J2bzxMyW0jFDTzSmNp6H7IwnoFyrQIr+b++8OoBdmOS/8nShUTODiPWN6fksar
         Hk6QgeG70nS4ygbJaEB0rABDJZZ/Vpt9QetW8hfOMBlJ7nzcRlpmTmmGqoifT9f8SwTQ
         1gBSKQhg2nh+Rg/+E9EXYj4FB5nXfp9ez8rcPXQTTU8LH07V67fgVMhQqaEG1AwrfDDt
         t+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVqtr39imLCEZP88MC8NpNzz8vkHVFvxYco5SL0B69j40fumr1c6CuDeAy9gAPxG3G4EGUh0jSXo23tpbtt2U1x@vger.kernel.org, AJvYcCWC1JC7K5Hl7UB2w57XJXKhycLWKjFNl7/vKCefVuKEZgfEdTHU8qz85azjgl04csKPfgg=@vger.kernel.org, AJvYcCWS1hmHRDLVx6wE4YbjocIVJ+tAcz/z82F8xhM6qYn68Dw3Y5C/nIUg8oZmkmI9A2DX25nXtlzC@vger.kernel.org, AJvYcCWwp6g7oxIXBrieIrxPKKf3EKtC6mscsHvFHKkJjP+/jfIEHso1+XwMB3pqtceFu0rF1+xD2bmnoeSfWXd9@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnJTW+2CZ9nBc6bg1SFJm+foUwdvhjPkGBFJIFqvWv35FzsF4
	FrmVzRNGF+YQT7FxxOJfR3QG8Ksu+BD0doC7NTwSCeFfJG7H4YM=
X-Gm-Gg: ASbGncv0VqOahLgLLDCkT4LN9YiZRgb/pF/HSzcbaHm1PelTGPuoHAWf4ykR+uSE/n6
	s4I+sSTem+fdqUBPmghc1P5/dnTq7C5JbwEkgwd7sRRnf8l5fvOxirowLZcG9qfHdYJAw0C+PkG
	891hIlAkHQ6QxIQzDF9w6yG69t74L+FTkczTZxZk42EnnCVz6Idl1MhFAPfhR7uOP/+yF1zunpY
	fj0cbcykfp1QpONGCTQlIpOM10HA7CKH7ESEVwqi6L2uMaWLqqb0b4ncSz1dGbglTFPho29HQzK
	47JgXxyciw2Lk35hS0tBJkQzwA==
X-Google-Smtp-Source: AGHT+IFriNgiLyWVrFraOkel3ezG8+RV3+l5DHO1UXAqXjqjIc4HYuUR8iAH7/VmO5yu8/AkmsOQ1A==
X-Received: by 2002:a05:6a00:4f8c:b0:730:8e2c:e53b with SMTP id d2e1a72fcca58-73426c8e2b8mr5469542b3a.5.1740154493744;
        Fri, 21 Feb 2025 08:14:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732642d908esm12253499b3a.159.2025.02.21.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:14:53 -0800 (PST)
Date: Fri, 21 Feb 2025 08:14:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Migrate test_xdp_vlan.sh
 into test_progs
Message-ID: <Z7imfH-Adq5qUUsB@mini-arch>
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
 <20250221-xdp_vlan-v1-2-7d29847169af@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-xdp_vlan-v1-2-7d29847169af@bootlin.com>

On 02/21, Bastien Curutchet (eBPF Foundation) wrote:
> test_xdp_vlan.sh isn't used by the BPF CI.
> 
> Migrate test_xdp_vlan.sh in prog_tests/xdp_vlan.c.
> It uses the same BPF programs located in progs/test_xdp_vlan.c and the
> same network topology.
> Remove test_xdp_vlan*.sh and their Makefile entries.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  tools/testing/selftests/bpf/Makefile               |   4 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_vlan.c  | 175 ++++++++++++++++
>  tools/testing/selftests/bpf/test_xdp_vlan.sh       | 233 ---------------------
>  .../selftests/bpf/test_xdp_vlan_mode_generic.sh    |   9 -
>  .../selftests/bpf/test_xdp_vlan_mode_native.sh     |   9 -
>  5 files changed, 176 insertions(+), 254 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5dc9c84ed30f6e5a46572a9e428f692a79623469..09c1f731b8280696c729e3c87020ef749fee9dcb 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -103,8 +103,6 @@ TEST_PROGS := test_kmod.sh \
>  	test_tunnel.sh \
>  	test_lwt_seg6local.sh \
>  	test_lirc_mode2.sh \
> -	test_xdp_vlan_mode_generic.sh \
> -	test_xdp_vlan_mode_native.sh \
>  	test_lwt_ip_encap.sh \
>  	test_tc_tunnel.sh \
>  	test_tc_edt.sh \
> @@ -118,7 +116,7 @@ TEST_PROGS := test_kmod.sh \
>  
>  TEST_PROGS_EXTENDED := \
>  	ima_setup.sh verify_sig_setup.sh \
> -	test_xdp_vlan.sh test_bpftool.py
> +	test_bpftool.py
>  
>  TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
>  	bpf_test_modorder_y.ko
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..18dd25344de768aa83a162a0c091f28a4e5f505e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Network topology:
> + *  -----------        -----------
> + *  |  NS1    |        |   NS2   |
> + *  | veth0  -|--------|- veth0  |
> + *  -----------        -----------
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <net/if.h>
> +#include <uapi/linux/if_link.h>
> +
> +#include "network_helpers.h"
> +#include "test_progs.h"
> +#include "test_xdp_vlan.skel.h"
> +
> +
> +#define VETH_NAME	"veth0"
> +#define NS_MAX_SIZE	32
> +#define NS1_NAME	"ns-xdp-vlan-1-"
> +#define NS2_NAME	"ns-xdp-vlan-2-"
> +#define NS1_IP_ADDR	"100.64.10.1"
> +#define NS2_IP_ADDR	"100.64.10.2"
> +#define VLAN_ID		4011
> +
> +static int setup_network(char *ns1, char *ns2)
> +{
> +	if (!ASSERT_OK(append_tid(ns1, NS_MAX_SIZE), "create ns1 name"))
> +		goto fail;
> +	if (!ASSERT_OK(append_tid(ns2, NS_MAX_SIZE), "create ns2 name"))
> +		goto fail;
> +

[..]

> +	SYS(fail, "ip netns add %s", ns1);
> +	SYS(fail, "ip netns add %s", ns2);

Will replacing these with open_netns work? Or we don't setup up enough
state to cooperate with 'ip' tool? (same for cleanup_network if it
works)

> +	SYS(fail, "ip -n %s link add %s type veth peer name %s netns %s",
> +	    ns1, VETH_NAME, VETH_NAME, ns2);
> +
> +	/* NOTICE: XDP require VLAN header inside packet payload
> +	 *  - Thus, disable VLAN offloading driver features
> +	 */
> +	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns1, VETH_NAME);
> +	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns2, VETH_NAME);
> +
> +	/* NS1 configuration */
> +	SYS(fail, "ip -n %s addr add %s/24 dev %s", ns1, NS1_IP_ADDR, VETH_NAME);
> +	SYS(fail, "ip -n %s link set %s up", ns1, VETH_NAME);
> +
> +	/* NS2 configuration */
> +	SYS(fail, "ip -n %s link add link %s name %s.%d type vlan id %d",
> +	    ns2, VETH_NAME, VETH_NAME, VLAN_ID, VLAN_ID);
> +	SYS(fail, "ip -n %s addr add %s/24 dev %s.%d", ns2, NS2_IP_ADDR, VETH_NAME, VLAN_ID);
> +	SYS(fail, "ip -n %s link set %s up", ns2, VETH_NAME);
> +	SYS(fail, "ip -n %s link set %s.%d up", ns2, VETH_NAME, VLAN_ID);
> +
> +	/* At this point ping should fail because VLAN tags are only used by NS2 */
> +	return !SYS_NOFAIL("ip netns exec %s ping -W 1 -c1 %s", ns2, NS1_IP_ADDR);
> +
> +fail:
> +	return -1;
> +}
> +
> +static void cleanup_network(const char *ns1, const char *ns2)
> +{
> +	SYS_NOFAIL("ip netns del %s", ns1);
> +	SYS_NOFAIL("ip netns del %s", ns2);
> +}
> +
> +static void xdp_vlan(struct bpf_program *xdp, struct bpf_program *tc, u32 flags)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
> +	char ns1[NS_MAX_SIZE] = NS1_NAME;
> +	char ns2[NS_MAX_SIZE] = NS2_NAME;
> +	struct nstoken *nstoken = NULL;
> +	int interface;
> +	int ret;
> +
> +	if (!ASSERT_OK(setup_network(ns1, ns2), "setup network"))
> +		goto cleanup;
> +
> +	nstoken = open_netns(ns1);
> +	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
> +		goto cleanup;
> +
> +	interface = if_nametoindex(VETH_NAME);
> +	if (!ASSERT_NEQ(interface, 0, "get interface index"))
> +		goto cleanup;
> +
> +	ret = bpf_xdp_attach(interface, bpf_program__fd(xdp), flags, NULL);
> +	if (!ASSERT_OK(ret, "attach xdp_vlan_change"))
> +		goto cleanup;
> +
> +	tc_hook.ifindex = interface;
> +	ret = bpf_tc_hook_create(&tc_hook);
> +	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
> +		goto detach_xdp;
> +
> +	/* Now we'll use BPF programs to pop/push the VLAN tags */
> +	tc_opts.prog_fd = bpf_program__fd(tc);
> +	ret = bpf_tc_attach(&tc_hook, &tc_opts);
> +	if (!ASSERT_OK(ret, "bpf_tc_attach"))
> +		goto detach_xdp;
> +
> +	close_netns(nstoken);
> +	nstoken = NULL;
> +
> +	/* Now the namespaces can reach each-other, test with pings */
> +	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns1, NS2_IP_ADDR);
> +	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns2, NS1_IP_ADDR);
> +
> +
> +detach_tc:
> +	bpf_tc_detach(&tc_hook, &tc_opts);
> +detach_xdp:
> +	bpf_xdp_detach(interface, flags, NULL);
> +cleanup:
> +	close_netns(nstoken);
> +	cleanup_network(ns1, ns2);
> +}
> +
> +/* First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
> + * egress use TC to add back VLAN tag 4011
> + */
> +void test_xdp_vlan_change(void)
> +{
> +	struct test_xdp_vlan *skel;
> +
> +	skel = test_xdp_vlan__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "xdp_vlan__open_and_load"))
> +		return;
> +

[..]

> +	if (test__start_subtest("0"))
> +		xdp_vlan(skel->progs.xdp_vlan_change, skel->progs.tc_vlan_push, 0);

Does the original test also test with flags=0? What is the purpose?

