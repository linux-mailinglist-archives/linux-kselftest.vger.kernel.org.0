Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE19C3FA128
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 23:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhH0V2g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhH0V2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 17:28:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71EC0613D9;
        Fri, 27 Aug 2021 14:27:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k24so6956953pgh.8;
        Fri, 27 Aug 2021 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rpHtTbp15HJh/ptbaGOZzKJv8NxAlmEFpkpJjglISck=;
        b=qybuEzO+6JTEALszutJES4QgB8s8ZfxvsPEDS5dKp4GuFf2drQOyt8uKwBrHhGx0SB
         R2BhAabUOtNe2U7JJceKd9zQwXKD7u1IAh1cG1TJZWQubnZ2szfDc9B5qYYtMY1AhotR
         LtppI2dvm4dNOacvJ+26YW0fOTtVXYyPCHWMqH14BdgZ5nqo2hxSJcwQtQETZNdJbjJ3
         cFWbwlcSrehlJphrGoOcJo8eo48Mxjb7gMBrgZDDhqc76JodkK9PwijKZpqYLiN/wv7p
         b48QkJBv/n1wysZ/o2lbJ2CztKr3d9IwKbgbDPAL7t/2FzD3EN6zWkcVZHVLIdid9nEX
         6vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rpHtTbp15HJh/ptbaGOZzKJv8NxAlmEFpkpJjglISck=;
        b=Vv6UaMylbaQnKG6SwxnetIKVjtQ7NkMEcc7I+enQJ0p5+lw87JradjHlCf0t8ZKxFD
         /rmyGnRfzCmH6XDMAl4cpwLskDbV9mqhcwKnqizXh2BDyAr/IwdMUFOsAKa98VLJkr6x
         +tnzDG5WH3/nt/7ljh3D7nU2Kze2Kn2WTvzIo17fqMxzDha6hHsCKyCT2Jq94YoW3nkm
         BFQOX0V5cbAN/YnCKg/G/ve0hn073wS+liqtXVXvt7E4TQe2vBc8YWgMbC2KvV4AEVrR
         ONiafa/mO3nwVq8OhUXM0elCMDdyCYVtvk09rR7Ol1tl36iVnOHIkqfIECUMHJzanCyu
         pGVw==
X-Gm-Message-State: AOAM533uzTRXMDq5owfxD+miQHZvzYXGpClEfWUXVEltL+zUJDBmPrZp
        SHfMMAyEmvytblQoxZ7Uhe0=
X-Google-Smtp-Source: ABdhPJxQBn594lxRsCn5MmX28sihnOF3tWTEyNMqRzoJJqG2Qp6te4ezL6RmZDqxpsnUlJetM8VXHA==
X-Received: by 2002:a65:6287:: with SMTP id f7mr9479799pgv.444.1630099666286;
        Fri, 27 Aug 2021 14:27:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x13sm7290038pjh.30.2021.08.27.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 14:27:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Aug 2021 11:27:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YSlY0H/qeXQIGOfk@slm.duckdns.org>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com>
 <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Fri, Aug 27, 2021 at 05:19:31PM -0400, Waiman Long wrote:
> Well, that is a valid point. The cpus may have been offlined when a
> partition is being created. I can certainly relent on this check in forming
> a partition. IOW, cpus_allowed can contain some or all offline cpus and a
> valid (some are online) or invalid (all are offline) partition can be
> formed. I can also allow an invalid child partition to be formed with an
> invalid parent partition. However, the cpu exclusivity rules will still
> apply.
> 
> Other than that, do you envision any other circumstances where we should
> allow an invalid partition to be formed?

Now that most restrictions are removed from configuration side, just go all
the way? Given that the user must check the status afterwards anyway, I
don't see technical or even usability reasons for leaving some pieces
behind. Going all the way would be easier to use too - bang in the target
config and read the resulting state to reliably find out why a partition
isn't valid, especially if we list *all* the reasons so that the user can
tell whether the configuration is as intended immediately.

Thanks.

-- 
tejun
