Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F516D562B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 03:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjDDBhq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 21:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDDBhp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 21:37:45 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FDB8;
        Mon,  3 Apr 2023 18:37:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E9E65C01BE;
        Mon,  3 Apr 2023 21:37:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 21:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680572261; x=1680658661; bh=GQ
        rl89O1RAwOi5BoeGN0zQm5w3SNwrUnoP1QapVDans=; b=Z/QqfEdMmmJs0ljPwO
        u7xPN5DG1HwhElSf3kR9ewWFdEVSNVOMjljR3qZMjlL0zMdTo2meEEeFapiDRS/C
        Q859oCSFUv77gWgj0BiE2TdfR2ABGh4JL2oSiwpu7Xb8TZdf3AN7ze1VulOIz0cv
        gEDK9ymmuQXAE094cV6BBnIbANDso9P+LWxMm1YFMXsdSFCzi3RMgACW696EMQtV
        zpcvJQo2yOw7gI/m4c6+7otm8e0DhZXLKioODJbxpVCiO63ONe1qnQo6DD5Ihs6j
        bOPrLvrd2kFf6RdEJqQ03X9PJ+OAyHE7BRhtcXZ7KSr+/4L84LDOE6bSMuDOUEOL
        oUOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680572261; x=1680658661; bh=GQrl89O1RAwOi
        5BoeGN0zQm5w3SNwrUnoP1QapVDans=; b=DYNxPFQEd2dHK5hFs2GRIQh3VTwnQ
        2uSxRajzjH+iqoMetCdRxBELRp0lnlKNSRJH7eOrNYHFwtu90aOuSPkDHqEUd6BR
        CtbyTWGxIX+oEQ1mAQMfXxr50MZ9XK6/EO56pVtMXo2VDqSgh8IZlFpQ+Ht6gL35
        1yFRWmBdHKndipTVg3nnmIdGF/j8btKudP+pBK6dNsnGHQ2E16lpX8QDkiYNpDh7
        PrUh92ZaCAsGdWs7EwtK8DPd9xznTi0n+u68CRx2h4bThEmKKFgCeSiCOvu9bHU7
        4Mle4VpPn3NTe6eC5W5eXBTGJ5rZA8UbNigNT2uXkWdmdW8YOSNK3bbxw==
X-ME-Sender: <xms:ZH8rZGb91I3MBWSDC8j6mfcsTd75kl5YOa1tDEMkmmJ0HXUL6SfALQ>
    <xme:ZH8rZJakVxWa7sH0-oHOkOCMndiu7DOOO_Au9V3wUtXxGCMx_68zCr4oHYsiu87Ll
    9XoT241EtnrArSnJao>
X-ME-Received: <xmr:ZH8rZA8w2JmA-8WmIGUrCWgxeFyhs9qL67D3QSAAf8zKkzUe-VjNinEhaGO7KlGaVqSBnCZaZYiMjOcKW6V6Rn5UYcOdM1JKq1zy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeikedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeefgfejvefgudfhfeevudekueegtdeutdejhffhhfdv
    keejhfehheefgfehteejffenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvght
    vghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:ZH8rZIpc8VAac85-Pk0xYRWvNvEkoizA-2hSyLexTyCn4Me8gWbL6Q>
    <xmx:ZH8rZBonZIelrhHpvpK528rwxTCEBDHjfNkFPnX5_Syk8GhZwjPxvg>
    <xmx:ZH8rZGSepLkFeRphgw1fKcc-IyzKQ_J3dP6cTP6I94Kc42hdQCC6tQ>
    <xmx:ZX8rZC65VOuQkhuJxh1lV6bqplT4Vn9GwTAP4PUMe2RZYkMyMk--ng>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 21:37:35 -0400 (EDT)
Date:   Tue, 4 Apr 2023 11:37:31 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Candle Sun <candle.sun@unisoc.com>,
        Jose Torreguitar <jtguitar@google.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Silvan Jegen <s.jegen@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Jason Gerecke <killertofu@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH 00/11] selftests: hid: import the tests from hid-tools
Message-ID: <20230404013731.GA38303@quokka>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
 <20230403162024.sespaq5iwbjan4xl@mail.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403162024.sespaq5iwbjan4xl@mail.corp.redhat.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 03, 2023 at 06:20:24PM +0200, Benjamin Tissoires wrote:
> On Feb 17 2023, Benjamin Tissoires wrote:
> > I have been running hid-tools for a while, but it was in its own
> > separate repository for multiple reasons. And the past few weeks
> > I finally managed to make the kernel tests in that repo in a
> > state where we can merge them in the kernel tree directly:
> > 
> > - the tests run in ~2 to 3 minutes
> > - the tests are way more reliable than previously
> > - the tests are mostly self-contained now (to the exception
> >   of the Sony ones)
> > 
> > To be able to run the tests we need to use the latest release
> > of hid-tools, as this project still keeps the HID parsing logic
> > and is capable of generating the HID events.
> > 
> > The series also ensures we can run the tests with vmtest.sh,
> > allowing for a quick development and test in the tree itself.
> > 
> > This should allow us to require tests to be added to a series
> > when we see fit and keep them alive properly instead of having
> > to deal with 2 repositories.
> > 
> > In Cc are all of the people who participated in the elaboration
> > of those tests, so please send back a signed-off-by for each
> > commit you are part of.
> > 
> > This series applies on top of the for-6.3/hid-bpf branch, which
> > is the one that added the tools/testing/selftests/hid directory.
> > Given that this is unlikely this series will make the cut for
> > 6.3, we might just consider this series to be based on top of
> > the future 6.3-rc1.
> > 
> > Cheers,
> > Benjamin
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> 
> Jiri, do you mind if I push that code in the hid tree with the following
> changes:
> - Peter privately gave me his signed-off-by

Apologies, this fell off my list after the initial ack in a meeting with
Benjamin. This time publicly:
  Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
for the relevant commits.

Cheers,
  Peter


> - I included changes from https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/143
>   to fix the failing sony tests in v6.3
> 
> I am not a big fan of sending a v2 because the ML are not happy with the
> amount of changes...
> 
> Cheers,
> Benjamin
> 
> > Benjamin Tissoires (11):
> >       selftests: hid: make vmtest rely on make
> >       selftests: hid: import hid-tools hid-core tests
> >       selftests: hid: import hid-tools hid-gamepad tests
> >       selftests: hid: import hid-tools hid-keyboards tests
> >       selftests: hid: import hid-tools hid-mouse tests
> >       selftests: hid: import hid-tools hid-multitouch and hid-tablets tests
> >       selftests: hid: import hid-tools wacom tests
> >       selftests: hid: import hid-tools hid-apple tests
> >       selftests: hid: import hid-tools hid-ite tests
> >       selftests: hid: import hid-tools hid-sony and hid-playstation tests
> >       selftests: hid: import hid-tools usb-crash tests
> > 
> >  tools/testing/selftests/hid/Makefile               |   12 +
> >  tools/testing/selftests/hid/config                 |   11 +
> >  tools/testing/selftests/hid/hid-apple.sh           |    7 +
> >  tools/testing/selftests/hid/hid-core.sh            |    7 +
> >  tools/testing/selftests/hid/hid-gamepad.sh         |    7 +
> >  tools/testing/selftests/hid/hid-ite.sh             |    7 +
> >  tools/testing/selftests/hid/hid-keyboard.sh        |    7 +
> >  tools/testing/selftests/hid/hid-mouse.sh           |    7 +
> >  tools/testing/selftests/hid/hid-multitouch.sh      |    7 +
> >  tools/testing/selftests/hid/hid-sony.sh            |    7 +
> >  tools/testing/selftests/hid/hid-tablet.sh          |    7 +
> >  tools/testing/selftests/hid/hid-usb_crash.sh       |    7 +
> >  tools/testing/selftests/hid/hid-wacom.sh           |    7 +
> >  tools/testing/selftests/hid/run-hid-tools-tests.sh |   28 +
> >  tools/testing/selftests/hid/settings               |    3 +
> >  tools/testing/selftests/hid/tests/__init__.py      |    2 +
> >  tools/testing/selftests/hid/tests/base.py          |  345 ++++
> >  tools/testing/selftests/hid/tests/conftest.py      |   81 +
> >  .../selftests/hid/tests/descriptors_wacom.py       | 1360 +++++++++++++
> >  .../selftests/hid/tests/test_apple_keyboard.py     |  440 +++++
> >  tools/testing/selftests/hid/tests/test_gamepad.py  |  209 ++
> >  tools/testing/selftests/hid/tests/test_hid_core.py |  154 ++
> >  .../selftests/hid/tests/test_ite_keyboard.py       |  166 ++
> >  tools/testing/selftests/hid/tests/test_keyboard.py |  485 +++++
> >  tools/testing/selftests/hid/tests/test_mouse.py    |  977 +++++++++
> >  .../testing/selftests/hid/tests/test_multitouch.py | 2088 ++++++++++++++++++++
> >  tools/testing/selftests/hid/tests/test_sony.py     |  282 +++
> >  tools/testing/selftests/hid/tests/test_tablet.py   |  872 ++++++++
> >  .../testing/selftests/hid/tests/test_usb_crash.py  |  103 +
> >  .../selftests/hid/tests/test_wacom_generic.py      |  844 ++++++++
> >  tools/testing/selftests/hid/vmtest.sh              |   25 +-
> >  31 files changed, 8554 insertions(+), 10 deletions(-)
> > ---
> > base-commit: 2f7f4efb9411770b4ad99eb314d6418e980248b4
> > change-id: 20230217-import-hid-tools-tests-dc0cd4f3c8a8
> > 
> > Best regards,
> > -- 
> > Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> 
