Return-Path: <linux-kselftest+bounces-609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11AD7F9072
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 01:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5147228131B
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2092803;
	Sun, 26 Nov 2023 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D32KG8WI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F7111
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Nov 2023 16:34:50 -0800 (PST)
Message-ID: <eb34b5e0-caf0-472a-99fa-77b43cfce56e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700958888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/ZPoKiZbkIfm1dDuAoTcnp78skWk0ipL2jJQiXwSIE=;
	b=D32KG8WIWSBlHoBw7qhYyejBIRSZr+xdqovTapw2Vt6keOmhtykzSweeRHG0kTVlyIwyNo
	P2ayW2Bgvur9fHVvNA+qnJGp0E9Rkloz5zbiNgzzKESB1UBtAKg3lZALqHBjehuWlQRlBg
	HSB3WDuzyt6JS4FtcRXcea9ZIrbWyuI=
Date: Sat, 25 Nov 2023 16:34:36 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 5/7] bpf: selftests: test_tunnel: Use
 vmlinux.h declarations
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, ast@kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, alexei.starovoitov@gmail.com
Cc: mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@linux-ipsec.org, netdev@vger.kernel.org
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <c5f6a6686e1472e17014f5d015c8dacade9f053e.1700676682.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c5f6a6686e1472e17014f5d015c8dacade9f053e.1700676682.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/22/23 1:20 PM, Daniel Xu wrote:
> vmlinux.h declarations are more ergnomic, especially when working with
> kfuncs. The uapi headers are often incomplete for kfunc definitions.
>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
>   .../selftests/bpf/progs/test_tunnel_kern.c    | 48 ++++---------------
>   2 files changed, 9 insertions(+), 40 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> index 0b793a102791..1bdc680b0e0e 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -26,6 +26,7 @@
>   #define IPV6_AUTOFLOWLABEL	70
>   
>   #define TC_ACT_UNSPEC		(-1)
> +#define TC_ACT_OK		0
>   #define TC_ACT_SHOT		2
>   
>   #define SOL_TCP			6
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index f66af753bbbb..3065a716544d 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -6,62 +6,30 @@
>    * modify it under the terms of version 2 of the GNU General Public
>    * License as published by the Free Software Foundation.
>    */
> -#include <stddef.h>
> -#include <string.h>
> -#include <arpa/inet.h>
> -#include <linux/bpf.h>
> -#include <linux/if_ether.h>
> -#include <linux/if_packet.h>
> -#include <linux/if_tunnel.h>
> -#include <linux/ip.h>
> -#include <linux/ipv6.h>
> -#include <linux/icmp.h>
> -#include <linux/types.h>
> -#include <linux/socket.h>
> -#include <linux/pkt_cls.h>
> -#include <linux/erspan.h>
> -#include <linux/udp.h>
> +#include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
> +#include "bpf_kfuncs.h"
> +#include "bpf_tracing_net.h"
>   
>   #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
>   
> -#define VXLAN_UDP_PORT 4789
> +#define VXLAN_UDP_PORT		4789
> +#define ETH_P_IP		0x0800
> +#define PACKET_HOST		0
> +#define TUNNEL_CSUM		bpf_htons(0x01)
> +#define TUNNEL_KEY		bpf_htons(0x04)
>   
>   /* Only IPv4 address assigned to veth1.
>    * 172.16.1.200
>    */
>   #define ASSIGNED_ADDR_VETH1 0xac1001c8
>   
> -struct geneve_opt {
> -	__be16	opt_class;
> -	__u8	type;
> -	__u8	length:5;
> -	__u8	r3:1;
> -	__u8	r2:1;
> -	__u8	r1:1;
> -	__u8	opt_data[8]; /* hard-coded to 8 byte */
> -};
> -
>   struct vxlanhdr {
>   	__be32 vx_flags;
>   	__be32 vx_vni;
>   } __attribute__((packed));

In my particular setup, I have struct vxlanhdr defined in vmlinux.h so
I hit a compilation failure.

>   
> -struct vxlan_metadata {
> -	__u32     gbp;
> -};
> -
> -struct bpf_fou_encap {
> -	__be16 sport;
> -	__be16 dport;
> -};
> -
> -enum bpf_fou_encap_type {
> -	FOU_BPF_ENCAP_FOU,
> -	FOU_BPF_ENCAP_GUE,
> -};
> -
>   int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
>   			  struct bpf_fou_encap *encap, int type) __ksym;
>   int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,

