Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751097782F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjHJVzF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHJVy6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 17:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243462D4F;
        Thu, 10 Aug 2023 14:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A19DB66966;
        Thu, 10 Aug 2023 21:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A17CC433C7;
        Thu, 10 Aug 2023 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691704496;
        bh=LKd+4Ea4HCc6qzOyCezsC0/UcrPbS4S07GBHDZkZ1oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pifn18Yu5ypIOo15CTwZwrMGt2/uGXQeVBRDuy7SXkmxTJ2DXc9M5Qc9Awv1/Oo+r
         NLZKWHWNSh33/MU1zynCRI7cRh0cW4ZWTDyYUHihzDS3O8DEnh+1XMB9+4ndA/DY0w
         t15aacXpbNRvVNqbuTd6K8jF9uJunzunn74PApf01w47FcJBJkUhTIcuM03uHoTvqX
         2vN/nxeOwBpClcEbiJE48E6/DuY5pctgzOOvfCSk1zPsij3aYYJP8AekO9HUsHebfB
         NwXcTCQpkFpKXaxO5xe05r5pCTH7l5ife1Rjthj4kDcNPJrly03fUUcErsKRyKtJOs
         ccyh4ngx4R58Q==
Received: (nullmailer pid 1346033 invoked by uid 1000);
        Thu, 10 Aug 2023 21:54:53 -0000
Date:   Thu, 10 Aug 2023 15:54:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cocci@inria.fr,
        Mark Brown <broonie@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernelci@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add a test to catch unprobed Devicetree devices
Message-ID: <20230810215453.GA1341305-robh@kernel.org>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
 <20230810214309.GA1226583-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810214309.GA1226583-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 03:43:09PM -0600, Rob Herring wrote:
> On Thu, Aug 10, 2023 at 04:23:49PM -0400, Nícolas F. R. A. Prado wrote:
> > 
> > Regressions that cause a device to no longer be probed by a driver can
> > have a big impact on the platform's functionality, and despite being
> > relatively common there isn't currently any generic test to detect them.
> > As an example, bootrr [1] does test for device probe, but it requires
> > defining the expected probed devices for each platform.
> > 
> > Given that the Devicetree already provides a static description of
> > devices on the system, it is a good basis for building such a test on
> > top.
> > 
> > This series introduces a test to catch regressions that prevent devices
> > from probing.
> > 
> > Patch 1 introduces a script to parse the kernel source using Coccinelle
> > and extract all compatibles that can be matched by a Devicetree node to
> > a driver. Patch 2 adds a kselftest that walks over the Devicetree nodes
> > on the current platform and compares the compatibles to the ones on the
> > list, and on an ignore list, to point out devices that failed to be
> > probed.
> > 
> > A compatible list is needed because not all compatibles that can show up
> > in a Devicetree node can be used to match to a driver, for example the
> > code for that compatible might use "OF_DECLARE" type macros and avoid
> > the driver framework, or the node might be controlled by a driver that
> > was bound to a different node.
> > 
> > An ignore list is needed for the few cases where it's common for a
> > driver to match a device but not probe, like for the "simple-mfd"
> > compatible, where the driver only probes if that compatible is the
> > node's first compatible.
> > 
> > Even though there's already scripts/dtc/dt-extract-compatibles that does
> > a similar job, it didn't seem to find all compatibles, returning ~3k,
> > while Coccinelle found ~11k. Besides that, Coccinelle actually parses
> > the C files, so it should be a more robust solution than relying on
> > regexes.
> 
> I just sent a patch[1] last week fixing missing a bunch. I only looked 
> at the change in count of undocumented (by schema) though.

With the existing script, I get 11761 compatibles and 12916 with my fix. 
So how are you getting only 3k?

Rob
