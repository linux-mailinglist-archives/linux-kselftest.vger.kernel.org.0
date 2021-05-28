Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA4394196
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhE1LCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 07:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbhE1LCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 07:02:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F72C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 04:01:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a5so4795981lfm.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 04:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5yAFnidpA2BQbeJKH28tAxU0DrXwCRwR23hK0aE+KnA=;
        b=OIwAvsSDIKcTgIm62bG0YTK00+C14Z/8smaSa4PGz8cMoAEEq7ynnfgEwQgbnrhtOi
         pRsqEE9yiHvg/YKDPOPTTCeIjAwq0wZKx61TUtzpy461d0xXTB4LfQhaSPUSF5klPYZf
         0c2e8v+X/89Q1Bv6tfyToupd4GWRe+FYOe7PIhUW72raBUPbhAQjzpvK2jKOqymj5rff
         I1xMwnn0qtBa5LQDAPk4Xko5UtvHR/H4NfOrC6z3ZvJfr3pC8Ih1GbYCL/Wb2LLX4ixJ
         6O8PujRDWepQJB1aRlwWkJwwLHSma/OSj7+ah5aH0wuLSXajoEUnz9am2AHNGFRqJW71
         kO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5yAFnidpA2BQbeJKH28tAxU0DrXwCRwR23hK0aE+KnA=;
        b=YQdGjTn6muhp7tk8EzfuOmU8xjdqACy1o7ajY0Wgn2vJio9zZ8Aq9XgWr2FcS2IaFg
         zREvQ1sE7Ze1waisUKlX1Fb0SbDM1uob7vkfjhKjsWPfalJgV4gTXzW6zjFhjaH6v9bf
         WE+niUEoEy4ihgQf3cdwXUWUfhBffoXIImQ/4o1Ov2u/HM0zquUSsK+tLxIC+pmopUg+
         qE2BOnD2UnSPE1/VcVAd9+zPfCuWXckgnt3o77PaOOzsZkJU3q40PllzyXNHB5ns58zc
         nlIhZNhwwSWqAEYtfXxPlQaBEyud7hFK9L7y2Q0psDVL40FUR+ouv2Bsfrk5fHxRPHnV
         0VYQ==
X-Gm-Message-State: AOAM532blh99rVFCovTxkd6xN+ZX6Z6RT/GZaWgde1PxFtO9Uu/v3T3e
        2EP+g57OLKvbESAhLJxxW1tPow==
X-Google-Smtp-Source: ABdhPJwD1KsNz3QaTh4zsnGHrGefbiwV1NmA+hSdcMcc7KydHQVCt94urcDZDnfFxCRQ1Dx5YYcaqg==
X-Received: by 2002:ac2:4e0a:: with SMTP id e10mr5217205lfr.33.1622199668880;
        Fri, 28 May 2021 04:01:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t14sm444529lfk.186.2021.05.28.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:01:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BCDD7102761; Fri, 28 May 2021 14:01:15 +0300 (+03)
Date:   Fri, 28 May 2021 14:01:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     shuah@kernel.org, sfr@canb.auug.org.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next] khugepaged: selftests: remove debug_cow
Message-ID: <20210528110115.xxgvr5bn7af43wrj@box.shutemov.name>
References: <20210430051117.400189-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430051117.400189-1-sunnanyong@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 30, 2021 at 01:11:17PM +0800, Nanyong Sun wrote:
> The debug_cow attribute had been removed since commit 4958e4d86ecb01
> ("mm: thp: remove debug_cow switch"), so remove it in selftest code too,
> otherwise the khugepaged test will fail.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
