Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD161513B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 19:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKASEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiKASEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 14:04:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED8DB865;
        Tue,  1 Nov 2022 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667325840; x=1698861840;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIEmCpVfRRWPffZCKLWu7PxI+hb2qI36bvVulVYkRfE=;
  b=eHsvOA1tWPiruDLqRwiLbLzw3d2MIMfBMx4+gz0KrX+HWJ4M+6BSIVSV
   dDssiUITMASySwfD5SfUmHWLUzw3wphoLDvB6DGv8QiYrO3uk2DMBPA2K
   oiStP4Dcir6pKGginFsAzQSOxEigI7ygcHFYzELrdMKbrOo/bsVYY6/8f
   Q4ouWEFabQmk0lZkvxH1x9WMYSXTfF4pAaxuqkgEIPdi+YOAS9joOjoeU
   c4WqDslZtAmS/RlCnOBrsNePSsDeJFHZf++fL1WIFPmW1HwNBswQ/sifj
   uOG9y1W8VaTDnlbMzuoFOPFqyoJ4yM0SMLVsYxdEAYo9jzmDxQhaOWPU+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292512050"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292512050"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697492011"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="697492011"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2022 11:03:59 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.29.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 59319580AA7;
        Tue,  1 Nov 2022 11:03:53 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:03:49 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     David Gow <davidgow@google.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?UTF-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com, igt-dev@lists.freedesktop.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org, n@nfraprado.net,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?QW5k?= =?UTF-8?B?csOp?= Almeida 
        <andrealmeid@riseup.net>,
        KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
Message-ID: <20221101190349.4043db12@maurocar-mobl2>
In-Reply-To: <F263C946-123C-407F-984D-7AC284CC1B29@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-4-isabbasso@riseup.net>
        <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com>
        <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
        <20221101133323.72101670@maurocar-mobl2>
        <F263C946-123C-407F-984D-7AC284CC1B29@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 1 Nov 2022 14:17:26 -0300
Isabella Basso <isabbasso@riseup.net> wrote:

> Hi, Mauro,
>=20
> > Am 01/11/2022 um 9:33 AM schrieb Mauro Carvalho Chehab <mauro.chehab@li=
nux.intel.com>:
> >=20
> > Hi Isabella,
> >=20
> > On Mon, 19 Sep 2022 17:43:19 -0300
> > Isabella Basso <isabbasso@riseup.net> wrote:
> >  =20
> >>> Do you want to _require_ KUnit be built as a module, rather than buil=
t-in here?   =20
> >>=20
> >> I=E2=80=99ll change the comment and the warning in v3 to clarify this.=
 =20
> >=20
> > When do you intend to submit v3? =20
>=20
> I=E2=80=99m currently waiting for my peers to review some refactorings an=
d test
> things thoroughly. I hope to submit it in a week or two. Sorry it=E2=80=
=99s taking so
> long.

No problem. In the mean time, I'll try to do some tests with the current
version.

Btw, if you want, you can also check the RFC patch I submitted today, adding
KUnit support for i915:

	https://patchwork.freedesktop.org/patch/509448/?series=3D110384&rev=3D1

The tests there are hardware-independent, but they need to be built
using x86_64 arch, due to i915 dependencies.

Regards,
Mauro
