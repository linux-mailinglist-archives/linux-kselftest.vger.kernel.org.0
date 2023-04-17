Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86686E457D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDQKpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDQKpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 06:45:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77165AF;
        Mon, 17 Apr 2023 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CW9lw2Cj2XyT8UmS0Kl5czpsMOIb9NpzZKIOou+Y6j4=;
        t=1681728258; x=1682937858; b=RRBcRusnzaTG3BgEcC0O0NhOaZiod09xPNO77lteSGjFvJw
        Jors0yiTgUCtCxb1Yla3gxOx0LTt+r0+ITy+qfKaRODie0E0FieRvQ9Bphc2xmZPbBduNOkZju0C3
        22yBn0vvqcKO/QwpSe30jkOaC9iF2P3HamC4G22nIIc8iLwCh6Dh1++tsMjwjDbe4fHYoTrJPDTYz
        q/6UTECEWZTOjNzrlUaYJqidjvanp9emxHj7pHxY0nmrvBVMIVklkEQuCxuLnKFaEGwQ6DWb3f5Uw
        3FYL06JeALGRqgAgaJtxPhLJca55QMYCckmPre3TjX3wz4yA1qK5pY2XUhYp4H0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1poMK9-000fGG-2W;
        Mon, 17 Apr 2023 12:43:06 +0200
Message-ID: <4560d22e3d0a9beb71ef10202d8bcb77b5148eae.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: Set the current KUnit context when cleaning up
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Apr 2023 12:43:03 +0200
In-Reply-To: <20230415091401.681395-1-davidgow@google.com>
References: <20230415091401.681395-1-davidgow@google.com>
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

Hi,

On Sat, 2023-04-15 at 17:14 +0800, David Gow wrote:
> KUnit tests run in a kthread, with the current->kunit_test pointer set
> to the test's context. This allows the kunit_get_current_test() and
> kunit_fail_current_test() macros to work. Normally, this pointer is
> still valid during test shutdown (i.e., the suite->exit function, and
> any resource cleanup). However, if the test has exited early (e.g., due
> to a failed assertion), the cleanup is done in the parent KUnit thread,
> which does not have an active context.

My only question here is whether assertions (not expectations) are OK
within the exit/cleanup handler. That said, it wouldn't be clear
whether we should try to continue cleaning up after every failure, so
probably it is reasonable to not do that.

But, I did see that at least the clock tests currently use assertions
inside the init function. And, in those tests, if the context
allocation fails the exit handler will dereference the NULL pointer.

So, nothing for this patch, but maybe it would make sense to mark tests
as failed (or print a warning) if they use assertions inside init, exit
or cleanup handlers?

Benjamin

> Fix this by setting the active KUnit context for the duration of the
> test shutdown procedure. When the test exits normally, this does
> nothing. When run from the KUits previous value (probably NULL)
> afterwards.
>=20
> This should make it easier to get access to the KUnit context,
> particularly from within resource cleanup functions, which may, for
> example, need access to data in test->priv.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>=20
> This becomes useful with the current kunit_add_action() implementation,
> as actions do not get the KUnit context passed in by default:
> https://lore.kernel.org/linux-kselftest/CABVgOSmjs0wLUa4=3DErkB9tH8p6A1P6=
N33befv63whF+hECRExQ@mail.gmail.com/
>=20
> I think it's probably correct anyway, though, so we should either do
> this, or totally rule out using kunit_get_current_test() here at all, by
> resetting current->kunit_test to NULL before running cleanup even in
> the normal case.
>=20
> I've only given this the most cursory testing so far (I'm not sure how
> much of the executor innards I want to expose to be able to actually
> write a proper test for it), so more eyes and/or suggestions are
> welcome.
>=20
> Cheers,
> -- David
>=20
> ---
> =C2=A0lib/kunit/test.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e2910b261112..2d7cad249863 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -392,10 +392,21 @@ static void kunit_case_internal_cleanup(struct kuni=
t *test)
> =C2=A0static void kunit_run_case_cleanup(struct kunit *test,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kunit_suit=
e *suite)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we're no-longer running =
from within the test kthread() because it failed
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * or timed out, we still need=
 the context to be okay when running exit and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cleanup functions.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit *old_current =3D =
current->kunit_test;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current->kunit_test =3D test;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (suite->exit)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0suite->exit(test);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_case_internal_clean=
up(test);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Restore the thread's previo=
us test context (probably NULL or test). */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current->kunit_test =3D old_cu=
rrent;
> =C2=A0}
> =C2=A0
> =C2=A0struct kunit_try_catch_context {

