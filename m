Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12866CBFE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjC1Mzd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjC1Mz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 08:55:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FCA8
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=F+rQqljTgcGO9WdWA46gPD7q/0BLet8d4j36J4dW8Rw=;
        t=1680008094; x=1681217694; b=ibNOR5Xvjgs4vA3KP5pohLX4fSAuQb0z4S5pxykfyYDIiOm
        +2nbS8YVheXJ0pB4YWrtUCfEC323jrcZ60mBP13rqCAq4n1quINil3flbSP9ZzOQ1k7YZeQoy08sU
        kSSdHmQH3ksYMqEfA6jkLFWirfGk9C53zd7QHIw4dn/6we1PTlAB85jJOruXrrfVogxi4iN/Vrn8J
        1iB1ZI16atQKyTI8ttn8SWfrrd2aNwxKLAmeiwtpkYp331vehSpMs6MXHBD4MSX+wh4u2iBsOeV35
        1lNsi682hIs0ZuewRCn5HJNWeLYsZ0AYrwSsPopOis1IS7KRf5DKBVeTG9RtxdGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ph8qd-00GisX-1L;
        Tue, 28 Mar 2023 14:54:47 +0200
Message-ID: <3bca9d93e10d5fab7e6f1a3f0b9aa36dd941a915.camel@sipsolutions.net>
Subject: Re: new kunit infrastructure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Tue, 28 Mar 2023 14:54:46 +0200
In-Reply-To: <CABVgOSmtyYDTNO+fREYpsO+BLeGYmajVPjrqqrxq+88HfPFsjQ@mail.gmail.com>
References: <0bfe4ca4863c22208d09d9b437cc563ed50877a1.camel@sipsolutions.net>
         <CABVgOSmtyYDTNO+fREYpsO+BLeGYmajVPjrqqrxq+88HfPFsjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

Thanks for the quick reply!

> "established process" is probably overselling it, but we're more than
> happy to accept improvements and additions to KUnit.

Yeah I guess I was expecting that. Was more wondering if you had
anything in mind other than sending it to kunit-dev/linux-kselftest
lists. I'll assume no for now :-)

> > For example, we have this macro that makes KUNIT_ARRAY_PARAM easier by
> > letting you just declare an array of test cases:
> >=20
> > /* Similar to KUNIT_ARRAY_PARAM, but avoiding an extra function */
> > #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)               =
                         \
> >         static const void *name##_gen_params(const void *prev, char *de=
sc)                      \
> >         {                                                              =
                         \
> >                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next))=
 prev) + 1 : (array);      \
> >                 if (__next - (array) < ARRAY_SIZE((array))) {          =
                         \
> >                         strscpy(desc, __next->desc_member, KUNIT_PARAM_=
DESC_SIZE);              \
> >                         return __next;                                 =
                         \
> >                 }                                                      =
                         \
> >                 return NULL;                                           =
                         \
> >         }
> >=20
>=20
> Very neat! I'm more than happy to see this added.

Credits to Benjamin, FWIW. We'll send a patch.

> We're definitely in favour of adding these sorts of helpers. Thus far,
> these have mostly lived alongside the tests or subsystem being tested,
> but if they're widely useful then they can sit alongside the KUnit
> code.
>=20
> My personal feeling is that it's better to have these sorts of
> subsystem-specific helpers be written and maintained as part of the
> subsystems (like the tests themselves), largely because that's where
> the subsystem expertise lies, but we're definitely happy to review any
> such patches to make sure they fit into the KUnit infrastructure well.

Right, that all makes sense. But ...

> (And, of course, if something spans several subsystems, then lib/kunit
> may be the best place to keep it.)

Exactly. Even for wifi, being split between cfg80211 and mac80211 makes
things harder than they should be and less clean if it's part of
cfg80211 and then somehow exposed to other bits, and then possibly
refactored into somewhere else in net if that starts using it.

So I think in the case of test-managed SKBs, it would make sense to put
it into lib/kunit.

> Yeah, it's a combination of "no-one has needed it yet", "no-one
> working on KUnit understands it well enough", and "we haven't had the
> time yet". We are a bit hesitant to add these features without having
> tests that use them, too: often things will be coded by hand for one
> or two tests, and only then refactored out into a common helper.

Right, we're already at that place adding tests to cfg80211 and mac80211
now, basically.

> There are a few other similar helpers being worked on at the moment,
> mostly around providing test-managed "struct device"s, so this is
> definitely an active field of development.

Great.

I think we'll just send a couple of patches to start out with, for SKBs
and the test case array macro above.

Thanks!

johannes
