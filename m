Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C833B5EB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhF1NJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 09:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233103AbhF1NJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 09:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624885615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wsog/UA6NQRm36wrbUHXM3ftcSt/9+OFEW6vcsabAY=;
        b=cMRbEXfqxUMVSeJ2YUMlPgYrjVgPuyjmXWOiXWb5aHBee5QRvLzQNt+g4XdhyxSJj8Facf
        TOlcHiCfXZy96xcc8487RUSy18/wEiCOEYYTW6NYYkBdx91kWN/v+jy1kB3D+17c5QCipj
        NGBHmqADMO7jL0gtPUaIf1scd9OwFB0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-g5qpmq9sOPy8aKYUksQWfA-1; Mon, 28 Jun 2021 09:06:53 -0400
X-MC-Unique: g5qpmq9sOPy8aKYUksQWfA-1
Received: by mail-qv1-f70.google.com with SMTP id g14-20020ad4510e0000b02902890eb69b5aso5540864qvp.21
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3Wsog/UA6NQRm36wrbUHXM3ftcSt/9+OFEW6vcsabAY=;
        b=oiN50EH+cOHh+K56yEKoUda0FURCPEpX1EJ3tnzEbAaw3v42Cpyu+lcjjNtEqhNmxi
         2mnNE48bBUA4DmZ5WZ/gaWHDORkv69vPzJsb9T85SumHmm3rj9G09/del8wMGDv07ibq
         eZ8VfEV43BxI161OLFvtFYYVOlpQftR1SYs82YVeQV0Omyhaa7JUgMCLpCMSdDlV72+M
         ajlpSIVuyJBZ37tlobNOZU2joQSe4J7hp4bdwfkYU+EG4M5SKXnw/6ttgQEJMGbW4S80
         EZ4He6cSN3OKYsT83RWPbNEFEtJHyxJVKlzrpyEmsjlQcrMJxot5+tZbT5uXOdI/RNVw
         NCAw==
X-Gm-Message-State: AOAM532vKKbHeLG3n97R+JxO/9t+LH1PqcwNwnSlQ3bBHOz1tmpyd8gl
        whsAVHIfFEMm0UJ5Fu7WNWW4YtXlT5pw2QypavHQDWn25MzJz4qYT1x/RWomTGNXBIC+FgWf8M8
        srzYcovMuNkV9y1uJBhKnerSHjMqx
X-Received: by 2002:a37:9986:: with SMTP id b128mr25711688qke.485.1624885612616;
        Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUlJHxYKkE1I0xN1vBM5amAltWfY9ckZGLT37Njz1aTkLclF02YuG2OEJBVFBBcLl/BywiTA==
X-Received: by 2002:a37:9986:: with SMTP id b128mr25711669qke.485.1624885612428;
        Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h128sm10222579qkc.94.2021.06.28.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:06:51 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
Message-ID: <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
Date:   Mon, 28 Jun 2021 09:06:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNcHOe3o//pIiByh@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/26/21 6:53 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Jun 21, 2021 at 02:49:20PM -0400, Waiman Long wrote:
>>   1) A partition root can't be changed to member if it has child partition
>>      roots.
>>   2) Removing CPUs from cpuset.cpus that causes it to become invalid is
>>      not allowed.
> I'm not a fan of this approach. No matter what we have to be able to handle
> CPU removals which are user-iniated operations anyway, so I don't see why
> we're adding a different way of handling a different set of operations. Just
> handle them the same?

The main reason for doing this is because normal cpuset control file 
actions are under the direct control of the cpuset code. So it is up to 
us to decide whether to grant it or deny it. Hotplug, on the other hand, 
is not under the control of cpuset code. It can't deny a hotplug 
operation. This is the main reason why the partition root error state 
was added in the first place.

Normally, users can set cpuset.cpus to whatever value they want even 
though they are not actually granted. However, turning on partition root 
is under more strict control. You can't turn on partition root if the 
CPUs requested cannot actually be granted. The problem with setting the 
state to just partition error is that users may not be aware that the 
partition creation operation fails.  We can't assume all users will do 
the proper error checking. I would rather let them know the operation 
fails rather than relying on them doing the proper check afterward.

Yes, I agree that it is a different philosophy than the original cpuset 
code, but I thought one reason of doing cgroup v2 is to simplify the 
interface and make it a bit more erorr-proof. Since partition root 
creation is a relatively rare operation, we can afford to make it more 
strict than the other operations.

Cheers,
Longman

