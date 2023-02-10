Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5266923C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjBJQ4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 11:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjBJQ4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 11:56:48 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2471A655;
        Fri, 10 Feb 2023 08:56:19 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4PD0HG2B7bzDrW9;
        Fri, 10 Feb 2023 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1676048154; bh=7LVN0Tvz41/zBY9UM/sXCMf+UpGWNMgOWyrI3wquCP8=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=LaPaxfoTeQPcMlW74LzYbWaN8BC3jxoiyJaWcQMV+0yB6rrUdQULG3NlTbg1ShavA
         bKlljjktaSkPC12B2NZ9a01mMvryMXfL7dgk4HZrMpxlVNSHyeUSj1qzaTBXXoCpof
         WnZo796wf4X2I+JgLb0TwwiuhlRkcehlg4v+aNAs=
X-Riseup-User-ID: 547A6DEB417079ABCF46AD6A6C88F2CA2B3872DFC3F7C4A8A0290186BCF3DB36
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4PD0H83Kh0z1y9M;
        Fri, 10 Feb 2023 16:55:48 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
From:   Isabella Basso <isabbasso@riseup.net>
In-Reply-To: <7621786.lvqk35OSZv@jkrzyszt-mobl1.ger.corp.intel.com>
Date:   Fri, 10 Feb 2023 13:55:34 -0300
Cc:     igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?utf-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>, n@nfraprado.net,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Gow <davidgow@google.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Trevor Woerner <twoerner@gmail.com>,
        Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F50369FC-2168-44EC-9BD9-53CF23A5EB97@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
 <2101392.KlZ2vcFHjT@jkrzyszt-mobl1.ger.corp.intel.com>
 <66E07FE6-0FE1-4CDF-A346-CF23C7B9D073@riseup.net>
 <7621786.lvqk35OSZv@jkrzyszt-mobl1.ger.corp.intel.com>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Janusz,

> Am 2023-02-10 um 11:56 AM schrieb Janusz Krzysztofik =
<janusz.krzysztofik@linux.intel.com>:
>=20
> Hi Isabella,
>=20
> On Monday, 19 September 2022 22:55:44 CET Isabella Basso wrote:
>> Hi, Janusz,
>>=20
>>> Am 09/09/2022 um 12:18 PM schrieb Janusz Krzysztofik =
<janusz.krzysztofik@linux.intel.com>:
>>>=20
>>> ...
>>>=20
>>> Anyway, related to my comment about naming that function a parser, I =
think the=20
>>> best approach would be for that parser to return a generic set of =
results from=20
>>> kunit execution, then we could feed that data into an IGT specific =
handler=20
>>> that would convert them to IGT results (SUCCESS, FAIL, or SKIP) as =
if returned=20
>>> by a set of IGT dynamic subtests.
>>=20
>> That sounds like a good idea to me, I might take some extra time =
before v3 to
>> do that, though.=20
>=20
> Were you able to make any progress?  Do you need any help?

I=E2=80=99ve already handled most common cases but I still have to =
address Chehab=E2=80=99s comments =E2=80=94 specifically in what =
concerns crashes. I=E2=80=99ve been doing most of the development by =
myself as GSoC has ended so I=E2=80=99m taking my time on this.

My most up-to-date work is available at [1], so if you have any =
suggestions as to what might be done I=E2=80=99d love to hear them =
before sending out v3 to the mailing list.

[1] - =
https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/merge_requests/1

Cheers,
--
Isabella Basso

> Thanks,
> Janusz
>=20
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit =
https://groups.google.com/d/msgid/kunit-dev/7621786.lvqk35OSZv%40jkrzyszt-=
mobl1.ger.corp.intel.com.

