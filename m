Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD93D810C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 23:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhG0VOc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 17:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232140AbhG0VOb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 17:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627420471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTTYyPAE0g/if8d0gvKRc9AYw/duV58RDsVIEQdGHsg=;
        b=MmkBaBOuV1AUKpXcAGXaLo/TeoW4gQqCDymf0l637stY7WqPGA86SYbuh+wtcQ7hpYt7MT
        hUTp6iLOSanU7p/9clCUsJ64XRMc4aaHAO4uHlGU6ffxKiELIorxd9ypOLe7sYtp8sfOpx
        n04zqWTT+p13i3Tbjb2ksU5G5lD4PYQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-aBTB7hVeOfWBWBp75FxQbg-1; Tue, 27 Jul 2021 17:14:29 -0400
X-MC-Unique: aBTB7hVeOfWBWBp75FxQbg-1
Received: by mail-qv1-f70.google.com with SMTP id r14-20020a0c8d0e0000b02902e82df307f0so534362qvb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jul 2021 14:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HTTYyPAE0g/if8d0gvKRc9AYw/duV58RDsVIEQdGHsg=;
        b=K4u26JQdIBdEkRRBGhnHevFzzp792G+6ZqbsOiuwTrxuKl9VKmuMnY4I2tlM8HzDAH
         YEPIhZHISY4c9SjZ3TZ0KkrvZBTpYzyQCColEyr3a7UxFTQNsHvd/upCe9BmVcsBgibK
         QR3vkZIMsf/tpdpNSWR1+vgD0tPUd9QFOPW8qd48snWKRPCw5TvM5fgHpGF+etCeM1ho
         fL5ZvKQBk8RGO2/kYvpbgihO32GprhXZBq4opZSwwWIzBbwWsdHYvBF9l3vYEfBLWBaQ
         FmJCbGwLIo2U2TkghMZEQnlhqPwI3KNF7J3mxyFiUenvkiq7grWgGQ1lfbrNLeyoLrS5
         Y2+Q==
X-Gm-Message-State: AOAM533t+R7r/4JCM9c11q/R8UNC0eWUXwvsxlCDOBkJ6YvBY+wFZNw3
        bQGcap+lHWQJjHYxgCtYS0Xl8oq8hHbOCB9gXW9rt2If2wcZXUyz9InQLThljhIWt2c58KfFT/p
        m9QBzn/wnGw0rIHZoZeGYlnxNMlqy
X-Received: by 2002:ae9:f30e:: with SMTP id p14mr4710204qkg.412.1627420469420;
        Tue, 27 Jul 2021 14:14:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz21PRLExOooxNoN1eIO3l2I/Tqj7X6DVLfqcyC+i2GacI9azNipKAbtqXgsR/XOpGArUqZBQ==
X-Received: by 2002:ae9:f30e:: with SMTP id p14mr4710180qkg.412.1627420469234;
        Tue, 27 Jul 2021 14:14:29 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id p22sm1908465qtq.64.2021.07.27.14.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 14:14:28 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/9] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
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
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210720141834.10624-1-longman@redhat.com>
 <YP9ChFvrGrDMGzbe@slm.duckdns.org>
Message-ID: <b2f49b2e-d5a4-1504-bd0c-0bd82943d855@redhat.com>
Date:   Tue, 27 Jul 2021 17:14:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP9ChFvrGrDMGzbe@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/26/21 7:17 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, Jul 20, 2021 at 10:18:25AM -0400, Waiman Long wrote:
>> v3:
>>   - Add two new patches (patches 2 & 3) to fix bugs found during the
>>     testing process.
>>   - Add a new patch to enable inotify event notification when partition
>>     become invalid.
>>   - Add a test to test event notification when partition become invalid.
> I applied parts of the series. I think there was a bit of miscommunication.
> I meant that we should use the invalid state as the only way to indicate
> errors as long as the error state is something which can be reached through
> hot unplug or other uncontrollable changes, and require users to monitor the
> state transitions for confirmation and error handling.

Yes, that is the point of adding the event notification patch.

In the current code, direct write to cpuset.cpus.partition are strictly 
controlled and invalid transitions are rejected. However, changes to 
cpuset.cpus that do not break the cpu exclusivity rule or cpu hot plug 
may cause a partition to changed to invalid. What is currently done in 
this patchset is to add extra guards to reject those cpuset.cpus change 
that cause the partition to become invalid since changes that break cpu 
exclusivity rule will be rejected anyway. I can leave out those extra 
guards and allow those invalid cpuset.cpus change to go forward and 
change the partition to invalid instead if this is what you want.

However, if we have a complicated partition setup with multiple child 
partitions. Invalid cpuset.cpus change in a parent partition will cause 
all the child partitions to become invalid too. That is the scenario 
that I don't want to happen inadvertently. Alternatively, we can 
restrict those invalid changes if a child partition exist and let it 
pass through and make it invalid if it is a standalone partition.

Please let me know which approach do you want me to take.

Cheers,
Longman



