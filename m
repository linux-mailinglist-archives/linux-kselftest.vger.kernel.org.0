Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8363F10C332
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 05:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfK1EUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 23:20:21 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfK1EUV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 23:20:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47NkvR1l1bz9sPh;
        Thu, 28 Nov 2019 15:20:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574914819;
        bh=hg9CuS6PbhGkwD89jLreqnHse+GbuOVvpYAlDz16wNo=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=LUCTH5B/M+7qBOLT0KIHbMwSjJUf7TfWKm4oxA/E/p6MOw3RF2qnhH4rGHfWGQSSU
         hdycLXbbKtLXj3FQQrNynPSYyNRETyQ++jmL/zVMXTY6ttP/nd0ogSbdd/x1ni3/Gd
         0pUQMgxKyyygynWYTlnqKu3xMCEXGaAq6dRZzfpde0GO0EkLY2u0UiZt/nl/AIR4Tl
         98fgx4pFEGlAnaEQSljuPRtFgRi/ITLBaSM6Kz20yK168ssmP5GLrHXtSjXE1caxI1
         1WV6jVYqIxCvpnflDi4I9GYksdd0gqkLpzJw5G1bZRtkdcEa4oSoaWHR4lbKyn8Xxe
         msPdY+z8VwwNA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     shuah <shuah@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>, Tim.Bird@sony.com,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        shuah <shuah@kernel.org>
Subject: Re: kselftest: failed to build with -C tool/testing/selftests when KBUILD_OUTPUT is set
In-Reply-To: <cf2ac53a-4547-0df7-52df-ef0ff4ffb453@kernel.org>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com> <8736ea2cty.fsf@mpe.ellerman.id.au> <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com> <8bd66a2d-e92f-6108-77d0-91d737df9b0d@kernel.org> <c0d01c8f-1a40-e491-28e8-e93f8f90c874@arm.com> <cf2ac53a-4547-0df7-52df-ef0ff4ffb453@kernel.org>
Date:   Thu, 28 Nov 2019 15:20:18 +1100
Message-ID: <871rts1vjx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

shuah <shuah@kernel.org> writes:
> On 11/27/19 9:23 AM, Cristian Marussi wrote:
>> On 27/11/2019 16:04, shuah wrote:
>>>> On 27/11/2019 03:54, Michael Ellerman wrote:
...
>>>>>
>>>>> It just hit my travis jobs when I merged up to master:
>>>>>
>>>>>     https://travis-ci.org/linuxppc/linux/jobs/617482001
>>>>>
>>>>> Shuah can we please get this reverted?
>>>>>
>>>
>>> I will take care of this. Supporting all these use-cases has been
>>> maintenance problem. Fixing one use-case breaks another. :(
...
>
> If all of the above works with kselftest-install target, I would rather
> ask for CI's to change, so we can get rid of make -C usage for install.
>
> In which case, I would rather not revert this and request CIs to start
> using kselftest-install target.
>
> I would like to see CI's use kselftest-* targets from the main makefile
> for build/run/install.

The problem is old kernels (stable branches & distro kernels) don't
support that (or it doesn't work correctly).

So then the CIs have to invoke the selftest build differently depending
on which kernel version they're building, which gets ugly for them.

cheers
