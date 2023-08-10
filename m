Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5797782C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHJVnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHJVnN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 17:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF112D44;
        Thu, 10 Aug 2023 14:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB6463AB5;
        Thu, 10 Aug 2023 21:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0062C433C8;
        Thu, 10 Aug 2023 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691703791;
        bh=5gfooN1WBDgyvFXuZxSLOiq5g3Z7icCet3KI5PB9gbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARaBNIhiB1lhQbxYjA0c8e78hYWMIBh9PTQ2W9BcCA/xx55IcPgYYcDuusRbrqkZD
         sLbpUho0+zjdh6E9dKlsebhS1r6ESCLfaqbrUpH8zbEo+eGoVqryQPDnYz97ka/wiu
         teuz9FVTJRC50QZK9J5iP3tuQEtyT4+BWwkMbIVcDZUb6tiQCNqVFEdjj7VK0OrBys
         gJBSL9Sg9NOSBq3MkaYrSy9ann6LW+Jx70SKyKwoQ6CtcjKJWw5pViRs7zNwmHHAtk
         +AVEB/7o4rTor3ooIyJzSrwS7a5S/+HG3jrwbNLB/uXWdPv3uu4fDo/eOeoVjKwwGB
         uLDDU6Sv2jqjw==
Received: (nullmailer pid 1316675 invoked by uid 1000);
        Thu, 10 Aug 2023 21:43:09 -0000
Date:   Thu, 10 Aug 2023 15:43:09 -0600
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
Message-ID: <20230810214309.GA1226583-robh@kernel.org>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810202413.1780286-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 04:23:49PM -0400, Nícolas F. R. A. Prado wrote:
> 
> Regressions that cause a device to no longer be probed by a driver can
> have a big impact on the platform's functionality, and despite being
> relatively common there isn't currently any generic test to detect them.
> As an example, bootrr [1] does test for device probe, but it requires
> defining the expected probed devices for each platform.
> 
> Given that the Devicetree already provides a static description of
> devices on the system, it is a good basis for building such a test on
> top.
> 
> This series introduces a test to catch regressions that prevent devices
> from probing.
> 
> Patch 1 introduces a script to parse the kernel source using Coccinelle
> and extract all compatibles that can be matched by a Devicetree node to
> a driver. Patch 2 adds a kselftest that walks over the Devicetree nodes
> on the current platform and compares the compatibles to the ones on the
> list, and on an ignore list, to point out devices that failed to be
> probed.
> 
> A compatible list is needed because not all compatibles that can show up
> in a Devicetree node can be used to match to a driver, for example the
> code for that compatible might use "OF_DECLARE" type macros and avoid
> the driver framework, or the node might be controlled by a driver that
> was bound to a different node.
> 
> An ignore list is needed for the few cases where it's common for a
> driver to match a device but not probe, like for the "simple-mfd"
> compatible, where the driver only probes if that compatible is the
> node's first compatible.
> 
> Even though there's already scripts/dtc/dt-extract-compatibles that does
> a similar job, it didn't seem to find all compatibles, returning ~3k,
> while Coccinelle found ~11k. Besides that, Coccinelle actually parses
> the C files, so it should be a more robust solution than relying on
> regexes.

I just sent a patch[1] last week fixing missing a bunch. I only looked 
at the change in count of undocumented (by schema) though.

In any case, I'm happy if we have a better solution, but really we 
should only have 1. So your script would need to replace the existing 
one.

I'd be interested in a performance comparison. IME, coccinelle is 
fairly slow. Slower is okay to a point though.

> 
> The reason for parsing the kernel source instead of relying on
> information exposed by the kernel at runtime (say, looking at modaliases
> or introducing some other mechanism), is to be able to catch issues
> where a config was renamed or a driver moved across configs, and the
> .config used by the kernel not updated accordingly. We need to parse the
> source to find all compatibles present in the kernel independent of the
> current config being run.

I've been down this route. I had another implementation using gdb to 
extract all of_device_id objects from a built kernel, but besides the 
build time, it was really slow.

Rob

[1] https://lore.kernel.org/all/20230804190130.1936566-1-robh@kernel.org/
