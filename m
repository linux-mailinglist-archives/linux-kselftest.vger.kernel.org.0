Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631A0B555F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfIQScw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 14:32:52 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:26589 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfIQScw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 14:32:52 -0400
IronPort-SDR: fo2tBWupeJ1358pLhuf1Uq9jiDlTX/ZwbVx1w7EWKXSGNABBbIT24OrhP4rvPGyw7HZZAb8Eq1
 BND0FX/5WSeihyp9VPHC1boSQg9moPrA4K1/vVKmcMsBSXFM7lIzPD6d19aao44GMZPmFHNIDa
 6+0E1d/mWahOB9QBP+GKbVy1nMah144JZZNheC8wkdT0gUXe1HF7T6d67xEUsmNEotQPV4Kxwt
 3FwfXbwyuiTR+Y03UKXwoMHjubVSHAhic7p6HwNAC5ONxytMLRFScZrm383nik1asZf06ZxL2s
 ZNE=
X-IronPort-AV: E=Sophos;i="5.64,517,1559548800"; 
   d="scan'208";a="43244354"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 17 Sep 2019 10:32:50 -0800
IronPort-SDR: 2LXmIcWQgDFW845Q6YPBGMkuk9fl6htXrlBKexNeFo9VUhq6ua1tzpJfGh2M9o5EpisZdMBxlp
 JyfD74Cb/3mdKMq87ktahwmCTLglPwkR72zdcwD4xTYfpuNWiEO3MxJaFZOX0YipdhqC/4LEyf
 OlHtB7MJzp8R1bWSqBXk2rC2a4t/8D+gx0OjlEQWkT/4XQ9EhcmcrG6VFxOT8M2zLW3aHCWY88
 9zfH14srd4KdP4lfcaNmD7fOxuLDcIPA81Ge9dwqGyzv8L6Ezoe4spTLg8Y+NZI9dEFJ04rSg8
 Aeo=
Date:   Tue, 17 Sep 2019 14:32:47 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
Message-ID: <20190917183246.GB15686@mam-gdavis-lt>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
 <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
 <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
 <374127ff-d06f-fcc3-d317-5614dfdc5a71@kernel.org>
 <20190917175056.GA24224@vmlxhi-102.adit-jv.com>
 <2ede1d4d-fa52-2100-2725-1ae32e62a5b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ede1d4d-fa52-2100-2725-1ae32e62a5b6@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Shuah,

On Tue, Sep 17, 2019 at 12:05:06PM -0600, shuah wrote:
> On 9/17/19 11:50 AM, Eugeniu Rosca wrote:
> >On Tue, Sep 17, 2019 at 11:44:45AM -0600, shuah wrote:
> >>On 9/17/19 10:54 AM, Eugeniu Rosca wrote:
> >>>Shuah,
> >>>
> >>>On Tue, Sep 17, 2019 at 09:25:31AM -0600, shuah wrote:
> >>>
> >>>[..]
> >>>
> >>>>I want two patches and the first one with
> >>>>Fixes tag.
> >>>
> >>
> >>These two patches need to be separate. The first one is a fix and
> >>the second is an enhancement.
> >
> >That was exactly the idea of v1.
> >
> >>
> >>Please send two patches - the first one with Fixes tag.
> >
> >Can you please pick [v1] series from below:
> >  - https://patchwork.kernel.org/patch/11136283/
> >  - https://patchwork.kernel.org/patch/11136285/
> >
> >with adding a one-liner Fixes tag to the first patch?
> >
> 
> Please send v2 with Fixes tag on the first one and making the changes
> I suggested on that v1 series.

I'll submit v3 series with the requested changes.

Thanks!

> 
> thanks,
> -- Shuah

-- 
Regards,
George
