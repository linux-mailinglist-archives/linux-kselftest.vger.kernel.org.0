Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136706F8656
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjEEQDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjEEQDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 12:03:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A91637D;
        Fri,  5 May 2023 09:03:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6439df6c268so712504b3a.0;
        Fri, 05 May 2023 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683302632; x=1685894632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQKJTg5ApR448/3rL3jZGIW7r7Tt+TftEzg/PrUenB8=;
        b=KdeViUdQB/XlTtwKjiqtdqzxGXJNnUwIDquRJ+lSj2VGU9tE1P0MAkcVPmNkcz6vHB
         fDXCRHapjvFVEV3o1VGhvwLDLqnYkDZk590OXp4RU/dg1K9J4irJGis253sNeWuqWAHu
         N/LRTdnrS4B20Cwt15aQB3erb35WH+otXfr8XUrmfXJ5F0YNoIEPGGTqcVdo6AqE2RYy
         J7XuI0QXsJZknjLlLhZHvKE2H0pbe5RlsDzZgofl+XV4kim3baGkMM9j0zEi/klPxtaQ
         onIuV02H251+0B0rKEGb09NzWZixob41Xeurhro2dcypBvg34lEmo7vXh51YUQDZ8RoK
         gZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683302632; x=1685894632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQKJTg5ApR448/3rL3jZGIW7r7Tt+TftEzg/PrUenB8=;
        b=GTV0qp6FaGmPvFv3RTQzaYPCHbR7md7FnKfQzYIoVfnp+VCaZBNukhaSODfWDSHGl/
         1twdFFz4rn3bRzvcqe1GBAQXCjl3zz6qp0p2zR5qE9pFHJWEuCYUH2RqJlNDdtR0YRkR
         bqwk7COcxxGB4Ojd+40etKmXA1ojhtcnaaN8eMpBfCVWCwMqBFnfkmpJJo3eF6Q0TxF6
         VBfd7JMuig3Ruj2m/LPshZ+T6UFEP8beOvPaBno9aoyfzIOvAwk0SvmX2V7pK05YVZ7N
         AYoWimlU+Ni+XsPQkCTnxSOOvvKxDKQxaIpX9UQ6sZkkxr5ctp7OF0Bplezy82vAcpFd
         qu4g==
X-Gm-Message-State: AC+VfDzP7qfgSVZ7Z/JVSHV7wJUCtv1dPM6ImmgJKk4wyKzkqyCxcA4t
        PyeKlucpOT90Ln3Afay4J7c=
X-Google-Smtp-Source: ACHHUZ4rGO4G5r8RKJhtCl5hnX5yV4ufmU+sPfN+IDho1ZxP3Bk9vj/mp3idARfflddFuXx+MlxxOw==
X-Received: by 2002:a17:902:a5c6:b0:1aa:d706:e0e5 with SMTP id t6-20020a170902a5c600b001aad706e0e5mr1732585plq.47.1683302631602;
        Fri, 05 May 2023 09:03:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902c18700b001a04d27ee92sm1938725pld.241.2023.05.05.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:03:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 06:03:48 -1000
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
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
References: <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
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

On Wed, May 03, 2023 at 11:01:36PM -0400, Waiman Long wrote:
> 
> On 5/2/23 18:27, Michal Koutný wrote:
> > On Tue, May 02, 2023 at 05:26:17PM -0400, Waiman Long <longman@redhat.com> wrote:
> > > In the new scheme, the available cpus are still directly passed down to a
> > > descendant cgroup. However, isolated CPUs (or more generally CPUs dedicated
> > > to a partition) have to be exclusive. So what the cpuset.cpus.reserve does
> > > is to identify those exclusive CPUs that can be excluded from the
> > > effective_cpus of the parent cgroups before they are claimed by a child
> > > partition. Currently this is done automatically when a child partition is
> > > created off a parent partition root. The new scheme will break it into 2
> > > separate steps without the requirement that the parent of a partition has to
> > > be a partition root itself.
> > new scheme
> >    1st step:
> >    echo C >p/cpuset.cpus.reserve
> >    # p/cpuset.cpus.effective == A-C (1)
> >    2nd step (claim):
> >    echo C' >p/c/cpuset.cpus # C'⊆C
> >    echo root >p/c/cpuset.cpus.partition
> 
> It is something like that. However, the current scheme of automatic
> reservation is also supported, i.e. cpuset.cpus.reserve will be set
> automatically when the child cgroup becomes a valid partition as long as the
> cpuset.cpus.reserve file is not written to. This is for backward
> compatibility.
> 
> Once it is written to, automatic mode will end and users have to manually
> set it afterward.

I really don't like the implicit switching behavior. This is interface
behavior modifying internal state that userspace can't view or control
directly. Regardless of how the rest of the discussion develops, this part
should be improved (e.g. would it work to always try to auto-reserve if the
cpu isn't already reserved?).

Thanks.

-- 
tejun
