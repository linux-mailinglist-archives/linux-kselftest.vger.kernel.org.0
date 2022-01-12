Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7248CDBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 22:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiALVZh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 16:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiALVZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 16:25:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32A4C06173F;
        Wed, 12 Jan 2022 13:25:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so7554696pjp.0;
        Wed, 12 Jan 2022 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=71MHWWgwv/fcd6sVQlX/nQYgJbOKyivyKZ2pLN/ooAE=;
        b=MBKN0ogjzTfVJcRRMglHt5ESyQHxLRwHCERWBzWPgi83VsoxTi/Fbn8BYq/uobfLzZ
         gHZp+dt9q700lzX2CllbNPEzFxC2mi2HCC6jQZGf3GM+tSFkr4RxazZlKiX52oxuYdHO
         u27qqIDERnsUEtWROk2gV3xo3MCQPV+p61qlPOqHxVW5IZ0o67fe93e8aiV9efjo2z0R
         EhHLVlGg4Pa0/P3so+qZE3kbaDSJMsts+HEvdWoUH07QFmfRW7WMEN4HtpMsW/xHTIf0
         m+MHVNTyDXpXyh2xH5gY7ShdMbrOlFuqW1s45u/xNjJ+33GeSfqzTgTkSRD1RyUDdC6Q
         hcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=71MHWWgwv/fcd6sVQlX/nQYgJbOKyivyKZ2pLN/ooAE=;
        b=qRBWz9VGm++UX7vuOTsi10OsuPlwZoZYHnE59V46fOKEhXKI4MPryueuRg9kRU12mt
         LWY9HI1LO+kh4I2sY+fWCgoQY5cnVAx4F1r1ndzVYIsv5VxN/9IP3depfhZsxdkBd1nI
         y8R5veV36AqVz1ewGYb9OodUydPcwf4u3+RBxo/ZgkijWS+uVMCpe69xEHaYqS32lWds
         /LoXkmlY0lCyW5nmxAiq1O2NOS/rkIhoryYSTzN5w1Qaxz1sCbP+ZXFRS06c2i9Mvr60
         SS7Ty7YLhU66DuuLyMB3ggQCJbYJMtkr5EUuovs43CsqG92m3H5iXIpIo8uZg2m+/m8u
         x8Vg==
X-Gm-Message-State: AOAM532f+sRlXOjDzZIjpBHIW3bYjYXK0nCn5zU02f6JMEqeNLX1Ezhs
        UW50PGCx8ki/S3MawaweSRg=
X-Google-Smtp-Source: ABdhPJw+N7bRQaNyf8Dv9Y3SYFf4IM95GVtc1OynWB0qzu4QMpIzFmCg9jbdNsBBQS9lT15Yv88qbA==
X-Received: by 2002:a62:e217:0:b0:4be:3ce4:17a7 with SMTP id a23-20020a62e217000000b004be3ce417a7mr1164361pfi.55.1642022735256;
        Wed, 12 Jan 2022 13:25:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c19sm509955pfl.118.2022.01.12.13.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:25:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 11:25:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     longman@redhat.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, corbet@lwn.net, frederic@kernel.org,
        guro@fb.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com,
        mtosatti@redhat.com, pauld@redhat.com, peterz@infradead.org,
        shuah@kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Make child cpusets restrict parents on v1
 hierarchy
Message-ID: <Yd9HTVxEPo2/zfou@slm.duckdns.org>
References: <8d73dc26-74e1-d763-d897-6e03cdac3c8c@redhat.com>
 <20211217154854.41409-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211217154854.41409-1-mkoutny@suse.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 04:48:54PM +0100, Michal Koutný wrote:
> The commit 1f1562fcd04a ("cgroup/cpuset: Don't let child cpusets
> restrict parent in default hierarchy") inteded to relax the check only
> on the default hierarchy (or v2 mode) but it dropped the check in v1
> too.
> 
> This patch returns and separates the legacy-only validations so that
> they can be considered only in the v1 mode, which should enforce the old
> constraints for the sake of compatibility.
> 
> Fixes: 1f1562fcd04a ("cgroup/cpuset: Don't let child cpusets restrict parent in default hierarchy")
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-5.17-fixes.

Thanks.

-- 
tejun
