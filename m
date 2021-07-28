Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC03D9337
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhG1Q2E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhG1Q2D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627489681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVx/5yrmyZbbRVeN3LD+d66Q2FozCvKMMwaCU5JpwKA=;
        b=C8TkkbLtJNQFJzm7vuOth01N1hoMg0o0Hs8+2dm7BpdaI8dOJqXNDhrEA3SBMadh7Jwh/W
        lPwIwRsPDZSA32snFj1Bcb9EEFYnZKf0h78flfT2UnWWzerOSoKlOUmmgKM5TXw/JDZkc8
        RwAXJ7aDIw2Oj6fYt/TdD2tgTxNPJqE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-VVFEAaYnNdCZ2mk1d4xayA-1; Wed, 28 Jul 2021 12:28:00 -0400
X-MC-Unique: VVFEAaYnNdCZ2mk1d4xayA-1
Received: by mail-qt1-f197.google.com with SMTP id z16-20020ac87cb00000b029025bf786be09so1285557qtv.20
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jul 2021 09:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oVx/5yrmyZbbRVeN3LD+d66Q2FozCvKMMwaCU5JpwKA=;
        b=eKGNVa2Fe5yX1FKrQXrq3J28AnQc/yv3224vPUCmRlAZPMrlMJL95RISuEG+KjZGtb
         z2F3QdYYCB8oDFplfd47jrN4kAOIqG8DaGFvhajrjofeTurEIOraN0qDUSMOqBzgOWT2
         8whfaytuUDsN2qhlvAcY5km4TBbVq3rsHRyUfS+XcvyHH3jq3hYpCCMuSXvO3NjFEfZj
         cPOBgNJv3iBQrMpneJP7vlDz+9jJf+WLPVBOgwOLEv8Ywc2UkE66i+8ee2hVPKCCfq/F
         dYbMUDNFPLx8gs+NqPI8atrGqz+d8Y68F4V8U3g01BFDThcBs58SAKKbQ8Qq+ARns/T+
         PxVg==
X-Gm-Message-State: AOAM5307UgFuTQ7JijZ1aJ1fMlEY64VTqrMAJLWjkQ0TSXbmjwakimRM
        yY9korwkXIin1x2CDb/IJ02hVjRzqOcsECj7enA/b3aACZuYeCtY1Amb2X9WKhsDUuYXa4Sy1ao
        2S7WRDa/GvKp5pxyrbBOEZZpfAeRe
X-Received: by 2002:a37:9244:: with SMTP id u65mr520015qkd.46.1627489680044;
        Wed, 28 Jul 2021 09:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZRqP37sqJcrPzK/iLTHBFFo1TykeaKOBzeN4NCV6nY6od2hic7g0uzGrV0SdRcBpcBj9h2w==
X-Received: by 2002:a37:9244:: with SMTP id u65mr519993qkd.46.1627489679827;
        Wed, 28 Jul 2021 09:27:59 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id p13sm236018qkk.87.2021.07.28.09.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:27:59 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 6/9] cgroup/cpuset: Add a new isolated cpus.partition
 type
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-7-longman@redhat.com>
 <20210728160900.GA8905@blackbody.suse.cz>
Message-ID: <f1afbd9e-d16b-c972-c3c0-022a05cec2a6@redhat.com>
Date:   Wed, 28 Jul 2021 12:27:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728160900.GA8905@blackbody.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/21 12:09 PM, Michal Koutný wrote:
> Hello Waiman.
>
> On Tue, Jul 20, 2021 at 10:18:31AM -0400, Waiman Long <longman@redhat.com> wrote:
>> @@ -2026,6 +2036,22 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>> [...]
>> +	} else if (old_prs && new_prs) {
> If an isolated root partition becomes invalid (new_prs == PRS_ERROR)...
>
>> +		/*
>> +		 * A change in load balance state only, no change in cpumasks.
>> +		 */
>> +		update_flag(CS_SCHED_LOAD_BALANCE, cs, (new_prs != PRS_ISOLATED));
> ...this seems to erase information about CS_SCHED_LOAD_BALANCE zeroness.
>
> IOW, if there's an isolated partition that becomes invalid and later
> valid again (a cpu is (re)added), it will be a normal root partition
> without the requested isolation, which is IMO undesired.
>
> I may have overlooked something in broader context but it seems to me
> the invalidity should be saved independently of the root/isolated type.

PRS_ERROR cannot be passed to update_prstate(). For this patchset, 
PRS_ERROR can only be set by changes in hotplug. The current design will 
maintain the set flag (CS_SCHED_LOAD_BALANCE) and use it to decide to 
switch back to PRS_ENABLED or PRS_ISOLATED when the cpus are available 
again.

Cheers,
Longman

