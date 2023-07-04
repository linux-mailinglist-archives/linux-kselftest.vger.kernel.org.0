Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D554746A5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGDHPc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 03:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDHPc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 03:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FA130;
        Tue,  4 Jul 2023 00:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFA96116A;
        Tue,  4 Jul 2023 07:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D3C433C7;
        Tue,  4 Jul 2023 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688454927;
        bh=Qx6SPa/FXBtKHsuhqwtcpwkMWYF76dpQTGSInwUFiQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fimT/YP/AwhUtgGvGKQgdcx3SzNIvCNt5RUuS9ji1RvM5vdWAfDmfhixbrbnTaj9p
         Tk8ZV65fRATwJUd6IdHdAoqcns/a5N6xzLUlm4O/Tkj1HvnjwH4jaVpPJB1cwJ6lD3
         lOX5CVIewQ7zemoDIRdUeyU5nmoLMFgq2q71zWD8hj56TNCZ/hqkLoObBMQ2lUrPSF
         fNBR1YcW0VIUCrZmojkUIU99BpEZtJgGzx7Mop3MyaM9AiAUyDnuCZNBA2l4stl5D2
         utvmVnQ3jYCiZiMu6XYBkbwnYdqOn5nwk3N5OH96xX1Uqx/6RnXygRzEXNCe7yeOi+
         Ija1G9VDGSOjw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qGaFw-00ALG1-JE;
        Tue, 04 Jul 2023 08:15:24 +0100
MIME-Version: 1.0
Date:   Tue, 04 Jul 2023 08:15:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
In-Reply-To: <202307032309.v4K1IBoR-lkp@intel.com>
References: <202307032309.v4K1IBoR-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: lkp@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org, kunit-dev@googlegroups.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-03 16:11, kernel test robot wrote:
> tree/branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next
> specific files for 20230703
> 

[...]

> Unverified Error/Warning (likely false positive, please contact us if
> interested):
> 
> arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140

This *is* a false positive. The function is entered with a lock
held, it will exit with the lock held as well. Inside the body
of the function, we release and reacquire the lock.

         M.
-- 
Jazz is not dead. It just smells funny...
