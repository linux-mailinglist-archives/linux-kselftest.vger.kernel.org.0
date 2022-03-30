Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209054ECFB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 00:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiC3WdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351698AbiC3Wc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 18:32:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A955BD27;
        Wed, 30 Mar 2022 15:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0443F617C8;
        Wed, 30 Mar 2022 22:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F358C340EE;
        Wed, 30 Mar 2022 22:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648679469;
        bh=Vk0IrcuxiTSc8yFnQkIRJPR2GhpeV1CL0DQ4Hb/fETQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=usMyz6pz1sAuO70HtBJNE4C7ik1N2XSzCrRDTw0FE9RsNoDSxBBTfXMQx7fx3fI3Q
         ThRP0iJgodfkDyW+nXeWRcSM6dwiiMWmRXE8Lxj8IYPutVDeMGCpZdAYseUUy4hkRq
         nCofQQkeW1+Npua4PygZoGL1U5Ec3iuDgZRfH5VJT7R7GPHiH4gcItGo7/T6Nt32B4
         55q+heL0EJNklGnBTLk8BujIbIg7h4qxSH2Nn2EvTqjD1QpAixV2r9144aK43PyCi+
         c1jSvOTYNE+V8UghKKDBk8ESpwM8NCQ1YB/J2Zw5PSKPf8cMBvm7iEyvvr95Fk00gk
         yBKByQoBXLXwg==
Message-ID: <cc2c191065c489eb22bb15bf3dd2e3cddc822543.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for
 encl_stack
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 31 Mar 2022 01:30:08 +0300
In-Reply-To: <595369cd-b7d4-985c-a7e0-7110ffe9a606@intel.com>
References: <20220322074313.7444-1-jarkko@kernel.org>
         <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com> <YkRvFkEO8Ic1VdQ8@iki.fi>
         <0031a4f0-75f6-3104-1825-dcc2528f61b0@intel.com>
         <f68d472877b7136c32d8770603a3de38de59c322.camel@kernel.org>
         <ef991f0d-d0d2-f422-96d8-0951d593d2a5@intel.com>
         <d44b3fc7ce9f053f978645dfe19018885d372d87.camel@kernel.org>
         <595369cd-b7d4-985c-a7e0-7110ffe9a606@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-03-30 at 14:29 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 3/30/2022 1:40 PM, Jarkko Sakkinen wrote:
> > On Wed, 2022-03-30 at 13:05 -0700, Reinette Chatre wrote:
> > >=20
> > >=20
> > > On 3/30/2022 12:03 PM, Jarkko Sakkinen wrote:
> > > > On Wed, 2022-03-30 at 10:40 -0700, Reinette Chatre wrote:
> > > > > Could you please elaborate how the compiler will fix it up?
> > > >=20
> > > > Sure.
> > > >=20
> > > > Here's the disassembly of the RBX version:
> > > >=20
> > > > [0x000021a9]> pi 1
> > > > lea rax, [rbx + loc.encl_stack]
> > > >=20
> > > > Here's the same with s/RBX/RIP/:
> > > >=20
> > > > [0x000021a9]> pi 5
> > > > lea rax, loc.encl_stack
> > > >=20
> > > > Compiler will substitute correct offset relative to the RIP,
> > > > well, because it can and it makes sense.
> > >=20
> > > It does not make sense to me because, as proven with my test,
> > > the two threads end up sharing the same stack memory.
> >=20
> > I see, I need to correct my patch, thanks!
> >=20
> > RBX gives correct results because of the binary organization,
> > i.e. TCS's are placed to zero offset and forward, and=20
> > unrelocated symbol is just compiled in as an untranslated
> > offset.
> >=20
> > RPI is given correct results but how the semantics work
> > right now is incompatible.
> >=20
> > Still, even for kselftest, I would consider a switch
> > because that way:
> >=20
> > 1. You can layout binary however you wan and things
> > =C2=A0=C2=A0 won't break.
> > 2. You can point to any symbol not just stack, if
> > =C2=A0=C2=A0 ever need.
> > =C2=A0=C2=A0=20
> > I admit it works semantically but it just super
> > unrobust.
>=20
> I do not think that we need an exceptionally flexible
> runtime as part of the SGX selftests but instead something
> that is easy(*) to understand while also sufficient to support
> the tests.
>=20
> Reinette
>=20
> * I do not actually consider the existing enclave test binary
> =C2=A0 easy to understand (this thread is proof) but keeping its
> =C2=A0 complexity to be minimal would benefit folks needing to
> =C2=A0 ramp up on SGX and/or debug kselftest failures.

Based on you feedback I refined the patch:

https://lore.kernel.org/linux-sgx/20220330222834.139769-1-jarkko@kernel.org=
/T/#u

BR, Jarkko



=09
=09




BR, Jarkko
