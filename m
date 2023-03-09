Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A06B2902
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCIPo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 10:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCIPoz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 10:44:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B585DB6DE
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Mar 2023 07:44:53 -0800 (PST)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9549D3F07F
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Mar 2023 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678376691;
        bh=2gjXX1i93aqnxVp2YbSt/zPpzLesmU2S3pmU+Gog+1Q=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qnbL/JwYKUmp0tQIGaUjmeZzm73bAIUdeqydBt+Neo60RfYne7PNOe+xJ4noyf+TG
         jl6wAEFTbFcoSFqwnFMKe6fOOqXgF960GZY8vvglKFnay9sZS5UCR6JFj4k7rjLf66
         qb0n78MudgPg+oxzkiShq1x7JScjlJ8k4fRK0NUY1ko0bSfJYQA9sTX8LAVS4DAH2D
         5JykbJXZTtihIHKgc1MU+ne2qg4vkh4FcWJwKb+W7yb/as8nlpdOXMKqOPVkldlPei
         haBLTpi0+xr5hpCVKhIXk3vd0QKKJIl9jO5ey2K9+3vb7NlLbettamj2pjklTfrIr7
         6sQBTM5SRN0wg==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-176ab50d9a6so1301971fac.5
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Mar 2023 07:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678376690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gjXX1i93aqnxVp2YbSt/zPpzLesmU2S3pmU+Gog+1Q=;
        b=VmJVnmk4CkvadBrXpWejmazOv9gRnRtwmshKx7P+RaZ+GxrIAzuWuyalx4x61+uDvV
         2/d8ptjB6y5lm1Qmw3SpkqsB/ogKuGqyN55kX1uahJOTTlV+fWGGl2Fm2HBvJCnZiQ/D
         /k2M8WaPMJKBRB7CHAjjS9uOpHDMh1vMsmHgO3Pl/U4WiuZIsRimZYwIsb7CjRNIvp6T
         XLdtw9DD0QsauXRx+nEB0smof2wLPFs+UY2jE9M3242GJf3DPz5fP7Nkl464HpasDB9i
         bLSGCGR1l4AwTwhmek+WdoNyri1eKStLfOwBa6agUH81ebjqIxOdNKcM6ZHKcrhESMFi
         N1hg==
X-Gm-Message-State: AO0yUKVOs42DFCZILXIFgwXc/341Wc+NhEbhnidgM/MoFZX8jXS94M0n
        qLvdCI2i486Z39oZxvBSbuhPA9spaiohMqd2arZJXRLNqe8vpCVfKIdUilA8ypyZYpfHroHctWG
        m+qdWWMI+uoOlj1e3dx/7VdFaO1yAdYRJ9BIMYpN2kpllsLnD5oSOb5mKE4yP
X-Received: by 2002:a05:6870:7711:b0:176:542b:15a6 with SMTP id dw17-20020a056870771100b00176542b15a6mr7592823oab.2.1678376689874;
        Thu, 09 Mar 2023 07:44:49 -0800 (PST)
X-Google-Smtp-Source: AK7set9qTHc/MLtOBogD5cWDMRNOl6LTsiZYhtc/i0lWBdziyMH4wHZEdhQgGeXF3+JBMumSFvjuR43EtXkZ4VRqg+A=
X-Received: by 2002:a05:6870:7711:b0:176:542b:15a6 with SMTP id
 dw17-20020a056870771100b00176542b15a6mr7592818oab.2.1678376689634; Thu, 09
 Mar 2023 07:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20230307150030.527726-1-po-hsu.lin@canonical.com>
 <ZAhV8nKuLVAQHQGl@nanopsycho> <CAMy_GT92sg4_JLPHvRpH542DPLbxOEYYoCMa2cnET1g8bz_R9Q@mail.gmail.com>
 <ZAh0fY4XoNcLTIOI@nanopsycho> <CAMy_GT_mLedbejcyTYkhEbuneuEvWycVi2orB82kC9ymXx0rng@mail.gmail.com>
 <ZAjS8OAFd++ThaHV@nanopsycho>
In-Reply-To: <ZAjS8OAFd++ThaHV@nanopsycho>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 9 Mar 2023 23:44:10 +0800
Message-ID: <CAMy_GT-5DTTyXQsyHO8YX+NANeu-XvQgHG_PwQ3AeGt93CzSPg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 9, 2023 at 2:24=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Mar 08, 2023 at 03:37:41PM CET, po-hsu.lin@canonical.com wrote:
> >On Wed, Mar 8, 2023 at 7:41=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Wed, Mar 08, 2023 at 11:21:57AM CET, po-hsu.lin@canonical.com wrote:
> >> >On Wed, Mar 8, 2023 at 5:31=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >> >>
> >> >> Tue, Mar 07, 2023 at 04:00:30PM CET, po-hsu.lin@canonical.com wrote=
:
> >> >> >The `devlink -j port show` command output may not contain the "fla=
vour"
> >> >> >key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-gener=
ic),
> >> >> >iproute2-5.15.0:
> >> >> >  {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
> >> >> >           "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"}=
,
> >> >> >           "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
> >> >> >           "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}=
}}
> >> >>
> >> >> As Jakub wrote, this is odd. Could you debug if kernel sends the fl=
avour
> >> >> attr and if not why? Also, could you try with most recent kernel?
> >> >
> >> >I did a quick check on another s390x LPAR instance which is running
> >> >with Ubuntu 23.04 (6.1.0-16-generic) iproute2-6.1.0, there is still n=
o
> >> >"flavour" attribute.
> >> >$ devlink port show
> >> >pci/0001:00:00.0/1: type eth netdev ens301
> >> >pci/0001:00:00.0/2: type eth netdev ens301d1
> >> >pci/0002:00:00.0/1: type eth netdev ens317
> >> >pci/0002:00:00.0/2: type eth netdev ens317d1
> >> >
> >> >The behaviour didn't change with iproute2 built from source [1]
> >>
> >> Could you paste output of "devlink dev info"?
> >> Looks like something might be wrong in the kernel devlink/driver code.
> >>
> >The `devlink dev info` output is empty. The following output is from
> >that Ubuntu 23.04 s390x LPAR, run as root:
> ># devlink dev show
> >pci/0001:00:00.0
> >pci/0002:00:00.0
> ># devlink dev show pci/0001:00:00.0
> >pci/0001:00:00.0
> ># devlink dev info
> ># devlink dev info pci/0001:00:00.0
>
> Interesting, could you try ethtool -i to get the driver name?
>
Hi,

Here you go:
$ ethtool -i ens301
driver: mlx4_en
version: 4.0-0
firmware-version: 2.35.5100
expansion-rom-version:
bus-info: 0001:00:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

$ ethtool -i ens317
driver: mlx4_en
version: 4.0-0
firmware-version: 2.35.5100
expansion-rom-version:
bus-info: 0002:00:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

HTH


>
> >kernel answers: Operation not supported
> >
> >>
