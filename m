Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA59780E98
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351927AbjHRPJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377971AbjHRPJE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 11:09:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0EE5F;
        Fri, 18 Aug 2023 08:09:02 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F84A660724E;
        Fri, 18 Aug 2023 16:08:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692371341;
        bh=mhdojlCbmeEU7uCj6+adG3ogY7i8gXwpuCCoPvyHEk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF+ggUAG96t74cPQvxQ7IRVH+/ZTDlYjKL9esEnrKF/6O3C6IWWX2L2fmKOqVwA+h
         xO0b8m3PjTKxo8ySeW19TSs3ZBbQh94oSLZ6gMZV5TeYG/ga+n1DzX4wAGFV34O05D
         MeQeLppnmA4INaiRKUpKWR+HGetn7IgOYwxPCak5fHhMYVoKAz7VR68lRmHPUUowhV
         oCpdXt1gS5RctrtksIuLTNor45m8oScdWRPvG2AR0CbanCY+pp1URzJrNMOagULp4R
         9w2wn6fqn+r4OY1FPxq+T9KIHw+HjYaZYutjAKOJedFqowPNdWiy0QrPQdvoi/XNYL
         Q9XxJ5k/rjmBQ==
Date:   Fri, 18 Aug 2023 11:08:55 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, kernelci@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <bdd6da06-d790-42c1-a5ea-372d38bf0ea7@notapiano>
References: <20230817233635.2306377-1-nfraprado@collabora.com>
 <20230817233635.2306377-4-nfraprado@collabora.com>
 <69848238-17d8-4b87-8bc1-474cae127410@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69848238-17d8-4b87-8bc1-474cae127410@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 01:54:21PM +0100, Mark Brown wrote:
> On Thu, Aug 17, 2023 at 07:35:27PM -0400, Nícolas F. R. A. Prado wrote:
> 
> > --- /dev/null
> > +++ b/tools/testing/selftests/dt/ktap_helpers.sh
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (c) 2023 Collabora Ltd
> > +#
> > +# Helpers for outputting in KTAP format
> > +#
> 
> These look generic so could be at the top level kselftest directory in
> case any other tests want to use them?

Yes, they're generic. And sure, we can move it up. The tests using it will need
to source it at run-time, so we can either update the kselftest Makefile to
always copy this helper when installing, or each test's Makefile can
make its own copy during build.

> 
> The test itself looks good in so far as I can read shell.

Thanks for the feedback!

Thanks,
Nícolas
