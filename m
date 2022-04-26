Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0072550EE52
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 03:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiDZB5K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 21:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiDZB5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 21:57:10 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51929120D04;
        Mon, 25 Apr 2022 18:54:04 -0700 (PDT)
Date:   Mon, 25 Apr 2022 18:53:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650938042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZsy6ZebabS1TsQcaFiZ0sPD2AjyXhLmbrTmljIpUeA=;
        b=Pi1rV36/KmttICAXEd0fKT1KpBXiMySRUBxxWjE2+dRPpMgGjZlxHRKt6LrkdEU97QrkS+
        S5iwFooeG+o4SgYZ1oWAlxvXobVWlOqWdlLqCkA1vu08s6FEvumTymbGTVXfQD6X7IHluN
        OORjBvR/DN+bY8gxVyu3IwOtj9fkjFA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/4] selftests: cgroup: return -errno from
 cg_read()/cg_write() on failure
Message-ID: <YmdQrql2rSMwjmY4@carbon>
References: <20220425190040.2475377-1-yosryahmed@google.com>
 <20220425190040.2475377-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425190040.2475377-3-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 25, 2022 at 07:00:38PM +0000, Yosry Ahmed wrote:
> Currently, cg_read()/cg_write() returns 0 on success and -1 on failure.
> Modify them to return the -errno on failure.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
