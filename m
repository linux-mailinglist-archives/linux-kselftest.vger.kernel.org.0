Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13490722E42
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjFESEZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjFESEF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:04:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE0E49;
        Mon,  5 Jun 2023 11:03:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-65299178ac5so4624490b3a.1;
        Mon, 05 Jun 2023 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685988224; x=1688580224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7uQ8QjbEIiqKEh+gAYz/364Mw8hqnIeWQ0ws9py8v4=;
        b=ZZUUkU1id25XUT7xzdMGrfSeQBz12c6CsXPYvy99BkUDyNpTI8Nk3dtBpa6o0bB3Ye
         T1BzhXQbKlgXLWz0ONNcVvg9J2srMSm979nKkowd2Tdai2MxNYcR4Xv/Fd+gNnGWEcBj
         +tdGktnKGB7IHV4jcDkT+7h+8GuTAnS8BZ/YTER7GeCghLjr31+D8KWBUIX77NMsFRXr
         vmNig4VJKob0X9z1WU80jFxOmYtnYoopLn04QN6/gnTovH9KHRNJkTn++D1D+7SFcD3w
         qwL1PMsm3g0eokamoTOQwHPmREB1nQ9b/UD+TnHhjVjUblG4u0o9R3NUrwLkSZcNYgTD
         VHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988224; x=1688580224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7uQ8QjbEIiqKEh+gAYz/364Mw8hqnIeWQ0ws9py8v4=;
        b=edGu9C9Gaa/DO3/C3sRFyYTReTpdGOd5vixEwt35quKW3mAA80YdnpoLM3V2kW79KP
         579YHBTcj5l/2WYV1oN8sCkBwVhmFze4B01qL6Od/H4ArQUe2tnT1xUc8YtGTG2pN+OE
         F6ryygVmPjbcqlKjgk0fwOpzTRd+atorUJozsG/keEcpY1djrbtmztGQETIHGo+4P66Y
         ehMYdgXjC7v+dNalJUadY8kq4s1zPZYfdHb62l5IXO6JO2SI9TPAMA25FuNKT+P89vRC
         8krvaZKX7uRo/aiDl73SRYlqmSDTDwXWtWH0F4v2ddyFwDdEOzMdo4O+OMxSzdYRT9v7
         O9zg==
X-Gm-Message-State: AC+VfDzldN8eINa72ENGsGphOj18sgR7WBEwkAF4ftTmwpKc8KHLfQDV
        BpbVquob0hiyZXog6eFIN7g=
X-Google-Smtp-Source: ACHHUZ4Eb3dRTX7BPtTzDnDRnFPVDzzGWQOhROXaY3q99Qhi0JUFr7PXGrwliw8sAT5rh0+4Y0EevA==
X-Received: by 2002:a05:6a20:5495:b0:111:4a86:f70 with SMTP id i21-20020a056a20549500b001114a860f70mr9430752pzk.6.1685988223898;
        Mon, 05 Jun 2023 11:03:43 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id x5-20020a636305000000b0053051d50a48sm6090200pgb.79.2023.06.05.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:03:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 08:03:42 -1000
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
Message-ID: <ZH4jfmypOXGJPu0D@slm.duckdns.org>
References: <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
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

Hello, Waiman.

On Sun, May 28, 2023 at 05:18:50PM -0400, Waiman Long wrote:
> On 5/22/23 15:49, Tejun Heo wrote:
> Sorry for the late reply as I had been off for almost 2 weeks due to PTO.

And me too. Just moved.

> > Why is the syntax different from .cpus? Wouldn't it be better to keep them
> > the same?
> 
> Unlike cpuset.cpus, cpuset.cpus.reserve is supposed to contains CPUs that
> are used in multiple partitions. Also automatic reservation of adjacent
> partitions can happen in parallel. That is why I think it will be safer if

Ah, I see, this is because cpu.reserve is only in the root cgroup, so you
can't say that the knob is owned by the parent cgroup and thus access is
controlled that way.

...
> > >      There are two types of partitions - adjacent and remote.  The
> > >      parent of an adjacent partition must be a valid partition root.
> > >      Partition roots of adjacent partitions are all clustered around
> > >      the root cgroup.  Creation of adjacent partition is done by
> > >      writing the desired partition type into "cpuset.cpus.partition".
> > > 
> > >      A remote partition does not require a partition root parent.
> > >      So a remote partition can be formed far from the root cgroup.
> > >      However, its creation is a 2-step process.  The CPUs needed
> > >      by a remote partition ("cpuset.cpus" of the partition root)
> > >      has to be written into "cpuset.cpus.reserve" of the root
> > >      cgroup first.  After that, "isolated" can be written into
> > >      "cpuset.cpus.partition" of the partition root to form a remote
> > >      isolated partition which is the only supported remote partition
> > >      type for now.
> > > 
> > >      All remote partitions are terminal as adjacent partition cannot
> > >      be created underneath it.
> >
> > Can you elaborate this extra restriction a bit further?
> 
> Are you referring to the fact that only remote isolated partitions are
> supported? I do not preclude the support of load balancing remote
> partitions. I keep it to isolated partitions for now for ease of
> implementation and I am not currently aware of a use case where such a
> remote partition type is needed.
>
> If you are talking about remote partition being terminal. It is mainly
> because it can be more tricky to support hierarchical adjacent partitions
> underneath it especially if it is not isolated. We can certainly support it
> if a use case arises. I just don't want to implement code that nobody is
> really going to use.
> 
> BTW, with the current way the remote partition is created, it is not
> possible to have another remote partition underneath it.

The fact that the control is spread across a root-only file and per-cgroup
file seems hacky to me. e.g. How would it interact with namespacing? Are
there reasons why this can't be properly hierarchical other than the amount
of work needed? For example:

  cpuset.cpus.exclusive is a per-cgroup file and represents the mask of CPUs
  that the cgroup holds exclusively. The mask is always a subset of
  cpuset.cpus. The parent loses access to a CPU when the CPU is given to a
  child by setting the CPU in the child's cpus.exclusive and the CPU can't
  be given to more than one child. IOW, exclusive CPUs are available only to
  the leaf cgroups that have them set in their .exclusive file.

  When a cgroup is turned into a partition, its cpuset.cpus and
  cpuset.cpus.exclusive should be the same. For backward compatibility, if
  the cgroup's parent is already a partition, cpuset will automatically
  attempt to add all cpus in cpuset.cpus into cpuset.cpus.exclusive.

I could well be missing something important but I'd really like to see
something like the above where the reservation feature blends in with the
rest of cpuset.

Thanks.

-- 
tejun
