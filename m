Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57DD68A9E0
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Feb 2023 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjBDNE2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Feb 2023 08:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjBDNE1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Feb 2023 08:04:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B18A28848
        for <linux-kselftest@vger.kernel.org>; Sat,  4 Feb 2023 05:04:25 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-86-3jVmZkmhN5e2cWi5sxwtfw-1; Sat, 04 Feb 2023 13:04:21 +0000
X-MC-Unique: 3jVmZkmhN5e2cWi5sxwtfw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Sat, 4 Feb
 2023 13:04:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Sat, 4 Feb 2023 13:04:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guillaume Tucker' <guillaume.tucker@collabora.com>,
        Guillaume Tucker <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: RE: [PATCH] selftests: find echo binary to use -ne options
Thread-Topic: [PATCH] selftests: find echo binary to use -ne options
Thread-Index: AQHZN+PflpeLeEnGBkKgHYJRIoEYbK6+wYOg
Date:   Sat, 4 Feb 2023 13:04:19 +0000
Message-ID: <90ace4f466ee4f79bf2dd94c5830e57a@AcuMS.aculab.com>
References: <20230203152603.11450-1-guillaume.tucker@collabora.com>
In-Reply-To: <20230203152603.11450-1-guillaume.tucker@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Guillaume Tucker
> Sent: 03 February 2023 15:26
> 
> Find the actual echo binary using $(which echo) and use it for
> formatted output with -ne.  On some systems, the default echo command
> doesn't handle the -e option and the output looks like this (arm64
> build):
> 
> -ne Emit Tests for alsa
> 
> -ne Emit Tests for amd-pstate
> 
> -ne Emit Tests for arm64

Nack.
There is no reason to suppose that /bin/echo is any different from
the version of echo builtin to the shell that make uses.

Not only that 'which' is a horrid shell script that is trying to
emulate csh builtin.
The bourne shell equivalent is 'type' and the posix one 'command'.

In any case the portable way to fix this is to use printf.
This is a well defined program and is bultin to all modern shells.

	David


> 
> This is for example the case with the KernelCI Docker images
> e.g. kernelci/gcc-10:x86-kselftest-kernelci.  With the actual echo
> binary (e.g. in /bin/echo), the output is formatted as expected (x86
> build this time):
> 
> Emit Tests for alsa
> Emit Tests for amd-pstate
> Skipping non-existent dir: arm64
> 
> Only the install target is using "echo -ne" so keep the $ECHO variable
> local to it.
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  tools/testing/selftests/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 41b649452560..9619d0f3b2ff 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -234,10 +234,11 @@ ifdef INSTALL_PATH
>  	@# While building kselftest-list.text skip also non-existent TARGET dirs:
>  	@# they could be the result of a build failure and should NOT be
>  	@# included in the generated runlist.
> +	ECHO=`which echo`; \
>  	for TARGET in $(TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" &&
> continue; \
> -		echo -ne "Emit Tests for $$TARGET\n"; \
> +		[ ! -d $(INSTALL_PATH)/$$TARGET ] && $$ECHO "Skipping non-existent dir: $$TARGET" &&
> continue; \
> +		$$ECHO -ne "Emit Tests for $$TARGET\n"; \
>  		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
>  			-C $$TARGET emit_tests >> $(TEST_LIST); \
>  	done;
> --
> 2.30.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

