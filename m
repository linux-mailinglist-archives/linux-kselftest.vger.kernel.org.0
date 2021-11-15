Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569F945163C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 22:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbhKOVRr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 16:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350422AbhKOUXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 15:23:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E5C079789;
        Mon, 15 Nov 2021 12:11:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x5so5340434pfr.0;
        Mon, 15 Nov 2021 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oBGYRkWYdG5WWKlBVnjVyKfV04QfW8RGDK164b+TnA4=;
        b=LxH3FSerOz2L4FFx8lOOBlj5sDebiEU7bdQ78fpem8rYkFkIwKt5lahlCizi4TTF4P
         VTs2qdZ7z5qxOaw7+EF9s5ZQDtxw/RGxj5lZY+KSMkC1AQd6K2EbCjmFhZ4ocqCGHGOb
         9i8Mts523tK+s/SCBSnuYNuvroDWi4X/q2lI8nbpcoOjE9B7ggNCCCILmNcZAPRa8hER
         pbwfvpEsASm/U5Qj6kF7DBMmZZe7YMxar375ZhNDdGQw9prl0zjDy9RFx5Bnolf1XIwP
         e6BbZOgECPQK0GP30XfIgGS9IherX0cM+mOZZspbp1kcKU+dG0bkbBLPX4q+xOu4o1E5
         PivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=oBGYRkWYdG5WWKlBVnjVyKfV04QfW8RGDK164b+TnA4=;
        b=Sg9nTRedHXbQlK9Q3sL+lFBSQA9/JNg+3+8ETlu7+0+Gb5uXfDAhUQi+yooLELJv1z
         5L6PZjdet45+NbzvFukvliePysRkBXENgYN4c3EGqFyIIddc/h+OF9Q9Z7bkI2YJ95KQ
         /FVm1F0tKi1yXbc3mlB+dXa9cME372NHpIZyFHXGhnvDI7jJ7tk09RPV4jV2P/RKbqqK
         bFQWhNxhmtM4USEUWOCr0IWKW6EEwwzljPLlSCCqTVVQ9lPZ+aXLcDqk+KQxECdzTx9v
         9+l4/zKY4fqAUFqnofyfw4N1wrMNInP65tacMvIJWLu+OnUvdkjySV7lSnQRLR7+harq
         FSnw==
X-Gm-Message-State: AOAM530idC/ktTb7NgFivtZRnxXSL/x9wMC8nz+HTtmm12LmbuCiY71h
        ZW8cKY2aG+peGlJn+arOzgSgG/aK2hzZrFss
X-Google-Smtp-Source: ABdhPJxlTbEBdEjhMkuMIfYCIEqv49Q4KcpOugleQP8lUeIT/H3234v7Woz9z6kgy+M8DFDHV2ERsQ==
X-Received: by 2002:a63:b502:: with SMTP id y2mr1066503pge.214.1637007109631;
        Mon, 15 Nov 2021 12:11:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f3sm16180564pfg.167.2021.11.15.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 12:11:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Nov 2021 10:11:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
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
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YZK/A43T+zvu89dl@slm.duckdns.org>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115193122.GA16798@blackbody.suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Mon, Nov 15, 2021 at 08:31:22PM +0100, Michal Koutný wrote:
> Now to the constraints and partition setups. I think it's useful to have
> a model with which the implementation can be compared with.
> I tried to condense some "simple rules" from the descriptions you posted
> in v8 plus your response to my remarks in v7 [2]. These should only be
> the "validity conditions", not "transition conditions".

FWIW, my opinion is pretty much in line with Michal's in this regard. Other
than that, everything looks pretty good to me.

Thanks.

-- 
tejun
