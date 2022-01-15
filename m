Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B242D48F81F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jan 2022 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiAORCw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jan 2022 12:02:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52722 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiAORCt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jan 2022 12:02:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20FA660E98;
        Sat, 15 Jan 2022 17:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08339C36AEA;
        Sat, 15 Jan 2022 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642266168;
        bh=lbcKM5IskQWWFzlg/kckGAMSE3TDu0u/GgkckYbyE9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWkO1fSTwWIB5yIp5wZtkwR3dsraY1y1zumsLrKc6uxe+Di0Q177JbPUQyG7fopnB
         4zioVHKPIJ0DkOVzIjCrRFMkwX/OrC1jp8BR9ahAQONHqTXFARqp6SfHf9bS9GnIcH
         MofqRFVMoxBNR9VzRSmZA6YI35sgYgODxxgsfosva5QUsWB/33H23aWHndxsNJqAyA
         HBZ7h6OpSpM8AFQGW5q26hzaFEorRtfDVzzJXabB9ansjDOg77k/gTyHJfh2G3dour
         NUIl0OgH3mSGDsykF0T/jO4rErq+h6tNLrP414v7pobDteRdgossCn5cFSvWAcvUIn
         CNjTMYXCLo5AQ==
Date:   Sat, 15 Jan 2022 19:02:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v4 1/2] selftests: tpm2: Determine available PCR bank
Message-ID: <YeL+K9lQAwEyw4c7@iki.fi>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
 <YaVkw5dnCewnFybR@iki.fi>
 <eaad369c-f02e-8d83-94b1-fdac7ae84388@linux.ibm.com>
 <1e3b1e6f-6600-d77f-843b-f3d60e062192@linux.ibm.com>
 <YeLt7hbm6aIMeWBE@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeLt7hbm6aIMeWBE@iki.fi>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 15, 2022 at 05:53:18PM +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 13, 2022 at 01:04:03PM -0500, Stefan Berger wrote:
> > Jarkko,
> > 
> >   can you take this patch 1/2?
> > 
> >  https://lore.kernel.org/lkml/20211128041052.1395504-1-stefanb@linux.vnet.ibm.com/T/#m21209a978c237368499ce5f082f3c0fc03bcbbeb
> > 
> >   Stefan
> 
> Oops. Sorry, I missed your request at 23rd.
> 
> Yes, we can for sure take that. I now tested by with SHA256 only
> configuration so:
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I'm considering 5.17-rc2 pull rquest but want to leave the final
> decision to the time when it can be sent. If I'll make rc2 PR in
> the first place, I'll include this to the pull request.

OK, it's now applied, thank you.

BR, Jarkko
