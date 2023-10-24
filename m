Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B07D45EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJXD25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXD25 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 23:28:57 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4238B98;
        Mon, 23 Oct 2023 20:28:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d0f945893so33084946d6.1;
        Mon, 23 Oct 2023 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698118134; x=1698722934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTo20FcUXXMO+/pOwmcs+nnpx2i5KYsByzJwepOvoxk=;
        b=nZrCAzGCaPqoBtcTnvTBP8Hj9+ny8p4yDb/FjEyrP45mtWj9Q6NFAr2zL95VbIB+H2
         pR2maC1DHo7l++87MKeDyh05Q54/TMXaQwMX/SFy4v4vzlHS1QTj28oLFQI06PzfmORO
         N9BPs7Y3nZ/rLQ3816HZyVp79QN5wKGpisxOOpvHEq+G2x6sbUP+Om5gZ2jjA8GntRuR
         Uj8eKs5r+fLAJ/8mNZMwIQQBZ9/shkvHtXHv7ajJlno61kRA9+/3HScSFKDRUBxNHBJ4
         +NUlCCJhgxj6pjXRvRfVyrZwGtyOcC2ajdA21CtpNwc70HscF+hxqMKQChdz1tcsyF4T
         YniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698118134; x=1698722934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTo20FcUXXMO+/pOwmcs+nnpx2i5KYsByzJwepOvoxk=;
        b=VQx+cyhFDkbx5xmTQwb4RjycTreXpdQYpev4msZdfG3otOUlk0aG67tfbUASPeVP8Q
         Tg42OvQyQVkinQ820o6mRk2kMqpDjn/e6D7JgPIFDBX4yLx1bySe17SFdW36FatqIhAY
         90zkP+W9mqi8YAc2g6gl26u0LSX94xKcNWNFk+DbhDERRpNWwqyPaaTy2xWLLuhx2e9o
         W888ZMuGQpm1Tlnd/5gpDi24wa8ptKcR5c19o7P6gt3hRN9ktxWBLqJ++izdZ8ij9T9L
         iSGq7cbNS2lvr0bRHhUXj3eY6XpvfjXDnnKJY730Z4z0UX2n4oEWbKbMnQeodqM0kT/R
         edDg==
X-Gm-Message-State: AOJu0YzBy/Cx2FO98mV1NxRzk4aQJbm+TM5k6OMb4yIy0ysdHV3k+53W
        uB8DqNjiQ2u/PpPoWEgEp8I=
X-Google-Smtp-Source: AGHT+IFwysZrTp14vMBV1pMcKzLRrVUe0lHv6oGb6mcQNBNnuq3qMDuPBxqFPqxCAjWxQi6Rit5eoQ==
X-Received: by 2002:a05:6214:762:b0:66d:99cb:a15 with SMTP id f2-20020a056214076200b0066d99cb0a15mr13658536qvz.28.1698118134328;
        Mon, 23 Oct 2023 20:28:54 -0700 (PDT)
Received: from localhost ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id y3-20020ad457c3000000b0066d1e71e515sm3310044qvx.113.2023.10.23.20.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:28:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 Oct 2023 17:28:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 1/4] workqueue: Add
 workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
Message-ID: <ZTc57JX2qZiXn3p4@mtj.duckdns.org>
References: <20231013181122.3518610-1-longman@redhat.com>
 <20231013181122.3518610-2-longman@redhat.com>
 <ZS-kTXgSZoc985ul@slm.duckdns.org>
 <4e9cc6e3-7582-64af-76d7-6f9f72779146@redhat.com>
 <f8796057-e7f0-b589-783f-d11538aaafbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8796057-e7f0-b589-783f-d11538aaafbf@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Wed, Oct 18, 2023 at 03:18:52PM -0400, Waiman Long wrote:
> I have a second thought after taking a further look at that. First of all,
> cpuset_allowed_mask isn't relevant here and the mask can certainly contain
> offline CPUs. So cpu_possible_mask is the proper fallback.
> 
> With the current patch, wq_user_unbound_cpumask is set up initially as 
> (HK_TYPE_WQ ∩ HK_TYPE_DOMAIN) house keeping mask and rewritten by any
> subsequent write to workqueue/cpumask sysfs file. So using

The current behavior is not something which is carefully planned. It's more
accidental than anything. If we can come up with a more intutive and
consistent behavior, that should be fine.

> wq_user_unbound_cpumask has the implied precedence of user-sysfs written
> mask, command line isolcpus or nohz_full option mask and cpu_possible_mask.
> I think just fall back to wq_user_unbound_cpumask if the operation fails
> should be enough.

But yeah, that sounds acceptable.

Thanks.

-- 
tejun
