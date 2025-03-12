Return-Path: <linux-kselftest+bounces-28799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85268A5D72D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A7C189CD41
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC11E9B07;
	Wed, 12 Mar 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKxlu+sP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93D1C8628;
	Wed, 12 Mar 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763889; cv=none; b=pJSRV8kYuYRRKHB96NafBhOAFS6Ru5S+jOm8G+8TH432uDH9eFK1nklC3POHbT10g/XWXSKbALBHjPzpvLP2AtjYZdL0Ongw/vFtDpPx3uB/JjteghCqQk9970raXfWagrA+bRkM5J87bbX40R8GgRAWHZTxjw65B4mQm7kjP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763889; c=relaxed/simple;
	bh=4rqV3oBvxm0/qDJ0ZOaANRfeB8c6RO4+mTqqNxr54S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLFErn2/PQ0hl6OaNt4e5O+cGCfGhFTmTdPB/T091HInGDqJGPa1yZONZz+rHx8XuC7cB67ngL7yxkWEaLxfY+dRO2bLfsk8AC1pxdGwjl1CSOMBulXBKQ4ZoLpLSacGYJM5f689R8EzNL3s7amB6nexn8qavELeaqIav1drPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKxlu+sP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BKa626007033;
	Wed, 12 Mar 2025 07:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p9zABO
	oKZ3EWVV/pag03HMCyagJaHfs03y4vdzUeiTc=; b=SKxlu+sPHeG4HBAOGA77Dq
	ywmhCySaN1OsGMlqoAl3Sw03vZ0UcrJmziwMAYbfqnbpItS6piTf0oCPpWUXHWYD
	xEIUuA20Og0b6DyuttqlbdBdsG/XveOkTkDvFg8sCMzg8EuaAFpPU2SAkg5Z2CTG
	yNYR/GIQ1JJuzOyuQOqdMK6hgzpTKS0/vh933WTlgM1qaCWUxCNu/N7UHgOLkXnw
	5l0hKPvFFiVpyIdZHwmU1ftgdN8jI/YZhFWj9BMogXW+2xG9PEaL8/+OdJ2H+UK6
	4d4LyuBUZtJRpahUP0V4dVmzP2+rvkrgpGTO2bLk9GwpfbHkBiwx/uAr+S5Tm0/Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avbpj8f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 07:17:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52C73g0r024657;
	Wed, 12 Mar 2025 07:17:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avbpj8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 07:17:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6NuXd026064;
	Wed, 12 Mar 2025 07:17:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspauyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 07:17:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52C7HXqx18743736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 07:17:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF77758059;
	Wed, 12 Mar 2025 07:17:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0991A58043;
	Wed, 12 Mar 2025 07:17:27 +0000 (GMT)
Received: from [9.61.240.129] (unknown [9.61.240.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 07:17:26 +0000 (GMT)
Message-ID: <ba66843b-1732-43dc-8296-aee5eb387293@linux.ibm.com>
Date: Wed, 12 Mar 2025 12:47:25 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Fix sockopt selftest failure on powerpc
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, mykolal@fb.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, miaxu@meta.com
References: <20250311084647.3686544-1-skb99@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250311084647.3686544-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: va6jlByc_HjrOfEJacSFo0vhXa4k_jnU
X-Proofpoint-GUID: u7S7954LJyzvu2_TNl-Dos5hKotEdZQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120045


On 11/03/25 2:16 pm, Saket Kumar Bhaskar wrote:
> The SO_RCVLOWAT option is defined as 18 in the selftest header,
> which matches the generic definition. However, on powerpc,
> SO_RCVLOWAT is defined as 16. This discrepancy causes
> sol_socket_sockopt() to fail with the default switch case on powerpc.
>
> This commit fixes by defining SO_RCVLOWAT as 16 for powerpc.
>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> index 59843b430f76..bcd44d5018bf 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -15,7 +15,11 @@
>   #define SO_KEEPALIVE		9
>   #define SO_PRIORITY		12
>   #define SO_REUSEPORT		15
> +#if defined(__TARGET_ARCH_powerpc)
> +#define SO_RCVLOWAT		16
> +#else
>   #define SO_RCVLOWAT		18
> +#endif
>   #define SO_BINDTODEVICE		25
>   #define SO_MARK			36
>   #define SO_MAX_PACING_RATE	47


Applied this patch on linux-mainline and tested. It fixes the issue.

Without this patch:

#define SO_RCVBUF               8
#define SO_KEEPALIVE            9
#define SO_PRIORITY             12
#define SO_REUSEPORT            15
#define SO_RCVLOWAT             18
#define SO_BINDTODEVICE         25
#define SO_MARK                 36


  ./test_progs -t sockopt
#20      bpf_iter_setsockopt:OK
#21      bpf_iter_setsockopt_unix:OK
create_netns:PASS:create netns 0 nsec
create_netns:PASS:set lo up 0 nsec
create_netns:PASS:add veth 0 nsec
create_netns:PASS:bring veth up 0 nsec
test_setget_sockopt:PASS:open skel 0 nsec
test_setget_sockopt:PASS:if_nametoindex 0 nsec
test_setget_sockopt:PASS:load skel 0 nsec
test_setget_sockopt:PASS:attach cgroup 0 nsec
test_setget_sockopt:PASS:attach_cgroup 0 nsec
test_tcp:PASS:start_server 0 nsec
test_tcp:PASS:connect_to_fd_server 0 nsec
test_tcp:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_tcp:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_tcp:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_tcp:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_tcp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_tcp:PASS:nr_bind 0 nsec
test_tcp:PASS:start_server 0 nsec
test_tcp:PASS:connect_to_fd_server 0 nsec
test_tcp:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_tcp:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_tcp:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_tcp:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_tcp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_tcp:PASS:nr_bind 0 nsec
test_udp:PASS:start_server 0 nsec
test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 < expected 1
test_udp:PASS:nr_bind 0 nsec
test_udp:PASS:start_server 0 nsec
test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 < expected 1
test_udp:PASS:nr_bind 0 nsec
test_ktls:PASS:start_server 0 nsec
test_ktls:PASS:connect_to_fd 0 nsec
test_ktls:PASS:accept 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:read 0 nsec
test_ktls:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_ktls:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_ktls:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_ktls:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_ktls:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_ktls:PASS:nr_bind 0 nsec
test_ktls:FAIL:nr_fin_wait1 unexpected nr_fin_wait1: actual 0 != expected 1
test_ktls:PASS:start_server 0 nsec
test_ktls:PASS:connect_to_fd 0 nsec
test_ktls:PASS:accept 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:read 0 nsec
test_ktls:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_ktls:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_ktls:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_ktls:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_ktls:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_ktls:PASS:nr_bind 0 nsec
test_ktls:FAIL:nr_fin_wait1 unexpected nr_fin_wait1: actual 0 != expected 1
test_nonstandard_opt:PASS:start_server 0 nsec
test_nonstandard_opt:PASS:connect_to_fd_server 0 nsec
test_nonstandard_opt:PASS:getsockopt prog 0 nsec
test_nonstandard_opt:PASS:accept 0 nsec
test_nonstandard_opt:PASS:getsockopt_flags 0 nsec
test_nonstandard_opt:PASS:cb_flags_set 0 nsec
test_nonstandard_opt:PASS:start_server 0 nsec
test_nonstandard_opt:PASS:connect_to_fd_server 0 nsec
test_nonstandard_opt:PASS:getsockopt prog 0 nsec
test_nonstandard_opt:PASS:accept 0 nsec
test_nonstandard_opt:PASS:getsockopt_flags 0 nsec
test_nonstandard_opt:PASS:cb_flags_set 0 nsec
#303     setget_sockopt:FAIL
#326/1   sockopt/getsockopt: no expected_attach_type:OK
#326/2   sockopt/getsockopt: wrong expected_attach_type:OK
#326/3   sockopt/getsockopt: bypass bpf hook:OK
#326/4   sockopt/getsockopt: return EPERM from bpf hook:OK
#326/5   sockopt/getsockopt: no optval bounds check, deny loading:OK
#326/6   sockopt/getsockopt: read ctx->level:OK
#326/7   sockopt/getsockopt: deny writing to ctx->level:OK
#326/8   sockopt/getsockopt: read ctx->optname:OK
#326/9   sockopt/getsockopt: read ctx->retval:OK
#326/10  sockopt/getsockopt: deny writing to ctx->optname:OK
#326/11  sockopt/getsockopt: read ctx->optlen:OK
#326/12  sockopt/getsockopt: deny bigger ctx->optlen:OK
#326/13  sockopt/getsockopt: ignore >PAGE_SIZE optlen:OK
#326/14  sockopt/getsockopt: support smaller ctx->optlen:OK
#326/15  sockopt/getsockopt: deny writing to ctx->optval:OK
#326/16  sockopt/getsockopt: deny writing to ctx->optval_end:OK
#326/17  sockopt/getsockopt: rewrite value:OK
#326/18  sockopt/setsockopt: no expected_attach_type:OK
#326/19  sockopt/setsockopt: wrong expected_attach_type:OK
#326/20  sockopt/setsockopt: bypass bpf hook:OK
#326/21  sockopt/setsockopt: return EPERM from bpf hook:OK
#326/22  sockopt/setsockopt: no optval bounds check, deny loading:OK
#326/23  sockopt/setsockopt: read ctx->level:OK
#326/24  sockopt/setsockopt: allow changing ctx->level:OK
#326/25  sockopt/setsockopt: read ctx->optname:OK
#326/26  sockopt/setsockopt: allow changing ctx->optname:OK
#326/27  sockopt/setsockopt: read ctx->optlen:OK
#326/28  sockopt/setsockopt: ctx->optlen == -1 is ok:OK
#326/29  sockopt/setsockopt: deny ctx->optlen < 0 (except -1):OK
#326/30  sockopt/setsockopt: deny ctx->optlen > input optlen:OK
#326/31  sockopt/setsockopt: ignore >PAGE_SIZE optlen:OK
#326/32  sockopt/setsockopt: allow changing ctx->optlen within bounds:OK
#326/33  sockopt/setsockopt: deny write ctx->retval:OK
#326/34  sockopt/setsockopt: deny read ctx->retval:OK
#326/35  sockopt/setsockopt: deny writing to ctx->optval:OK
#326/36  sockopt/setsockopt: deny writing to ctx->optval_end:OK
#326/37  sockopt/setsockopt: allow IP_TOS <= 128:OK
#326/38  sockopt/setsockopt: deny IP_TOS > 128:OK
#326/39  sockopt/can attach only BPF_CGROUP_SETSOCKOP:OK
#326/40  sockopt/can attach only BPF_CGROUP_GETSOCKOP:OK
#326     sockopt:OK
#327     sockopt_inherit:OK
#328     sockopt_multi:OK
#329     sockopt_qos_to_cc:OK
#330     sockopt_sk:OK

All error logs:
create_netns:PASS:create netns 0 nsec
create_netns:PASS:set lo up 0 nsec
create_netns:PASS:add veth 0 nsec
create_netns:PASS:bring veth up 0 nsec
test_setget_sockopt:PASS:open skel 0 nsec
test_setget_sockopt:PASS:if_nametoindex 0 nsec
test_setget_sockopt:PASS:load skel 0 nsec
test_setget_sockopt:PASS:attach cgroup 0 nsec
test_setget_sockopt:PASS:attach_cgroup 0 nsec
test_tcp:PASS:start_server 0 nsec
test_tcp:PASS:connect_to_fd_server 0 nsec
test_tcp:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_tcp:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_tcp:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_tcp:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_tcp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_tcp:PASS:nr_bind 0 nsec
test_tcp:PASS:start_server 0 nsec
test_tcp:PASS:connect_to_fd_server 0 nsec
test_tcp:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_tcp:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_tcp:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_tcp:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_tcp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_tcp:PASS:nr_bind 0 nsec
test_udp:PASS:start_server 0 nsec
test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 < expected 1
test_udp:PASS:nr_bind 0 nsec
test_udp:PASS:start_server 0 nsec
test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 < expected 1
test_udp:PASS:nr_bind 0 nsec
test_ktls:PASS:start_server 0 nsec
test_ktls:PASS:connect_to_fd 0 nsec
test_ktls:PASS:accept 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:read 0 nsec
test_ktls:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_ktls:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_ktls:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_ktls:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_ktls:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_ktls:PASS:nr_bind 0 nsec
test_ktls:FAIL:nr_fin_wait1 unexpected nr_fin_wait1: actual 0 != expected 1
test_ktls:PASS:start_server 0 nsec
test_ktls:PASS:connect_to_fd 0 nsec
test_ktls:PASS:accept 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:setsockopt 0 nsec
test_ktls:PASS:read 0 nsec
test_ktls:FAIL:nr_listen unexpected nr_listen: actual 0 != expected 1
test_ktls:FAIL:nr_connect unexpected nr_connect: actual 0 != expected 1
test_ktls:FAIL:nr_active unexpected nr_active: actual 0 != expected 1
test_ktls:FAIL:nr_passive unexpected nr_passive: actual 0 != expected 1
test_ktls:FAIL:nr_socket_post_create unexpected nr_socket_post_create: 
actual 0 != expected 2
test_ktls:PASS:nr_bind 0 nsec
test_ktls:FAIL:nr_fin_wait1 unexpected nr_fin_wait1: actual 0 != expected 1
test_nonstandard_opt:PASS:start_server 0 nsec
test_nonstandard_opt:PASS:connect_to_fd_server 0 nsec
test_nonstandard_opt:PASS:getsockopt prog 0 nsec
test_nonstandard_opt:PASS:accept 0 nsec
test_nonstandard_opt:PASS:getsockopt_flags 0 nsec
test_nonstandard_opt:PASS:cb_flags_set 0 nsec
test_nonstandard_opt:PASS:start_server 0 nsec
test_nonstandard_opt:PASS:connect_to_fd_server 0 nsec
test_nonstandard_opt:PASS:getsockopt prog 0 nsec
test_nonstandard_opt:PASS:accept 0 nsec
test_nonstandard_opt:PASS:getsockopt_flags 0 nsec
test_nonstandard_opt:PASS:cb_flags_set 0 nsec
#303     setget_sockopt:FAIL
Summary: 7/40 PASSED, 0 SKIPPED, 1 FAILED


With this patch:


#if defined(__TARGET_ARCH_powerpc)
#define SO_RCVLOWAT             16
#else
#define SO_RCVLOWAT             18
#endif
#define SO_BINDTODEVICE         25
#define SO_MARK                 36
#define SO_MAX_PACING_RATE      47


./test_progs -t sockopt
#20      bpf_iter_setsockopt:OK
#21      bpf_iter_setsockopt_unix:OK
#303     setget_sockopt:OK
#326/1   sockopt/getsockopt: no expected_attach_type:OK
#326/2   sockopt/getsockopt: wrong expected_attach_type:OK
#326/3   sockopt/getsockopt: bypass bpf hook:OK
#326/4   sockopt/getsockopt: return EPERM from bpf hook:OK
#326/5   sockopt/getsockopt: no optval bounds check, deny loading:OK
#326/6   sockopt/getsockopt: read ctx->level:OK
#326/7   sockopt/getsockopt: deny writing to ctx->level:OK
#326/8   sockopt/getsockopt: read ctx->optname:OK
#326/9   sockopt/getsockopt: read ctx->retval:OK
#326/10  sockopt/getsockopt: deny writing to ctx->optname:OK
#326/11  sockopt/getsockopt: read ctx->optlen:OK
#326/12  sockopt/getsockopt: deny bigger ctx->optlen:OK
#326/13  sockopt/getsockopt: ignore >PAGE_SIZE optlen:OK
#326/14  sockopt/getsockopt: support smaller ctx->optlen:OK
#326/15  sockopt/getsockopt: deny writing to ctx->optval:OK
#326/16  sockopt/getsockopt: deny writing to ctx->optval_end:OK
#326/17  sockopt/getsockopt: rewrite value:OK
#326/18  sockopt/setsockopt: no expected_attach_type:OK
#326/19  sockopt/setsockopt: wrong expected_attach_type:OK
#326/20  sockopt/setsockopt: bypass bpf hook:OK
#326/21  sockopt/setsockopt: return EPERM from bpf hook:OK
#326/22  sockopt/setsockopt: no optval bounds check, deny loading:OK
#326/23  sockopt/setsockopt: read ctx->level:OK
#326/24  sockopt/setsockopt: allow changing ctx->level:OK
#326/25  sockopt/setsockopt: read ctx->optname:OK
#326/26  sockopt/setsockopt: allow changing ctx->optname:OK
#326/27  sockopt/setsockopt: read ctx->optlen:OK
#326/28  sockopt/setsockopt: ctx->optlen == -1 is ok:OK
#326/29  sockopt/setsockopt: deny ctx->optlen < 0 (except -1):OK
#326/30  sockopt/setsockopt: deny ctx->optlen > input optlen:OK
#326/31  sockopt/setsockopt: ignore >PAGE_SIZE optlen:OK
#326/32  sockopt/setsockopt: allow changing ctx->optlen within bounds:OK
#326/33  sockopt/setsockopt: deny write ctx->retval:OK
#326/34  sockopt/setsockopt: deny read ctx->retval:OK
#326/35  sockopt/setsockopt: deny writing to ctx->optval:OK
#326/36  sockopt/setsockopt: deny writing to ctx->optval_end:OK
#326/37  sockopt/setsockopt: allow IP_TOS <= 128:OK
#326/38  sockopt/setsockopt: deny IP_TOS > 128:OK
#326/39  sockopt/can attach only BPF_CGROUP_SETSOCKOP:OK
#326/40  sockopt/can attach only BPF_CGROUP_GETSOCKOP:OK
#326     sockopt:OK
#327     sockopt_inherit:OK
#328     sockopt_multi:OK
#329     sockopt_qos_to_cc:OK
#330     sockopt_sk:OK
Summary: 8/40 PASSED, 0 SKIPPED, 0 FAILED

Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


