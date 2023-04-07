Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DB6DA711
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 03:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjDGBro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 21:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDGBrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 21:47:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185C658B;
        Thu,  6 Apr 2023 18:47:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so254654pjo.4;
        Thu, 06 Apr 2023 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680832062; x=1683424062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PepjG6ZLpeM6OfRQMKXaRAf4V5wN0coiY427k79nKUo=;
        b=q06bERKiMblIXmReR0YrSdnhJKKVUJpLuCEvAE8es1YZyb76PfR8Cs4RvrKMKDwyAU
         XikKG61gWv5vNn1Mjv0fdAB3+5TgDdF+gzPhbbJtA/zemoItBt7wybLGoLJsgK4f7l/k
         y1cU8F7AM7JHxd69HPpuCAZhVHwHuPPmiaM96G08YwawfDR/MT6vcy/mX7AK/5rztqR6
         zZAIV1LkL2XycFKMnQk4w6TiIM2aSyR8BM2Q/OqflDbf48KahgCcjgjLoTpeGqqg5kl8
         mEhhnnR3J+noyV6Zpl/Tb2SsgtdOwmqIQJnO5ks7BYGRjWUZe8BhTgcOD8hNXctISnNI
         JcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680832062; x=1683424062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PepjG6ZLpeM6OfRQMKXaRAf4V5wN0coiY427k79nKUo=;
        b=qOTgrpq28LKmo7lX6aHAfTtDrIdWAvKiyXrOg+w6DsSSlX5fU2L5WnTm6KlNCCZK/M
         DnKEqFXX011vRH2Z83SGP1QQvPWL3lqu8mykyLxOEpbGuM8VaG4MDwHU0mcFDDOWq1fa
         jN2DIEYFPQHbBMSVY7GlhHxcYmfrwWhH/r0LSgp1a8Vx5UDhdshHLNUUck18IYKkhKJe
         Wi5Kk4Gj92H9VE+QChpWQUOba4cjqsjaccVSdYM7sAgwPNx83p1EcLherrF5gxXS9XCe
         81gbxjwuOKqF63Sab7aN+ZZAMBEoB9EJjPPLWKtO6TxPVfCg7FN6+NrBy8SJ6IBk23ev
         Do5w==
X-Gm-Message-State: AAQBX9dzq1dtsvzI5JT4h7ougGkz+sxPrW72lBGa32BApL928tVoX1Jw
        WZ3fbuoc8YoREIEEJJ11ZwA=
X-Google-Smtp-Source: AKy350ZY8Rp79bXWrwucj9FTCSZp+fQOFO4WTUaVrUHI3gQblqwFuU/WCiYepCMaqEM9SXsTN/Clrw==
X-Received: by 2002:a17:90a:5c:b0:23f:580d:b252 with SMTP id 28-20020a17090a005c00b0023f580db252mr612049pjb.36.1680832061857;
        Thu, 06 Apr 2023 18:47:41 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5abd])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c1d200b0019e8c3cd3f4sm1941897plc.201.2023.04.06.18.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 18:47:41 -0700 (PDT)
Date:   Thu, 6 Apr 2023 18:47:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Christian Ehrig <cehrig@cloudflare.com>
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Paul Chaignon <paul@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Test FOU kfuncs for
 externally controlled ipip devices
Message-ID: <20230407014737.sqnq4a3g7ye2novk@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <cover.1680520500.git.cehrig@cloudflare.com>
 <528a824713c1545839d870eaad84d87749a23371.1680520500.git.cehrig@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528a824713c1545839d870eaad84d87749a23371.1680520500.git.cehrig@cloudflare.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 03, 2023 at 02:12:09PM +0200, Christian Ehrig wrote:
> +
> +SEC("tc")
> +int ipip_encap_get_tunnel(struct __sk_buff *skb)
> +{
> +	int ret;
> +	struct bpf_tunnel_key key = {};
> +	struct bpf_fou_encap encap = {};
> +
> +	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ret = bpf_skb_get_fou_encap(skb, &encap);
> +	if (ret < 0) {
> +		log_err(ret);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	if (bpf_ntohs(encap.dport) != 5555)
> +		return TC_ACT_SHOT;
> +
> +	bpf_printk("%d remote ip 0x%x, sport %d, dport %d\n", ret,
> +		   key.remote_ipv4, bpf_ntohs(encap.sport),
> +		   bpf_ntohs(encap.dport));
> +	return TC_ACT_OK;
> +}
> +
>  SEC("tc")
>  int ipip6_set_tunnel(struct __sk_buff *skb)
>  {
> diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
> index 2dec7dbf29a2..f2379414a887 100755
> --- a/tools/testing/selftests/bpf/test_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tunnel.sh

All looks good to me, but please integrate the selftest into test_progs.
test_tunnel is obsolete. BPF CI doesn't run it and maintainers don't do either.
