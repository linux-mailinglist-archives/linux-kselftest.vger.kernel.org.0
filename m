Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5231F549D6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348563AbiFMTVi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiFMTVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CABA1CB22;
        Mon, 13 Jun 2022 10:23:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s37so3637895pfg.11;
        Mon, 13 Jun 2022 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7M+A4Tkcl4j2ZEYJxnHofmbHWBP8K2O9jymdDhG9tv0=;
        b=SfbzRvanLsSXpQIXsHN2DLvLUMY5t8/g0db/VVEH7eeh+ei07KzvHZObXvbjTtVeim
         QqAtDY4GBjmFmerP5kZz+/mf7m/AS/3Q5XZMZOj/OJ8HDObBVWj2SDvQTRMUldRoZMZ+
         SeJLzy0p5MzASUh/0RwJPnMgBysfdsAoMl1zLmYslcAO+FOxbb8NVeSW1lz0Tf3iyUJ1
         7LDCIUE5aIDnihc8OtiMhEzJchy+X65LWl8FCJEPOHTTeMSAznyrJtD842u6apyMxgiI
         ZuePfGPvvzwdUYaLN3R4KH78h6kCwyviro32caqZmQSWGivj6/D750j/QfJwc+em2o6W
         8ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=7M+A4Tkcl4j2ZEYJxnHofmbHWBP8K2O9jymdDhG9tv0=;
        b=t3DkZMS/cctafLZdQLmxZP854yMY27zMd3yQMrXvqyh8klLUZAh1a8p1Yg3DldYyXG
         1Y6I47mjQxw0VkSicPFwXJkPaw9VgcJ5o1Uz3aBm3RKqAw7KeMkzFvIZQH2bslvRsM+K
         ohuOWNPBBN3yjD/xEa+soqp+6a7nj77qDycRfjGMDXqbAoxR7oAR34RmTRwM0SlufChL
         6Uzp2r7InXKbTsVAGao0SaCE3aj5FRtkte/esTEJDQmTGQxuI0mGvKbCO/SlA+m4pC0C
         eYnTWuZ7kV89ZHDgMKIUpU0MOgsuEOMGRCkTfu8fJswXUic1ksdCUebQukqM8Y+18oMu
         GNCw==
X-Gm-Message-State: AOAM531gkt+L5SdHB/8PZ9u3H9D0zXCWxttkv8Szo7ecXSbAs0NqtrLY
        VJU1CZv1DIyGLCTPgAKNgeo=
X-Google-Smtp-Source: ABdhPJw4VXb316KPeH1PJV6+trUh6zgGxF5VJQRHS1G9M7KvTAY4ypmt5bbKi2jd6R5tOl/qrqr8KQ==
X-Received: by 2002:a63:1f55:0:b0:3fd:41c5:b53a with SMTP id q21-20020a631f55000000b003fd41c5b53amr529334pgm.441.1655140985316;
        Mon, 13 Jun 2022 10:23:05 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b003fd1111d73csm5956795pgc.4.2022.06.13.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:23:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Jun 2022 07:23:03 -1000
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
Subject: Re: [PATCH v11 3/8] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Message-ID: <Yqdydz3vNgfVMgDf@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
 <YqYlCRywdgSYtwKk@slm.duckdns.org>
 <YqYlOQjKtQCBsQuT@slm.duckdns.org>
 <ce3106c1-a3c4-b449-bafc-6940d672bd94@redhat.com>
 <YqanEZZooeZwtutA@slm.duckdns.org>
 <20220613140206.GA6910@blackbody.suse.cz>
 <f1c33447-1f82-9698-6b0c-fc9ffb12b4bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1c33447-1f82-9698-6b0c-fc9ffb12b4bb@redhat.com>
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

On Mon, Jun 13, 2022 at 12:47:37PM -0400, Waiman Long wrote:
> On 6/13/22 10:02, Michal Koutný wrote:
> > On Sun, Jun 12, 2022 at 04:55:13PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > But how would that happen? A lot of other things would break too if that
> > > were to happen.
> > cpuset is a threaded controller where the internal-node-constraint does
> > not hold. So the additional condition for cpuset migrations is IMO
> > warranted (and needed if there's no "fall up").
> 
> Yes, you are right. cpuset is threaded and so it may have tasks even if it
> is not the leaf node.

And we had this same exchange the last time. Can you please add a comment?
We might also already have had this exchange before too but is it necessary
to allow threaded cgroups to be isolated roots? The interaction between
being threaded and isolated is cleaner at that layer as it's interactions
between two explicit mode changes.

Thanks.

-- 
tejun
