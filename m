Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05931599B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 20:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBKTZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 14:25:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35075 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgBKTZt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 14:25:49 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so1682566pjc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fduhzb+WwBefc5G2IiZw7jkFkPhFvQRZKGxZZqFDo/E=;
        b=aBFZgI1bEVFMDfd8bvtXh9AZ1Mze2/1St6L/4BVij/mXj+0ZVWJe/BBz62kvdV/PUy
         KBlDmWnFixMHuEJ2x57jhZe2RZwo4KxOOAhGPDQppATODztQCUF1bGUHqwB2F+7dyFEs
         eKbWf5MArG16cSHqLbOgFxRg8G+4rPIDu1A8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fduhzb+WwBefc5G2IiZw7jkFkPhFvQRZKGxZZqFDo/E=;
        b=boV2MkocvoWgQBRnrbOTuDsmyFictdZO4GWzQK6Snitp/mQOyJBtb6MSusCbttpv1m
         LRMYZ4QfgAC6PxPKE9eYBTtb+eVjIvb3wLjAluvs6sMk5WwqG3GSlv0afhKtfE8S/XCj
         oYan7MYjwpmsdV913l/18hwBhJ1sfCKEO2zriFziKXXzyJYuoHeFxMo9wUFznv98W4YE
         sm8nqZqM5G/ghKl06hCukgMQjbf+gqhfT+zQRMk8heJTn9qJ6ADGUjUofOz5qlXpq7Mk
         DJoxswrrb7Yv9Tczc5o1hYPC6+sw2X/eLwNQSW4WO2YnZRgrRyVBv+G7k4yaA5DYphjV
         cApg==
X-Gm-Message-State: APjAAAVRg2hYxHL9Hw0OHzWTriXRAuVTbvv+omPrGQkiu86kqoXDgN9v
        ebyw+O4USg+EZO5pIrQNG5rtpg==
X-Google-Smtp-Source: APXvYqzYyVOg7uqgSBmTXebLQ5IGOoof6bohkjL6i/HNSEw99SG6fXpTLlzi3kbK2a4VrLpxXNd1Pg==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr6814381pjr.22.1581449148710;
        Tue, 11 Feb 2020 11:25:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm4285511pjg.27.2020.02.11.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 11:25:47 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:25:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 7/7] selftests/exec: Add READ_IMPLIES_EXEC tests
Message-ID: <202002111124.0A334167@keescook>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-8-keescook@chromium.org>
 <4f8a5036-dc2a-90ad-5fc8-69560a5dd78e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8a5036-dc2a-90ad-5fc8-69560a5dd78e@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 11, 2020 at 11:11:21AM -0700, shuah wrote:
> On 2/10/20 12:30 PM, Kees Cook wrote:
> > In order to check the matrix of possible states for handling
> > READ_IMPLIES_EXEC across native, compat, and the state of PT_GNU_STACK,
> > add tests for these execution conditions.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> No issues for this to go through tip.
> 
> A few problems to fix first. This fails to compile when 32-bit libraries
> aren't installed. It should fail the 32-bit part and run other checks.

Do you mean the Makefile should detect the missing compat build deps and
avoid building them? Testing compat is pretty important to this test, so
it seems like missing the build deps causing the build to fail is the
correct action here. This is likely true for the x86/ selftests too.

What would you like this to do?

-- 
Kees Cook
