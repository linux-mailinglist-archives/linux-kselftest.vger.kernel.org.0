Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34250598A8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiHRRgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 13:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345011AbiHRRgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 13:36:00 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BFC578E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 10:35:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DA819240031
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 19:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660844155; bh=qnhd6HdPquVSm0kh0TC8MijB3p2ZP/IpLjvgG/ZYqJQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iwGsXNcg519jBoFq8qXIbpeagtK6pWC2ePR9B0Fyea0BF9+YXq7x/Ac3hWaQaSTG1
         0t8cdaI/rw8dXJaeh1D1GeyPKLdREjsF3sobEr8yCvTfYgbFwnVpdBhXjfJ9HwqsSE
         uqqNwXafjKYZX+fBgZxpo7vcbXP2BvKaib2WzwU6aD3jQjZO99anO1X+8tlI/ybHez
         4T2aHw2CyxDD7a4hITme6LloaitAqZLsni2TPU4C9dEGfJgBw18K2NpubsH4qVPIJa
         mEiz8NTfxDUnBDTF3WLOtRBxlu8GgZ2AZhxpf/jkMH+04XZb4/ScCtuKKvITGiX4TJ
         D5ojkZJYssXuw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M7sVR5G6Yz9rxW;
        Thu, 18 Aug 2022 19:35:42 +0200 (CEST)
Date:   Thu, 18 Aug 2022 17:35:39 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     roberto.sassu@huaweicloud.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v12 07/10] selftests/bpf: Compile kernel with everything
 as built-in
Message-ID: <20220818173539.q47uycc2oy5kkezl@muellerd-fedora-PC2BDTX9>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-8-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818152929.402605-8-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 18, 2022 at 05:29:26PM +0200, roberto.sassu@huaweicloud.com wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Since the eBPF CI does not support kernel modules, change the kernel config
> to compile everything as built-in.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/testing/selftests/bpf/config        | 26 +++++++++++------------
>  tools/testing/selftests/bpf/config.x86_64 |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 3fc46f9cfb22..0fdd11e6b742 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -7,9 +7,9 @@ CONFIG_BPF_LSM=y
>  CONFIG_BPF_STREAM_PARSER=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_CGROUP_BPF=y
> -CONFIG_CRYPTO_HMAC=m
> -CONFIG_CRYPTO_SHA256=m
> -CONFIG_CRYPTO_USER_API_HASH=m
> +CONFIG_CRYPTO_HMAC=y
> +CONFIG_CRYPTO_SHA256=y
> +CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_DYNAMIC_FTRACE=y
>  CONFIG_FPROBE=y
>  CONFIG_FTRACE_SYSCALLS=y
> @@ -24,30 +24,30 @@ CONFIG_IP_NF_FILTER=y
>  CONFIG_IP_NF_RAW=y
>  CONFIG_IP_NF_TARGET_SYNPROXY=y
>  CONFIG_IPV6=y
> -CONFIG_IPV6_FOU=m
> -CONFIG_IPV6_FOU_TUNNEL=m
> +CONFIG_IPV6_FOU=y
> +CONFIG_IPV6_FOU_TUNNEL=y
>  CONFIG_IPV6_GRE=y
>  CONFIG_IPV6_SEG6_BPF=y
> -CONFIG_IPV6_SIT=m
> +CONFIG_IPV6_SIT=y
>  CONFIG_IPV6_TUNNEL=y
>  CONFIG_LIRC=y
>  CONFIG_LWTUNNEL=y
>  CONFIG_MPLS=y
> -CONFIG_MPLS_IPTUNNEL=m
> -CONFIG_MPLS_ROUTING=m
> +CONFIG_MPLS_IPTUNNEL=y
> +CONFIG_MPLS_ROUTING=y
>  CONFIG_MPTCP=y
>  CONFIG_NET_CLS_ACT=y
>  CONFIG_NET_CLS_BPF=y
> -CONFIG_NET_CLS_FLOWER=m
> -CONFIG_NET_FOU=m
> +CONFIG_NET_CLS_FLOWER=y
> +CONFIG_NET_FOU=y
>  CONFIG_NET_FOU_IP_TUNNELS=y
>  CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
>  CONFIG_NET_IPIP=y
> -CONFIG_NET_MPLS_GSO=m
> +CONFIG_NET_MPLS_GSO=y
>  CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NET_SCHED=y
> -CONFIG_NETDEVSIM=m
> +CONFIG_NETDEVSIM=y
>  CONFIG_NETFILTER=y
>  CONFIG_NETFILTER_SYNPROXY=y
>  CONFIG_NETFILTER_XT_CONNMARK=y
> @@ -60,7 +60,7 @@ CONFIG_NF_DEFRAG_IPV6=y
>  CONFIG_RC_CORE=y
>  CONFIG_SECURITY=y
>  CONFIG_SECURITYFS=y
> -CONFIG_TEST_BPF=m
> +CONFIG_TEST_BPF=y
>  CONFIG_USERFAULTFD=y
>  CONFIG_VXLAN=y
>  CONFIG_XDP_SOCKETS=y
> diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
> index f0859a1d37ab..ce70c9509204 100644
> --- a/tools/testing/selftests/bpf/config.x86_64
> +++ b/tools/testing/selftests/bpf/config.x86_64
> @@ -47,7 +47,7 @@ CONFIG_CPU_IDLE_GOV_LADDER=y
>  CONFIG_CPUSETS=y
>  CONFIG_CRC_T10DIF=y
>  CONFIG_CRYPTO_BLAKE2B=y
> -CONFIG_CRYPTO_DEV_VIRTIO=m
> +CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_CRYPTO_SEQIV=y
>  CONFIG_CRYPTO_XXHASH=y
>  CONFIG_DCB=y
> -- 
> 2.25.1

The change looks good to me. Thanks for making it.

Acked-by: Daniel Müller <deso@posteo.net>
