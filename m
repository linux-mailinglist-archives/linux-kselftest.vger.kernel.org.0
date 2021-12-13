Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5D473652
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 22:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhLMVAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 16:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhLMVAT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 16:00:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68499C061574;
        Mon, 13 Dec 2021 13:00:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so12034203plr.11;
        Mon, 13 Dec 2021 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WMxjO0tx6t02AbcQby54NPy8RyK3yOypDjZIab8vXh4=;
        b=f9xizRMo/j3PXqOZs5juMJcQ37RJ5hWQLM+DY21WpJeu9oIwrszgkESzp+5lzfcPu/
         S1xClURBIc1R5ZVu5ZUI/+iUkArHUMLGwuCCKqUaRzYwg5Avh7YpSAokVvTPS2Fl4yej
         QEpPj8HkBkveAgjGp1Uwvd74RkiIpvriZ0fL7nvbYk0KnZrMlg7CSDEyu3KP1tz1BuDs
         QfTGyB7tn/01WVnR0Fwv8cm0i1q2j9i7t0OAAPsgRMy/+EsZTeFoyqT/4Xo1TuvOAomL
         rtOobYElaG+HmdQnvhuS2kPRXEJ534YqBFGguvlzK1LZO2run0kelOEKRf4Yj3qIeeoE
         ar2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WMxjO0tx6t02AbcQby54NPy8RyK3yOypDjZIab8vXh4=;
        b=rLqvmML42zYIc28M9XqybmOXqbLcZaJ2cwnE7KpKMp7TkZkVTFIIQuj7MdPuAg834P
         O4QXtXJLpdIHdtdPV6VfW4yVRFYiNOOZohcDjfACVrfoZeCtvlIgWJWesOEqafY0yFtz
         FgOpVyPmTPdAqvT54SEtevub+Sex6pdFETEPd+dbBLJmSy9p79C3WZM6tO1GeHPaqvFK
         UyQ7u35kp80hIVa93CKIzjw2fTOTLDn0aqi+fD81j5wFC0zK2J1wfN78VFdAb7eVn9Sf
         tZERx/rQpHBfZpT344yekkzEagXcjlbXj7ScN08UvyB2WlWXymE4Np7UfKFTxYDHofwR
         /FGA==
X-Gm-Message-State: AOAM531g4rQ3Xe736AgMrafvK5YGlYoJdzB2eW2rvsgGgmqNokC0jafh
        daca8DO93wgv+FXfDM1b75I=
X-Google-Smtp-Source: ABdhPJz081wudgrw0mrWIs2FAxS1rWp5wOiKfQbqpkYviU3rS8iu9dWtDsDEnN9Q6qUkBrtVzexdhQ==
X-Received: by 2002:a17:902:b110:b0:142:7621:aecb with SMTP id q16-20020a170902b11000b001427621aecbmr481454plr.55.1639429218693;
        Mon, 13 Dec 2021 13:00:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ot1sm36852pjb.6.2021.12.13.13.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:00:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 11:00:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v9 6/7] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <Ybe0YWEo7Wp7wib9@slm.duckdns.org>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205183220.818872-7-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Sun, Dec 05, 2021 at 01:32:19PM -0500, Waiman Long wrote:
> +	In the case of an invalid partition root, a descriptive string on
> +	why the partition is invalid is included within parentheses.
> +
> +	Almost all possible state transitions among "member", valid
> +	and invalid partition roots are allowed except from "member"
> +	to invalid partition root.

So, this part still bothers me for the following two reasons that I brought
up earlier:

* When a valid partition turns invalid, now we have a reliable way of
  discovering what exactly caused the transition. However, when a user now
  fails to turn a member into partition, all they get is -EINVAL and there's
  no way to discover why it failed and the failure conditions that -EINVAL
  represents aren't simple.

* In an automated configuration scenarios, this operation mode may be
  difficult to make reliable and lead to sporadic failures which can be
  tricky to track down. The core problem is that whether a given operation
  succeeds or not may depend on external states (CPU on/offline) which may
  change asynchronously in a way that the configuring entity doesn't have
  any control over.

It's true that both are existing problems with the current partition
interface and given that this is a pretty spcialized feature, this can be
okay. Michal, what are your thoughts?

Thanks.

-- 
tejun
