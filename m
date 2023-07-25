Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC2761C37
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGYOrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjGYOrY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B318E63;
        Tue, 25 Jul 2023 07:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D41561777;
        Tue, 25 Jul 2023 14:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA407C433C7;
        Tue, 25 Jul 2023 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296439;
        bh=Bo0L8NVAyrHOgGQCPLhEipmIw8MhpD2MSjL5nHcNdsA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aTwLe2S/soCzZmmI2FjM24eQj/SpC2A5oY2AfGtxo+LczogipNM3KYOe7h0nzUYeM
         NIt6FPH2RkGimz1HDPBKdPgQkDOpCXPe5VN3kQ3+K7qEUIwIG7yQoe7NRPBOdEJwFm
         df9A9JRMsNSOZL0kqy17+5K7UXuXE3nJw0fJgBX+1Sz6DsnBHJur54LkX482WxRepE
         avfYJ9V0FqigXslCrZr5ruo35nt0QMfyuAFaS/e/R2BwcKVLfoBZ+X4eCdilR2aqHy
         0b7nt/cbddP5/Rbdv4lPFddDYWsIeNPAjVfLqAox5XCTzPDvnpePEHVRHlBmjCOVgZ
         1c7g/pXq5OdlQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [3/8] wifi: zd1211rw: fix typo "tranmits"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230622012627.15050-4-shamrocklee@posteo.net>
References: <20230622012627.15050-4-shamrocklee@posteo.net>
To:     Yueh-Shun Li <shamrocklee@posteo.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yueh-Shun Li <shamrocklee@posteo.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029643392.3309254.342001893123754863.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:47:15 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Yueh-Shun Li <shamrocklee@posteo.net> wrote:

> Spell "transmits" properly.
> 
> Found by searching for keyword "tranm".
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Patch applied to wireless-next.git, thanks.

2d5947830868 wifi: zd1211rw: fix typo "tranmits"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230622012627.15050-4-shamrocklee@posteo.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

