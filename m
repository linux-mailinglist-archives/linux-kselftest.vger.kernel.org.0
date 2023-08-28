Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AA78A57E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 08:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH1GE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjH1GEY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 02:04:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE9EC;
        Sun, 27 Aug 2023 23:04:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c06f6f98c0so21997275ad.3;
        Sun, 27 Aug 2023 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693202662; x=1693807462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3w60luS48j6vUYZqPx587vsJwRkad+xFDz6Iuy07TfY=;
        b=kQml0mzl+6L4UF8cHDKVVCmFq4e5tayCw1DlF2QQvBw8fOOuBOeNGZ2c0Z2MqGDf3Z
         sX/fJ2RezR87FM8ZXTuf3IgJ7zY+nfPLeU9eVJ1E4SmT+SAcpRC1+AZ29T4T941TVmHB
         CavKMhjwlYhE0B1LpXI9nAljVdUIIPDYXyeCeSxMwwgLrSI8AIpd0Cc1Y3BhFS2opVSr
         QeZHw4sd3XXHvGxTohPfKQPplaPZCz4I2lBldmZsut2xn3caRgfc0W7s0hwBNxwuYEEP
         MpzKAXiOw/F+VqmfrsFHbwB/LGXiotbuRu/K+htuZmagLXnEOMRepD0wJrnjRNw8YKiV
         nRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693202662; x=1693807462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w60luS48j6vUYZqPx587vsJwRkad+xFDz6Iuy07TfY=;
        b=gVlfYkkM5R86wh+4onwLzwscsx48EQoCyTtolE3kQa27mrkr3e4xjmYG9VcobTQoID
         jgx1VFopj8aIUaCCvLr91Pew+cIFqdL5yODCH1unPkSBJDLhKOUudJRW6zY6FazNgHCx
         j4d/Ux/xKqDul4lbEi7cE0lRH71GcpKVhCr5irQpKlE3IRTS4Q0u+PYPrE8eZU/a6oRe
         xz6t6pZAolZwgCicLA9R45r6oH6IkCsqpcdEXPEIhyIBU3kwrhzvaYWo4ZdEIr8cuuX/
         pHkZDzvblr4uaFqCxgGvWhCEZOjrqvB2m4yg0Efcsq/ahacgk74y12g5iXDxioLRNxUw
         JFfQ==
X-Gm-Message-State: AOJu0YxgiGcQDyraMWSGfgVJkg/6u5Awgy7P0bP5c7hoO/iUPbPn1jHo
        oMxzHlUVf2qq8NuLIylaEMo=
X-Google-Smtp-Source: AGHT+IELM9yP+4vP6DACSH+Fv9Hniiv/KteTD8sX/BfTxlIped+YCry8g1m/KSQIazlINwfa5tHodw==
X-Received: by 2002:a17:902:c3c3:b0:1b8:6cae:3570 with SMTP id j3-20020a170902c3c300b001b86cae3570mr25192497plj.11.1693202661704;
        Sun, 27 Aug 2023 23:04:21 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001bde877a7casm6280498plk.264.2023.08.27.23.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:04:20 -0700 (PDT)
Date:   Mon, 28 Aug 2023 14:04:16 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v3] selftests: bonding: create directly devices
 in the target namespaces
Message-ID: <ZOw44Bvbr4qRhz8x@Laptop-X1>
References: <20230826022330.3474899-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826022330.3474899-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 26, 2023 at 10:23:30AM +0800, Zhengchao Shao wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So it will be safer creating directly the
> devices in the target namespaces.
> 
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v3: create the eth0 in the namespace
> v2: create directly devices in the target namespaces
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> index 7b2d421f09cf..4917dbb35a44 100755
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
> +ip -n client link add eth0 type veth peer name eth0 netns server
> +ip netns exec server ip link set dev eth0 up
>  ip netns exec server ip addr add ${server_ip4}/24 dev eth0
>  
> -ip netns add "client"
> -ip link set dev link1_1 netns client down name eth0
>  ip netns exec client ip link add dev bond0 down type bond mode 1 \
>  	miimon 100 all_slaves_active 1
>  ip netns exec client ip link set dev eth0 down master bond0
> -- 
> 2.34.1
> 

Acked-by: Hangbin Liu <liuhangbin@gmail.com>
