Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56A512B4E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2019 14:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfL0NfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Dec 2019 08:35:18 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2542 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0NfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Dec 2019 08:35:18 -0500
X-Greylist: delayed 2548 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Dec 2019 08:35:17 EST
Received: from [10.68.100.236] (h10-gesig.woeg.acw.at [217.116.178.11] (may be forged))
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id xBRCqS4g015370
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Fri, 27 Dec 2019 13:52:28 +0100
Subject: Re: What is the best way to compare an unsigned and a constant?
To:     SeongJae Park <sjpark@amazon.com>
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
References: <20191227123938.5271-1-sjpark@amazon.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <688d8f4b-266f-2c47-d4e9-d0336316a0a9@petrovitsch.priv.at>
Date:   Fri, 27 Dec 2019 13:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191227123938.5271-1-sjpark@amazon.com>
Content-Type: multipart/mixed;
 boundary="------------D98A0A31D62B0BC2939BAEE9"
Content-Language: en-US
X-DCC--Metrics: esgaroth.tuxoid.at 1480; Body=6 Fuz1=6 Fuz2=6
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=ALL_TRUSTED,AWL
        autolearn=unavailable version=3.3.1
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.4 AWL AWL: Adjusted score from AWL reputation of From: address
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on esgaroth.tuxoid.at
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------D98A0A31D62B0BC2939BAEE9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all!

On 27/12/2019 13:39, SeongJae Park wrote:
[...]
> I have a function returning 'unsigned long', and would like to write a =
kunit
> test for the function, as below.
>=20
>     unsigned long foo(void)
>     {
>     	return 42;
>     }
>=20
>     static void foo_test(struct kunit *test)
>     {
>         KUNIT_EXPECT_EQ(test, 42, foo());
>     }

For this case: shouldn't=20
----  snip  ----
static void foo_test(struct kunit *test)
{
     KUNIT_EXPECT_EQ(test, 42ul, foo());
}
----  snip  ----
do the trick?

MfG,
	Bernd
--=20
"I dislike type abstraction if it has no real reason. And saving
on typing is not a good reason - if your typing speed is the main
issue when you're coding, you're doing something seriously wrong."
    - Linus Torvalds

--------------D98A0A31D62B0BC2939BAEE9
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DGX6K
-----END PGP PUBLIC KEY BLOCK-----

--------------D98A0A31D62B0BC2939BAEE9--
