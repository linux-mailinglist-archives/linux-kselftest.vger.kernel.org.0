Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5582F5B2A25
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIHXZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHXZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:25:53 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C72712D0B
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 16:25:50 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C08A3F1C8
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662679545;
        bh=tS+w+xDxLF4hvMpjpKaRAirhp1pKkbvak4v9jx2p1j8=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=nwxuIqd3PDZwxmWaifOuIsw9wVDoqgcK4pnyGUGI62CcAeW2tVrZlqgLmcdLEU5kv
         0YVlAC8V6olj1WPHoJtWRjHnd46yDKbOJARBtWwwmLtBFSFZ47pBCXvseGfgD7ClpD
         Ou7RsqLs/qhmZ2Tlo1hMP+IRLAKT92CX6Eyw18h6E6WIGFaayygaOlUvxjunuEjq2L
         XOvpbiMUoPKFiRxNIW6zzw355wuJDwBcton1TGeZO7OyPZRiaUYoVBXwYjuPIKq9aZ
         tNvvrLehRQNWCqyD1ql3FrFuCAuxVCzKutuf5ytlsVIZ90vtQ5p+kefuscl0LpwSBq
         30J75nX4raR4Q==
Received: by mail-pl1-f198.google.com with SMTP id u16-20020a17090341d000b001774940cbffso134497ple.8
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Sep 2022 16:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tS+w+xDxLF4hvMpjpKaRAirhp1pKkbvak4v9jx2p1j8=;
        b=KxUiiedy5RY8TsATT/2LWqVGrfqRDMxCw3p5dGFI/MwV+92UebHt32jv44IO3Odd2l
         0k+8KTgyZtwVYdeEuEv4k5geFUS91uU71ZymUM7yZC6tMIRjcNx0LP7rWPv1uWkE+u7c
         UoUrNWtcWjravt1bpGkY4MBwlPbT5caFSANV2SKqusJGsefeC2dvb8l5FBsaMh9Cr0Ry
         6zjm5ZeRe9BAoyMoVFpwiFBHK192fyKXS60hotIwQ/wUrSd+1l49SlfFzDenG4eWbyqQ
         +ttMHm9o/T6s96bRuvNV/uQabAA1hSxMn/LocE955oZX4Dryxc8S8y4yxTNO/m3kaF9V
         eZ6A==
X-Gm-Message-State: ACgBeo1B/264r0bqrAedeCDDQ/GHPBdo23WXjZVP67yo3H7yX9k9CURf
        70oseRJQAqg2t22Ag6DwBhTyyOwX+WKaR+AbToyaPrZj+6d/rnbiZyk4LkepaNBZ4dn/qJF/8js
        jG407c7/0WhMA2JdHwJhtg3dgyQPt3kImDHoDT+Pr7MydGg==
X-Received: by 2002:a17:902:f0d4:b0:176:988a:77fd with SMTP id v20-20020a170902f0d400b00176988a77fdmr10958068pla.25.1662679544113;
        Thu, 08 Sep 2022 16:25:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR63aLutnqaqmiGtlvpKhQuwX7EaLOG3coz37wJVtO5hsoY9Pzm9gjeK2erZlvtMMPj6dm43/A==
X-Received: by 2002:a17:902:f0d4:b0:176:988a:77fd with SMTP id v20-20020a170902f0d400b00176988a77fdmr10958055pla.25.1662679543858;
        Thu, 08 Sep 2022 16:25:43 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm28651pgb.12.2022.09.08.16.25.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:25:43 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 1E34260DBF; Thu,  8 Sep 2022 16:25:43 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 16522A02D5;
        Thu,  8 Sep 2022 16:25:43 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Benjamin Poirier <bpoirier@nvidia.com>
cc:     netdev@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Toppins <jtoppins@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3 0/4] Unsync addresses from ports when stopping aggregated devices
In-reply-to: <20220907075642.475236-1-bpoirier@nvidia.com>
References: <20220907075642.475236-1-bpoirier@nvidia.com>
Comments: In-reply-to Benjamin Poirier <bpoirier@nvidia.com>
   message dated "Wed, 07 Sep 2022 16:56:38 +0900."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31138.1662679543.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 08 Sep 2022 16:25:43 -0700
Message-ID: <31139.1662679543@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benjamin Poirier <bpoirier@nvidia.com> wrote:

>This series fixes similar problems in the bonding and team drivers.
>
>Because of missing dev_{uc,mc}_unsync() calls, addresses added to
>underlying devices may be leftover after the aggregated device is deleted=
.
>Add the missing calls and a few related tests.

	I'm not seeing any gaps in the logic; so, for the bonding parts
of the series

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J


>v2:
>* fix selftest installation, see patch 3
>
>v3:
>* Split lacpdu_multicast changes to their own patch, #1
>* In ndo_{add,del}_slave methods, only perform address list changes when
>  the aggregated device is up (patches 2 & 3)
>* Add selftest function related to the above change (patch 4)
>
>Benjamin Poirier (4):
>  net: bonding: Share lacpdu_mcast_addr definition
>  net: bonding: Unsync device addresses on ndo_stop
>  net: team: Unsync device addresses on ndo_stop
>  net: Add tests for bonding and team address list management
>
> MAINTAINERS                                   |   1 +
> drivers/net/bonding/bond_3ad.c                |   5 +-
> drivers/net/bonding/bond_main.c               |  57 +++++----
> drivers/net/team/team.c                       |  24 +++-
> include/net/bond_3ad.h                        |   2 -
> include/net/bonding.h                         |   3 +
> tools/testing/selftests/Makefile              |   1 +
> .../selftests/drivers/net/bonding/Makefile    |   5 +-
> .../selftests/drivers/net/bonding/config      |   1 +
> .../drivers/net/bonding/dev_addr_lists.sh     | 109 ++++++++++++++++++
> .../selftests/drivers/net/bonding/lag_lib.sh  |  61 ++++++++++
> .../selftests/drivers/net/team/Makefile       |   6 +
> .../testing/selftests/drivers/net/team/config |   3 +
> .../drivers/net/team/dev_addr_lists.sh        |  51 ++++++++
> 14 files changed, 297 insertions(+), 32 deletions(-)
> create mode 100755 tools/testing/selftests/drivers/net/bonding/dev_addr_=
lists.sh
> create mode 100644 tools/testing/selftests/drivers/net/bonding/lag_lib.s=
h
> create mode 100644 tools/testing/selftests/drivers/net/team/Makefile
> create mode 100644 tools/testing/selftests/drivers/net/team/config
> create mode 100755 tools/testing/selftests/drivers/net/team/dev_addr_lis=
ts.sh
>
>-- =

>2.37.2
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
