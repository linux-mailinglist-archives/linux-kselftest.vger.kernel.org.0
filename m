Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CE604DDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 18:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJSQy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJSQy6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 12:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605E9AFC4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666198492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hiPI5awSy8xIZ6rd///AMOSFCvHDWkmA5jXxoG5u5Y=;
        b=OiqUW1c4nGH34mKIpDomhW5DuQ+1phRjt2y+nqXcquZjEnydgLZL00kGhOq28Hm8L8ZP1I
        8waTrWUdnvcXjEhU0k/zPmjx9cQAX9R0VDJq3qisHpjlzz+aXHeGDrtTjHDvTpbvKWY3oG
        WDOHWG+JiBTHbvqXLEdHBb8IReTrTW0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-2z4jawuSOP-Zl9_34BXDiw-1; Wed, 19 Oct 2022 12:54:51 -0400
X-MC-Unique: 2z4jawuSOP-Zl9_34BXDiw-1
Received: by mail-qt1-f198.google.com with SMTP id u11-20020a05622a198b00b0039cca1826c8so13154430qtc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 09:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hiPI5awSy8xIZ6rd///AMOSFCvHDWkmA5jXxoG5u5Y=;
        b=iKug2Kt6cQBOgFLAN0EJWP04FfQBnhRk++xM2rMKjHyl6JbNvXsBJvwKOfBQ7EV+se
         NvPsfP1hd/e0RSGcWjujzkPSgLFeYeBW10aXWXrcBlA3V+zO33iGxraPsCrP4qMo6wHh
         NHmpmB+Uc+WbxTK03r8Q1xZdSvWGVRzius7mwBCFYHHyqxyxPIqkpi5eK1h4hy6PIGpR
         Ul/U4FDzJB1OI7VFDasWC+WxqRaPhTvUBDwaENHlrMtKKY+Hz71xoQ2HVsA02xNaJPku
         NAPJptZqIE7n9MGnmO4NM8ErKj5ci8L0FKMnOcdqaG5+Eu9esC30CqUgkM++aapBLJTM
         8e0A==
X-Gm-Message-State: ACrzQf3AzZ+FP9IMkNzMBvugJn0E4Xu5y3Xp5rQ6nQL6uxME7gUMqh4X
        t6t0U/mWjPT7oU8ZlSyOh+7fBpy3q1wZ5B2rBo5s708i9u+FlFKezwBMKEzdHV3UYEbUtV71vNb
        6wsps3v6P2QtfEPbySnlKMf3xd9P3
X-Received: by 2002:a05:620a:318d:b0:6ee:9097:ccc8 with SMTP id bi13-20020a05620a318d00b006ee9097ccc8mr6271613qkb.2.1666198491294;
        Wed, 19 Oct 2022 09:54:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5yPY5GjrBg7zzGzzsuXqv15YVK1iNlk3P31uBXzRWweLiVkPbaqTidA9uvyqr4xTxrqcWPgw==
X-Received: by 2002:a05:620a:318d:b0:6ee:9097:ccc8 with SMTP id bi13-20020a05620a318d00b006ee9097ccc8mr6271593qkb.2.1666198491061;
        Wed, 19 Oct 2022 09:54:51 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a450e00b006ce580c2663sm5357718qkp.35.2022.10.19.09.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 09:54:50 -0700 (PDT)
Message-ID: <b0e4d82f-f36b-1e18-76b9-a32b73da9fb8@redhat.com>
Date:   Wed, 19 Oct 2022 12:54:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH net 0/2] selftests: net: Fix problems in some drivers/net
 tests
Content-Language: en-US
To:     Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20221019091042.783786-1-bpoirier@nvidia.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <20221019091042.783786-1-bpoirier@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/19/22 05:10, Benjamin Poirier wrote:
> From: Benjamin Poirier <benjamin.poirier@gmail.com>
> 
> Fix two problems mostly introduced in commit bbb774d921e2 ("net: Add tests
> for bonding and team address list management").
> 
> Benjamin Poirier (2):
>    selftests: net: Fix cross-tree inclusion of scripts
>    selftests: net: Fix netdev name mismatch in cleanup
> 
>   tools/testing/selftests/drivers/net/bonding/Makefile        | 4 +++-
>   .../testing/selftests/drivers/net/bonding/dev_addr_lists.sh | 2 +-
>   .../selftests/drivers/net/bonding/net_forwarding_lib.sh     | 1 +
>   .../selftests/drivers/net/dsa/test_bridge_fdb_stress.sh     | 4 ++--
>   tools/testing/selftests/drivers/net/team/Makefile           | 4 ++++
>   tools/testing/selftests/drivers/net/team/dev_addr_lists.sh  | 6 +++---
>   tools/testing/selftests/drivers/net/team/lag_lib.sh         | 1 +
>   .../selftests/drivers/net/team/net_forwarding_lib.sh        | 1 +
>   tools/testing/selftests/lib.mk                              | 4 ++--
>   9 files changed, 18 insertions(+), 9 deletions(-)
>   create mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
>   create mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh
>   create mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
> 

Looks good, thanks.

For the series
Reviewed-by: Jonathan Toppins <jtoppins@redhat.com>

