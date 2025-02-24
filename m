Return-Path: <linux-kselftest+bounces-27332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69346A4191F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729E71888E62
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0E24BC06;
	Mon, 24 Feb 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TR+l/N2h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D03245027;
	Mon, 24 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389265; cv=none; b=p8MOq4L54wuQ/LA0DAjUfzWGRQZGgQ9kfaZWFQivX2TD9x1A7vROBhBi9CKlHYGSZMUqZZjGa/N4iK9JJqIKoVzeG3H9/We2+0f+JbeFMxpglPoT6lzN8sVl0qXqDYMiC3iRHSPRVRn6xKwF/NolnylG+8C1bb4cCS2G5y44COs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389265; c=relaxed/simple;
	bh=xtPJ+9TPcQnIoTApT2qVmDx4XC/2epsxSLv0GCkiSg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6wxrIW+Yo3clv5k0Suw2zYWxrQwKCLrWYu9fbvB0rHrtHjr1FNfVkEfXo/z8OotuKAJhYIxLrG8SwoPIKmyb4O/hHtaWFtaMp55noxUQIQOo/A1szeWXmkVopkvBx6/uy93PAl9728h+F1PIQt9/EGuQEM5uMPct9Vn0hOQcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TR+l/N2h; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56299433F8;
	Mon, 24 Feb 2025 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740389259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bv9esbM3X3XFxLbrYON0o0vsKE/aVAnt/YyaYFae7xk=;
	b=TR+l/N2hF7PDXRr6GdLqFUHz4pzP3rrdAMLp9Fd8O7SLWvARUubTLB8RON9mdUxDC7Pmdp
	4TfRCP7DzbIf0gRofSK86Hj0EHJrAehc8USbBKCJ0Fu4f/+skggRj281kRW9Z+dMRMSNdP
	Pljh70F0KT7m8e3YrCXONvSk2F3fy21YLeK0hXf/xyC/9BY9CjZ3GArRlHFPj51qn+vcL3
	trc1MnIn3Rg/0nN78UwGsAjZW1/XD73s/kC9ZwPE6RPBCPoz4LAlKJr1lh4zYYWYL/i5Qf
	4S7iNp39MdMwdfeOork7R7Rj5sUa1fEGUfpthSJaQ6uD1VDV71rqs8vtNmxq/g==
Message-ID: <4c39f9cf-a9cb-493b-b44f-b9ac264019c6@bootlin.com>
Date: Mon, 24 Feb 2025 10:27:37 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Migrate test_xdp_vlan.sh into
 test_progs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
 <20250221-xdp_vlan-v1-2-7d29847169af@bootlin.com>
 <Z7imfH-Adq5qUUsB@mini-arch>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z7imfH-Adq5qUUsB@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfehgefgteffkeehveeuvdekvddvueefgeejvefgleevveevteffveefgfehieejnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehsthhfohhmihgthhgvvhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Stanislav,

On 2/21/25 5:14 PM, Stanislav Fomichev wrote:
> On 02/21, Bastien Curutchet (eBPF Foundation) wrote:
>> test_xdp_vlan.sh isn't used by the BPF CI.
>>
>> Migrate test_xdp_vlan.sh in prog_tests/xdp_vlan.c.
>> It uses the same BPF programs located in progs/test_xdp_vlan.c and the
>> same network topology.
>> Remove test_xdp_vlan*.sh and their Makefile entries.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile               |   4 +-
>>   tools/testing/selftests/bpf/prog_tests/xdp_vlan.c  | 175 ++++++++++++++++
>>   tools/testing/selftests/bpf/test_xdp_vlan.sh       | 233 ---------------------
>>   .../selftests/bpf/test_xdp_vlan_mode_generic.sh    |   9 -
>>   .../selftests/bpf/test_xdp_vlan_mode_native.sh     |   9 -
>>   5 files changed, 176 insertions(+), 254 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 5dc9c84ed30f6e5a46572a9e428f692a79623469..09c1f731b8280696c729e3c87020ef749fee9dcb 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -103,8 +103,6 @@ TEST_PROGS := test_kmod.sh \
>>   	test_tunnel.sh \
>>   	test_lwt_seg6local.sh \
>>   	test_lirc_mode2.sh \
>> -	test_xdp_vlan_mode_generic.sh \
>> -	test_xdp_vlan_mode_native.sh \
>>   	test_lwt_ip_encap.sh \
>>   	test_tc_tunnel.sh \
>>   	test_tc_edt.sh \
>> @@ -118,7 +116,7 @@ TEST_PROGS := test_kmod.sh \
>>   
>>   TEST_PROGS_EXTENDED := \
>>   	ima_setup.sh verify_sig_setup.sh \
>> -	test_xdp_vlan.sh test_bpftool.py
>> +	test_bpftool.py
>>   
>>   TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
>>   	bpf_test_modorder_y.ko
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..18dd25344de768aa83a162a0c091f28a4e5f505e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
>> @@ -0,0 +1,175 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Network topology:
>> + *  -----------        -----------
>> + *  |  NS1    |        |   NS2   |
>> + *  | veth0  -|--------|- veth0  |
>> + *  -----------        -----------
>> + *
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <net/if.h>
>> +#include <uapi/linux/if_link.h>
>> +
>> +#include "network_helpers.h"
>> +#include "test_progs.h"
>> +#include "test_xdp_vlan.skel.h"
>> +
>> +
>> +#define VETH_NAME	"veth0"
>> +#define NS_MAX_SIZE	32
>> +#define NS1_NAME	"ns-xdp-vlan-1-"
>> +#define NS2_NAME	"ns-xdp-vlan-2-"
>> +#define NS1_IP_ADDR	"100.64.10.1"
>> +#define NS2_IP_ADDR	"100.64.10.2"
>> +#define VLAN_ID		4011
>> +
>> +static int setup_network(char *ns1, char *ns2)
>> +{
>> +	if (!ASSERT_OK(append_tid(ns1, NS_MAX_SIZE), "create ns1 name"))
>> +		goto fail;
>> +	if (!ASSERT_OK(append_tid(ns2, NS_MAX_SIZE), "create ns2 name"))
>> +		goto fail;
>> +
> 
> [..]
> 
>> +	SYS(fail, "ip netns add %s", ns1);
>> +	SYS(fail, "ip netns add %s", ns2);
> 
> Will replacing these with open_netns work? Or we don't setup up enough
> state to cooperate with 'ip' tool? (same for cleanup_network if it
> works)
> 

Yes, it will work. Initially I planned to use it but it isn't very 
convenient in this case because struct netns_obj is defined in 
test_progs.c, not in the header. This means you can't access ns->nsname 
to get the namespace name and as I use append_tid() this name is 
dynamic. So using netns_new / close_netns / netns_free would require 
keeping both the namespace names (for further ip commands / open_netns) 
and the netns_objs objects (for netns_free) whereas here I only keep the 
namespace name.

I can send a V2 using netns_* helpers if you prefer, though. Maybe I can 
also either move the netns_obj definition in test_progs.h or create a 
'get_nsname()' helper ?

>> +	SYS(fail, "ip -n %s link add %s type veth peer name %s netns %s",
>> +	    ns1, VETH_NAME, VETH_NAME, ns2);
>> +
>> +	/* NOTICE: XDP require VLAN header inside packet payload
>> +	 *  - Thus, disable VLAN offloading driver features
>> +	 */
>> +	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns1, VETH_NAME);
>> +	SYS(fail, "ip netns exec %s ethtool -K %s rxvlan off txvlan off", ns2, VETH_NAME);
>> +
>> +	/* NS1 configuration */
>> +	SYS(fail, "ip -n %s addr add %s/24 dev %s", ns1, NS1_IP_ADDR, VETH_NAME);
>> +	SYS(fail, "ip -n %s link set %s up", ns1, VETH_NAME);
>> +
>> +	/* NS2 configuration */
>> +	SYS(fail, "ip -n %s link add link %s name %s.%d type vlan id %d",
>> +	    ns2, VETH_NAME, VETH_NAME, VLAN_ID, VLAN_ID);
>> +	SYS(fail, "ip -n %s addr add %s/24 dev %s.%d", ns2, NS2_IP_ADDR, VETH_NAME, VLAN_ID);
>> +	SYS(fail, "ip -n %s link set %s up", ns2, VETH_NAME);
>> +	SYS(fail, "ip -n %s link set %s.%d up", ns2, VETH_NAME, VLAN_ID);
>> +
>> +	/* At this point ping should fail because VLAN tags are only used by NS2 */
>> +	return !SYS_NOFAIL("ip netns exec %s ping -W 1 -c1 %s", ns2, NS1_IP_ADDR);
>> +
>> +fail:
>> +	return -1;
>> +}
>> +
>> +static void cleanup_network(const char *ns1, const char *ns2)
>> +{
>> +	SYS_NOFAIL("ip netns del %s", ns1);
>> +	SYS_NOFAIL("ip netns del %s", ns2);
>> +}
>> +
>> +static void xdp_vlan(struct bpf_program *xdp, struct bpf_program *tc, u32 flags)
>> +{
>> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
>> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
>> +	char ns1[NS_MAX_SIZE] = NS1_NAME;
>> +	char ns2[NS_MAX_SIZE] = NS2_NAME;
>> +	struct nstoken *nstoken = NULL;
>> +	int interface;
>> +	int ret;
>> +
>> +	if (!ASSERT_OK(setup_network(ns1, ns2), "setup network"))
>> +		goto cleanup;
>> +
>> +	nstoken = open_netns(ns1);
>> +	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
>> +		goto cleanup;
>> +
>> +	interface = if_nametoindex(VETH_NAME);
>> +	if (!ASSERT_NEQ(interface, 0, "get interface index"))
>> +		goto cleanup;
>> +
>> +	ret = bpf_xdp_attach(interface, bpf_program__fd(xdp), flags, NULL);
>> +	if (!ASSERT_OK(ret, "attach xdp_vlan_change"))
>> +		goto cleanup;
>> +
>> +	tc_hook.ifindex = interface;
>> +	ret = bpf_tc_hook_create(&tc_hook);
>> +	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
>> +		goto detach_xdp;
>> +
>> +	/* Now we'll use BPF programs to pop/push the VLAN tags */
>> +	tc_opts.prog_fd = bpf_program__fd(tc);
>> +	ret = bpf_tc_attach(&tc_hook, &tc_opts);
>> +	if (!ASSERT_OK(ret, "bpf_tc_attach"))
>> +		goto detach_xdp;
>> +
>> +	close_netns(nstoken);
>> +	nstoken = NULL;
>> +
>> +	/* Now the namespaces can reach each-other, test with pings */
>> +	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns1, NS2_IP_ADDR);
>> +	SYS(detach_tc, "ip netns exec %s ping -i 0.2 -W 2 -c 2 %s > /dev/null", ns2, NS1_IP_ADDR);
>> +
>> +
>> +detach_tc:
>> +	bpf_tc_detach(&tc_hook, &tc_opts);
>> +detach_xdp:
>> +	bpf_xdp_detach(interface, flags, NULL);
>> +cleanup:
>> +	close_netns(nstoken);
>> +	cleanup_network(ns1, ns2);
>> +}
>> +
>> +/* First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
>> + * egress use TC to add back VLAN tag 4011
>> + */
>> +void test_xdp_vlan_change(void)
>> +{
>> +	struct test_xdp_vlan *skel;
>> +
>> +	skel = test_xdp_vlan__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "xdp_vlan__open_and_load"))
>> +		return;
>> +
> 
> [..]
> 
>> +	if (test__start_subtest("0"))
>> +		xdp_vlan(skel->progs.xdp_vlan_change, skel->progs.tc_vlan_push, 0);
> 
> Does the original test also test with flags=0? What is the purpose?

The original test allows testing the 'xdp', 'xdpgeneric' and 'xdpdrv' 
modes. My understanding is that flags=0 is the 'xdp' equivalent. IIRC, 
there are fallbacks that will set these flags to SKB or DRV mode at some 
point but, since it's allowed by the bpf_xdp_attach API, I thought it 
was worth testing. This way, if the fallbacks stop working at some 
point, we'll be noticed.

Best regards,
Bastien

