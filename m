Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7026ECC17
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjDXMcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjDXMck (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 08:32:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B830C5;
        Mon, 24 Apr 2023 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+AKUr/16XMPYHadRWyJapkJc4/eIA0iPZIHyUWZAMxw=;
        t=1682339556; x=1683549156; b=fo9wBJH/aRA46Ibx+Yn00VHxm+pn2ibQHFo60wRroMUtdKW
        nBhVwrRfAwJku6B3kbW5GBvuvoWhx9ayvm2UNMOzKiZc90INo9uNmvHTODnhdqk+G0EyIFtslnyIs
        2EYuqQXk4oA6lUTxDFaS2JuwK+odEPayTVG8JxSKEiY6iX7nx52SB0M9DDFOcf4texQfoYsLdPvt8
        6mzSkTykLjp3A5m5e1xZS2R94tUy6U8OaUZNu91sNSRdcQDvGtqntg9ILGBSxf6bGcyCmU0pX+RiS
        9F+NH1VdPul95uTwHK9UkvQ9Ler4gh4K20+tmtYUF50x3AzUALA9vS03zk84r6VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1pqvMg-007EaT-2q;
        Mon, 24 Apr 2023 14:32:19 +0200
Message-ID: <54b49d4ddf371d0581f3b795f50f7f6673557a96.camel@sipsolutions.net>
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
Date:   Mon, 24 Apr 2023 14:32:16 +0200
In-Reply-To: <20230421084226.2278282-1-davidgow@google.com>
References: <20230421084226.2278282-1-davidgow@google.com>
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

On Fri, 2023-04-21 at 16:42 +0800, 'David Gow' via KUnit Development wrote:
> This is v1 of the KUnit deferred actions API, which implements an
> equivalent of devm_add_action[1] on top of KUnit managed resources. This
> provides a simple way of scheduling a function to run when the test
> terminates (whether successfully, or with an error). It's therefore very
> useful for freeing resources, or otherwise cleaning up.
>=20
> The notable changes since RFCv2[2] are:
> - Got rid of the 'cancellation token' concept. It was overcomplicated,
> =C2=A0 and we can add it back if we need to.
> - kunit_add_action() therefore now returns 0 on success, and an error
> =C2=A0 otherwise (like devm_add_action()). Though you may wish to use:
> - Added kunit_add_action_or_reset(), which will call the deferred
> =C2=A0 function if an error occurs. (See devm_add_action_or_reset()). Thi=
s
> =C2=A0 also returns an error on failure, which can be asserted safely.
> - Got rid of the function pointer typedef. Personally, I liked it, but
> =C2=A0 it's more typedef-y than most kernel code.
> - Got rid of the 'internal_gfp' argument: all internal state is now
> =C2=A0 allocated with GFP_KERNEL. The main KUnit resource API can be used
> =C2=A0 instead if this doesn't work for your use-case.
>=20
> I'd love to hear any further thoughts!

I am happy with it as-is.

Reviewed-By: Benjamin Berg <benjamin.berg@intel.com>

>=20
> Cheers,
> -- David
>=20
> [1]: https://docs.kernel.org/driver-api/basics.html#c.devm_add_action
> [2]: https://patchwork.kernel.org/project/linux-kselftest/list/?series=3D=
735720
>=20
>=20
> David Gow (3):
> =C2=A0 kunit: Add kunit_add_action() to defer a call until test exit
> =C2=A0 kunit: executor_test: Use kunit_add_action()
> =C2=A0 kunit: kmalloc_array: Use kunit_add_action()
>=20
> =C2=A0include/kunit/resource.h=C2=A0 | 76 +++++++++++++++++++++++++++++++
> =C2=A0include/kunit/test.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++-
> =C2=A0lib/kunit/executor_test.c | 11 ++---
> =C2=A0lib/kunit/kunit-test.c=C2=A0=C2=A0=C2=A0 | 88 +++++++++++++++++++++=
++++++++++++++-
> =C2=A0lib/kunit/resource.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 95 +++++++++++=
++++++++++++++++++++++++++++
> =C2=A0lib/kunit/test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 48 ++++----------------
> =C2=A06 files changed, 279 insertions(+), 49 deletions(-)
>=20
> --=20
> 2.40.0.634.g4ca3ef3211-goog
>=20

