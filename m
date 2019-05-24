Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9913229CAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEXREq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 13:04:46 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59553 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXREq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 13:04:46 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CDCFCC0007;
        Fri, 24 May 2019 17:04:42 +0000 (UTC)
Date:   Fri, 24 May 2019 19:04:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: about selftests/rtc test related stuff
Message-ID: <20190524170442.GE3274@piout.net>
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
 <20190523174739.GY3274@piout.net>
 <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
 <20190523225219.GZ3274@piout.net>
 <CAG=yYwkhy5wTRywr5QUmGVQOED3EGQC8jFSCSj---TJfoyEhpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwkhy5wTRywr5QUmGVQOED3EGQC8jFSCSj---TJfoyEhpw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/05/2019 19:23:57+0530, Jeffrin Thalakkottoor wrote:
> On Fri, May 24, 2019 at 4:22 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > I just sent a fix for that timeout issue.
> 
> anyway thanks related to that
> shall i  send a selftest fix that bail out in the test program  if the
> user does not have root privileges ?
> 

No, it bails out just fine.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
