Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E409780E5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377861AbjHROzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358970AbjHROzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 10:55:14 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E235BB;
        Fri, 18 Aug 2023 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=V+hKc+AoclIVijYb9tmyVJ/kpz+nndvmM+7r5NohFGM=; b=YQFHFXUW7thyrRLdoBV6PkHHUY
        +Izgr6kblP9lpp9CeaaszXl+zCv1ct06LH/F7CWHLEozVREy9eVDSlZKKLGlEl44ejM4FIuMNpOhD
        FXbjPMzZI99NisfZlfG5rnzpoLVcep+8tSM07FY/Vn7A82ZZOfOfImLJmsbHBAgeukiyJ3BGQNKaP
        RaSqrNzOORXT3t6LdNrnbR/VviLO+oExT++BH+Wn0W/bEz5qb3SRWwQupA74LAzkb4jto56EmkEr8
        nZFVo6wjuDl9MebfyuM+6HJA6T1K27EtwMZDgq4M4URgtoCcx/WEUbC+jI0G5Q2X0EijO22lH1ZFn
        TuNAKURw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qX0sX-000GVQ-IT; Fri, 18 Aug 2023 16:55:09 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qX0sW-000XLM-7l; Fri, 18 Aug 2023 16:55:08 +0200
Subject: Re: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
To:     Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1692326837.git.yan@cloudflare.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
Date:   Fri, 18 Aug 2023 16:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1692326837.git.yan@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27004/Fri Aug 18 09:41:49 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/18/23 4:58 AM, Yan Zhai wrote:
> lwt xmit hook does not expect positive return values in function
> ip_finish_output2 and ip6_finish_output. However, BPF programs can
> directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
> and etc to the caller. Such return values would make the kernel continue
> processing already freed skbs and eventually panic.
> 
> This set fixes the return values from BPF ops to unexpected continue
> processing, checks strictly on the correct continue condition for
> future proof. In addition, add missing selftests for BPF redirect
> and reroute cases for BPF-CI.
> 
> v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.com/
> v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/
> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> 
> changes since v5:
>   * fix BPF-CI failures due to missing config and busybox ping issue

Series looks good, thanks! Given we're fairly close to merge window and
this has been broken for quite some time, I took this into bpf-next.

Thanks,
Daniel
