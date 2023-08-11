Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0D779098
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHKNRt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHKNRs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 09:17:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E869F26A0;
        Fri, 11 Aug 2023 06:17:47 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BAECC6607247;
        Fri, 11 Aug 2023 14:17:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691759866;
        bh=L9YasLlSzK5k+C3DoxCi9Qs1i1/Jfe91wWSnXZpz0PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4gr2y6+v6uvPxZoRsge8aKFNhLdLxOvlD+Nyb0Owsm+ZmjXzxtJng++00GSR5n9V
         /m/PLS6ePwLcciNzJ5wpB3S2uswrBqqGL/4pDvU9X93VY/ycDYBNV0SsAolwuzPIGw
         EQ68F86OpAxnVwNn8BSTadCBTnSbKssPYSJNrmPbWsTgfuQoE2Dy35Epxuk0q81R+3
         uetDCzkip61SSNIRcqNlqz/p+S7P/ad0LPIloe/2yCQGZWMRmQ1ONdE8YLQtbK4kh+
         /iKdm0VQsSaaIZDaN0rKQLkICv6ACqAyS7yLbTxpblm0xO3xBpaKWurorPfF7ILOTt
         Aas1zU6hflC5g==
Date:   Fri, 11 Aug 2023 09:17:40 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <7e915b52-c356-4a39-b286-27b31fa1abf9@notapiano>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
 <20230810214309.GA1226583-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810214309.GA1226583-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Ah, looks like I mixed up the output from the dt-extract-compatibles script and
the output from the make dt_compatible_check. The python script does list
practically (*) all compatibles that Coccinelle found. So I'll look into
extending it for the purposes of this test next.

(*) it misses 3 compatibles in .h files, and fsl,mpc5200-gpt-gpio because the
comment above it has ';'. Those are easy to fix though, either on the regex or
on the driver's code.

> 
> In any case, I'm happy if we have a better solution, but really we 
> should only have 1. So your script would need to replace the existing 
> one.

Agreed.

> 
> I'd be interested in a performance comparison. IME, coccinelle is 
> fairly slow. Slower is okay to a point though.

Yes, Coccinelle seems to be quite a bit slower. I can provide a comparison after
I've tweaked the python script to get the same matches as Coccinelle so it is a
fair comparison.

> 
> > 
> > The reason for parsing the kernel source instead of relying on
> > information exposed by the kernel at runtime (say, looking at modaliases
> > or introducing some other mechanism), is to be able to catch issues
> > where a config was renamed or a driver moved across configs, and the
> > .config used by the kernel not updated accordingly. We need to parse the
> > source to find all compatibles present in the kernel independent of the
> > current config being run.
> 
> I've been down this route. I had another implementation using gdb to 
> extract all of_device_id objects from a built kernel, but besides the 
> build time, it was really slow.

Interesting to know, that's another option that I'd considered.

Thanks,
Nícolas
