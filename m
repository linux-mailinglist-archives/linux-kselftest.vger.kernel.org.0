Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9612B8CC8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfHNHTB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 03:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfHNHTB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 03:19:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2312084F;
        Wed, 14 Aug 2019 07:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565767140;
        bh=CgAKQPDJ39jdFLM0nBvPd2yB9ynIfZDmD15ru0dJ7Os=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xaHZ0IYch7m/jbb9TEOjTqeFLiP9rjxW2XvyKLTklDuQ9VCWvHmVQLVD1vQiu2rnn
         cOw3uwlSbmBaV+/CauuBCa6G8Ycn0SjO7DHdkifs3BC5XJgnHS80jI2+9Un3NHt0B8
         RdlAMWFb7XoCTlu2ZRn/MyMMRRqi3LC5q4DnDaVA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814055108.214253-15-brendanhiggins@google.com>
References: <20190814055108.214253-1-brendanhiggins@google.com> <20190814055108.214253-15-brendanhiggins@google.com>
Subject: Re: [PATCH v13 14/18] kunit: defconfig: add defconfigs for building KUnit tests
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
Date:   Wed, 14 Aug 2019 00:18:59 -0700
Message-Id: <20190814071859.EB2312084F@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Brendan Higgins (2019-08-13 22:51:04)
> Add defconfig for UML and a fragment that can be used to configure other
> architectures for building KUnit tests. Add option to kunit_tool to use
> a defconfig to create the kunitconfig.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

