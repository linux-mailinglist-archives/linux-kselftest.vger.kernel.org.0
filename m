Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C26B02F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCHJcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 04:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCHJbw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 04:31:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECBB854B
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 01:31:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o12so63015575edb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112; t=1678267892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmxXJHvQxfbDrLAWch03k5xnRMut7MXIx9gMNxn4uhY=;
        b=OJ+Fshl6p4wQwfjnQ7Wu1DMBjivuuttYpOO2S1744KYFu1VdWDzM2mrbbop/MBibWl
         nqGh/HVAAipXTKPjazricJRIcgdWKN4zTOAEEqIE1huj8lkVYGyPvBUFpIhY+Mpw9sGT
         kB19U5+5ugE5oE5FZNbEPqHnOpz9a12nbuUYUZ+1RU9VNO3cZIbEZQz6jm4dEcyJUTIP
         vJ1Pe129zIOglZgs6sel8ROQuOZkqF4a0oRcA8xA24xM/Zt/+/AiJZmZ2pLbmjdK+lxg
         G1/q8ufDsCrBPpJfwzeKRsrTPyuHmaY3hi0/JPonrNhP4IHl4DRVoA++5WsyNNflINqu
         aFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678267892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmxXJHvQxfbDrLAWch03k5xnRMut7MXIx9gMNxn4uhY=;
        b=sXhhVxqM08ZowiOyMKyHZ1W2cRjvSRClpanbpeH+NxSqs8s5nA7AQy0gA8uYOxfqe5
         XAG1AT+oWlMa9yf+2bma7KjtV2e9xEZOyPbK7fF03Yo2yLvem01vsppMutjiLVrH24cT
         p1h8tyFxU5znUXb4g+sZG0bZhTKJeU5ZjcvJrLI6W9ESqUb33B/45N9d4R8iwCvNEnem
         oqVgLD0K/KHrZrb9xFjhSmRdxSsz2UVb979kyktCao3Xtl1JgzXwMoBKBb48tSi8l/OA
         8VihayvNNvxEGZ7jJyITJl7XkiewjODbWdqMMy4t420NZHxpvyS5qR+EwnNX09+00aFE
         keUg==
X-Gm-Message-State: AO0yUKXNc2buQQiwmUMgrP/SnxXsI3yhwT3JAOQ7A8efFSeNLEkUhyLA
        MjirfwbfT1iCtLowATKX2WrvhFQ7riDc6+JS8NU=
X-Google-Smtp-Source: AK7set9f9BPCcWpi1PJQqIc99NrzF34rCnuqLJbhNbcxkqwL4pDsGdVSBZfi393m/qGblUav7G30kA==
X-Received: by 2002:a05:6402:1291:b0:4ad:66b:84a5 with SMTP id w17-20020a056402129100b004ad066b84a5mr16119629edv.22.1678267892393;
        Wed, 08 Mar 2023 01:31:32 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v24-20020a50d598000000b004bfc59042e5sm7858518edi.61.2023.03.08.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:31:31 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:31:30 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com,
        danieller@mellanox.com, petrm@mellanox.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Subject: Re: [PATCHv2] selftests: net: devlink_port_split.py: skip test if no
 suitable device available
Message-ID: <ZAhV8nKuLVAQHQGl@nanopsycho>
References: <20230307150030.527726-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307150030.527726-1-po-hsu.lin@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tue, Mar 07, 2023 at 04:00:30PM CET, po-hsu.lin@canonical.com wrote:
>The `devlink -j port show` command output may not contain the "flavour"
>key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-generic),
>iproute2-5.15.0:
>  {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
>           "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"},
>           "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
>           "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}}}

As Jakub wrote, this is odd. Could you debug if kernel sends the flavour
attr and if not why? Also, could you try with most recent kernel?
