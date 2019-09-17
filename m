Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADCAB5585
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfIQSnv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 14:43:51 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:2259 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfIQSnv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:51 -0400
IronPort-SDR: HpQp4kH+OrAJ8CmQ902m8pSvzuR+fbwgUXLHLsJV6DpttlWCpJWZlRpnJwpnwtvICr1plRRlAq
 lMYtyV7yGiHBPbcAemjWEEs/x+Kvx+S3tymTr7L9KwGX/JXSWyd01PISTQ17+Uq/Jw/oNI7vqG
 h6MpFj5ATglqVPUOM53v48tewCP2TYoEUMk9ijG4kO5A9RnNi3ncbQ66uPSPIdJ+cFRRj5DZhJ
 YtNLcYC8KyeYoJKQpwOyhTstmQ60rzA7a7v/72cItS1Z98PSAtRoQf4SpLVC/8BfVBgjlKjcAp
 rWI=
X-IronPort-AV: E=Sophos;i="5.64,517,1559548800"; 
   d="scan'208";a="41445973"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 17 Sep 2019 10:43:50 -0800
IronPort-SDR: MBiaonLjv0RcrTAWRYQsw5i7MIRF0ReF2ZhHbczRbMjJxPlGsKbDpcDRlg7lXgWScIDkUPj0gZ
 1s+cNG09n838e1BRcPWW4RbWQ+VJXfTQPuW+02XYUFKJ/9KNMTcew9uGLVK0+X6nZDIlmW94iV
 Axl6e8ULT48xq7AhFOJP/6IjKB1RKK4qu/sz3rMk9yB9wDDGVShdcaX1bC/5wWHJhf+33BMpXq
 TDTnpmSb4/5/sSwsi9P2N2QrCtsGL1PaqSflteaxnSSHCZ8DFrmeeBewMImP8rgskUrznSgIy5
 Trw=
Date:   Tue, 17 Sep 2019 14:43:46 -0400
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
Message-ID: <20190917184345.GC15686@mam-gdavis-lt>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
 <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
 <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
 <374127ff-d06f-fcc3-d317-5614dfdc5a71@kernel.org>
 <20190917175056.GA24224@vmlxhi-102.adit-jv.com>
 <2ede1d4d-fa52-2100-2725-1ae32e62a5b6@kernel.org>
 <20190917183246.GB15686@mam-gdavis-lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190917183246.GB15686@mam-gdavis-lt>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 17, 2019 at 02:32:47PM -0400, George G. Davis wrote:
> Hello Shuah,
> 
> On Tue, Sep 17, 2019 at 12:05:06PM -0600, shuah wrote:
> > On 9/17/19 11:50 AM, Eugeniu Rosca wrote:
> > >On Tue, Sep 17, 2019 at 11:44:45AM -0600, shuah wrote:
> > >>On 9/17/19 10:54 AM, Eugeniu Rosca wrote:
> > >>>Shuah,
> > >>>
> > >>>On Tue, Sep 17, 2019 at 09:25:31AM -0600, shuah wrote:
> > >>>
> > >>>[..]
> > >>>
> > >>>>I want two patches and the first one with
> > >>>>Fixes tag.
> > >>>
> > >>
> > >>These two patches need to be separate. The first one is a fix and
> > >>the second is an enhancement.
> > >
> > >That was exactly the idea of v1.
> > >
> > >>
> > >>Please send two patches - the first one with Fixes tag.
> > >
> > >Can you please pick [v1] series from below:
> > >  - https://patchwork.kernel.org/patch/11136283/
> > >  - https://patchwork.kernel.org/patch/11136285/
> > >
> > >with adding a one-liner Fixes tag to the first patch?
> > >
> > 
> > Please send v2 with Fixes tag on the first one and making the changes
> > I suggested on that v1 series.
> 
> I'll submit v3 series with the requested changes.

Eugeniu has submitted v3 with requested changes.

Thanks!

> 
> Thanks!
> 
> > 
> > thanks,
> > -- Shuah
> 
> -- 
> Regards,
> George

-- 
Regards,
George
