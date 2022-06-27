Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7355C3AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiF0TKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiF0TKd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 15:10:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003B5597;
        Mon, 27 Jun 2022 12:10:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so10310355pjv.3;
        Mon, 27 Jun 2022 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/TJYBcpsxpHM1dgljke9KHv7g4SupUF3o95Sw1aZ2ck=;
        b=IUrCqExbfNSEqdj1+aclN5lVCX6iP7eBPxz3UnA29I42X7w8qUJC0d2QFa6lECfvHS
         lTMdErf6FACs1/hyp38L86tGz+o787pLf2VIheb7iIKAGcJlc9+ImxpPc6dZHKPr2Lnd
         297Swn9MhvVXOe5pLyL9hyobmlUtJUylIgtVuWFNUy7M/cvy0Ei9a+7/6RNLP/vuaWpm
         qPXLfyJ7VkpxIpiy0dSvQGEwS2wO1IikzptCMphwHEF+yGlRha2BCj6vVKJloizO0jzV
         wtWURRXun0tZKmoLu2aju0/0SznVwcWbO33ww6x17xU68Xd6vEBZdnna3JSmuqObPHbN
         196g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/TJYBcpsxpHM1dgljke9KHv7g4SupUF3o95Sw1aZ2ck=;
        b=IMOxxCH+3YW5q69QljDGHjGdATj/9ipfgW8YCq9jPRqEyKqBRh2RZXFh4D7ZsUEVfT
         mzyE2c4HHjZRyqIbUedzt1hnDzWumsvZ+nLG3+Sk/z0xcWNMzal8k1FLfXDcQnoHeIKl
         ILWXqMi+/qF5Wbcni0hFrj1L/19CjIzt39lLEcCfP8PfC01hO3DDcPajvIXh4/pDcDga
         6EsNtsdJOaojsCFXBewDrTw4w8ViVOiRXUqN/RAi5JStChLWQHyqii4df9+DRv5dzjMh
         LKUvfXKhMiBz2PyciB+RSaywmCZCkwZ6DeoS/bqambujl3RFc+c8KYEAbumVLkh3K+qX
         uxqQ==
X-Gm-Message-State: AJIora91OBj6bihYl7CPX5A7XSvvfFZyAdfauZt6Awu7PWCc9g02kP2J
        0C8f7S8c2PRRSttO0AzNRnY=
X-Google-Smtp-Source: AGRyM1v4pZPlgtYqoeaDHgmUszlXO0IEON1F8nITnkj9iOAgcw3+OR56oHGI6Qm3c0Gt8vy7rjuFZw==
X-Received: by 2002:a17:902:bc4c:b0:16a:4849:ddbe with SMTP id t12-20020a170902bc4c00b0016a4849ddbemr816273plz.25.1656357031911;
        Mon, 27 Jun 2022 12:10:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4120])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090aae0500b001ec4f258028sm7805995pjq.55.2022.06.27.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:10:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 28 Jun 2022 04:10:29 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
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
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YroApRMPV/6zO5I8@mtj.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
 <YqdzuSQuAeiPXQvy@slm.duckdns.org>
 <20220613175548.GB21665@blackbody.suse.cz>
 <Yqd7WMFj6AEyV3Cy@slm.duckdns.org>
 <20220614115345.GA6771@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220614115345.GA6771@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Tue, Jun 14, 2022 at 01:53:45PM +0200, Michal Koutný wrote:
> On Mon, Jun 13, 2022 at 08:00:56AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > Yeah, I don't know why this part is different from any other errors that the
> > parent can make.
> 
> It's different because a write to parent's cpuset.cpus is independent of
> whether cpuset.cpus of its children are exclusive or not.
> In an extreme case the children may be non-exclusive
> 
>     parent	cpuset.cpus=0-3 //   valid partition
>     `- child_1	cpuset.cpus=0-1	// invalid partition
>     `- child_2	cpuset.cpus=1-2 // invalid partition
> 
> but the parent can still be a valid partition (thanks to cpu no. 3 in
> the example above).
> 
> Do I miss anything?

What I'm trying to say is that cpuset.cpus of child_1 and child_2 are
owned by the parent, so a feature which blocks siblings from
intersecting each other doesn't make whole lot of sense because all
those files are under the control of the parent who would have the
power to enable or disable the restrition anyway.

The partition mode file is owned by the parent too, right? So, all
these are to be configured by the same entity and the errors can be
reported the same way, no?

Thanks.

-- 
tejun
