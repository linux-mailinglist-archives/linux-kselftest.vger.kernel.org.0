Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00A50B83D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447744AbiDVNV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 09:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447683AbiDVNVY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 09:21:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92410580DD;
        Fri, 22 Apr 2022 06:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FFC1B82D47;
        Fri, 22 Apr 2022 13:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6977CC385A0;
        Fri, 22 Apr 2022 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650633507;
        bh=b3cLy4CKtqux3jqGHuSXvrfXhwmJTx37EbQCGlvn+AM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oceIaNcjR2SdZ2Hwo0Ldz7l80qzNDIytljZHUBXyBxeBXYYVk/AtcfANR5yStwnzN
         7udFzKNqeqOcVb8oDyTe3ax53OIKEP01Tc9poDXMDzS2AO0SBFuJsAHqeViLI7cJp7
         ZAXeMNS5PTTH7LbXvOFmeIRxoNZqTKLI7DHqQkjdcYf2uxBEOHYKkrlIpG5V8XSOPs
         Lt8uHINNI+fuNOsPqKJDh11p1MxgqDEf3JHY395iZhuwDdMmiLMTd9BiIn7RWcsvLH
         X7p5FyBiPZcfOU5+F7E2QjXn9qzE6ylVsQwclh+tPQuRLrnc0IbYfeHBgIqOpoVcXp
         wj/yF9vyItHoA==
Message-ID: <9e8fffb8344323ce9a80adc733e9250a63cb68ee.camel@kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>, jethro@fortanix.com
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
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
Date:   Fri, 22 Apr 2022 16:17:11 +0300
In-Reply-To: <YmJyYwp9UHRLWaTw@kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
         <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
         <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
         <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
         <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
         <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
         <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
         <YmJyYwp9UHRLWaTw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-04-22 at 12:16 +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 21, 2022 at 08:29:31PM -0700, Reinette Chatre wrote:
> > Hi Vijay and Mark,
> >=20
> > On 4/21/2022 4:46 PM, Dhanraj, Vijay wrote:
> > > Hi All,
> > >=20
> > > I evaluated V4 patch changes with Gramine and ran into an issue when =
trying to set EPC page permission to PROT_NONE. It looks like with V3 patch=
 series a change was introduced which requires
> > > kernel to have at least R permission when calling RESTRICT IOCTL. Thi=
s change was done under the assumption that EPCM requires at least R permis=
sion for EMODPE/EACCEPT to succeed. But when
> > > testing with V2 version, EACCEPT worked fine with page permission set=
 to PROT_NONE.=20
> > >=20
> > > Thanks to @Shanahan, Mark for confirming that EPCM does not need to h=
ave R value to allow EACCEPT or EMODPE. Given this, can we please revert th=
is change?
> > >=20
> >=20
> > Thank you very much for pointing this out. I can revert the change
> > to what was done in V2 where the only check is to ensure that W require=
s R.
> > This is a requirement of EMODPR. Could you please check if this snippet
> > results in things working for you again?
> >=20
> > ---8<---
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/=
ioctl.c
> > index 83674d054c13..7c7c8a61196e 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -855,12 +855,8 @@ static long sgx_ioc_enclave_restrict_permissions(s=
truct sgx_encl *encl,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (params.permissions =
& ~SGX_SECINFO_PERMISSION_MASK)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Read access is required f=
or the enclave to be able to use the page.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * SGX instructions like ENC=
LU[EMODPE] and ENCLU[EACCEPT] require
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * read access.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(params.permissions & S=
GX_SECINFO_R))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((params.permissions & SG=
X_SECINFO_W) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(params.=
permissions & SGX_SECINFO_R))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (params.result || pa=
rams.count)
>=20
> Just adding that it's fine for me to revert this.

Jethro, I thought it would be also good to get yor view on the current
series. Is this something that your platform can live with?

BR, Jarkko
