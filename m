Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575D73BB57
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjFWPOc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFWPOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 11:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5C30CD;
        Fri, 23 Jun 2023 08:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFFF61A87;
        Fri, 23 Jun 2023 15:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F081C433C9;
        Fri, 23 Jun 2023 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533126;
        bh=YYcQZGlseXwVCP6x5vAM/Qq8Z8vOikb1DJdq0Jth5Gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISUfUcrTT8eOjZzIDi7bXv9M5bOvSsptJEaRizHPX8Vk79/U+gljC4+gUbOu/Ve7X
         6UoftSAtMmnQL87QxvPPIY8Ze+cHV1/9FVfuzFfMt3HJ5PdIns2vqH1mvtCFkrTdhz
         XBLx5YnYlo0KEivTEIQe+pzenKN75aTns5i4hsCKMsg5fStyAAA9RKOzglDQqQyucf
         am1ZrDpnY0NZ7Od9f9F2CjdWpyDpw7PN8oRTRUQVzEnQq92JDBXKthooXbnwa5XtuJ
         PjHBk4GVtgTbT1VuvEdASv/xKoNLMcIrla0SAm/4l3+8omCVOSSip/YP6zkw4YqcbY
         kaWJwHsJJFp6Q==
Date:   Fri, 23 Jun 2023 08:12:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yueh-Shun Li <shamrocklee@posteo.net>
Cc:     jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com,
        pabeni@redhat.com, apw@canonical.com, joe@perches.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
Message-ID: <20230623081205.71e07bcc@kernel.org>
In-Reply-To: <50a88781b9e2a80588438c315167bbec@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
        <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
        <50a88781b9e2a80588438c315167bbec@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 23 Jun 2023 08:51:39 +0000 Yueh-Shun Li wrote:
> > Here is the summary with links:
> >   - [1/8] RDMA/rxe: fix comment typo
> >     (no matching commit)
> >   - [2/8] i40e, xsk: fix comment typo
> >     https://git.kernel.org/netdev/net-next/c/b028813ac973
> >   - [3/8] zd1211rw: fix comment typo
> >     (no matching commit)
> >   - [4/8] scsi: fix comment typo
> >     (no matching commit)
> >   - [5/8] tcp: fix comment typo
> >     https://git.kernel.org/netdev/net-next/c/304b1875ba02
> >   - [6/8] net/tls: fix comment typo
> >     https://git.kernel.org/netdev/net-next/c/a0e128ef88e4
> >   - [7/8] selftests: mptcp: connect: fix comment typo
> >     (no matching commit)
> >   - [8/8] scripts/spelling.txt: Add "transmit" patterns
> >     (no matching commit)
> >=20
> > You are awesome, thank you! =20
>=20
> Should I rebase the local branch onto netdev/net-next/main
> and send the "no matching commit" patches again?

No, not directly to netdev, at least..

rdma/rxe needs to go to linux-rdma
i40e should be picked up by Tony (CCed, no need to repost)
zd1211rw is wireless so post it to linux-wireless
scsi, I don't even know off the top of my head, not networking
mptcp should be picked up by MPTCP folks (CCed, no need to repost)
scripts, IDK who takes that, Andrew? =F0=9F=A4=B7=EF=B8=8F
