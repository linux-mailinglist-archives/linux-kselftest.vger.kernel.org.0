Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4120010C32D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 05:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK1ERX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 23:17:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfK1ERX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 23:17:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Nkr041S7z9sPh;
        Thu, 28 Nov 2019 15:17:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574914641;
        bh=VEyyPP4HvO8k4r9mELIjMEJj5VIL+iMWnQDGCO2SKMs=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=WjtXk+D2/h6cMNvjuIQxPCYQCzHu0Dfruk0iswtYUczPpEvxkC+egvFtzZhvn3j5S
         1HMZEq1QSCleidlsS5WVivv+1I61nIPL7iEjbbf8xgrzLCSWlEINddLYygxnZ6nxxL
         5Fpb8gieuqwvwWBk9NueoFHBcHssyo2Wrr/u5YqWiITQCGhxTbLAbNcFDfGOPPUY6V
         HAFkL3DZW9CmdVVBo6pTvyh/7YCYmVxeJoNR60L0WJo7UWKNLx2yJpHNpsI8mwtrzv
         0P//e+X4ucGMACxlursR4j6Y91yGBwtReCcIhDXgMgnzz7AsNm6c4lyrxA++food05
         mTgBxO8Xov+Kg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tim.Bird@sony.com, shuah@kernel.org, cristian.marussi@arm.com,
        linux-kselftest@vger.kernel.org
Subject: RE: kselftest: failed to build with -C tool/testing/selftests when KBUILD_OUTPUT is set
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF982B3745@USCULXMSG17.am.sony.com>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com> <8736ea2cty.fsf@mpe.ellerman.id.au> <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com> <8bd66a2d-e92f-6108-77d0-91d737df9b0d@kernel.org> <c0d01c8f-1a40-e491-28e8-e93f8f90c874@arm.com> <cf2ac53a-4547-0df7-52df-ef0ff4ffb453@kernel.org> <3f436c1b-1921-78f7-c021-9c8472e24733@arm.com> <2fa5f914-e5d6-9ddd-03f0-abe95569a6f2@kernel.org> <ECADFF3FD767C149AD96A924E7EA6EAF982B3745@USCULXMSG17.am.sony.com>
Date:   Thu, 28 Nov 2019 15:17:20 +1100
Message-ID: <874kyo1vov.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

<Tim.Bird@sony.com> writes:
>> -----Original Message-----
>> From: linux-kselftest-owner@vger.kernel.org [mailto:linux-kselftest-
>> owner@vger.kernel.org] On Behalf Of shuah
>> Sent: Wednesday, November 27, 2019 5:33 PM
>> To: Cristian Marussi <cristian.marussi@arm.com>; Michael Ellerman
>> <mpe@ellerman.id.au>; Bird, Tim <Tim.Bird@sony.com>; linux-
>> kselftest@vger.kernel.org; shuah <shuah@kernel.org>
>> Subject: Re: kselftest: failed to build with -C tool/testing/selftests when
>> KBUILD_OUTPUT is set
>> 
>> On 11/27/19 9:53 AM, Cristian Marussi wrote:
...
>> > Well I'm not sure if it covers all the build cases/scenario for CIs and I have
>> > only verified that this specific failure seems to work using the toplevel Makefile
>> > targets (since the offending commit uses abs-objtree).
>> > Anyway $ ./kselftest_install.sh is broken too as of now.
>> 
>> With the revert, it will go back to not having support for relative
>> paths :(
>> 
>> I will look into reverting the offending commit or fixing it.
>
> There may not be many people using relative paths for KBUILD_OUTPUT.
> I was affected by it, and it's quite handy given some of the mechanisms in
> my CI system, but it's not that hard to work around.  (That is, I can just
> convert relative paths to absolute paths in a few key places in my
> CI, before calling the kernel make.)
>
> Given that I'm the only person (seemingly) who reported this, and I'm ok
> working around it, I think a revert is OK for now. 

I think that would be best at this stage, every day this is unfixed is
another day that selftests aren't getting built and tested.

It should just be a matter of passing your output directory to
`realpath` somewhere in your script.

cheers
