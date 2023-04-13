Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6145F6E033C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 02:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDMAdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 20:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMAdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 20:33:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B2449D;
        Wed, 12 Apr 2023 17:33:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id la3so13111306plb.11;
        Wed, 12 Apr 2023 17:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345997; x=1683937997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeVTMtCux2BOeObz5+AKrGQQdxp1bdVbjpePeClNJpo=;
        b=k3ksXRI5boYH1PJ4aL51Taqw6hvtAg0KYVtZ5LSutd4bs+Ama7qpxAoSze4A7L0gpl
         omUHyPRglIG6cycY06ZvINus+/9GsBNP02RktCm3rfaO9kZcr+52IgMeegbeUlkP6Ol4
         GnazoLBbvVbzAzWqgpBN14eYhnsrg7iPxKjt972IuYhn1qhpJuaINoJQTyp5UolqC3Qb
         60fnP8jse8Wk56KwrYncNxP9bcPeNiolIjfeD2lH5R8FbbY8XfaJxoGRREv/tqGaTITD
         B5HenCw6mN5oXFjVd5BO0bvN9qPsuUcLTfEZmg9nlwkiEdsQg7Qa5l55m36Z+aDmNu5C
         705g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345997; x=1683937997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeVTMtCux2BOeObz5+AKrGQQdxp1bdVbjpePeClNJpo=;
        b=VIGrCyQgUfhEppIBc2v5NKTa24XQXVuZ/bnxZeeT1mPAK0XeyoxBFBuMPKY3AViJQf
         1Wh3syazzbAGNpiQZS7/e0tl7ujsb1sGeK7Y0HD1pGwXbnpLQRvZABgRcsh0Ut742KD2
         xweaV9/0w20kO/d1lG6/cK2VFdTAAmAaD4g9Qlsy50vGbikBsuRXFK4H2DQIul2LFVcn
         Gyaxyk7AxaPnDhMLB5RwWog8ImyCLdSza6FTpi05DfLE7rOXC5uY2wiToTvN2hJRotJk
         dkcYj+5wbFOCPqZ9XAbDjkFYpI0AO/nSpM+VOouMfdmxc0Uagnsd60Dnb96y/Hd9lszw
         rlzA==
X-Gm-Message-State: AAQBX9fZNJmAHB+MOACqJ7XGLTLIni5vJPslKXAzrevp7HGlL00/vfRy
        6iENbpEx7FvmNIBkkW+pT68=
X-Google-Smtp-Source: AKy350YZNMZkgH+9uWTDQpdE2ql/ltywxQfXLvIF9L9t9EDDXuAjiEgjzlrJcnemUOsx2ulE8Xrclw==
X-Received: by 2002:a05:6a20:dc9f:b0:c6:c0c1:b1fe with SMTP id ky31-20020a056a20dc9f00b000c6c0c1b1femr136728pzb.57.1681345996825;
        Wed, 12 Apr 2023 17:33:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u36-20020a634724000000b0050bd9c8c53dsm178076pga.23.2023.04.12.17.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:33:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 14:33:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
References: <20230412153758.3088111-1-longman@redhat.com>
 <ZDcGVebCpyktxyWh@slm.duckdns.org>
 <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
 <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
 <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Wed, Apr 12, 2023 at 08:26:03PM -0400, Waiman Long wrote:
>   If the "cpuset.cpus.isolated" isn't set, the existing rules applies. If it
> is set, the new rule will be used.
> 
> Does that look reasonable to you?

Sounds a bit contrived. Does it need to be something defined in the root
cgroup? The only thing that's needed is that a cgroup needs to claim CPUs
exclusively without using them, right? Let's say we add a new interface
file, say, cpuset.cpus.reserve which is always exclusive and can be consumed
by children whichever way they want, wouldn't that be sufficient? Then,
there would be nothing to describe in the root cgroup.

Thanks.

-- 
tejun
