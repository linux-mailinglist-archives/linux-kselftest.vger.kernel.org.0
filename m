Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C92614AC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 13:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKAMdf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAMde (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 08:33:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285FE3A;
        Tue,  1 Nov 2022 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667306013; x=1698842013;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPNf+FzQp/e3Et/6Wapw/U8UpkpopWkGTZenhVM/bIM=;
  b=mOUJOSV7Vhj4kZVJDWbgHqDILN8pBJQX7W+qMiZkLkmmMEXJBOjetZzw
   kl3TAj8QK8NYJKg5X/DCt70zMg+yuB5VlDPpCVkHN4PNCQa7cR6OVchO+
   dR3L6mZvDviCfAgXtXLvVEnzZYrmmEoQx2EBTm3PIlfTNjXbBvdeqLCt1
   SiVXPPElDPnU+BCEAMX5bVHUF+EBFz2rlS0Uq9uDo12jjQpP8Q6bB6hYi
   lTR1/LvIt9FHS09FPKJnf23XL1xFyfI+gIBN3xRGmH25BDwwxiECSgU5b
   jl4Z58L4v2f42lek/EZ/Oin69fhC77PboCBRkoG6IOdubu0T0BIqXaCIG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310832171"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="310832171"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 05:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="697384294"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="697384294"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2022 05:33:32 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.29.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1A5CF580B9D;
        Tue,  1 Nov 2022 05:33:26 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:33:23 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?UTF-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>, n@nfraprado.net,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com, igt-dev@lists.freedesktop.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Trevor Woerner <twoerner@gmail.com>
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
Message-ID: <20221101133323.72101670@maurocar-mobl2>
In-Reply-To: <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-4-isabbasso@riseup.net>
        <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com>
        <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Isabella,

On Mon, 19 Sep 2022 17:43:19 -0300
Isabella Basso <isabbasso@riseup.net> wrote:

> > Do you want to _require_ KUnit be built as a module, rather than built-=
in here? =20
>=20
> I=E2=80=99ll change the comment and the warning in v3 to clarify this.

When do you intend to submit v3?

Regards,
Mauro
