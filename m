Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D159462862
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 00:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhK2Xkp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 18:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhK2Xkp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 18:40:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D88C061574;
        Mon, 29 Nov 2021 15:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73159B8164F;
        Mon, 29 Nov 2021 23:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F99C53FAD;
        Mon, 29 Nov 2021 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638229044;
        bh=AJzjOb0RLUniIeA3QowzZwfnvhx+8dP0y7m5Z2RHO5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYEX/wmJPSu+jpUXtHefHHuLbHhTLnzvZ1HUv4v89Fq136uc8dS5bXR/LYgTBVgh5
         dK/LgRt4e2lyV3s23Xq1GQOTQnhiIahYB3CWCbGme1R1Rioq6vmwM0feTpiCdzwG7F
         FXhDY7LGofNoToJiSbny5EYoUhe6nOJU4ewuBR9EH1jZEakiXcOttT8YV0YM85r3CQ
         em8FyvIqWisBo1rvlrxWMA+jq4NWHxaXVElliXXqM09Uumeamln93mkh1OFTEDnNse
         x89varzAVVS2mgxktfbBd9r6km18zd76T0+J3kD6dMGOwp7xeqARFGW1UT3Behd6wA
         e2XRRIxq2ysIg==
Date:   Tue, 30 Nov 2021 01:37:20 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v3 1/3] selftests: tpm2: Probe for available PCR bank
Message-ID: <YaVkMF8aKuef4K48@iki.fi>
References: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
 <20211125003827.1360432-2-stefanb@linux.vnet.ibm.com>
 <97ddf0f23592b74e7647e3c9b36b37553c594c82.camel@kernel.org>
 <2557c1e2-b0fa-8729-0eb0-6ae68ee6f653@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2557c1e2-b0fa-8729-0eb0-6ae68ee6f653@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 26, 2021 at 10:43:42PM -0500, Stefan Berger wrote:
> 
> On 11/26/21 19:29, Jarkko Sakkinen wrote:
> > On Wed, 2021-11-24 at 19:38 -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Probe for an available PCR bank to accommodate devices that do not have a
> > What does "probing for an vailable PCR bank" even mean?
> 
> Checking ? Testing ? What's the difference to those words?

This would an exact description:

"Some devices do not have SHA1 bank available. Try to use SHA256 as a
fallback when this occurs."

It does not leave any open territory what the patch does. It does exactly
this, not more or less.

/Jarkko

