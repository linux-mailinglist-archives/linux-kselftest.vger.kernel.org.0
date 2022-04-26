Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD650EF96
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 06:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiDZEMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 00:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbiDZEMH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 00:12:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0F17E13;
        Mon, 25 Apr 2022 21:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F020FB81C0E;
        Tue, 26 Apr 2022 04:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026BCC385A4;
        Tue, 26 Apr 2022 04:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650946138;
        bh=UF2W6wDrcxlNMtRIim34cJfK+miQaqNxs0sRQs93kdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oZK/Bkylyrvwtb+97S1FgyI27WMH/0/jf1Ljzxr1W0Esd1vpY82/bUpt3K8vAW0IW
         +nU/QMWo9MVCzGZZrv4D/s6okRjDpRl3yeNyeHonZKxKkrrDn00D9PgaWnC2KDk7mt
         WgongvnOf6/tnitnawdiKFslUj8LG4+sg8fqrs5Rqn1/y6CAok5SbNaEniLUvzhrnl
         RYyBuqdooZ4fb1v8QvlAhVQzTo00S54sGt4afhR3iUgwrpNjLKcTBqYNJrxMB9t77P
         C0/iW8yA+HcI5CLutsdjR6tVJXqXu/GpmgmqIPuHIA8pmSaS9f/j7Vp02fxU36+84I
         pcgxnlKSgaWfw==
Message-ID: <16d4ad77b5f306e14c089d56c60b160d1d23be52.camel@kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Date:   Tue, 26 Apr 2022 07:10:26 +0300
In-Reply-To: <d8aceb1e-c6ef-1ca0-f11e-e7e83e634854@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
         <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
         <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
         <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
         <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
         <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
         <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
         <YmJyYwp9UHRLWaTw@kernel.org>
         <DM8PR11MB5591CACC6757FE71B3E19FC3F6F89@DM8PR11MB5591.namprd11.prod.outlook.com>
         <d8aceb1e-c6ef-1ca0-f11e-e7e83e634854@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2022-04-25 at 16:56 -0700, Reinette Chatre wrote:
> > [PATCH V4 16/31] x86/sgx: Support adding of pages to an initialized enc=
lave
> > [PATCH V4 15/31] x86/sgx: Support restricting of enclave page permissio=
ns
> > [PATCH V4 18/31] x86/sgx: Support modifying SGX page type
> > [PATCH V4 19/31] x86/sgx: Support complete page removal

You can add my tested-by to all of the four now [*].

[*] https://github.com/enarx/enarx/pull/1776

BR, Jarkko
