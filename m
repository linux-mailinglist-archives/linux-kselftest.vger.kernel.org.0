Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AD072168B
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjFDMDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFDMDW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 08:03:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3EB6;
        Sun,  4 Jun 2023 05:03:21 -0700 (PDT)
Date:   Sun, 4 Jun 2023 14:03:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685880199; bh=Y0VmAPBnc2iUhmcy/FRoMmhQIlJtniUQSzlQLPpVGtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxDwHAjBDm998DtClOvBhxOPqQRi33p8ZFVGbEQ/GYv6jt1AGOwdAqV+z29URQRjA
         hmEV9WlSo+ZGqqqRlsI1A1VZFls9gNgud/cp/55PbFyPvhqHJ8uQcqGsT7i1hHrNML
         kH2RzEOTLz069CjPJ80OerNfCMG6xk2XsGHK1gWM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Dagonneau <v@vda.io>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: ensure fast64 integer types have 64 bits
Message-ID: <a69daf1f-4552-4610-bf23-a4b9d66e9e4b@t-8ch.de>
References: <20230530-nolibc-fast64-v1-1-883dea6bc666@weissschuh.net>
 <ZHxsWyTf5K5bJqi8@1wt.eu>
 <ZHx8rshTueq8V5fC@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHx8rshTueq8V5fC@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-04 13:59:42+0200, Willy Tarreau wrote:
> On Sun, Jun 04, 2023 at 12:50:03PM +0200, Willy Tarreau wrote:
> > On Tue, May 30, 2023 at 11:18:00AM +0200, Thomas Weißschuh wrote:
> > > On 32bit platforms size_t is not enough to represent [u]int_fast64_t.
> > > 
> > > Fixes: 3e9fd4e9a1d5 ("tools/nolibc: add integer types and integer limit macros")
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > > Cc: Vincent Dagonneau <v@vda.io>
> > > 
> > > Note: We could also fall back to compiler-provided data like:
> > > 
> > > __UINT_FAST{8,16,32,64}_{TYPE,MIN,MAX}__
> > 
> > I'm fine with the way you did it. I'm wondering how we managed to miss
> > this one given the tests in place!
> 
> BTW, it failed on 32-bit platforms:
> 
> 4407 tests passed, 84 skipped, 63 failed
> $ grep '^linux_arch\|FAIL' test14.out
> linux_arch=i386 qemu_arch=i386 gcc_arch=i386
> 52 limit_int_fast64_min = -2147483648                           [FAIL]
> 53 limit_int_fast64_max = 2147483647                            [FAIL]
> 54 limit_uint_fast64_max = 4294967295                           [FAIL]
> 
> The reason is that the constants also have to be adjusted. With the fix
> below everything works right:
> 
> --- a/tools/include/nolibc/stdint.h
> +++ b/tools/include/nolibc/stdint.h
> @@ -84,17 +84,17 @@ typedef uint64_t          uintmax_t;
>  #define  INT_FAST8_MIN   INT8_MIN
>  #define INT_FAST16_MIN   INTPTR_MIN
>  #define INT_FAST32_MIN   INTPTR_MIN
> -#define INT_FAST64_MIN   INTPTR_MIN
> +#define INT_FAST64_MIN   INT64_MIN
>  
>  #define  INT_FAST8_MAX   INT8_MAX
>  #define INT_FAST16_MAX   INTPTR_MAX
>  #define INT_FAST32_MAX   INTPTR_MAX
> -#define INT_FAST64_MAX   INTPTR_MAX
> +#define INT_FAST64_MAX   INT64_MAX
>  
>  #define  UINT_FAST8_MAX  UINT8_MAX
>  #define UINT_FAST16_MAX  SIZE_MAX
>  #define UINT_FAST32_MAX  SIZE_MAX
> -#define UINT_FAST64_MAX  SIZE_MAX
> +#define UINT_FAST64_MAX  UINT64_MAX
>  
>  #ifndef INT_MIN
>  #define INT_MIN          (-__INT_MAX__ - 1)
> 
> 
> 4470 tests passed, 84 skipped, 0 failed
> $ grep '^linux_arch\|fast64' test15.out 
> linux_arch=i386 qemu_arch=i386 gcc_arch=i386
> 52 limit_int_fast64_min = -9223372036854775808                   [OK]
> 53 limit_int_fast64_max = 9223372036854775807                    [OK]
> 54 limit_uint_fast64_max = -1                                    [OK]
> 
> If you're fine with it, I'll squash it into your patch.

Yes, please do so.

Fitting quote:

"I'm wondering how we managed to miss this one given the tests in place!"
