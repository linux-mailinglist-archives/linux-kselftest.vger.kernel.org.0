Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782C759B69C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiHUWWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHUWWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 18:22:45 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D59A183B1;
        Sun, 21 Aug 2022 15:22:44 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M9qkB3q3RzDr9K;
        Sun, 21 Aug 2022 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661120563; bh=ccrF4EfkahHpt/9Pba8wQctpnDNAB+Jj9k09ArPwhpc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=Uiv66D+U+gLOe7JE6i/oAl/E0FWpEbo+VZnWG24uszi9cNT1zkOpc8pufuhTFZ9lN
         MONx1BfcGTjtuMpMB2ydJ3EM7TveoQ6vG30WQlY5Oalfp9Wy56W/RPOs32B8HVdv/0
         4H0cTd/hcAahRWzr89TMVLCtK9O4eq5WYQK7fz6w=
X-Riseup-User-ID: 8AD00409068A65E08A13AA40A73B9388512B00AE92B6AD68FCA47EEA686532D1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M9qk239Jyz5vY6;
        Sun, 21 Aug 2022 22:22:33 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
From:   Isabella Basso <isabbasso@riseup.net>
In-Reply-To: <20220722162529.wy4ox7pyjhno66lz@macragge.hardline.pl>
Date:   Sun, 21 Aug 2022 19:22:30 -0300
Cc:     =?utf-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        Arthur Grillo <arthur.grillo@usp.br>,
        Rodrigo Siqueira <siqueirajordao@riseup.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org, n@nfraprado.net,
        andrealmeid@riseup.net, magalilemes00@gmail.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kunit-dev@googlegroups.com, mwen@igalia.com,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?utf-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        tales.aparecida@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52481C88-9CD7-4E4F-ABCB-1EFC01E4B4D0@riseup.net>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-10-maira.canal@usp.br>
 <CAM0jSHNG8Ozs+NpvwMK6zvbRm3Ve=Wa1_H7jS0uQ8FeAWgvyoA@mail.gmail.com>
 <b1ae4f77-4e24-24c9-fd87-abcd612a3533@usp.br>
 <20220722162529.wy4ox7pyjhno66lz@macragge.hardline.pl>
To:     =?utf-8?Q?Micha=C5=82_Winiarski?= <michal@hardline.pl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Micha=C5=82,

While I totally understand your point, we have talked about this in our =
GSoC
meetings with mentors, and have found a few reasons as to why a KUnit =
runner
integrated to IGT might be really useful.=20

> Am 22/07/2022 um 1:25 PM schrieb Micha=C5=82 Winiarski =
<michal@hardline.pl>:
>=20
> On Fri, Jul 22, 2022 at 08:04:51AM -0300, Ma=C3=ADra Canal wrote:
>> On 7/22/22 07:35, Matthew Auld wrote:
>>> On Fri, 8 Jul 2022 at 21:32, Ma=C3=ADra Canal <maira.canal@usp.br> =
wrote:
>>>>=20
>>>> From: Arthur Grillo <arthur.grillo@usp.br>
>>>>=20
>>>> Considering the current adoption of the KUnit framework, convert =
the
>>>> DRM mm selftest to the KUnit API.
>>>=20
>>> Is there a plan to convert the corresponding selftest IGT that was
>>> responsible for running this (also drm_buddy) to somehow work with
>>> kunit? Previously these IGTs were always triggered as part of
>>> intel-gfx CI, but it looks like they are no longer run[1].
>>>=20
>>> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/6433
>>=20
>> Hi Matthew,
>>=20
>> Isabella sent a while ago a patch to IGT adding KUnit compatibility =
to
>> IGT [1], but there wasn't any feedback on the patch. I believe that =
soon
>> she will resend the series in order to make all KUnit DRM tests run =
on IGT.
>>=20
>> Any feedback on the patch is welcomed so that we can fix this issue =
as
>> soon as possible.
>>=20
>> [1] https://patchwork.freedesktop.org/patch/489985/
>>=20
>> Best Regards,
>> - Ma=C3=ADra Canal
>=20
> Hi.
>=20
> Instead of going back to using IGT for *unit* tests, it would be a =
better idea
> to adjust the CI to just run the tests once at "build" time (just like =
e.g.
> checkpatch).

First, I=E2=80=99d like to point out that there would be some inherent =
overhead in
doing so, which might actually not be worth it, as KUnit tool would need =
to
compile HEAD in the UML arch, then we=E2=80=99d have to re-compile =
everything to a real
machine=E2=80=99s architecture, like x86_64 (in the least), having in =
mind still that
arch-dependent issues would not show up when we run tests in UML, so =
there=E2=80=99s
still a downside to it even if it=E2=80=99s quick enough.

Even if we don=E2=80=99t run them as UML and instead use a VM, there=E2=80=
=99s a VM being run
just for a couple of tests, which might be slower than adding a step to =
a
dedicated machine that=E2=80=99s (probably) already available, plus the =
setup and
hardware needed to run a VM inside of a CI runner are overheads in =
themselves,
needing dedicated, modern machines.

> We would then stop executing the same test multiple times on different =
machines
> (note that both DRM selftests and i915 "mock" selftests are pure unit =
tests - in
> other words, they don't need the hardware to be present), which would =
save some
> (small) amount of machine-time that can be utilized to do something =
that
> actually needs the hardware.

I totally agree with your solution in regards to arch-independent tests, =
though.

> Plus there's no need to maintain the kunit-runner in IGT.
> Note - we're currently going to lose "DMESG-WARN" detection if we go =
this route,
> but this is something that can be improved on the kunit-side.
>=20
> -Micha=C5=82

There=E2=80=99s also a point to be made on maintaining such a runner if =
we think about
companies like AMD, as they rely heavily on IGT, so they have lots of =
tests
written in there, and it'd be difficult for them to accommodate one more
non-trivial thing to their CI. Plus I think this might be a good =
starting point
for them to transition their CI to a KUnit-centered approach without =
stressing
engineers unnecessarily.

Cheers,
=E2=80=94
Isabella

