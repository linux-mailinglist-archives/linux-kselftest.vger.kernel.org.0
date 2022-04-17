Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385D850481F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Apr 2022 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiDQPCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Apr 2022 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQPCT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Apr 2022 11:02:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44D1AD9E;
        Sun, 17 Apr 2022 07:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F99B80BA6;
        Sun, 17 Apr 2022 14:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436A2C385A4;
        Sun, 17 Apr 2022 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650207580;
        bh=aV1EsqReTAAKk33KYLe38wDv6O+HSFpmd5F2Y/gzk1A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qhFns5V81wDBkJoMD8J7sDABIZnILkr5KZvVWEN4/i96CHHVrwx+CNDSV5p6m/vjT
         nVw+FcKmskI9b3akSsNuZ8xdfpv2w4aX/77/ssTzCDLQ6TADEp3ShT9Zrm/wTcNGuk
         8RsSi9gAtDNbAAjgfFK1m3bOcX8e1G/+C43l5vQSOKykMT1PDb55Sb1XRfJwKUAZwb
         WyDyzbevAD3Z+RG044BE2d9/1wNHOLRcKeD+WuoVcBpaJn53Ra8ec4INQangzh7XxP
         AnMMwQf/1dkldeFuxYxkGO8XO4BwTPd6yKmKB2jUNxDhF71cHbM0BySjm8tIMBkPrI
         gzapbvkUuXX5A==
Message-ID: <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 17 Apr 2022 17:58:29 +0300
In-Reply-To: <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
         <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
         <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
         <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-04-14 at 18:35 +0000, Dhanraj, Vijay wrote:
> Hi Jarkko,
>=20
> I am working on enabling Gramine with this EDMM patch series. I had teste=
d with V2 patch series and it looked fine. Will evaluate Gramine with V4 pa=
tch series and post my updates in a couple of
> days.

OK, good to hear. Looking forward to it.

BR, Jarkko
