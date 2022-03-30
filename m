Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766AE4ECE5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 23:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbiC3Unq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiC3Unp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 16:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964B21265;
        Wed, 30 Mar 2022 13:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B4FCB81E0B;
        Wed, 30 Mar 2022 20:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A404AC340F0;
        Wed, 30 Mar 2022 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648672917;
        bh=YoLEiYr7FjK+HfANJQQoei+ci9f7JQj4Iv0FSLnVaU0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ViHSiG1ajt3kn0PkxITnrxY+gbQsNZmldVedxzj8ca92V/aOMjh73kziyWAlF+6VH
         I/Amj1lssTRnjGnhRLYxmUv0QvXiXKykyOUXAE/2TwJZoDUkEGoNDeUfZpyBrj9Mgd
         RxH0IeN30ZnBFoqUJY1+dxD1LZI9TRo/HRr42WfyErtZu2yQKytiD+XjeWeYNMtOst
         wp6++of/YotGQ1emtvWAZmN6o0UHLca3x4KRLsJs0Wt9+KgdytHfK3HjhgbAMg95Z0
         Q4V5sTFMr29vza6LsH0R9EI2OEFM260E2dU2pzuGNzf258gpcotcEvhqz3PeYZnc8F
         lzjIF7t1CiKIQ==
Message-ID: <d44b3fc7ce9f053f978645dfe19018885d372d87.camel@kernel.org>
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
Date:   Wed, 30 Mar 2022 23:40:56 +0300
In-Reply-To: <ef991f0d-d0d2-f422-96d8-0951d593d2a5@intel.com>
References: <20220322074313.7444-1-jarkko@kernel.org>
         <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com> <YkRvFkEO8Ic1VdQ8@iki.fi>
         <0031a4f0-75f6-3104-1825-dcc2528f61b0@intel.com>
         <f68d472877b7136c32d8770603a3de38de59c322.camel@kernel.org>
         <ef991f0d-d0d2-f422-96d8-0951d593d2a5@intel.com>
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

On Wed, 2022-03-30 at 13:05 -0700, Reinette Chatre wrote:
>=20
>=20
> On 3/30/2022 12:03 PM, Jarkko Sakkinen wrote:
> > On Wed, 2022-03-30 at 10:40 -0700, Reinette Chatre wrote:
> > > Could you please elaborate how the compiler will fix it up?
> >=20
> > Sure.
> >=20
> > Here's the disassembly of the RBX version:
> >=20
> > [0x000021a9]> pi 1
> > lea rax, [rbx + loc.encl_stack]
> >=20
> > Here's the same with s/RBX/RIP/:
> >=20
> > [0x000021a9]> pi 5
> > lea rax, loc.encl_stack
> >=20
> > Compiler will substitute correct offset relative to the RIP,
> > well, because it can and it makes sense.
>=20
> It does not make sense to me because, as proven with my test,
> the two threads end up sharing the same stack memory.

I see, I need to correct my patch, thanks!

RBX gives correct results because of the binary organization,
i.e. TCS's are placed to zero offset and forward, and=20
unrelocated symbol is just compiled in as an untranslated
offset.

RPI is given correct results but how the semantics work
right now is incompatible.

Still, even for kselftest, I would consider a switch
because that way:

1. You can layout binary however you wan and things
   won't break.
2. You can point to any symbol not just stack, if
   ever need.
  =20
I admit it works semantically but it just super
unrobust.

BR, Jarkko
