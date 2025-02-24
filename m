Return-Path: <linux-kselftest+bounces-27362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC1A42778
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C99C1680B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8682627E8;
	Mon, 24 Feb 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxndlEwW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8026158E;
	Mon, 24 Feb 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413413; cv=none; b=LraXLU+4kiSJFHZoUZ6NvKBFECRV6HfO5wUb8qGku52eIoZ77df3ot7w0oluXlcE+PGWCiwYGrYwdal90AD4idWwR/13A3GcKzGrUiinFO/fjCA7LdxaYvu7h+y6f89j2GjsDL50YpmiaDLK1buZ1HhHWDE9TrH2bTi4kuB62bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413413; c=relaxed/simple;
	bh=6WjuLZpm+QEE9dIKAPyySAEoNZJ9ayU/FVpZzbBAkmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5v9p0JYSAg1LvQbwGl2D9tGdo7owbBEjoP3DxKKpdvTBys9ErG61sbNf2sJGKjzHJoFIbfB70yJIiD0MvYB1a+xHF54evxeN7Dh9kIC9lLT4QBH4l3XmbbO97UCLaLm5VmcEPUHXhP01V6u9WSBt40yS3MG1hY6rhJ2Du8rLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxndlEwW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2211cd4463cso91814955ad.2;
        Mon, 24 Feb 2025 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740413409; x=1741018209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5r63pk939T0bUbu3tb/a211NVxDN9o/hsx35p2S0CZ4=;
        b=mxndlEwWWA3UGGHLYfPcnN7AdXsPuHBgskrKktc/i2fFTA7QC8mmP9BjW0cM/mf3l6
         4yXArAHtfQfG6ShV80HU1V/kINhhDeTOGK9mFdIssDS1wsnXMchFF5YFOflrZE+lbCp1
         XngX7wnKLiM/A868cmxfjGNpePCLGj36CttAHbTvjFJSaTdfbj2nn3RMBH02dL/uBrHW
         YnfgRcw54+WJuIxRhe2uB2gjD0CaGpJBkkKI5ixV9cHP5N48knauvmSedG75G6eHlrwO
         rw8lsKzGiX54WCltOOOOt8yC/opnArW4TxPNPXkYuz4kXcEyZreb2iCefEFQjarkjMrZ
         fHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413409; x=1741018209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r63pk939T0bUbu3tb/a211NVxDN9o/hsx35p2S0CZ4=;
        b=fAS8L3e/5xYC/uxSSV7pbK03u9PDPIgYuDFS5md1gAjF8BA/m8dB4VDCNf4KoJt/zI
         NObJ7OcHBzpt+bzVm6EujMaYZZwye+2ezXFZhvLQNj3+nYq56fndyOSHOM6CHKpcwwAy
         cVbPIImSRCFIDFBm8EH4Lyx4U06p6Z3sXyBRm2dFS+AmIWxX5MSulJyH/lqqdXQaeaj/
         V5atQVmKo9PMMVT33LPVbT8CEGYozvz0/dc2yOHZocrLX4IzmzSV5wIkyA79b2dI0j2x
         EvVklcNA5PpuoEiSJSyv4lgD5xmC8S40HisCQGVpNFINzjBH45G6l1voia38L1DlINQM
         mJqw==
X-Forwarded-Encrypted: i=1; AJvYcCVrkfDjsQoi2hGo9qUwh/GFVNzlV4it/RxNPxhONjO5rk33rdlwl0WaW0LWm3lULqE+BHc=@vger.kernel.org, AJvYcCWDcyCve4l63BywyT8dRdMjwri/tfulUuhb6qUV95tlYjGXOxmeby9b3AI7eDKfOLLZ+65XO8i/@vger.kernel.org, AJvYcCWVuFZG29a/vb+I34RHfk6W2BwBvLVKm97rXXRJNKZfQYRpw7BClb08lrHd/rL7S3VZDlS5YaICbN8iMS2Z@vger.kernel.org, AJvYcCWcHPrAw1DQWeLfs9OP2sH1QpZQNwh06KMGnBlGnXDJ4XzDcvWhgVWWcSiryFkZeuMSvUutZ224xl+ca04DS2VQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2P2n2vJSTZiRPb3yQD3aL6d7Cr8U1swEUJrPDLp6lyRkucTy6
	Z/p1rLhBXeyoEUna2GL9JSrJM+m6dHWvjX/4Ufx3xMMTHcHUE2g=
X-Gm-Gg: ASbGnct6osfhE5L1CE5DTbbd1G/NEhsrIFXeckmxo31DbCAePSdW+E5RbiDYqhzUSW/
	PQY04i9bd2gApp5fJS7uWEhxJ7Jf22pQRZRjVfyqQaLe8NR0/Bpc/uHxYBywjhLfNatcEZjU+nR
	HjQfOJatiwnbuBTZ57CuFjG4ZF7K/Ni5v85QeGP5n1oKI/C/UxgBUQIr2E3zj9UnuUU1YZnV+OY
	9IUd4nhEbLOCOV13Dd5c/2aIaCureMaex702AXpmcfkzwbZJK4oDLQ34wd+hfLaGiMSOB6mtUwD
	yMzyEKqR9Fbn6lYtGDhBlQgkjQ==
X-Google-Smtp-Source: AGHT+IFg6cuRHSKUeYQ0SfolWMB4fJ/Dfv7ctS0ze61vksOQT1zFlaVLvra1o6h7g3zgrbJBByqooA==
X-Received: by 2002:a05:6a00:4654:b0:732:5c88:990 with SMTP id d2e1a72fcca58-73426d72746mr20156715b3a.17.1740413409203;
        Mon, 24 Feb 2025 08:10:09 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242761538sm21514546b3a.139.2025.02.24.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:10:08 -0800 (PST)
Date: Mon, 24 Feb 2025 08:10:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
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
Message-ID: <Z7yZ31lcb3R7jYuB@mini-arch>
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
 <20250221-xdp_vlan-v1-2-7d29847169af@bootlin.com>
 <Z7imfH-Adq5qUUsB@mini-arch>
 <4c39f9cf-a9cb-493b-b44f-b9ac264019c6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c39f9cf-a9cb-493b-b44f-b9ac264019c6@bootlin.com>

On 02/24, Bastien Curutchet wrote:
> Hi Stanislav,
> 
> On 2/21/25 5:14 PM, Stanislav Fomichev wrote:
> > On 02/21, Bastien Curutchet (eBPF Foundation) wrote:
> > > test_xdp_vlan.sh isn't used by the BPF CI.
> > > 
> > > Migrate test_xdp_vlan.sh in prog_tests/xdp_vlan.c.
> > > It uses the same BPF programs located in progs/test_xdp_vlan.c and the
> > > same network topology.
> > > Remove test_xdp_vlan*.sh and their Makefile entries.
> > > 
> > > Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> > > ---
> > >   tools/testing/selftests/bpf/Makefile               |   4 +-
> > >   tools/testing/selftests/bpf/prog_tests/xdp_vlan.c  | 175 ++++++++++++++++
> > >   tools/testing/selftests/bpf/test_xdp_vlan.sh       | 233 ---------------------
> > >   .../selftests/bpf/test_xdp_vlan_mode_generic.sh    |   9 -
> > >   .../selftests/bpf/test_xdp_vlan_mode_native.sh     |   9 -
> > >   5 files changed, 176 insertions(+), 254 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index 5dc9c84ed30f6e5a46572a9e428f692a79623469..09c1f731b8280696c729e3c87020ef749fee9dcb 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -103,8 +103,6 @@ TEST_PROGS := test_kmod.sh \
> > >   	test_tunnel.sh \
> > >   	test_lwt_seg6local.sh \
> > >   	test_lirc_mode2.sh \
> > > -	test_xdp_vlan_mode_generic.sh \
> > > -	test_xdp_vlan_mode_native.sh \
> > >   	test_lwt_ip_encap.sh \
> > >   	test_tc_tunnel.sh \
> > >   	test_tc_edt.sh \
> > > @@ -118,7 +116,7 @@ TEST_PROGS := test_kmod.sh \
> > >   TEST_PROGS_EXTENDED := \
> > >   	ima_setup.sh verify_sig_setup.sh \
> > > -	test_xdp_vlan.sh test_bpftool.py
> > > +	test_bpftool.py
> > >   TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
> > >   	bpf_test_modorder_y.ko
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..18dd25344de768aa83a162a0c091f28a4e5f505e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
> > > @@ -0,0 +1,175 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * Network topology:
> > > + *  -----------        -----------
> > > + *  |  NS1    |        |   NS2   |
> > > + *  | veth0  -|--------|- veth0  |
> > > + *  -----------        -----------
> > > + *
> > > + */
> > > +
> > > +#define _GNU_SOURCE
> > > +#include <net/if.h>
> > > +#include <uapi/linux/if_link.h>
> > > +
> > > +#include "network_helpers.h"
> > > +#include "test_progs.h"
> > > +#include "test_xdp_vlan.skel.h"
> > > +
> > > +
> > > +#define VETH_NAME	"veth0"
> > > +#define NS_MAX_SIZE	32
> > > +#define NS1_NAME	"ns-xdp-vlan-1-"
> > > +#define NS2_NAME	"ns-xdp-vlan-2-"
> > > +#define NS1_IP_ADDR	"100.64.10.1"
> > > +#define NS2_IP_ADDR	"100.64.10.2"
> > > +#define VLAN_ID		4011
> > > +
> > > +static int setup_network(char *ns1, char *ns2)
> > > +{
> > > +	if (!ASSERT_OK(append_tid(ns1, NS_MAX_SIZE), "create ns1 name"))
> > > +		goto fail;
> > > +	if (!ASSERT_OK(append_tid(ns2, NS_MAX_SIZE), "create ns2 name"))
> > > +		goto fail;
> > > +
> > 
> > [..]
> > 
> > > +	SYS(fail, "ip netns add %s", ns1);
> > > +	SYS(fail, "ip netns add %s", ns2);
> > 
> > Will replacing these with open_netns work? Or we don't setup up enough
> > state to cooperate with 'ip' tool? (same for cleanup_network if it
> > works)
> > 
> 
> Yes, it will work. Initially I planned to use it but it isn't very
> convenient in this case because struct netns_obj is defined in test_progs.c,
> not in the header. This means you can't access ns->nsname to get the
> namespace name and as I use append_tid() this name is dynamic. So using
> netns_new / close_netns / netns_free would require keeping both the
> namespace names (for further ip commands / open_netns) and the netns_objs
> objects (for netns_free) whereas here I only keep the namespace name.
> 
> I can send a V2 using netns_* helpers if you prefer, though. Maybe I can
> also either move the netns_obj definition in test_progs.h or create a
> 'get_nsname()' helper ?

If it's only gonna complicate the matters let's keep as is. I'm mainly
coming from the position of trying to eliminate external calls (SYS()),
but removing two will not move the needle :-)

> > > +	SYS(fail, "ip -n %s link add %s type veth peer name %s netns %s",
> > > +	    ns1, VETH_NAME, VETH_NAME, ns2);
> > > +
> > > +	/* NOTICE: XDP require VLAN header inside packet payload
> > > +	 *  - Thus, disable VLAN offloading driver features
> > > +	 */
> > > +	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns1, VETH_NAME);
> > > +	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns2, VETH_NAME);
> > > +
> > > +	/* NS1 configuration */
> > > +	SYS(fail, "ip -n %s addr add %s/24 dev %s", ns1, NS1_IP_ADDR, VETH_NAME);
> > > +	SYS(fail, "ip -n %s link set %s up", ns1, VETH_NAME);
> > > +
> > > +	/* NS2 configuration */
> > > +	SYS(fail, "ip -n %s link add link %s name %s.%d type vlan id %d",
> > > +	    ns2, VETH_NAME, VETH_NAME, VLAN_ID, VLAN_ID);
> > > +	SYS(fail, "ip -n %s addr add %s/24 dev %s.%d", ns2, NS2_IP_ADDR, VETH_NAME, VLAN_ID);
> > > +	SYS(fail, "ip -n %s link set %s up", ns2, VETH_NAME);
> > > +	SYS(fail, "ip -n %s link set %s.%d up", ns2, VETH_NAME, VLAN_ID);
> > > +
> > > +	/* At this point ping should fail because VLAN tags are only used by NS2 */
> > > +	return !SYS_NOFAIL("ip netns exec %s ping -W 1 -c1 %s", ns2, NS1_IP_ADDR);
> > > +
> > > +fail:
> > > +	return -1;
> > > +}
> > > +
> > > +static void cleanup_network(const char *ns1, const char *ns2)
> > > +{
> > > +	SYS_NOFAIL("ip netns del %s", ns1);
> > > +	SYS_NOFAIL("ip netns del %s", ns2);
> > > +}
> > > +
> > > +static void xdp_vlan(struct bpf_program *xdp, struct bpf_program *tc, u32 flags)
> > > +{
> > > +	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
> > > +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
> > > +	char ns1[NS_MAX_SIZE] = NS1_NAME;
> > > +	char ns2[NS_MAX_SIZE] = NS2_NAME;
> > > +	struct nstoken *nstoken = NULL;
> > > +	int interface;
> > > +	int ret;
> > > +
> > > +	if (!ASSERT_OK(setup_network(ns1, ns2), "setup network"))
> > > +		goto cleanup;
> > > +
> > > +	nstoken = open_netns(ns1);
> > > +	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
> > > +		goto cleanup;
> > > +
> > > +	interface = if_nametoindex(VETH_NAME);
> > > +	if (!ASSERT_NEQ(interface, 0, "get interface index"))
> > > +		goto cleanup;
> > > +
> > > +	ret = bpf_xdp_attach(interface, bpf_program__fd(xdp), flags, NULL);
> > > +	if (!ASSERT_OK(ret, "attach xdp_vlan_change"))
> > > +		goto cleanup;
> > > +
> > > +	tc_hook.ifindex = interface;
> > > +	ret = bpf_tc_hook_create(&tc_hook);
> > > +	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
> > > +		goto detach_xdp;
> > > +
> > > +	/* Now we'll use BPF programs to pop/push the VLAN tags */
> > > +	tc_opts.prog_fd = bpf_program__fd(tc);
> > > +	ret = bpf_tc_attach(&tc_hook, &tc_opts);
> > > +	if (!ASSERT_OK(ret, "bpf_tc_attach"))
> > > +		goto detach_xdp;
> > > +
> > > +	close_netns(nstoken);
> > > +	nstoken = NULL;
> > > +
> > > +	/* Now the namespaces can reach each-other, test with pings */
> > > +	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns1, NS2_IP_ADDR);
> > > +	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns2, NS1_IP_ADDR);
> > > +
> > > +
> > > +detach_tc:
> > > +	bpf_tc_detach(&tc_hook, &tc_opts);
> > > +detach_xdp:
> > > +	bpf_xdp_detach(interface, flags, NULL);
> > > +cleanup:
> > > +	close_netns(nstoken);
> > > +	cleanup_network(ns1, ns2);
> > > +}
> > > +
> > > +/* First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
> > > + * egress use TC to add back VLAN tag 4011
> > > + */
> > > +void test_xdp_vlan_change(void)
> > > +{
> > > +	struct test_xdp_vlan *skel;
> > > +
> > > +	skel = test_xdp_vlan__open_and_load();
> > > +	if (!ASSERT_OK_PTR(skel, "xdp_vlan__open_and_load"))
> > > +		return;
> > > +
> > 
> > [..]
> > 
> > > +	if (test__start_subtest("0"))
> > > +		xdp_vlan(skel->progs.xdp_vlan_change, skel->progs.tc_vlan_push, 0);
> > 
> > Does the original test also test with flags=0? What is the purpose?
> 
> The original test allows testing the 'xdp', 'xdpgeneric' and 'xdpdrv' modes.
> My understanding is that flags=0 is the 'xdp' equivalent. IIRC, there are
> fallbacks that will set these flags to SKB or DRV mode at some point but,
> since it's allowed by the bpf_xdp_attach API, I thought it was worth
> testing. This way, if the fallbacks stop working at some point, we'll be
> noticed.

Right, it seems like 'xdp' triggers a single 'dev->netdev_ops->ndo_bpf ?
XDP_MODE_DRV : XDP_MODE_SKB' check in dev_xdp_mode. I did miss that the
original test gives you three options, thanks for clarifying!

