Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3473F695FC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 10:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjBNJvW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 04:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjBNJvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 04:51:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE201E9D7;
        Tue, 14 Feb 2023 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676368240; x=1707904240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhBWla462uE1/WQewQ2F+AfWTlZLdWeKkC1spHlwS1w=;
  b=dEqfISczJoXvld6TK9G8NEX988aOwsTalTIft8Wr5Us6qxs3gb2DmqwX
   VOSBt2d6NYl7djWNcH3IxiepG42d8Mp+2AkcTvPnu81NX22Wof3rUfFmi
   5qDUPHBg8PzYjX54nvfyV6xuYim/PAQJT+xrDU4IPhGtoYzOueeADYlx7
   v2Gy8BAy6um+IFSZ9cErqIf1mh2LxBdU6YDjlNoAnhJzepsSggL5SeWvH
   JjI+v/2KIDzNlD94tzjGnH3ru2fp9rTuKvIAIO9chSNdyyQXfdg4AK5on
   QSaxUYlXWG7aNlAcKg5Y5/XLGBv66pRFH7xsyrNK5xw2YP0th6b7ocLw1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417341094"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="417341094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:50:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701601503"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="701601503"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.19.67])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:50:33 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>, n@nfraprado.net,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Gow <davidgow@google.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Trevor Woerner <twoerner@gmail.com>,
        Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
Date:   Tue, 14 Feb 2023 10:50:30 +0100
Message-ID: <4438162.8F6SAcFxjW@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <F50369FC-2168-44EC-9BD9-53CF23A5EB97@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net> <7621786.lvqk35OSZv@jkrzyszt-mobl1.ger.corp.intel.com> <F50369FC-2168-44EC-9BD9-53CF23A5EB97@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Isabella,

On Friday, 10 February 2023 17:55:34 CET Isabella Basso wrote:
> Hi, Janusz,
>=20
> > Am 2023-02-10 um 11:56 AM schrieb Janusz Krzysztofik <janusz.krzysztofi=
k@linux.intel.com>:
> >=20
> > Hi Isabella,
> >=20
> > On Monday, 19 September 2022 22:55:44 CET Isabella Basso wrote:
> >> Hi, Janusz,
> >>=20
> >>> Am 09/09/2022 um 12:18 PM schrieb Janusz Krzysztofik <janusz.krzyszto=
fik@linux.intel.com>:
> >>>=20
> >>> ...
> >>>=20
> >>> Anyway, related to my comment about naming that function a parser, I =
think the=20
> >>> best approach would be for that parser to return a generic set of res=
ults from=20
> >>> kunit execution, then we could feed that data into an IGT specific ha=
ndler=20
> >>> that would convert them to IGT results (SUCCESS, FAIL, or SKIP) as if=
 returned=20
> >>> by a set of IGT dynamic subtests.
> >>=20
> >> That sounds like a good idea to me, I might take some extra time befor=
e v3 to
> >> do that, though.=20
> >=20
> > Were you able to make any progress?  Do you need any help?
>=20
> I=E2=80=99ve already handled most common cases but I still have to addres=
s Chehab=E2=80=99s comments =E2=80=94 specifically in what concerns crashes=
=2E I=E2=80=99ve been doing most of the development by myself as GSoC has e=
nded so I=E2=80=99m taking my time on this.
>=20
> My most up-to-date work is available at [1], so if you have any suggestio=
ns as to what might be done I=E2=80=99d love to hear them before sending ou=
t v3 to the mailing list.
>=20
> [1] - https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/merge_reque=
sts/1

Thanks for pointing me to that merge request, it's great to know there is=20
some progress.  I've just had a look and I can see you are now working on s=
ome=20
comments from Maria and Tales.  I've requested to be notified on new posts =
to=20
that merge request so I hope to review your next update when available.

As soon as you resolve issues and feel comfortable with sharing your work,=
=20
please submit your changes to the igt-dev list to give them a try on our CI=
=20
system.

Thanks,
Janusz

>=20
> Cheers,
> --
> Isabella Basso
>=20
> > Thanks,
> > Janusz
> >=20
> >=20
>=20
>=20




