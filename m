Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA166ECFE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDXOCq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjDXOCp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 10:02:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6A19B;
        Mon, 24 Apr 2023 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eOUUhIXDyGgeQaweCO9P/fOjDvQFT0UkxA5tSLPbPTo=;
        t=1682344963; x=1683554563; b=SPrigklm0Nuc0qDGPX5o4WOLusX8Fe86X5JgsnYyw9tzvNf
        MgkRxkYo433rHJ5IxxVKbQOznn1c/c52UpEWMC+6avbcrhSrN+70CM2LGHfMFieM3lsGzHb7U/UI1
        +egyMJufR1tRDiDt/z841xA6mwUtInpaMZxFOFhWdn06QV2pGJj44KxH+O5WUMfugYE1K/jrTOPY5
        pbIKloytcYIDuRtC9qJahD7n4b7oB+NnR+7r6ZwTyrK1tYzYB2JnA9wNOPQuIHNXwldpkM4WEsb1c
        yDoSGIMEN50qShTti3agW4+20Xkcv37NRQd9T4qwMQqfHfpsvxHb6sa1Dp3YaUQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1pqwlz-007GLe-0s;
        Mon, 24 Apr 2023 16:02:31 +0200
Message-ID: <5a820cf9aae169e18635a8c867835817a50892b0.camel@sipsolutions.net>
Subject: Re: [PATCH v1 0/3] kunit: Deferred action helpers
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Date:   Mon, 24 Apr 2023 16:02:29 +0200
In-Reply-To: <54b49d4ddf371d0581f3b795f50f7f6673557a96.camel@sipsolutions.net>
References: <20230421084226.2278282-1-davidgow@google.com>
         <54b49d4ddf371d0581f3b795f50f7f6673557a96.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Mon, 2023-04-24 at 14:32 +0200, Benjamin Berg wrote:
> On Fri, 2023-04-21 at 16:42 +0800, 'David Gow' via KUnit Development wrot=
e:
> > This is v1 of the KUnit deferred actions API, which implements an
> > equivalent of devm_add_action[1] on top of KUnit managed resources. Thi=
s
> > provides a simple way of scheduling a function to run when the test
> > terminates (whether successfully, or with an error). It's therefore ver=
y
> > useful for freeing resources, or otherwise cleaning up.
> >=20
> > The notable changes since RFCv2[2] are:
> > - Got rid of the 'cancellation token' concept. It was overcomplicated,
> > =C2=A0 and we can add it back if we need to.
> > - kunit_add_action() therefore now returns 0 on success, and an error
> > =C2=A0 otherwise (like devm_add_action()). Though you may wish to use:
> > - Added kunit_add_action_or_reset(), which will call the deferred
> > =C2=A0 function if an error occurs. (See devm_add_action_or_reset()). T=
his
> > =C2=A0 also returns an error on failure, which can be asserted safely.
> > - Got rid of the function pointer typedef. Personally, I liked it, but
> > =C2=A0 it's more typedef-y than most kernel code.
> > - Got rid of the 'internal_gfp' argument: all internal state is now
> > =C2=A0 allocated with GFP_KERNEL. The main KUnit resource API can be us=
ed
> > =C2=A0 instead if this doesn't work for your use-case.
> >=20
> > I'd love to hear any further thoughts!
>=20
> I am happy with it as-is.

Oh, wait. Nothing big, but I just noticed that the new API functions
seem to not yet be exported using EXPORT_SYMBOL_GPL.

Benjamin

> Reviewed-By: Benjamin Berg <benjamin.berg@intel.com>
>=20
> >=20
> > Cheers,
> > -- David
> >=20
> > [1]:
> > https://docs.kernel.org/driver-api/basics.html#c.devm_add_action
> > [2]:
> > https://patchwork.kernel.org/project/linux-kselftest/list/?series=3D735=
720
> >=20
> >=20
> > David Gow (3):
> > =C2=A0 kunit: Add kunit_add_action() to defer a call until test exit
> > =C2=A0 kunit: executor_test: Use kunit_add_action()
> > =C2=A0 kunit: kmalloc_array: Use kunit_add_action()
> >=20
> > =C2=A0include/kunit/resource.h=C2=A0 | 76 +++++++++++++++++++++++++++++=
++
> > =C2=A0include/kunit/test.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++-
> > =C2=A0lib/kunit/executor_test.c | 11 ++---
> > =C2=A0lib/kunit/kunit-test.c=C2=A0=C2=A0=C2=A0 | 88
> > +++++++++++++++++++++++++++++++++++-
> > =C2=A0lib/kunit/resource.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 95
> > +++++++++++++++++++++++++++++++++++++++
> > =C2=A0lib/kunit/test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 48 ++++----------------
> > =C2=A06 files changed, 279 insertions(+), 49 deletions(-)
> >=20
> > --=20
> > 2.40.0.634.g4ca3ef3211-goog
> >=20
>=20

