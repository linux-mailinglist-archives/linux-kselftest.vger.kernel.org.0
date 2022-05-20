Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7322A52EFDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbiETQAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiETQAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 12:00:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15C1737C5;
        Fri, 20 May 2022 09:00:23 -0700 (PDT)
Date:   Fri, 20 May 2022 18:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653062422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnj4dzgEf3cd0cUpRb4wWF+QnX5ehgnowPWFeUo5Y30=;
        b=Ra3XXBiASrR10Ub71lzV9nlJu0F8um3RH3J8in7Y5LS0d/jE7qREr9dqxxRSOY9TNovqLc
        XkE3+aifCs1zi93TJCiHojm4aml8uKnMBoyACDljhGuMPzDrSbEgFNZEgxOftfCa/IVIUn
        sxGgIO6O8QblEbwt8afnoDZpOGoHlVUn7a349OYjmM7hsXtekfGV3TRCztLhVxdgRrVH21
        Kj21RBHRBcG35GttKuy18nJ3Rcuc5hXME+OCtyd5x8dX2yMezAsAbfNL2/pjyonSfUGGam
        X/a49Re1oO5bHf5YSxq92bpnR9eaJxE7hAleI92KFqMsVntCtAChf7Kq5vrO9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653062422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnj4dzgEf3cd0cUpRb4wWF+QnX5ehgnowPWFeUo5Y30=;
        b=QDJEvVCEWunHzQI08pOSsVL88R4XX2kv96ohHXzjnjq7VKbDiG+klRveqr+8XPXu5qzicb
        YZfGzniaXjMpTkDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v11 0/8] cgroup/cpuset: cpu partition code enhancements
Message-ID: <Yoe7FOkZpUwwTTQW@linutronix.de>
References: <20220510153413.400020-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510153413.400020-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-05-10 11:34:05 [-0400], Waiman Long wrote:
> v11:
>  - Fix incorrect spacing in patch 7 and include documentation suggestions
>    by Michal.
>  - Move partition_is_populated() check to the last one in list of
>    conditions to be checked.

If I follow this correctly, then this is the latest version of the
isolcpus= replacement with cgroup's cpusets, correct?

Sebastian
