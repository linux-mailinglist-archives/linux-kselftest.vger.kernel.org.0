Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1197F723157
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjFEU1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 16:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjFEU1k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 16:27:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F298;
        Mon,  5 Jun 2023 13:27:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b01dac1a82so27949405ad.2;
        Mon, 05 Jun 2023 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685996855; x=1688588855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcWiwa0YHCZMhNxhxBqh5ZQM/CWxwyBQyza33kkTAC0=;
        b=i8JXhA9zZMx49v6PRp16clRpN55RyyktDBCfAeBEFfFnEgBqXEDKSYt5ZAyi47e2uf
         Y/KK46uCWEJLuizeei3enQGeTIl69jOUY8zzIOeGmy3aM/zO7xwfOV+YSbg9EV0cg3G5
         hqztIAp2GcduSsce4mxSdP04CxAfOcqixllrUe0J8cFFjAlTpii8qkv+EVJQ/+JgZrMh
         jwbkaENVdINA4RprEbsTX78c//E3/Kj+Oj57bnekhvsKtWG1usE1kmO636cgxZsrWRL+
         k/INory2HDFdwDxgptcLlPMiQ/obxvaq2ZlTJU/Oba5Vr1E31iY6gKks/921N+Jkqh+K
         G7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996855; x=1688588855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcWiwa0YHCZMhNxhxBqh5ZQM/CWxwyBQyza33kkTAC0=;
        b=LXFww5SFr1rKtWcR21+NwHPRcl2aXbZ0nP0Va3Dxa0ddJfthKb611dICo+q7hnaFzr
         2XCaVdLyPZV6gmoxrVf1KFfaWEnmThdvxYDPFpAGW/boOPNFAa/Dv9bnluIkEHA95ikn
         V9kkcXcSaw9qIkneCz9w+qlH1d96zy02LUDBLZsw8SdiVTRpKEWBwK1wsDm9MJ9Eo9Wc
         tWHUDTuoWPU8KbA+SHam9U03uvHlAPli7FfcErd3ZAnTKMmJ1t4u65Kg/V2e4mlMgQ5a
         BMSECW/Kx3VyFEM5Lg8yvqKaVEBhcWGupvBzI5v+O2w7HcSEHrtTN82UTnpvj8ThxpaV
         GOuA==
X-Gm-Message-State: AC+VfDwS9mVoawOJTm0ky2UCzHjrExuG+cc5PrbXnWfor9YmeFbno/U+
        GAnDtgodlOjwKi/Lreg019M=
X-Google-Smtp-Source: ACHHUZ63hqcvm7/z6JK1ec5e9pDq0SLHV1VII+2frZ31Kg3Uq6CnAKYMDB6rXQg2Zx47zYHJmrv+Cw==
X-Received: by 2002:a17:902:bcc5:b0:1b0:3d54:357d with SMTP id o5-20020a170902bcc500b001b03d54357dmr51205pls.24.1685996854689;
        Mon, 05 Jun 2023 13:27:34 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001ac4d3d3f72sm6920798plb.296.2023.06.05.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:27:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 10:27:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZH5FNc6wjlGPsaaO@slm.duckdns.org>
References: <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
 <ZH4jfmypOXGJPu0D@slm.duckdns.org>
 <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
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

On Mon, Jun 05, 2023 at 04:00:39PM -0400, Waiman Long wrote:
...
> > file seems hacky to me. e.g. How would it interact with namespacing? Are
> > there reasons why this can't be properly hierarchical other than the amount
> > of work needed? For example:
> > 
> >    cpuset.cpus.exclusive is a per-cgroup file and represents the mask of CPUs
> >    that the cgroup holds exclusively. The mask is always a subset of
> >    cpuset.cpus. The parent loses access to a CPU when the CPU is given to a
> >    child by setting the CPU in the child's cpus.exclusive and the CPU can't
> >    be given to more than one child. IOW, exclusive CPUs are available only to
> >    the leaf cgroups that have them set in their .exclusive file.
> > 
> >    When a cgroup is turned into a partition, its cpuset.cpus and
> >    cpuset.cpus.exclusive should be the same. For backward compatibility, if
> >    the cgroup's parent is already a partition, cpuset will automatically
> >    attempt to add all cpus in cpuset.cpus into cpuset.cpus.exclusive.
> > 
> > I could well be missing something important but I'd really like to see
> > something like the above where the reservation feature blends in with the
> > rest of cpuset.
> 
> It can certainly be made hierarchical as you suggest. It does increase
> complexity from both user and kernel point of view.
> 
> From the user point of view, there is one more knob to manage hierarchically
> which is not used that often.

From user pov, this only affects them when they want to create partitions
down the tree, right?

> From the kernel point of view, we may need to have one more cpumask per
> cpuset as the current subparts_cpus is used to track automatic reservation.
> We need another cpumask to contain extra exclusive CPUs not allocated
> through automatic reservation. The fact that you mention this new control
> file as a list of exclusively owned CPUs for this cgroup. Creating a
> partition is in fact allocating exclusive CPUs to a cgroup. So it kind of
> overlaps with the cpuset.cpus.partititon file. Can we fail a write to

Yes, it substitutes and expands on cpuset.cpus.partition behavior.

> cpuset.cpus.exclusive if those exclusive CPUs cannot be granted or will this
> exclusive list is only valid if a valid partition can be formed. So we need
> to properly manage the dependency between these 2 control files.

So, I think cpus.exclusive can become the sole mechanism to arbitrate
exclusive owenership of CPUs and .partition can depend on .exclusive.

> Alternatively, I have no problem exposing cpuset.cpus.exclusive as a
> read-only file. It is a bit problematic if we need to make it writable.

I don't follow. How would remote partitions work then?

> As for namespacing, you do raise a good point. I was thinking mostly from a
> whole system point of view as the use case that I am aware of does not needs
> that. To allow delegation of exclusive CPUs to a child cgroup, that cgroup
> has to be a partition root itself. One compromise that I can think of is to
> only allow automatic reservation only in such a scenario. In that case, I
> need to support a remote load balanced partition as well and hierarchical
> sub-partitions underneath it. That can be done with some extra code to the
> existing v2 patchset without introducing too much complexity.
> 
> IOW, the use of remote partition is only allowed on the whole system level
> where one has access to the cgroup root. Exclusive CPUs distribution within
> a container can only be done via the use of adjacent partitions with
> automatic reservation. Will that be a good enough compromise from your point
> of view?

It seems too twisted to me. I'd much prefer it to be better integrated with
the rest of cpuset.

Thanks.

-- 
tejun
