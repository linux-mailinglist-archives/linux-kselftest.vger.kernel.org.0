Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15166E5D40
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDRJYd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDRJYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 05:24:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357144BE;
        Tue, 18 Apr 2023 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dP8wONo/0L8QgOubZf3pNmHKECgV6F1n+49HKuhWnB8=;
        t=1681809867; x=1683019467; b=qpNE0dfVEV5nYW9Rxc8P1tnPnYWZuq3oJJCtqySNsESziBP
        pH5tHvb347K+emkHQv9fA7TlPiAWbzig9/VcxmC8H/DUBrAZt5v/pMouyErB9BJrJ4VhNgrLt4DKp
        eyU5dutylrvXMTTUsti/8DylaBjZ0C4i9GdhrvfYalKkq+M9p/Cn9TmLE279b2XAc2rq9wr79j8jM
        G4Qxv9+N6RHnOTjP/aILH7fIKLpcT+xV1fRnCSvY1M83H1yk3CCxsrpxILg/DW0T72+WA6r2bLq5e
        1ddnTP/I7Q73yOYnftP6+g3GfzXiOUnNkxPgAmCkpvffQHtBnEI9kqJrFVOPdr2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1pohZU-001Ymu-0O;
        Tue, 18 Apr 2023 11:24:20 +0200
Message-ID: <a39af0400abedb2e9b31d84c37551cecc3eed0e1.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: Set the current KUnit context when cleaning up
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Apr 2023 11:24:18 +0200
In-Reply-To: <CABVgOSmGa-4M6w7MJ5MP8222FMuZJike1uDauporBsu5QUDb9w@mail.gmail.com>
References: <20230415091401.681395-1-davidgow@google.com>
         <4560d22e3d0a9beb71ef10202d8bcb77b5148eae.camel@sipsolutions.net>
         <CABVgOSmGa-4M6w7MJ5MP8222FMuZJike1uDauporBsu5QUDb9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Tue, 2023-04-18 at 14:53 +0800, David Gow wrote:
> On Mon, 17 Apr 2023 at 18:43, Benjamin Berg <benjamin@sipsolutions.net> w=
rote:
> >=20
> > Hi,
> >=20
> > On Sat, 2023-04-15 at 17:14 +0800, David Gow wrote:
> > > KUnit tests run in a kthread, with the current->kunit_test pointer se=
t
> > > to the test's context. This allows the kunit_get_current_test() and
> > > kunit_fail_current_test() macros to work. Normally, this pointer is
> > > still valid during test shutdown (i.e., the suite->exit function, and
> > > any resource cleanup). However, if the test has exited early (e.g., d=
ue
> > > to a failed assertion), the cleanup is done in the parent KUnit threa=
d,
> > > which does not have an active context.
> >=20
> > My only question here is whether assertions (not expectations) are OK
> > within the exit/cleanup handler. That said, it wouldn't be clear
> > whether we should try to continue cleaning up after every failure, so
> > probably it is reasonable to not do that.
>=20
> Excellent point.
> In general:
> - It's okay to use expectations within exit and cleanup functions.
> - It's not okay for assertions to fail within an exit / cleanup handler.
> - It's not okay to access anything which was allocated on the stack
> from within a test in exit / cleanup handlers.
> - It's okay to access and free resources from within cleanup / exit
> handlers, though it's not permitted to create new resources from
> cleanup handlers (exit is okay).

The list makes sense to me.

> I do think we need to document this better, at the very least.
>=20
> What I think we'll end up doing is implementing a different system:
> - The test (and, if successful, cleanup) runs in a kthread.
> - If it aborts (e.g., due to an assertion), cleanup runs in another kthre=
ad.
> - If this second kthread aborts early, no further cleanup is run.
>=20
> This would protect the KUnit executor thread from misbehaving cleanup
> functions, and if an assertion happens in a cleanup function, we'll
> leak things (which is bad), but not dereference a bunch of invalid
> pointers (which is worse).

Sounds good.

> I've got this mostly working here, and will send it out as a
> replacement to this patch (that second kthread will have
> current->kunit_test set, rendering this change redundant).

Cool!

> > But, I did see that at least the clock tests currently use assertions
> > inside the init function. And, in those tests, if the context
> > allocation fails the exit handler will dereference the NULL pointer.
>=20
> Hmm... which clock test is that? Regardless, it sounds like a bug in the =
test.
>=20
> I think that ultimately, the right solution for dealing with the
> context pointer issue is to use resources (or, when available,
> kunit_add_action()), which nicely enforces the ordering as well. In
> the meantime, though, I guess it just needs wrapping in a lot of "if
> (ctx)" or similar...

I am talking about drivers/clk/clk-gate_test.c. The _init functions
(and clk_gate_test_alloc_ctx) use assertions heavily. The _exit handles
does not deal with the ctx being NULL though. But, the fix is trivial
though:

diff --git a/drivers/clk/clk-gate_test.c b/drivers/clk/clk-gate_test.c
index e136aaad48bf..f1adafe725e4 100644
--- a/drivers/clk/clk-gate_test.c
+++ b/drivers/clk/clk-gate_test.c
@@ -225,6 +225,9 @@ static void clk_gate_test_exit(struct kunit *test)
 {
        struct clk_gate_test_context *ctx =3D test->priv;
=20
+       if (!ctx)
+               return;
+
        clk_hw_unregister_gate(ctx->hw);
        clk_hw_unregister_fixed_rate(ctx->parent);
 }


> > So, nothing for this patch, but maybe it would make sense to mark tests
> > as failed (or print a warning) if they use assertions inside init, exit
> > or cleanup handlers?
> >=20
>=20
> I think we'll still want to support assertions in init functions
> (albeit possibly with some documentation pointing out any pitfalls).
> If actions or resources are used, it's not a problem.

Yeah, a short sentence in the "struct kunit_suite" documentation should
be enough. Something along the lines of: "This call to @exit will
always happen, even if @init returned an error or aborted due to an
assertion.".

> Also, a lot of these issues also apply to kunit_skip(), which is used
> _heavily_ in init functions.
>=20
> Warnings for assertions in exit or cleanup make sense. I _could_ see a
> reason to allow assertions if we wanted to have, e.g., helpers which
> asserted that their inputs were valid -- it'd be a bit rough to deny
> their use if the inputs are known to be okay -- but I'm not aware of
> any such case in practice yet, so I suspect it's still worth failing
> tests (and seeing if anyone complains).

I am not going to insist on disallowing or warning about assertions. It
is OK from my point of view, as long as the damage is contained to a
kunit kthread and "only" affects cleanup.

Benjamin
