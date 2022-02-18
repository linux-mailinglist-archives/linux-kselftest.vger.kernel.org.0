Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532254BC17F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiBRVDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 16:03:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiBRVDK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 16:03:10 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45828B619
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 13:02:51 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s1so9034699iob.9
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 13:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TIOIhGACo4yRcpICfvsrQ9RUZoszNIPIS4XTNvXi2Qw=;
        b=MZB986Q5OSMTg2q6+FUc1U94/pExFm35n39q13oWTNYdQROdXMFcoR99fsh8mRRgjF
         NPE7EENmDHROij227U77hwGmuLHZIZn+6OnB3gCcog4VeC1F3yAJrZC+lUeX3GlZGpMo
         SZPkWb9QoKj+nf3PyOEkJMnyHVAGE3Vr0NL3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIOIhGACo4yRcpICfvsrQ9RUZoszNIPIS4XTNvXi2Qw=;
        b=R3aUEW4lbuy6AodbvQcG+7J5EorN1VCYxpOurfV8MzvChq24OOi/B9Dq4xcMDvvRec
         Q7RxT92F8TmERgFLGtk0aJu2x+09JGvMKhcrr3aCLeuSNW84OgMlTOVh9YV/HYbHR7Pi
         /jFZPOsTEHtGEWF9moQ7imqjOyaSdVxebi7GkAKXLp4tWsFIKe886u1vBEr3KFGJSuYf
         MGBtlTAQH+8DHIUccg0f7E7s1pCtz7x8QPnCmwz5+hIvw2zGw3tvDMJ/e3beOkH9nK2z
         f7hoy8Cyb5lG6zpFTryWzjPP/2l2qbpmcjj4jU7eQrUNsQBYcwS+9d/Yqlts2bW0MUqG
         ANww==
X-Gm-Message-State: AOAM532wLmCDQUEkzeEybjLdzvAu5XPKBVFLk8r47DfF6X8v8Ape+cXb
        HiA1fWAm4itTOq/aaRT4dP3c9W0JcSVGQA==
X-Google-Smtp-Source: ABdhPJyo3ZOGYVP9/XlaofaMHbR2s2snoXoa1AN7h3bGWaqLBI5qvvTPK0qLjHDTttG5v3huKWsaCw==
X-Received: by 2002:a02:a411:0:b0:314:b51c:3b74 with SMTP id c17-20020a02a411000000b00314b51c3b74mr2485006jal.69.1645218170847;
        Fri, 18 Feb 2022 13:02:50 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l1sm4536557iln.29.2022.02.18.13.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 13:02:50 -0800 (PST)
Subject: Re: [PATCH net-next v3 5/5] selftests: forwarding: tests of locked
 port feature
To:     Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org,
        Hans Schultz <schultz.hans+netdev@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-6-schultz.hans+netdev@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0afb9bb6-e8fd-71ce-7626-1d8bf90dd1e4@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 14:02:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220218155148.2329797-6-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 8:51 AM, Hans Schultz wrote:
> These tests check that the basic locked port feature works, so that no 'host'
> can communicate (ping) through a locked port unless the MAC address of the
> 'host' interface is in the forwarding database of the bridge.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>   .../testing/selftests/net/forwarding/Makefile |   1 +
>   .../net/forwarding/bridge_locked_port.sh      | 174 ++++++++++++++++++
>   tools/testing/selftests/net/forwarding/lib.sh |  16 ++
>   3 files changed, 191 insertions(+)
>   create mode 100755 tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> 
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index 72ee644d47bf..8fa97ae9af9e 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+ OR MIT
>   
>   TEST_PROGS = bridge_igmp.sh \
> +	bridge_locked_port.sh \
>   	bridge_port_isolation.sh \
>   	bridge_sticky_fdb.sh \
>   	bridge_vlan_aware.sh \

Looks good to me. Looks like TEST_PROGS # is getting close to 60.
Cool.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
