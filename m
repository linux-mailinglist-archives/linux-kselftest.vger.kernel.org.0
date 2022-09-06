Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D45ADDAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 05:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiIFDCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 23:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiIFDCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 23:02:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C6659DF;
        Mon,  5 Sep 2022 20:02:05 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k9so2188772ils.12;
        Mon, 05 Sep 2022 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=e6ax8KuifIHCkjxOKF7xRRHTen0YEWPFansA8s37f58=;
        b=dO6dAQQckz+0jiklz9ahATwePXix0rbWdfr/4fMWI/Ovn071zhNGvL+NZgIhStsBqb
         omRs4OrQwcbQNv+cKzTuWziTU6nfh4Ynn/Lp6VCuJcQSqe7Nic2Hp769YKLrOWQr77fB
         5HHVuZPqIx4VGfJlAZAfz8DU5gYTJF74azx3kM4y2f5aeBJysYuow03iRnLejGr9RFi8
         QLCF4lP31ucxNOmTUgUFXwxRTsq4PSEh3qhHqhaOFXyFzWOFeHEcLdTbw/pzcREayBSm
         PBruQly9qfGF153+HsMP39n4dA0uQAU5c4+eUpEP/x09QN8IbtgPnLmN0hH//twJzCs5
         Dd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e6ax8KuifIHCkjxOKF7xRRHTen0YEWPFansA8s37f58=;
        b=Kb3e+EjDuGOyi1aa95pK4gHLJNWiJUzfI0pHnduEKCvqQpGzhUDohGxvlea6sMpSw0
         Fljf5K0L75WlfCmAmMV7yFoN9Ap9mJ6E/Srj8eTrV4qxKKJ9EK9kgZJaZYtWg1OyGSBQ
         LanIs9/66jpFg83uwuHE+0HhhoUddDTlzMnfRuFpy9BrOmVFJyKmC96AMr7IH2xF9Q5z
         Far4M41Ji2w8X7MSwQyROLnHUv+oNG3Xtfjz2x6D8SO7Jqk5Wz9svbaH8MbbcRKbu1R3
         9VzRmkFvF4b3qKsK8hNipyoCTCCyoU6IQweGQiT1eZXpM/yRqSq5jKhx/DY3CbgW1wzd
         sPTA==
X-Gm-Message-State: ACgBeo05UDq/ZTsPxfFgPw4ZgqrXwgxbYglnwMrmPmhrLOarw/Icvc5L
        DKuPK33vUHjMjW27qHdJqK5vjI8yDTWJPUHaSCU=
X-Google-Smtp-Source: AA6agR7H9SaerJROiw7/20zb89NXmiAzsHL24H5gnJDTHW9EOIQIed6Rk1G85r6k/W3zb+IKmFXncEorBLQEhbHMAFo=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr3971056ill.216.1662433325236; Mon, 05
 Sep 2022 20:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-9-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-9-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 05:01:29 +0200
Message-ID: <CAP01T74iyyxyrvO_qMG98_8zJ_GtStGkqjG-jgOtDOr2Eh=DWQ@mail.gmail.com>
Subject: Re: [PATCH v16 08/12] selftests/bpf: Compile kernel with everything
 as built-in
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Since the eBPF CI does not support kernel modules, change the kernel conf=
ig
> to compile everything as built-in.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Daniel M=C3=BCller <deso@posteo.net>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  tools/testing/selftests/bpf/config        | 26 +++++++++++------------
>  tools/testing/selftests/bpf/config.x86_64 |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 3fc46f9cfb22..0fdd11e6b742 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -7,9 +7,9 @@ CONFIG_BPF_LSM=3Dy
>  CONFIG_BPF_STREAM_PARSER=3Dy
>  CONFIG_BPF_SYSCALL=3Dy
>  CONFIG_CGROUP_BPF=3Dy
> -CONFIG_CRYPTO_HMAC=3Dm
> -CONFIG_CRYPTO_SHA256=3Dm
> -CONFIG_CRYPTO_USER_API_HASH=3Dm
> +CONFIG_CRYPTO_HMAC=3Dy
> +CONFIG_CRYPTO_SHA256=3Dy
> +CONFIG_CRYPTO_USER_API_HASH=3Dy
>  CONFIG_DYNAMIC_FTRACE=3Dy
>  CONFIG_FPROBE=3Dy
>  CONFIG_FTRACE_SYSCALLS=3Dy
> @@ -24,30 +24,30 @@ CONFIG_IP_NF_FILTER=3Dy
>  CONFIG_IP_NF_RAW=3Dy
>  CONFIG_IP_NF_TARGET_SYNPROXY=3Dy
>  CONFIG_IPV6=3Dy
> -CONFIG_IPV6_FOU=3Dm
> -CONFIG_IPV6_FOU_TUNNEL=3Dm
> +CONFIG_IPV6_FOU=3Dy
> +CONFIG_IPV6_FOU_TUNNEL=3Dy
>  CONFIG_IPV6_GRE=3Dy
>  CONFIG_IPV6_SEG6_BPF=3Dy
> -CONFIG_IPV6_SIT=3Dm
> +CONFIG_IPV6_SIT=3Dy
>  CONFIG_IPV6_TUNNEL=3Dy
>  CONFIG_LIRC=3Dy
>  CONFIG_LWTUNNEL=3Dy
>  CONFIG_MPLS=3Dy
> -CONFIG_MPLS_IPTUNNEL=3Dm
> -CONFIG_MPLS_ROUTING=3Dm
> +CONFIG_MPLS_IPTUNNEL=3Dy
> +CONFIG_MPLS_ROUTING=3Dy
>  CONFIG_MPTCP=3Dy
>  CONFIG_NET_CLS_ACT=3Dy
>  CONFIG_NET_CLS_BPF=3Dy
> -CONFIG_NET_CLS_FLOWER=3Dm
> -CONFIG_NET_FOU=3Dm
> +CONFIG_NET_CLS_FLOWER=3Dy
> +CONFIG_NET_FOU=3Dy
>  CONFIG_NET_FOU_IP_TUNNELS=3Dy
>  CONFIG_NET_IPGRE=3Dy
>  CONFIG_NET_IPGRE_DEMUX=3Dy
>  CONFIG_NET_IPIP=3Dy
> -CONFIG_NET_MPLS_GSO=3Dm
> +CONFIG_NET_MPLS_GSO=3Dy
>  CONFIG_NET_SCH_INGRESS=3Dy
>  CONFIG_NET_SCHED=3Dy
> -CONFIG_NETDEVSIM=3Dm
> +CONFIG_NETDEVSIM=3Dy
>  CONFIG_NETFILTER=3Dy
>  CONFIG_NETFILTER_SYNPROXY=3Dy
>  CONFIG_NETFILTER_XT_CONNMARK=3Dy
> @@ -60,7 +60,7 @@ CONFIG_NF_DEFRAG_IPV6=3Dy
>  CONFIG_RC_CORE=3Dy
>  CONFIG_SECURITY=3Dy
>  CONFIG_SECURITYFS=3Dy
> -CONFIG_TEST_BPF=3Dm
> +CONFIG_TEST_BPF=3Dy
>  CONFIG_USERFAULTFD=3Dy
>  CONFIG_VXLAN=3Dy
>  CONFIG_XDP_SOCKETS=3Dy
> diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/se=
lftests/bpf/config.x86_64
> index f0859a1d37ab..ce70c9509204 100644
> --- a/tools/testing/selftests/bpf/config.x86_64
> +++ b/tools/testing/selftests/bpf/config.x86_64
> @@ -47,7 +47,7 @@ CONFIG_CPU_IDLE_GOV_LADDER=3Dy
>  CONFIG_CPUSETS=3Dy
>  CONFIG_CRC_T10DIF=3Dy
>  CONFIG_CRYPTO_BLAKE2B=3Dy
> -CONFIG_CRYPTO_DEV_VIRTIO=3Dm
> +CONFIG_CRYPTO_DEV_VIRTIO=3Dy
>  CONFIG_CRYPTO_SEQIV=3Dy
>  CONFIG_CRYPTO_XXHASH=3Dy
>  CONFIG_DCB=3Dy
> --
> 2.25.1
>
