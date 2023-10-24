Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1F7D45E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 05:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjJXD0N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 23:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXD0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 23:26:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D183;
        Mon, 23 Oct 2023 20:26:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77891c236fcso311438285a.3;
        Mon, 23 Oct 2023 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698117968; x=1698722768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5owIIMWHjveV3iNUQ2MkLe82JwsUOoqZbf2HycPTaSY=;
        b=YPPLaUHfbzGt5SFjkw2ZCi59ja2dWTp0HegmhLNtlCysXHNSFmqaZ1emb3Rqx9Jve9
         TYUvkfQkKddOEn4UcVf5Puf5ocRAKjASGxKOpy2b9KWocq7/gT9/9fdnB64Z6yGAWr/c
         udz4j8y//jxAykzDvcq3Par/W8ihNnpi6AJd9jwGmb2hJf700WBgUtfBnpDNBI0O94ip
         RDFhxui824SsF5Lmd2WfHyAdLzRKv62hsPupZB7UdRgNdaBI7rd1u64bVJWG2FDSmXlQ
         S2FNDwhZNQuhJXesIuP0f2rlyvSjElu/87MLMe+HbLy/yO8zsgpeAoCc34hp1CZiV2Tt
         BKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698117968; x=1698722768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5owIIMWHjveV3iNUQ2MkLe82JwsUOoqZbf2HycPTaSY=;
        b=Nkask539xEFMz/h2HAUJkHcE7xweiMWr5e2DVSDGthGf8QFrIuW6a/YgMM8FqCrFMs
         9XuuXVTcQ1PYF85GZFqu5PPVIYwyAh3b5j5UkcQe1v6OOslKnreILnGQWnjBa3TsZxsk
         T9bph+B4+3Sp5AqhKEvEOi9NC+ab1ZV+PskwPRTPJu/ISTI7m1roZbRiNcrpHGdEgQ0S
         w5/UL2omHfbXWjXUjO3QP7DFhtnnAGNTe0TWimmrAIVFiGGUSHbwqpfmguBVprPYk6mE
         GJ6Erdqc+snXmfPbCcsCMEgK/A0aZ6SmRCS5kVevr8JSJd/u2xdIJyuzEUZV4KORPBV9
         aHmw==
X-Gm-Message-State: AOJu0Yzk4YeFse0QHFc82hBr72jnomDp0865jf1YBomj5DLfYwe1WDz5
        7JS4EKMIk5XphpLvKC8oMVZw7QvvX/Y=
X-Google-Smtp-Source: AGHT+IHAqHRftchKIIm+zyE5nIYAlvq5MPiTMBcP8i5hwCmJXUwc8mYNL/w2F6CO4hJEhTWStLucIw==
X-Received: by 2002:a05:620a:388f:b0:778:96ec:661 with SMTP id qp15-20020a05620a388f00b0077896ec0661mr10769454qkn.73.1698117968265;
        Mon, 23 Oct 2023 20:26:08 -0700 (PDT)
Received: from localhost ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a074500b0077434d0f06esm1534578qki.52.2023.10.23.20.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:26:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 Oct 2023 17:25:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 3/4] cgroup/cpuset: Keep track of CPUs in isolated
 partitions
Message-ID: <ZTc5RXWemIhfrAlS@mtj.duckdns.org>
References: <20231013181122.3518610-1-longman@redhat.com>
 <20231013181122.3518610-4-longman@redhat.com>
 <ZS-kt6X5Dd1lktAw@slm.duckdns.org>
 <9e2772e3-f615-5e80-6922-5a2dd06a8b07@redhat.com>
 <ZTAfM0msp8Cg-qLy@slm.duckdns.org>
 <59448803-ac86-0762-d828-c3eba431ceb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59448803-ac86-0762-d828-c3eba431ceb4@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Wed, Oct 18, 2023 at 02:24:00PM -0400, Waiman Long wrote:
> If you mean saving the exclusion cpumask no matter who the caller is, we can
> add another exclusion cpumask to save it and expose it to sysfs. This should
> be done in the first workqueue patch, not as part of this patch. I expose
> this isolated cpumask for testing purpose to be checked by the
> test_cpuset_prs.sh script for correctness. As said, I can expose it without
> cgroup_debug if you think the information is useful in general.

I don't really care where the cpumask is in the source tree. I just want all
the workqueue cpumasks presented to the userspace in a single place. Also, I
think it makes sense to publish it to userspace in an easily accessible
manner as what the eventual configuration ends up being can be confusing and
the effect it has on the system subtle.

Thanks.

-- 
tejun
