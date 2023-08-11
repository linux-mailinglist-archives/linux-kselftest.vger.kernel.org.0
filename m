Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17777791A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjHKORS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 10:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbjHKORO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 10:17:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACE2706;
        Fri, 11 Aug 2023 07:17:01 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1E446607247;
        Fri, 11 Aug 2023 15:16:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691763419;
        bh=NZlwVv6zfIFpXPe7gaVoJDJ6zhVLPAy87Kilc5JeT1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrTmanFGMYBw2UDSuTY+IFBMMkyHRoMJ4Nq+idLsIYKvBJclwmAhm4+iPptpQJN5A
         HqJWWCXHMBUEAwjVx2vQ3KYWPcSMgmvuOithi9eP1n+obhS2NXbfK04V3dzP/0CK3L
         ndZpjntTTim3BnDtAGhiFhzTb9zI2wQ4lNnmPH33ehV2wgLeMGZjqjuIvK4lbH3pW2
         5pGkeWPtynt5FAKQ1vC4kM+fucxNt3lzGK70ACvsrMRZzVYi+2lowmJFsYgb9ADxq6
         QOYOUb9nviBWASIbtoVKlVjg26LtbaOWNFxgER8Z+KqeB4HNIg8zVImwNthCIXU/mE
         nRwBpMHKqmO2Q==
Date:   Fri, 11 Aug 2023 10:16:52 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cocci@inria.fr,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernelci@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kselftest: Add Devicetree unprobed devices test
Message-ID: <b4b1f56b-94c0-4849-a7fc-9228b4e40dc7@notapiano>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
 <20230810202413.1780286-3-nfraprado@collabora.com>
 <ZNY9sBgzrEQVVQT+@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNY9sBgzrEQVVQT+@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 02:54:56PM +0100, Mark Brown wrote:
> On Thu, Aug 10, 2023 at 04:23:51PM -0400, Nícolas F. R. A. Prado wrote:
> > Introduce a new kselftest to detect devices that were declared in the
> > Devicetree, and are expected to be probed by a driver, but weren't.
> > 
> > The test uses two lists: a list of compatibles that can match a
> > Devicetree device to a driver, and a list of compatibles that should be
> > ignored. The first is automatically generated from a script that parses
> > the kernel source using Coccinelle, and will be run as part of building
> > this test, therefore Coccinelle is a build-time dependency for this
> > test. The list of compatibles to ignore is a hand-crafted list to
> > capture the few exceptions of compatibles that are expected to match a
> > driver but not be bound to it.
> 
> This doesn't appear to produce KTAP output which is going to make it
> less useful for generic kselftest runners.

Right, I'm going to need to rewrite it in C for that, but since I already had
the shell script done, I decided to send it as is for the RFC, since I wanted to
get feedback on the general approach more than anything.

Thanks,
Nícolas
