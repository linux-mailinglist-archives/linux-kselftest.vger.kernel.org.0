Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FF6B0630
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCHLmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCHLmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:42:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C2BCFEE
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 03:41:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ay14so60817753edb.11
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 03:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112; t=1678275712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Is/quSvT3TJIPDFEbm6RZXsFk8WJ06IX2kfE6yYnF3I=;
        b=JoY9f/gwPqh8ulZsXsSOQ87r7ihrjL+906w9miXHgutvS5nyPCiFKX70IK/SUfoLAD
         7AsGePMghdxXk/wRT85Ed0ildPaEq5dxDhiG467t0qbymo7y97hEIWkipeoGYaKZmTmj
         iVZa6VHrf/1NS0zoKobiWAHPILBCjjXxE/rfkVpnYtGK1mPhfcFamEB0n1k05ekB/g76
         65L7yatB5sUWUuU1iz+Yf4mDSVn9mBT5fRUSqQmgfKjMEmaZmW4PDhppk7jQGlOPj0bD
         Ix2tPXz4k7s+tbki526dAWHYuvF74O3H2unqXz/RN5d9AF/UDS2IPqEweJve7ExeFNKg
         3tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678275712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Is/quSvT3TJIPDFEbm6RZXsFk8WJ06IX2kfE6yYnF3I=;
        b=XCavgPeGYDbBi+xPAAlC/cU6O2vphKmxh98/leZjBt1N9bDplGmk8cUuykva28rjOC
         Y4iGPkcYww90TIRox2IvxRQvPOpLEQO/AdDd0CVKylNQdi/R3NaikbzHNRVk7zfnoKyT
         FqeAxgCarW+HcV8DMIEG6fuckyn3vFI96J7KkuRJNENaM0/FsK6S1W197UKepq7WkIu3
         ZpsxEDSnRKxvIx81GdJR86N86OgVcsCIVG79fAFpJnfdV0qzcQn3SYHHM+U8NbQceXK+
         reUKHjKYEGXSPX1p0nBeGbeSPWhaP5/0Qz/SBnIMdfWQSrCGDSlGghNwFCG6cdNDCT/r
         AOSQ==
X-Gm-Message-State: AO0yUKUXLGo0rayLpXwNj5eks4pjtGiexki+460L2bbAHFQZfEvdSX2z
        KrIa/7VzxKL1NXSqcpCLbS5AIA==
X-Google-Smtp-Source: AK7set/1uwA+p1HHny45n37ykgfDDSeAWNPouc1UdQ7cJxYi4nqXIkMr1mgaN97QuJjYiLj4BlfjJw==
X-Received: by 2002:a17:906:1c13:b0:896:427b:148 with SMTP id k19-20020a1709061c1300b00896427b0148mr16362789ejg.1.1678275712179;
        Wed, 08 Mar 2023 03:41:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y7-20020a170906470700b008ef13127b5fsm7380758ejq.29.2023.03.08.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:41:51 -0800 (PST)
Date:   Wed, 8 Mar 2023 12:41:49 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com,
        danieller@mellanox.com, petrm@mellanox.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Subject: Re: [PATCHv2] selftests: net: devlink_port_split.py: skip test if no
 suitable device available
Message-ID: <ZAh0fY4XoNcLTIOI@nanopsycho>
References: <20230307150030.527726-1-po-hsu.lin@canonical.com>
 <ZAhV8nKuLVAQHQGl@nanopsycho>
 <CAMy_GT92sg4_JLPHvRpH542DPLbxOEYYoCMa2cnET1g8bz_R9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMy_GT92sg4_JLPHvRpH542DPLbxOEYYoCMa2cnET1g8bz_R9Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Wed, Mar 08, 2023 at 11:21:57AM CET, po-hsu.lin@canonical.com wrote:
>On Wed, Mar 8, 2023 at 5:31 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Mar 07, 2023 at 04:00:30PM CET, po-hsu.lin@canonical.com wrote:
>> >The `devlink -j port show` command output may not contain the "flavour"
>> >key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-generic),
>> >iproute2-5.15.0:
>> >  {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
>> >           "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"},
>> >           "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
>> >           "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}}}
>>
>> As Jakub wrote, this is odd. Could you debug if kernel sends the flavour
>> attr and if not why? Also, could you try with most recent kernel?
>
>I did a quick check on another s390x LPAR instance which is running
>with Ubuntu 23.04 (6.1.0-16-generic) iproute2-6.1.0, there is still no
>"flavour" attribute.
>$ devlink port show
>pci/0001:00:00.0/1: type eth netdev ens301
>pci/0001:00:00.0/2: type eth netdev ens301d1
>pci/0002:00:00.0/1: type eth netdev ens317
>pci/0002:00:00.0/2: type eth netdev ens317d1
>
>The behaviour didn't change with iproute2 built from source [1]

Could you paste output of "devlink dev info"?
Looks like something might be wrong in the kernel devlink/driver code.


