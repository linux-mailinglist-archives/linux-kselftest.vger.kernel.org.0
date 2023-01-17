Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363166E88E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 22:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjAQVi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 16:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjAQVgz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 16:36:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C537C59779;
        Tue, 17 Jan 2023 11:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DF5BB81A20;
        Tue, 17 Jan 2023 19:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC97DC433D2;
        Tue, 17 Jan 2023 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673985545;
        bh=nF3mX0FRh5dgfCx3CVH/H+twTc/Spc+GztkzKFwfJ0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EVYSaePle3s9HVyeSNst0WS+9A4ElwfjNRTUGzsRXGbUSGfyWJxPk1v4xjGZcM9KV
         buGSvhH3wHE9AXYl6CajZQ8Xo8Y2firfcqsbUHuOL02CqjmrdTMVeDzz22cx3Bqk+6
         yifdf9/Pt+whcGHQasn9YT2nWvDzqpgNOsJ3wefMo/2Bq7+d+89Via9SphmLhSUq7d
         NF3X2oMoE+bobemZwmoVO/SvG8S5l7ZUlmS1f9IJEtpPpMIY2MAErbWyQfA171+UzX
         cA9rhBT6wY3zS7TGlVyLRGZBvxb1T9VqS4b2kiIz2nOJcVxL7Kni35ENAQJ2l7jbcS
         2aJjSuxbudzoA==
Date:   Tue, 17 Jan 2023 13:59:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics 
        <aman1.gupta@samsung.com>
Cc:     'Shuah Khan' <skhan@linuxfoundation.org>,
        'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>,
        shradha.t@samsung.com, pankaj.dubey@samsung.com, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, shuah@kernel.org,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20230117195903.GA142672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003d01d919b2$3c7d54a0$b577fde0$@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 27, 2022 at 10:45:26AM +0530, Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics wrote:
> ...
> Thanks for review and suggestion. I understand that we would like to
> reuse and preserve the history of tools/pci/pcietest.c. So we have
> two approaches:
> 
> 1: Using git mv command move existing code from tools/pci/ to
> tools/testing/selftest/drivers/pci/ and then update the file to
> convert to kselftest framework. I thought about this but after
> movement, when we move it to kselftest format it is going to be huge
> churn and we will be having modification in almost all lines.
> 
> 2: Develop kselftest based driver in
> tools/testing/selftest/drivers/pci/ and eventually delete existing
> file from tools/pci/ folder providing justification in commit
> message.
> 
> From my viewpoint, going with the second approach makes more sense
> because if almost complete file is getting modified, and it will
> make the review process complex and anyways there is not much code
> reusability.
>
> Please let me know if you have any other thought
> process or if I am missing anything to understand your approach.

I vote for the first approach, with "git mv" and subsequent conversion
(in separate patches, of course).  If git knows about the move,
"git log --follow" will be useful even though the conversion will be a
big patch.  Adding a new test with the connection to the old one only
in the commit log makes more work for people who dig through the
history in the future.

Bjorn
