Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58D650B3E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445930AbiDVJUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244072AbiDVJTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 05:19:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0977254BFE;
        Fri, 22 Apr 2022 02:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57E5FCE27DC;
        Fri, 22 Apr 2022 09:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E2C385A0;
        Fri, 22 Apr 2022 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650618935;
        bh=wphSIBvr7Ma1//woXk0Uh+SjFy5kCgM83/jgyso856g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IadMM0AGGhNeQrUn/BzUo032y3FpRxAXbWOAnYyGSZ4U/UaIalbYvgke7dE/w9SS9
         8Edg1emCkaYqz1ZxEnnQqH+Ij38F9deMsfJSLZzSveltvIZPY6W0/JlyrL8pfBMxuC
         cC7aMkIi9MNJby/Y30//y1eP2/ZBWfzlRVDiEKcSUDFbQVpXn1SW9ufiQ/CL4Jml0x
         AkD5KAbWPUa/l0RSqIf1wYF5HUi3p2rir4fCNREQ4dcmikbru5PhBmsWJra1MvHUIA
         BjayHV3xMzl46U41OFqHXjpP5Nq1X2f915A/abqMbofunwKpHp3RfBeeSIZ4NDdqZh
         7QlBwycZpGD8g==
Date:   Fri, 22 Apr 2022 12:14:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Message-ID: <YmJx7E/1FFe0UTSP@kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
 <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
 <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
 <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
 <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 21, 2022 at 11:46:57PM +0000, Dhanraj, Vijay wrote:
> Hi All,
> 
> I evaluated V4 patch changes with Gramine and ran into an issue when
> trying to set EPC page permission to PROT_NONE. It looks like with V3
> patch series a change was introduced which requires kernel to have at
> least R permission when calling RESTRICT IOCTL. This change was done
> under the assumption that EPCM requires at least R permission for
> EMODPE/EACCEPT to succeed. But when testing with V2 version, EACCEPT
> worked fine with page permission set to PROT_NONE. 
> 
> Thanks to @Shanahan, Mark for confirming that EPCM does not need to have
> R value to allow EACCEPT or EMODPE. Given this, can we please revert this
> change?
> 
> Thanks,
> -Vijay

Let's try to avoid top-posting and split the lines appropriately.

BR, Jarkko
