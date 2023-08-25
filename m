Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5310787DD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjHYCiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 22:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbjHYChk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 22:37:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F56D1FFA;
        Thu, 24 Aug 2023 19:37:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-689f9576babso453706b3a.0;
        Thu, 24 Aug 2023 19:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692931019; x=1693535819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjgr9Lccp1LmGd0JexC+Jrb4z2QtfSQ9zg0bCsBzbbc=;
        b=lQ9tI6+yOCU0GhUIZAJSys3nx2Oqf/zruKH06HeH234eNXGH/K803y70TVpxHQcPC1
         S5fcvW0CjkyfD4ceuRbQx7xTDRbnVNwhjSQt92btaBUaYAqV4whEL41JdZR1EShirtC2
         fLYhfvNGcrGQgnmq3WyTn2S3UMEpQ2z6s8leU0qBYBsLvNET5ENEKFf+c0Xuu3DYpru0
         c1DEG5h7jIBixX2otUh/W36hXIEdDyXPnLlVfjr3bt+/nFQjUfUPUX1ZJvx4HmngmMG0
         X2Qh9oWI42fLaAIHUov0ERbA9kQ8FCyqzlEwLcow7L3nuliMLSaMENbJX/NqKzx4A3kG
         RTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931019; x=1693535819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjgr9Lccp1LmGd0JexC+Jrb4z2QtfSQ9zg0bCsBzbbc=;
        b=PVw37wys3nRZH89VuISy49IR4xl3l23vhthWrYJdHxcsNMqsbS2or2312L//ZbAKGF
         tosT1dVeWzvTVV48czpBZyQdycwIFGuU4F3q4lubVylOTIRLAzp9BjwLuCVaHM1PTULG
         kaa/xfm5ooQzyDNXvInI5qKOuk5fubcYtqRe0/B5HkSFj8NuehB4AJQEjWQ3eaOofrnH
         Oj5lXNteQBmR2AA1gHC4pvyE/eXLeCUWClqXNrtt1nSsBvNQ8MhLGxnt5Fe2SRRi6Y6i
         1mZlDA3eUpogZPd06c6wDBZNHP0pPcxzE2yjsVywAj73o5fh3px6vyjrNNKlAYh0gLsR
         SJWg==
X-Gm-Message-State: AOJu0YwAPKr896Sf//HJQU74udoSY/Pav7vBBXxjBzi00GeXJOFvw2j8
        UQ0dGPkI5UjRlJhBy2FAA9Y=
X-Google-Smtp-Source: AGHT+IH9i6mjcp5eSOlOD+z5ninGDmpYO+99GvzNf5cKCBOvYlaSh1TE4H2q8YpSxVpX8URIg534cQ==
X-Received: by 2002:a05:6a00:1501:b0:66a:2ff1:dee2 with SMTP id q1-20020a056a00150100b0066a2ff1dee2mr16910072pfu.10.1692931019422;
        Thu, 24 Aug 2023 19:36:59 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b006887be16675sm419835pfh.205.2023.08.24.19.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:36:58 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:36:53 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v2] selftests: bonding: create directly devices
 in the target namespaces
Message-ID: <ZOgTxefEAVNPkZ23@Laptop-X1>
References: <20230824135715.1131084-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824135715.1131084-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 24, 2023 at 09:57:15PM +0800, Zhengchao Shao wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So it will be safer creating directly the
> devices in the target namespaces.
> 
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: create directly devices in the target namespaces
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> index 7b2d421f09cf..fe7c34f89fc7 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> @@ -22,14 +22,12 @@ server_ip4=192.168.1.254
>  echo 180 >/proc/sys/kernel/panic
>  
>  # build namespaces
> -ip link add dev link1_1 type veth peer name link1_2
> -
>  ip netns add "server"
> -ip link set dev link1_2 netns server up name eth0
> +ip netns add "client"
> +ip link add dev eth0 netns client type veth peer name eth0 netns server

When we already have an eth0 interface on init net, this cmd will failed

# ip link add dev eth0 netns client type veth peer name eth0 netns server
RTNETLINK answers: File exists

You should create the eth0 in the namespace, e.g.

# ip -n client link add eth0 type veth peer name eth0 netns server

Thanks
Hangbin
