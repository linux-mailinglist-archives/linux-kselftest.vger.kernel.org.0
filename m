Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6609465349
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 17:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhLAQuP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 11:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhLAQuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 11:50:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D6C061574;
        Wed,  1 Dec 2021 08:46:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z6so18162146plk.6;
        Wed, 01 Dec 2021 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9iMR0CBR7MPcGZbowNZD3xNWW/iUgu7zwEMN81p5js=;
        b=jMRV0wsVPZIW6OEbb6hXpefzBZ0V0KHQo49RJDrJKlMu/xzDDqBxDRPNX4NbaJBUPL
         bv3xp8WqpGi+wlW/km8mda9bQxjfPh1P6BYcMqrCnNxnLYg0P2YgYO5evPSsgDBGESV5
         WDuUBUllOleYwxX0NXEGeT1Y9Wzxcv6SFmV74a2Ju2jaBZuToyZZEc0UrIPdiKM1YvR+
         9Fm5aDxg5tM9gYy0FTdf6ZtxvyXDInD9HlSQe+nwuD4fNGbNf5Edp7gDHd6R19zMSle+
         zN7e/vGb81iJkZMdAFJjQu04h2U3M8izjDnbGSxjOndsZpKRCPKMyY+p4/se9Zau9eU1
         XYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a9iMR0CBR7MPcGZbowNZD3xNWW/iUgu7zwEMN81p5js=;
        b=wd1v/m/ahbXSJiIXgApUveSEZ/2fLmOPpzeqGZt+Kc5b3kCs+QyJ1acWnhQi1B/y3a
         +xxs0aq3W9dMIfb9M6eLKupI8YjGEUt+yAxHuSM69rjAqScZxHJiyIZTbvviZK+hkXNN
         ep4vyfBK5cYC6J625bVW0vSaolBKjEP+xSg8TlGyaT5hyEiUKHWggKSzADrYovVYZjI+
         Hybz1mcbVS7nEbqW+hsIfjJo4ba9NgQqfvQF1f8J2ttmFaAgNV+RCRCJtDvLS84sfL6f
         SGin7ccyYxUl2swWQm97eSqjSpTVCsJuN0aJ1Ol/qiNprMSUaH5rlQGPWwgmZF5npHC0
         Uzjw==
X-Gm-Message-State: AOAM531UYvGD1NZG126Hzff3aTockRCId11uVS5+QkLuogFvixbCIJVK
        hGTN4eQv2OIHYVWBw7488/Y=
X-Google-Smtp-Source: ABdhPJxoiw70W4VTrln44U83WGe94uAslV8rzljRLVtivhMvFXKNEOJ709s7r0hic1IfqhE2edYt2Q==
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id 2-20020a170902c20200b001422441aa25mr8787470pll.68.1638377212665;
        Wed, 01 Dec 2021 08:46:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p10sm316442pff.173.2021.12.01.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:46:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 06:46:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <Yaem+r/YZ9BNXv9R@slm.duckdns.org>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Tue, Nov 30, 2021 at 10:56:34PM -0500, Waiman Long wrote:
> > What happens if an isolated domain becomes invalid and then valid again due
> > to cpu hotplug? Does it go "root invalid" and then back to "isolated"?
>
> Yes, the current code allow recovering from an invalid state. In this
> particular case, the transition will be "isolated" --> "root invalid" -->
> "isolated".

Wouldn't it be clearer if it became "isolated invalid"?

> > While it isn't necessarily tied to this series, it's a big no-no to restrict
> > what a parent can do depending on what its descendants are doing. A cgroup
> > higher up in the hierarchy should be able to change configuration however it
> > sees fit as deligation breaks down otherwise.
> > 
> > Maybe you can argue that cpuset is special and shouldn't be subject to such
> > convention but I can't see strong enough justifications especially given
> > that most of these restrictions can be broken by hotplug operations anyway
> > and thus need code to handle those situations.
> 
> These are all pre-existing restrictions before the introduction of
> partition. These are checks done in validate_change(). I am just saying out
> loud the existing behavior. If you think that needs to be changed, I am fine
> with that. However, it will be a separate patch as it is not a behavior that
> is introduced by this series.

I see. It looks more problematic now with the addtion of the state
transition error reporting, more possible state transitions and, well,
actual documentation.

> Once an invalid partition is changed to "member", there is no way for a
> child invalid partition root to recover and become valid again. There is why
> I force them to become "member" also. I am OK if you believe it is better to
> keep them in the invalid state forever until we explicitly changed them to
> "member" eventually.

That's because we don't allow turning a cgroup with descendants into a
partition, right?

So, when we were first adding the partition support, the thinking was that
as it's pretty niche anyway, we can take some aberrations and restrictions,
but I don't think it's a good direction to be building up on top of those
like this and would much prefer to clean up the rules and restrictions. I
know that this has been going on for quite a while and am sorry that am
coming back to the same issue repeatedly which isn't necessarily caused by
the proposed change. What do you think?

Thanks.

-- 
tejun
