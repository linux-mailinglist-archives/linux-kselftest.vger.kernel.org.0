Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16F4652ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 17:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhLAQm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 11:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhLAQm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 11:42:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8285FC061574;
        Wed,  1 Dec 2021 08:39:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq11so18430509pjb.3;
        Wed, 01 Dec 2021 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1EkC39adlEEsimMF8WAtkbLkh0JLAwJ99PUzWQZRq4M=;
        b=S4K6E60fowwK12pVSXDSezUToCQTbvMryZ9jCQjZdt8YBwTBgNsYvIktXGYED/SMI3
         VgJF3XTd8qW6MKe9OMmyat1BHCQiLqnkvcPtTavJrnjPTjO6h4yQ8goQdWB22s3zocqK
         Wl5E8OgrGvetUa6XHhgvfrYB+vbkzprmjM4Gs6VW1+5q5391x/rHz6T8kzBfnj9MHpc8
         hOVO7aI27QXPDn6ABgwCkknX8xtE+H4KWIbm9ae6e9+4ddYjSkRirXz6ZDYR+ylg0/9q
         g9MJbO+Gy1BPaqtpOKsrNe9CzPYLfINyLm/U/Hayo9rNcrY1urCnq00+/Vl+Z/Sl93bS
         nVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=1EkC39adlEEsimMF8WAtkbLkh0JLAwJ99PUzWQZRq4M=;
        b=glrF1TPqxEh579FXLqgcuS1E5TXEUvgI8p/+EXqeBn4s+zy0Fwxz2/NowGle64ven6
         fIblZaW/kvVZf3CMM1/+9WgWczSBFNoixPlsVBTAqwZTO5IWwU99KSpr29841GfJctUz
         7GBaBHyQqNGe1ZoV0tJ5+QKobK8bd6BBw73SIeROeOpV4iqxfloDtOmqjq3BRmrLjifw
         Z0VYbhHwUt2ezepVv8Au9YxfsAFsjemJ9NlFEe+eK+4n8xfBHZJLHETe24PgYBKJ9LH6
         a3ivV8bPZvm1pV+3FmkVNo56Oyc7FgBPgetrkRm+nnNoJVxRnpHwLO7LhdZbpb1sWJhl
         cHpA==
X-Gm-Message-State: AOAM530r/OsftmAqLxoQt3Amy+dG8yoiv07L5FOXJUiLpQ2s9XPKA9sz
        uFLBVVjSaLMDFFByykt653w=
X-Google-Smtp-Source: ABdhPJyNOPfPh8zj6bnvNceMnYfdsseo9B1V0hecoqWUwEoaGEAx0BGKmSABKZNaOG9F+xme3mz4Uw==
X-Received: by 2002:a17:903:4043:b0:142:4f21:6976 with SMTP id n3-20020a170903404300b001424f216976mr8767312pla.62.1638376776834;
        Wed, 01 Dec 2021 08:39:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g21sm358416pfc.95.2021.12.01.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:39:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 06:39:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
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
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YaelRiqWOIzT5uRs@slm.duckdns.org>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
 <20211201141350.GA54766@blackbody.suse.cz>
 <ec6e2b89-385a-fcc7-7cfa-7e9119fc34bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec6e2b89-385a-fcc7-7cfa-7e9119fc34bc@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 01, 2021 at 09:56:21AM -0500, Waiman Long wrote:
> Right, I shouldn't say corner cases. Having task in an intermediate
> partition is possible depending on event sequence. I am aware that there are
> code in the cpuset code to prevent that, but it didn't block all cases.
> > > A valid parent partition may distribute out all its CPUs to
> > >   its child partitions as long as there is no task associated with it.
> > Assuming there's always at least one kernel thread in the root cgroup
> > that can't be migrated anyway.]
> 
> I am aware of that. That is why I said root cgroup must have at least one
> cpu in its "cpuset.cpus.effective".

In that case, let's explicitly describe that condition.

Thanks.

-- 
tejun
