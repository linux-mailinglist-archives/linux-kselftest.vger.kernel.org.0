Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4C77BCDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjHNPVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjHNPVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 11:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BAEDA
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 08:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A84F2615FB
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 15:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A63BC433C8;
        Mon, 14 Aug 2023 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692026490;
        bh=21qKNzNxPDfwgDE8vrKO7hvz6hkx7i2KtgQh0A7uQEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QlLnqAwod8qr+qnrWizKJLr0QAlVPJe7byBm615TN6deShPujk5mavGHpOcZJWWcA
         eIfqL4CF/PqebRzPhNeWjiPUUjJowwblTaBV1MzBFb1suIpIRanEhSW996sg+briwU
         B20Vd88jQ3COmKHrRRTOiZUUnrXEroU7SoHMVBTA5ebiRYxtKjS9KeRQWY0rmaVCDa
         TTqK/CZLciQkiP6ovrHFtrgSssanGyLUOIZW4RX32mokX200wTtZDy3qZha/PCyZT9
         Df2ebIMWcezUDm6gs3cMxAK9RvJnEQCsMW0X73bjx/UqzIbS/jw7MXOYpgG+6FxDUX
         nEyp0ewPF5Ngg==
Date:   Mon, 14 Aug 2023 08:21:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <20230814082128.632d2b03@kernel.org>
In-Reply-To: <ZNpC4lAmlLn-5A9h@hog>
References: <cover.1691584074.git.sd@queasysnail.net>
        <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
        <20230811184347.1f7077a9@kernel.org>
        <ZNpC4lAmlLn-5A9h@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 14 Aug 2023 17:06:10 +0200 Sabrina Dubroca wrote:
> 2023-08-11, 18:43:47 -0700, Jakub Kicinski wrote:
> > On Wed,  9 Aug 2023 14:58:52 +0200 Sabrina Dubroca wrote:  
> > >  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
> > >  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
> > >  			conf = TLS_SW;  
> > 
> > Should we add a statistic for rekeying?  
> 
> Hmpf, at least I shouldn't be incrementing the existing stats on every
> update, especially not TLSCURR* :/
> 
> I don't see much benefit in tracking succesful rekeys. Failed rekeys
> seem more interesting to me. What would we get from counting succesful
> rekeys?

No huge benefit from counting rekeys, the main (only?) one I see is
that when user reports issues we can see whether rekeys were involved
(given that they are fairly rare). It could help narrow down triage.

