Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89F45A7331
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 03:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiHaBHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 21:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiHaBHb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 21:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDCA8CFF;
        Tue, 30 Aug 2022 18:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D0761899;
        Wed, 31 Aug 2022 01:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195F2C433D6;
        Wed, 31 Aug 2022 01:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661908047;
        bh=ZDQp0DCjUoMAedWVw3xsHhwQyWf4dqCG9UgLAyFZBgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nah2GeuuWjgaFTWmroxW7QCi+zIyl12sFlCigsvaAaZj34a3xc+xgjDu45+KgzKL3
         36IZcHZyUI21yoxqTPWkKpdSdT4fSpBtnZ4zJGUcC2bveAoOPTFk8BEFDjH6nS0rJ+
         oVPm2Yqg3ebKfCK0uXhM1Ivy6j9/kyV4UnJlyARkp8PNsi0sBb3tzdcrPCqaDQ0TwQ
         9Cj7Bptg3HKrM26KC72Ka6ipEsznTAdj1TftyIyD+K0bHFe1q36o26CXHQ83b73Dl4
         vAS4CwuePF6W0zkbljITe9D3zvamTAyC6pgaU2YZcuGzdyMOa4dqy/l8FRg+j+DFJM
         E/JstWyX1cXag==
Date:   Wed, 31 Aug 2022 04:07:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] selftests/sgx: Ignore OpenSSL 3.0 deprecated
 functions warning
Message-ID: <Yw60S/L76oQsETdA@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-4-jarkko@kernel.org>
 <1445d3bd-55d6-e2c1-d4f6-b30628759c8c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445d3bd-55d6-e2c1-d4f6-b30628759c8c@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 11:18:04AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > From: Kristen Carlson Accardi <kristen@linux.intel.com>
> > 
> > OpenSSL 3.0 deprecates some of the functions used in the SGX
> > selftests, causing build errors on new distros. For now ignore
> > the warnings until support for the functions is no longer
> > available and mark FIXME so that it can be clear this should
> > be removed at some point.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> 
> This one can be dropped from this series. The fix already made it
> into v6.0-rc3 via selftest.

ok

BR, Jarkko
