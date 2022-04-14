Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64387501A05
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiDNR2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiDNR2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:28:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5FC9B70
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 10:26:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q12so5307009pgj.13
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sz07fc6I7lIWKPKMNOVSVRZPVjZ/2q5aP50+7giwSck=;
        b=dF21I7xa+PEEtOju0dwSpmZ52AgeF8q9DD0slppiVuAkzhepRjGULhGl9GSpaBaN9k
         HGkp6aPpOc9KxYswilZx68HsiWuwoTmPMmPrje77QTltrR3lFASV4DzIG9UcRcdjscvl
         ffQJoIJtZdVAFsLtEgdP6aUWUI6OZWXIZjpoHl3BRmAwNH9B7bKriI3kN7Xrrghy+8ok
         w96Q/Nfe2bAgEu0mE0P095/9Fkk+kENEDAlaKx9Spnw61TPbAyCwio9dXAHsqa2FB/20
         SpIpeNvGk1Tj/340dPGN1lPPWwoBdi2stjlFsfs5ae5cBCgS/HibP9ne/pdbI3MJwjXl
         PXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sz07fc6I7lIWKPKMNOVSVRZPVjZ/2q5aP50+7giwSck=;
        b=3aut52IcAwHfRMxa1QrVzl1pY0EmvGGeNpgZe9gdRbSaR2TgF6q47JzzBuJAaOJUDH
         i/riGlfKryBOu0AFzQGQT939i7CGEG5Dgk/F752dklNyl/yzFSop/Uoua6htpds/YzZA
         kru3h7iSQt/98J5bYlPNMg4NlNXFxUkAL7LdtcUGiuiHpq1tG1OYwJR3ncTnmpjB5tvH
         WcxJyCPeHlQABTy62sDzprJUcDrqdXIfdjGJrfP8ReUIle4DcKc/lgD28hqClHPTbP1F
         gxLEkR23qmXiHClwg2mBLCGyqZX1zhCn556yW/n/1PT9QYxXvFytJq9I8rGpu3J8LFel
         ABrA==
X-Gm-Message-State: AOAM531u34IrkWWUCbtlGVM5i80WAp77aomD/5a11xgeIq4TotYA6ngz
        mc/15YqGheCY7V20/940AcsV3N+PMDD1pDgT9AfXgA==
X-Google-Smtp-Source: ABdhPJx93mXSCF+yEz9k2YvFHTy3Z6BKK4DmU6/ANhw2gPmq6Vl/jGOlUzeXD9No5PoS/iQzRus81pzLrcNCfCP0TIY=
X-Received: by 2002:a05:6a00:17a6:b0:505:a751:8354 with SMTP id
 s38-20020a056a0017a600b00505a7518354mr5003805pfg.82.1649957165014; Thu, 14
 Apr 2022 10:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com> <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <YlBCeadBqbeVvALK@dhcp22.suse.cz> <YlBM/HlPyPUZew5N@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <CAJD7tkbFjbGJ7CnNogpGq5enh_uhP8T5c0U+ku9PfwMoVLf2gg@mail.gmail.com>
In-Reply-To: <CAJD7tkbFjbGJ7CnNogpGq5enh_uhP8T5c0U+ku9PfwMoVLf2gg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Apr 2022 10:25:29 -0700
Message-ID: <CAJD7tkYJj2O-zaux9BZxJxG+JBjPrwRYKXPAAAh7i9GVE53VGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 8, 2022 at 1:08 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Fri, Apr 8, 2022 at 7:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > On Fri, Apr 08, 2022 at 04:11:05PM +0200, Michal Hocko wrote:
> > > Regarding "max" as a possible input. I am not really sure to be honest.
> > > I can imagine that it could be legit to simply reclaim all the charges
> > > (e.g. before removing the memcg) which should be achieveable by
> > > reclaiming the reported consumption. Or what exactly should be the
> > > semantic?
> >
> > Yeah, it just allows you to avoid reading memory.current to just
> > reclaim everything if you can specify "max" - you're still protected
> > by nretries to eventually bail out. Mostly, though I just feel like
> > supporting "max" makes memory.reclaim semetric with a lot of the
> > cgroup memory control files which tend to support "max".
>
> One possible approach here is to have force_empty behavior when we
> write "max" to memory.reclaim. From Google's perspective we don't have
> a preference, but it seems to me like logical behavior. We can do this
> either by directly calling mem_cgroup_force_empty() or just draining
> stock and lrus in memory_reclaim().
>
> This actually brings up another interesting point. Do you think we
> should drain lrus if try_to_free_mem_cgroup_pages() fails to reclaim
> the request amount? We can do this after the first call or before the
> last one. It could introduce more evictable pages for
> try_to_free_mem_cgroup_pages() to free.

Hey Michal, any thoughts on this? I am looking for feedback on this
before I send out v4.
