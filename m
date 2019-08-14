Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2758CC5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHNHQ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 03:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfHNHQ7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 03:16:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066412054F;
        Wed, 14 Aug 2019 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565767018;
        bh=XDAYAIHKx15cbm4MLaeL2uyl4aIQnIOMeL1b9sGwwNE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BivEU2xIZL82EeTgEkm0YeMoEaLJDpoEO7a2zS5hiA9cs3kvwHPeOwoR5hLAFoCSs
         QN7vT/TulxQAdD2w0+cnf1mdxQEv+C8FQSllITsMUv0YH0f9tH2JKqFwShfbEex0li
         PW40DSG+Nh81h9qArVWE/xPTvIfUmbeV1PbKJ/WE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814055108.214253-10-brendanhiggins@google.com>
References: <20190814055108.214253-1-brendanhiggins@google.com> <20190814055108.214253-10-brendanhiggins@google.com>
Subject: Re: [PATCH v13 09/18] kunit: test: add support for test abort
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 00:16:57 -0700
Message-Id: <20190814071658.066412054F@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Brendan Higgins (2019-08-13 22:50:59)
> Add support for aborting/bailing out of test cases, which is needed for
> implementing assertions.
>=20
> An assertion is like an expectation, but bails out of the test case
> early if the assertion is not met. The idea with assertions is that you
> use them to state all the preconditions for your test. Logically
> speaking, these are the premises of the test case, so if a premise isn't
> true, there is no point in continuing the test case because there are no
> conclusions that can be drawn without the premises. Whereas, the
> expectation is the thing you are trying to prove.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

