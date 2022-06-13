Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80D547DCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 05:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiFMDEX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 23:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiFMDEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 23:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590615FFF
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Jun 2022 20:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655089460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0JU6u7vHZ6SvfZIROd4EtKu4qFIwPLVf15Wl39hmo0=;
        b=KxrgwSmT7WS8VFdgYJ7Ha85LK/oS78IwW0UULmJ8cGYzkKjmgqh88s6pe9RuLDXfgNCF/K
        r/mPWykCADsVIiSP+U2hqEp14FRuXwvPAWNbe698df1/Ocr24MUP+IfDryFiZqtj4jTHQy
        wNEMwIzw5crDoJ//w6OKUXQa3Nm5eb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-arB-8VpdMqKwfkM8I74vdA-1; Sun, 12 Jun 2022 23:04:15 -0400
X-MC-Unique: arB-8VpdMqKwfkM8I74vdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDC5D85A582;
        Mon, 13 Jun 2022 03:04:14 +0000 (UTC)
Received: from [10.22.16.100] (unknown [10.22.16.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C04F1415103;
        Mon, 13 Jun 2022 03:04:14 +0000 (UTC)
Message-ID: <ec20a9f9-1236-b9dc-8380-d735df2685b9@redhat.com>
Date:   Sun, 12 Jun 2022 23:04:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 3/8] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Content-Language: en-US
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
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
 <YqYlCRywdgSYtwKk@slm.duckdns.org> <YqYlOQjKtQCBsQuT@slm.duckdns.org>
 <ce3106c1-a3c4-b449-bafc-6940d672bd94@redhat.com>
 <YqanEZZooeZwtutA@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqanEZZooeZwtutA@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/12/22 22:55, Tejun Heo wrote:
> On Sun, Jun 12, 2022 at 10:53:53PM -0400, Waiman Long wrote:
>> Without this patch, cpus.effective will never be empty. It just falls back
>> to its parent if it becomes empty. Now with an empty cpus.effective, I am
> Yeah, that part is fine.
>
>> afraid that if a task is somehow moved to such a cpuset, something bad may
>> happen. So I add this check as a safeguard.
> But how would that happen? A lot of other things would break too if that
> were to happen.

I will perform further check to see if this check is necessary.

Thanks,
Longman

