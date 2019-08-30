Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFFA3E7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 21:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfH3Tgy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 15:36:54 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:29797 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3Tgx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 15:36:53 -0400
IronPort-SDR: 9XRUpL6POJ3guwgFLWvXc32MrZEBskSfug1c7r564rLdpuiu0M4pyj54hgMBBN63VcJT5yzj1x
 xvgm54247oRyEWBPP17bOzMm5HvYUPe/VlHx8jr7ugPOee0ZCRKCCY6FozLiKF23MHmG9S3jTF
 54aeLf0wiLwuyBu4XZsai9ougkFTRgP1Eenh5CiGHFwQPNghWvPPPTPu2MZ70gGRmLuylfdZOI
 uN9nsFcPB6DYjzpOc5H7YtpItinEOCjX2AMkDDyPzkrynFtB5Wj8yt8TnCYhhc/NkVmYx6/yV4
 A90=
X-IronPort-AV: E=Sophos;i="5.64,447,1559548800"; 
   d="scan'208";a="40925959"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 30 Aug 2019 11:36:52 -0800
IronPort-SDR: x9jmDXOb2huxvuogOxVMMFlFqpqxWcsM/2Nbjb5tz4ACyOcVQUu2MiamtbLUerGlhUlbeXDvAt
 bXwrLkvIH+4WYud5npzQvkzUCif9gcEDVVtsDqbGjFbKxeEI/M9ZeS+SppIrQig5VzJ5jsusbi
 SeBfAcSZvMdeNe2kP7uoydcfPiYOZGNetRJd1D8MgwI0ti/FLij2VloCtlkBdblimUoxNgCea2
 SGEzMpOjPWF0GfH5TiDG8NZZFew7PJ0gBkmgTq6YCVhlinXfntEJSn3ucjwmaDUjsGZKcZ8Kpc
 6lA=
Date:   Fri, 30 Aug 2019 15:36:49 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     shuah <shuah@kernel.org>
CC:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v2] selftests: watchdog: Add optional file argument
Message-ID: <20190830193648.GE23419@mam-gdavis-lt>
References: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
 <197ee603-6ea7-a3c8-6b62-e3ba95433053@kernel.org>
 <20190830161320.GD23419@mam-gdavis-lt>
 <ff4527a1-3b94-9b4a-b785-507eb861379c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff4527a1-3b94-9b4a-b785-507eb861379c@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 30, 2019 at 10:20:23AM -0600, shuah wrote:
> On 8/30/19 10:13 AM, George G. Davis wrote:
> >On Fri, Aug 30, 2019 at 09:12:10AM -0600, shuah wrote:
> >>Can you split this line into two printf's. Checkpatch doesn't like
> >>it.
> >>
> >Sure, I'll add the following interdiff in v3:
> 
> Thanks. This is what I am looking for. Please send v3 with thsi change.

Done.

> >>On a separate note, I wish this usage block uses \t instead of spacing
> >>things out.
> >
> >I noticed that most of those lines are hard spaced with only one using tabs.
> >To remain consistent with existing CodingStyle, I used hard spaces.
> >
> 
> yes. My comment about using "\t" can be done later and if you would like
> to send for that patch, I will be happy to take it.

I'll send that along in a separate thread.

Thanks!

-- 
Regards,
George
