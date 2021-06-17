Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99953AA92D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 04:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhFQC4A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 22:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhFQC4A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 22:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623898432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yS1nM3ylxqu4LGWweeetnOJWhjHjFKRHgCRdFTmCJkE=;
        b=LWnI/2P1mWWpHcVVXlmMG6CZx5uMMQsX4C7mMkT7wbJrHDB5hLUxtEozVwEVi9cLiV31kb
        6triXbuKTG8jop3lH//iMvtvckh2Ofsml0ktiol6e/BzgJXsl67qQahFaftYWLZgWqIzJQ
        BQlIj6drWeh0dGWeQ4FD6erz9nc3JR4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192--xp6MqmROYq7JzgWAfW_wA-1; Wed, 16 Jun 2021 22:53:51 -0400
X-MC-Unique: -xp6MqmROYq7JzgWAfW_wA-1
Received: by mail-wr1-f69.google.com with SMTP id n4-20020a5d42040000b0290119fef97609so2253474wrq.18
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 19:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yS1nM3ylxqu4LGWweeetnOJWhjHjFKRHgCRdFTmCJkE=;
        b=Yss3bP8KjfFtbNVfvwlEf4OwGODm9W03Ey083Me2XgdUMIAf+i+YwNgiwmzczrcuzo
         vxJgTlh6HPhVCFJ1z6/j3bEjDTNbmQ6+DwlzWExT70ZvsRJZnzViZYJ16EmhA8rY/P7F
         Ey/xkrC00LtL9o/KkZxzJcDkLnOy4tZOpbHkDDhKa/jD1vdCPjbfwQrN690v8ltCDQgq
         BABs4ARmsOQmKYuPD2ase+e3Awy4SJxQdVDI0XA0ChPprjm4wOX0xinZlDYcER1rgJoT
         YpKrh6PFyWh7gMGj6hUI+KsjTaYChgOSek0LxI7kQkLFkhmPlH63L4mLkyBj/ScLrSVn
         h2Pg==
X-Gm-Message-State: AOAM531DNdXTPCZLukaM87BZDtwle7v4P3EALIL5R+JJpmNyLel695St
        7lXlD51E6aJaVwRdV+yOK8jn0+LKN5ENgt7uQ3zNaeYbaADQgbJVeuYxD1JTP9EPLM8R0vaar0J
        PY3j0MlUYqpjYXsHZfhicurKOKdl9
X-Received: by 2002:a7b:c446:: with SMTP id l6mr583734wmi.171.1623898430205;
        Wed, 16 Jun 2021 19:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycogHw1ABakuf4er+UbRreN9lkhiUZ8wnSoK8E3G9KFZOhpUS4fGgk6OHwkh2KfEcm5Rr5Lw==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr583714wmi.171.1623898430048;
        Wed, 16 Jun 2021 19:53:50 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n12sm3783427wrw.83.2021.06.16.19.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 19:53:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/5] cgroup/cpuset: Don't call validate_change() for some
 flag changes
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
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-2-longman@redhat.com>
 <YMphhLAzmRRyD+cm@slm.duckdns.org>
Message-ID: <4e4da272-ae34-4ff8-18bc-253e9c14a14c@redhat.com>
Date:   Wed, 16 Jun 2021 22:53:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMphhLAzmRRyD+cm@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/16/21 4:39 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jun 03, 2021 at 05:24:12PM -0400, Waiman Long wrote:
>> The update_flag() is called with one flag bit change and without change
>> in the various cpumasks in the cpuset. Moreover, not all changes in the
>> flag bits are validated in validate_change().  In particular, the load
>> balance flag and the two spread flags are not checked there. So there
>> is no point in calling validate_change() if those flag bits change.
> The fact that it's escaping validation conditionally from caller side is
> bothersome given that the idea is to have self-contained verifier to ensure
> correctness. I'd prefer to make the validation more complete and optimized
> (ie. detect or keep track of what changed) if really necessary rather than
> escaping partially because certain conditions aren't checked.

Thanks for the comments.

You are right. I will leave out this patch. Anyway, the rests of the 
patchset don't have a strict dependency on it.

Cheers,
Longman

