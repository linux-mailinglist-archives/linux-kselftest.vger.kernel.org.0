Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546F6D4D6E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjDCQV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjDCQVZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 12:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A71BF5
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680538834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxU62i4lWfFKhn+8/tWDLXfiD8gqbx4191bWfIWJHa0=;
        b=epEIU3G/QPoIOLJsmNZCTjnFMiYO3FscXSoYwikLF3TnX4/RaTmMQQuQ7ZLwuYzwBUyNq8
        X2iBzH7MSsRJkgUmD0MY+NKIY8Lp0B0t88AC7sx6+pamQ7UMaQopup/SJ0QZs/dBiAg9XI
        QG19OQHYbrbXJPB9ySE147T2cTnCiD8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-f2FFGFzfMhWUjfqN_fetMQ-1; Mon, 03 Apr 2023 12:20:31 -0400
X-MC-Unique: f2FFGFzfMhWUjfqN_fetMQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0C1F29AA3B3;
        Mon,  3 Apr 2023 16:20:30 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 507A0400F4F;
        Mon,  3 Apr 2023 16:20:27 +0000 (UTC)
Date:   Mon, 3 Apr 2023 18:20:24 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Candle Sun <candle.sun@unisoc.com>,
        Jose Torreguitar <jtguitar@google.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Silvan Jegen <s.jegen@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Jason Gerecke <killertofu@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH 00/11] selftests: hid: import the tests from hid-tools
Message-ID: <20230403162024.sespaq5iwbjan4xl@mail.corp.redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Feb 17 2023, Benjamin Tissoires wrote:
> I have been running hid-tools for a while, but it was in its own
> separate repository for multiple reasons. And the past few weeks
> I finally managed to make the kernel tests in that repo in a
> state where we can merge them in the kernel tree directly:
> 
> - the tests run in ~2 to 3 minutes
> - the tests are way more reliable than previously
> - the tests are mostly self-contained now (to the exception
>   of the Sony ones)
> 
> To be able to run the tests we need to use the latest release
> of hid-tools, as this project still keeps the HID parsing logic
> and is capable of generating the HID events.
> 
> The series also ensures we can run the tests with vmtest.sh,
> allowing for a quick development and test in the tree itself.
> 
> This should allow us to require tests to be added to a series
> when we see fit and keep them alive properly instead of having
> to deal with 2 repositories.
> 
> In Cc are all of the people who participated in the elaboration
> of those tests, so please send back a signed-off-by for each
> commit you are part of.
> 
> This series applies on top of the for-6.3/hid-bpf branch, which
> is the one that added the tools/testing/selftests/hid directory.
> Given that this is unlikely this series will make the cut for
> 6.3, we might just consider this series to be based on top of
> the future 6.3-rc1.
> 
> Cheers,
> Benjamin
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Jiri, do you mind if I push that code in the hid tree with the following
changes:
- Peter privately gave me his signed-off-by
- I included changes from https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/143
  to fix the failing sony tests in v6.3

I am not a big fan of sending a v2 because the ML are not happy with the
amount of changes...

Cheers,
Benjamin

> Benjamin Tissoires (11):
>       selftests: hid: make vmtest rely on make
>       selftests: hid: import hid-tools hid-core tests
>       selftests: hid: import hid-tools hid-gamepad tests
>       selftests: hid: import hid-tools hid-keyboards tests
>       selftests: hid: import hid-tools hid-mouse tests
>       selftests: hid: import hid-tools hid-multitouch and hid-tablets tests
>       selftests: hid: import hid-tools wacom tests
>       selftests: hid: import hid-tools hid-apple tests
>       selftests: hid: import hid-tools hid-ite tests
>       selftests: hid: import hid-tools hid-sony and hid-playstation tests
>       selftests: hid: import hid-tools usb-crash tests
> 
>  tools/testing/selftests/hid/Makefile               |   12 +
>  tools/testing/selftests/hid/config                 |   11 +
>  tools/testing/selftests/hid/hid-apple.sh           |    7 +
>  tools/testing/selftests/hid/hid-core.sh            |    7 +
>  tools/testing/selftests/hid/hid-gamepad.sh         |    7 +
>  tools/testing/selftests/hid/hid-ite.sh             |    7 +
>  tools/testing/selftests/hid/hid-keyboard.sh        |    7 +
>  tools/testing/selftests/hid/hid-mouse.sh           |    7 +
>  tools/testing/selftests/hid/hid-multitouch.sh      |    7 +
>  tools/testing/selftests/hid/hid-sony.sh            |    7 +
>  tools/testing/selftests/hid/hid-tablet.sh          |    7 +
>  tools/testing/selftests/hid/hid-usb_crash.sh       |    7 +
>  tools/testing/selftests/hid/hid-wacom.sh           |    7 +
>  tools/testing/selftests/hid/run-hid-tools-tests.sh |   28 +
>  tools/testing/selftests/hid/settings               |    3 +
>  tools/testing/selftests/hid/tests/__init__.py      |    2 +
>  tools/testing/selftests/hid/tests/base.py          |  345 ++++
>  tools/testing/selftests/hid/tests/conftest.py      |   81 +
>  .../selftests/hid/tests/descriptors_wacom.py       | 1360 +++++++++++++
>  .../selftests/hid/tests/test_apple_keyboard.py     |  440 +++++
>  tools/testing/selftests/hid/tests/test_gamepad.py  |  209 ++
>  tools/testing/selftests/hid/tests/test_hid_core.py |  154 ++
>  .../selftests/hid/tests/test_ite_keyboard.py       |  166 ++
>  tools/testing/selftests/hid/tests/test_keyboard.py |  485 +++++
>  tools/testing/selftests/hid/tests/test_mouse.py    |  977 +++++++++
>  .../testing/selftests/hid/tests/test_multitouch.py | 2088 ++++++++++++++++++++
>  tools/testing/selftests/hid/tests/test_sony.py     |  282 +++
>  tools/testing/selftests/hid/tests/test_tablet.py   |  872 ++++++++
>  .../testing/selftests/hid/tests/test_usb_crash.py  |  103 +
>  .../selftests/hid/tests/test_wacom_generic.py      |  844 ++++++++
>  tools/testing/selftests/hid/vmtest.sh              |   25 +-
>  31 files changed, 8554 insertions(+), 10 deletions(-)
> ---
> base-commit: 2f7f4efb9411770b4ad99eb314d6418e980248b4
> change-id: 20230217-import-hid-tools-tests-dc0cd4f3c8a8
> 
> Best regards,
> -- 
> Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 

