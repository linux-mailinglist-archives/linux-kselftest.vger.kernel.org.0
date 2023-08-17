Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5677FBE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353573AbjHQQSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353583AbjHQQRs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 12:17:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D5273F;
        Thu, 17 Aug 2023 09:17:47 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A709E660721F;
        Thu, 17 Aug 2023 17:17:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692289065;
        bh=0Uqouu18aJtJnWmk5w1rhn0/Y7zubvIQmjLGUoT/VeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcbQo2iJTz/mX0oydHhXWpkB7ja3aNjvDZTn6MV8Afmqo1NdCJQfz5D7Px1PwD9LB
         fxUuk8DkCNO6T7/q4PZI10igZRKtZknAj2oFVpIGPqOHQS+mGq13EbXiXMxnoNS5xv
         56DvNJAvjXl2QY4gxT19+6Esoeb8HGRq7QqXH948q8dDJurnvcE1G/OmXjDnsb9ZeJ
         axAQWy8LN0EhiceR2ydjizQ+KpLzhiE+USqkn0ooKDh7vfEulK6FhyEkro14DXAiBQ
         oRBSK+lpHW7zABYCb72an3YoAWoD5wjrPABmBpECjMmrO2XbkNqgMyPaZoL4zLYGwP
         CkG77/opLodqw==
Date:   Thu, 17 Aug 2023 12:17:38 -0400
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
Message-ID: <439f66c9-8dc1-40d0-ae36-fb8beee5a6f1@notapiano>
References: <20230810202413.1780286-1-nfraprado@collabora.com>
 <20230810202413.1780286-3-nfraprado@collabora.com>
 <ZNY9sBgzrEQVVQT+@finisterre.sirena.org.uk>
 <b4b1f56b-94c0-4849-a7fc-9228b4e40dc7@notapiano>
 <117448a6-671e-4f30-90c6-808a319caf32@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <117448a6-671e-4f30-90c6-808a319caf32@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 01:26:05PM +0100, Mark Brown wrote:
> On Fri, Aug 11, 2023 at 10:16:52AM -0400, Nícolas F. R. A. Prado wrote:
> > On Fri, Aug 11, 2023 at 02:54:56PM +0100, Mark Brown wrote:
> 
> > > This doesn't appear to produce KTAP output which is going to make it
> > > less useful for generic kselftest runners.
> 
> > Right, I'm going to need to rewrite it in C for that, but since I already had
> > the shell script done, I decided to send it as is for the RFC, since I wanted to
> > get feedback on the general approach more than anything.
> 
> I'm not clear why KTAP would require C?

When going through the documentation there was only mention of the C headers for
the kselftest framework which outputs using the KTAP format, so I thought that
was the only acceptable option.

But in the meantime while looking through the other tests I saw you've recently
added ktap output to ftrace/ftracetest. The newly added test in
net/mptcp/mptcp_lib.sh also has its own helpers for outputting in KTAP. There
are also a couple other cases of this in python.

So I can definitely do the same for this test.

Thanks,
Nícolas
