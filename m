Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF7532F36
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiEXQsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiEXQsO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 12:48:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B2766FB0;
        Tue, 24 May 2022 09:48:13 -0700 (PDT)
Date:   Tue, 24 May 2022 18:48:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653410891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+n2TeC63xBP9JcIIeIV1gUKizH+Y+lAFAohJMPfDSoc=;
        b=pWWP3msM6ICsdl2XG/L1Kk7BT7Kz8igPK9fm7BhaTk22EkNfv16BnjJoAQyz+zJeXVOELR
        apWDvp6IEgg7o0TFbKkX5MNz5iZejRxEhNuIxQYYyLkwTnIqFbU9+durOHCp/L+oAsdG8O
        OgI+/DmVASIjQzfRI4+Dj3/Uqc4zlxef5mz6JJpESBbbChHqhkhinOEcHq+9dS0tUW0E/V
        lR2X7/rzDxyj/BNc6FET/4tbz92+bDkY50fLTcuQ0RnlD6d1j2r9NTH0qbtzOz4JjvKkAH
        IiFjEvCplzzhF/dI1GRxCVyRGxNOUVKnPX4oF0trW5jZ/VK8ofUIEAGO98ID/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653410891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+n2TeC63xBP9JcIIeIV1gUKizH+Y+lAFAohJMPfDSoc=;
        b=7xRUXMgXMXv57nfU9kviAhVtxJ+a+EKZYQEc+3ccFWHfLVgToQy8lChbsT6TPS6uSYfdmk
        eKW1UWc6HbKj6VCA==
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
Message-ID: <Yo0MSnl/xowWz4PQ@linutronix.de>
References: <20220510153413.400020-1-longman@redhat.com>
 <Yoe7FOkZpUwwTTQW@linutronix.de>
 <75d31caf-2d26-9fcc-13fb-e8be2f2ad8e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75d31caf-2d26-9fcc-13fb-e8be2f2ad8e5@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-05-20 12:46:52 [-0400], Waiman Long wrote:
> On 5/20/22 12:00, Sebastian Andrzej Siewior wrote:
> > On 2022-05-10 11:34:05 [-0400], Waiman Long wrote:
> > > v11:
> > >   - Fix incorrect spacing in patch 7 and include documentation suggestions
> > >     by Michal.
> > >   - Move partition_is_populated() check to the last one in list of
> > >     conditions to be checked.
> > If I follow this correctly, then this is the latest version of the
> > isolcpus= replacement with cgroup's cpusets, correct?
> > 
> > Sebastian
> 
> It is just the beginning, there is still a lot of work to do before
> isolcpus= can be completely replaced.

Okay. Thanks.

> Cheers,
> Longman

Sebastian
