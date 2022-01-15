Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECA48F7A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jan 2022 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiAOPxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jan 2022 10:53:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35398 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAOPxe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jan 2022 10:53:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE8F6B8006F;
        Sat, 15 Jan 2022 15:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6BCC36AE3;
        Sat, 15 Jan 2022 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642262011;
        bh=CQ43lEVH8ZetR7NTPpgbsvWBH22zBadFcZwit9Bw41o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gseP8eznSGwRdUWSSanFYmBQpVtZjbjb3BDatzEwZt7ZFEtIyvMM+yAEK+umHFf/D
         OFyUZGZKKBRehAW24eLWAVoeRaGnHyoL+B1M7HxFQ/7pay6NvhlhazHgZW9sB5NEJb
         zvKqY7WebAqitwvo6lua0jpvWhTIzU68oQncIWOy8MOocO39UXaEgi9xF6IsoUTlee
         i/lNZfLYYjIaQGqwNK82JUHm+SaRrchBIiXHDd/h0RFPZ/0mpIT5LWgck/mE3g+F/2
         te7QWsTUKhi7bn+pbAB/TEl2yW5O/fDbWCaP7JICJ6z+TNUhz7MiWP4+7q8ac4UNJT
         aQ0M6Og2go0oA==
Date:   Sat, 15 Jan 2022 17:53:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v4 1/2] selftests: tpm2: Determine available PCR bank
Message-ID: <YeLt7hbm6aIMeWBE@iki.fi>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
 <YaVkw5dnCewnFybR@iki.fi>
 <eaad369c-f02e-8d83-94b1-fdac7ae84388@linux.ibm.com>
 <1e3b1e6f-6600-d77f-843b-f3d60e062192@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e3b1e6f-6600-d77f-843b-f3d60e062192@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 13, 2022 at 01:04:03PM -0500, Stefan Berger wrote:
> Jarkko,
> 
>   can you take this patch 1/2?
> 
>  https://lore.kernel.org/lkml/20211128041052.1395504-1-stefanb@linux.vnet.ibm.com/T/#m21209a978c237368499ce5f082f3c0fc03bcbbeb
> 
>   Stefan

Oops. Sorry, I missed your request at 23rd.

Yes, we can for sure take that. I now tested by with SHA256 only
configuration so:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

I'm considering 5.17-rc2 pull rquest but want to leave the final
decision to the time when it can be sent. If I'll make rc2 PR in
the first place, I'll include this to the pull request.

/Jarkko
