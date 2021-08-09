Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAD3E4F77
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 00:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhHIWrW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 18:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhHIWrW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 18:47:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D97C0613D3;
        Mon,  9 Aug 2021 15:47:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t3so18290218plg.9;
        Mon, 09 Aug 2021 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNgzSBl2ViZgrzMacCsKUZKoLxV/azVHoL6Wpcoyx1o=;
        b=aEhH+GbMzUwYKoNDDFkuXlWKEVtNn+ncfDq/pdkGJJN4UnbE3CmPYayiSuTemIyIyr
         lZHcTi35GE2BjPN9IB00dF6+Ir6KSDgrQCmP3pcBi4w34uvF+JWOSVOnitMB59NUcNHn
         IolBa8d9/W36apIoy0H1KpO34GW9m7kGbkT4hpaH4/SwFT52bQk8bc/vpD4DYViw/8RM
         wR3xDD4TI4UESH3BPx9xBe1a5yt+1l/7X14ojMklyUd91+GtS+/TEBViIswe/IDwYXai
         tpMJsJJw8HlHXlt10zIKo2l+e889s0F8JMxguiNcQdSJYXN2M05+5urFXjP33WKrLDMc
         bH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XNgzSBl2ViZgrzMacCsKUZKoLxV/azVHoL6Wpcoyx1o=;
        b=IYYmJFk+A3PHvtsDy6el00O4M3pz9E8AtzehmcoIzDs2OrytSmaJfCj7kPio5mWQUR
         3eGt1H8YAVk16bxZJNNl6s22Fq1Fv/m+9DNSJj6T3d5eGEM1mctdnj7ILM2NTm354wti
         E5ReFVjuRez7LUnM0TRQxuOfpro5Kczo0YdArm5V0IwM0t70pRiUFr7h6Aojyi+aY97v
         GhtwLxTZMg6ZsbxMNCJ7e9AwNRNrLX4ikoGsH931Qhqz5Dt3Kme+cKyXhEAsTFNybwpG
         bRBeFElGNz4Qh8BmZuqNeJ5ZoUZjVmZtrX1b0UQAmjrcZL/FdzIRldd/yR9HvzzXGmCH
         c0yA==
X-Gm-Message-State: AOAM531eET7QTYJd19+OBcvvkv50tNiaJx8b/SguTRMCz08Bne8Askfs
        pty9DRSiBZZGwgqS800ly7hwI0E7XzrTKw==
X-Google-Smtp-Source: ABdhPJyEsd06c5zbOMTazRPdLGXEAi0H/IIo/OTte6VZV5DwrEtvZyvvw3OtbCISVsJWDXUCT2Dx3A==
X-Received: by 2002:a65:5083:: with SMTP id r3mr166335pgp.161.1628549220702;
        Mon, 09 Aug 2021 15:47:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id c133sm4203621pfb.174.2021.08.09.15.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:47:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 12:46:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
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
Subject: Re: [PATCH v3 0/9] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Message-ID: <YRGwXw3KW8eFhEa8@mtj.duckdns.org>
References: <20210720141834.10624-1-longman@redhat.com>
 <YP9ChFvrGrDMGzbe@slm.duckdns.org>
 <b2f49b2e-d5a4-1504-bd0c-0bd82943d855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f49b2e-d5a4-1504-bd0c-0bd82943d855@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman. Sorry about the delay. Was off for a while.

On Tue, Jul 27, 2021 at 05:14:27PM -0400, Waiman Long wrote:
> However, if we have a complicated partition setup with multiple child
> partitions. Invalid cpuset.cpus change in a parent partition will cause all
> the child partitions to become invalid too. That is the scenario that I
> don't want to happen inadvertently. Alternatively, we can restrict those

I don't think there's anything fundamentally wrong with it given the
requirement that userland has to monitor invalid state transitions.
The same mass transition can happen through cpu hotplug operations,
right?

> invalid changes if a child partition exist and let it pass through and make
> it invalid if it is a standalone partition.
> 
> Please let me know which approach do you want me to take.

I think it'd be best if we can stick to some principles rather than
trying to adjust it for specific scenarios. e.g.:

* If a given state can be reached through cpu hot [un]plug, any
  configuration attempt which reaches the same state should be allowed
  with the same end result as cpu hot [un]plug.

* If a given state can't ever be reached in whichever way, the
  configuration attempting to reach such state should be rejected.

Thanks.

-- 
tejun
