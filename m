Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4C50BE48
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiDVROG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbiDVRNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 13:13:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C00939C1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 10:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B979B82B2E
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 17:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABCAC385A0;
        Fri, 22 Apr 2022 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650647429;
        bh=Tfj8nbxLW/+CjRCUEie3vjlP1L/DEQVuXe32j0yQLNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jm4EE8qFWyeLHTFHK/6Bd8CJthF89PKLDKTJ15+dn/fJQVrQW6KoDBl1qHSJSGKSJ
         BnIFusNX0tQ4usi1IA1cyinwk3RJcLWSwjorCWCm14dUJfKItAcaizn7R04aqWJUIu
         1fmXAYoKLayuMQ56QSJbAVPAh6u3beAMAHLDSBg6eU/bIWT4eWsTbnx86/C6xEdrja
         RplqP7gFfDTsulM7vxPaP2clDBsYsnEK56ImoWsQe9pQ9gJaK5AOU1+yQz6gcFWyEa
         0OaV+4Z7vNErNCvNZlJKTijSkcxCAl3xBCS8tth8p8KiS1U4JapArStTbu27oQqgo8
         o1riTvGYPOA3g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nhwnb-006ES4-7z; Fri, 22 Apr 2022 18:10:27 +0100
MIME-Version: 1.0
Date:   Fri, 22 Apr 2022 18:10:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <65c761cedb3b6e56f4a03fd196a3a767@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, broonie@kernel.org, will@kernel.org, skhan@linuxfoundation.org, shuah@kernel.org, alan.hayward@arm.com, luis.machado@arm.com, Salil.Akerkar@arm.com, Basant.KumarDwivedi@arm.com, szabolcs.nagy@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, luca.scalabrino@arm.com, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-04-19 12:22, Mark Brown wrote:
> This series provides initial support for the ARMv9 Scalable Matrix
> Extension (SME).  SME takes the approach used for vectors in SVE and
> extends this to provide architectural support for matrix operations.  A
> more detailed overview can be found in [1].

For the KVM patches:

Reviewed-by: Marc Zyngier <maz@kernel.org>

Catalin: the KVM patches are likely to slash a bit with the
WFxT stuff as well. It'd be good to swap stable branches!

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
