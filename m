Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9686B0B6A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCHOif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCHOie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:38:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6E39B80
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 06:38:22 -0800 (PST)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 57CF43F597
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678286301;
        bh=TLXbWgCSumBQHNJIEiKWgsAVxLokeDk3mverzNy4nO4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LcjVJL5Xu+c7VDQygsgAoMQXFFHQ7BCuiGxLBAKYpi7GkVDIM5yHDfyv02/46KQbe
         tpUU9GTC33BlrQuPZlwzOnQ3puRTDtTh42fpf4d1e6cXKbNdeHitUiwB/HiBbxeXZd
         Yq59/ZrmLaAPASL8fRTQHi5euYvpRg3D9F7udCdF6acHApaWhArWiBn0kWGWpGa6Cb
         GJi3rFbakC181OmdDaGU6+RWE9g366/8zJ/BU88El0YefeLk6sn1ncmy4hctUqXWXq
         suk3NJlXq7EGl/C5DOw21GDolzPHcic9suvca/UBiaYuSeLH7lLHlawccXlgCzR0EB
         0ec8CQBOLS4yA==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1767ec35ce2so8824370fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 06:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLXbWgCSumBQHNJIEiKWgsAVxLokeDk3mverzNy4nO4=;
        b=BOMyLuWltV3eIG7iIwXbPZxqh8xgesDPUXZzk/O9VRlx9vMu3wA6m6PEVX5WuHc/q3
         bUvzUAM3IVtS7SlBAnzMYXtIasFwObRYNvb9Ojg7DsIksfGem+MFeEOv75KDDAQmDKTN
         1m2r27lBzF4vceVK50P0ulZTCkxxgTyT2WN83mjcAYKQKN+BLat4gMi7GU4PEXS2qlKX
         IG2ylSfwF682w/x35CrrOYIOE/TskdDIsAwMnN+A+obbeKQbJ8FMXTZr4WHQh4iTs4fs
         fD2+ke9u+w0Se5g+OdBQps3n+7N9w8kUBZ6y4YCgYPI/9x2IzYyVFdFxnNJpz1D8YHYP
         HDfg==
X-Gm-Message-State: AO0yUKWMh1z7IVpGTjWUmg5yT4zTXdkoGmZaTTl94UlzZzGxGTWerAJp
        M1ZUPjHbVUh0vXB1u5i2Gnwthu9M/KaQuRC6BMt0RgxhV2rgNe50MLCDDSOfOMV1MXCNOj/evqF
        c5G65TuvJEWeGA1IY01H0TCgX11PbXfuH8AvIgvS1uS1vw9xjm2PjMeFtcskb
X-Received: by 2002:a05:6830:334c:b0:690:f4b3:2e30 with SMTP id l12-20020a056830334c00b00690f4b32e30mr6444446ott.1.1678286300213;
        Wed, 08 Mar 2023 06:38:20 -0800 (PST)
X-Google-Smtp-Source: AK7set8CbYqlLLaLD244VOn17v7HLJivmm7bmVIFY938Bnf4+RvnLS3VZ4SIkK1X3tytbIUaLC2Bkh8F169/l5atnKY=
X-Received: by 2002:a05:6830:334c:b0:690:f4b3:2e30 with SMTP id
 l12-20020a056830334c00b00690f4b32e30mr6444442ott.1.1678286299931; Wed, 08 Mar
 2023 06:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20230307150030.527726-1-po-hsu.lin@canonical.com>
 <ZAhV8nKuLVAQHQGl@nanopsycho> <CAMy_GT92sg4_JLPHvRpH542DPLbxOEYYoCMa2cnET1g8bz_R9Q@mail.gmail.com>
 <ZAh0fY4XoNcLTIOI@nanopsycho>
In-Reply-To: <ZAh0fY4XoNcLTIOI@nanopsycho>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 8 Mar 2023 22:37:41 +0800
Message-ID: <CAMy_GT_mLedbejcyTYkhEbuneuEvWycVi2orB82kC9ymXx0rng@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: net: devlink_port_split.py: skip test if no
 suitable device available
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com,
        danieller@mellanox.com, petrm@mellanox.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 8, 2023 at 7:41=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Mar 08, 2023 at 11:21:57AM CET, po-hsu.lin@canonical.com wrote:
> >On Wed, Mar 8, 2023 at 5:31=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Tue, Mar 07, 2023 at 04:00:30PM CET, po-hsu.lin@canonical.com wrote:
> >> >The `devlink -j port show` command output may not contain the "flavou=
r"
> >> >key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-generic)=
,
> >> >iproute2-5.15.0:
> >> >  {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
> >> >           "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"},
> >> >           "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
> >> >           "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}}}
> >>
> >> As Jakub wrote, this is odd. Could you debug if kernel sends the flavo=
ur
> >> attr and if not why? Also, could you try with most recent kernel?
> >
> >I did a quick check on another s390x LPAR instance which is running
> >with Ubuntu 23.04 (6.1.0-16-generic) iproute2-6.1.0, there is still no
> >"flavour" attribute.
> >$ devlink port show
> >pci/0001:00:00.0/1: type eth netdev ens301
> >pci/0001:00:00.0/2: type eth netdev ens301d1
> >pci/0002:00:00.0/1: type eth netdev ens317
> >pci/0002:00:00.0/2: type eth netdev ens317d1
> >
> >The behaviour didn't change with iproute2 built from source [1]
>
> Could you paste output of "devlink dev info"?
> Looks like something might be wrong in the kernel devlink/driver code.
>
The `devlink dev info` output is empty. The following output is from
that Ubuntu 23.04 s390x LPAR, run as root:
# devlink dev show
pci/0001:00:00.0
pci/0002:00:00.0
# devlink dev show pci/0001:00:00.0
pci/0001:00:00.0
# devlink dev info
# devlink dev info pci/0001:00:00.0
kernel answers: Operation not supported

>
