Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9326160154
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2020 02:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgBPBVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Feb 2020 20:21:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgBPBVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Feb 2020 20:21:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so6964829pfa.8
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2020 17:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZdGxk1PBOKOGawhQcLNZeyTj/xo8WHGgfqy1y6yzHoY=;
        b=VPkrR4aAn3aJbX9HSDDpW0USRaDzSdhdN+om9MlIpf6mSMxKE35qtR6HicoM83bMWF
         89aYUdl45Sd9QDTwpOs1ibLUQ0VqCTwOaZnAyXwClrb0QZ3LqHT2DQKNTGE5B0JeCzlw
         xQ06CSwG/XgtL+KBooQLph9KI5KyG3IdZ6tVc6PU/RveF/3awRvdk5p/6qyOHDdjX3GT
         gv4LGYBtF7uptKcEPBwSoE47pJuBGW2azc0j4bCn+Z332aoPAvIzfVn+DrIRIMqnLzFf
         YDR5Zfn0kFCTx9DMfbNdSbbwquq8tvMk73seGGqxATgAE501P6q3vyVnpSJA1VctTYP0
         heFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZdGxk1PBOKOGawhQcLNZeyTj/xo8WHGgfqy1y6yzHoY=;
        b=Ex8GyNah32d2UAsQy3sl7O191Ylh1HngoV4itnVJmcDJ4DDFdNoq0wiG7cKo46M2Ex
         pSrvYdxqwZKhLWRzCYhJ4fe+lntfnk89U0CPvzG/XyP+Fo3bSCahzyjboeaTrvPd9PeM
         jqDjRNW2T3v5rF/A/HQDbuRPrXK1sCAPlp7ePuYl7nDxKIlzXK39vRSPELJKEVm/0pcG
         pQvXWThfjyCg3W3pnFIi0MeG2NBN1ftphnmijW10c7sidbJgonORW6luyMHy+l0+GcWm
         M3LXxAo8f7pLkdHoi27UJbfPCQ1dT9TyIvn4fzPp6dx7go0fGT3xCzs4/Woa6aZKMbAy
         PGYA==
X-Gm-Message-State: APjAAAXMq5CvPLk1B8Bq2G0Jju+9pkrHsKc5Zw77Qffh19tTDH07rFh7
        El30WvvV32S/37lbF7zIglk67A==
X-Google-Smtp-Source: APXvYqwoLzYHO2Gi/QE5EcOl6jXQX5heYxareWbnikLCtYc4q3Ka3yDvQBaUmfxTlHxMIiSuHEeoRw==
X-Received: by 2002:a63:e257:: with SMTP id y23mr11028582pgj.104.1581816109493;
        Sat, 15 Feb 2020 17:21:49 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d1sm11803545pgj.79.2020.02.15.17.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 17:21:48 -0800 (PST)
Date:   Sat, 15 Feb 2020 17:21:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Mina Almasry <almasrymina@google.com>, shuah@kernel.org,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
In-Reply-To: <791880db-bdb0-8d34-ea9a-be6e4996fc0d@oracle.com>
Message-ID: <alpine.DEB.2.21.2002151720540.244463@chino.kir.corp.google.com>
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-2-almasrymina@google.com> <791880db-bdb0-8d34-ea9a-be6e4996fc0d@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Feb 2020, Mike Kravetz wrote:

> On 2/11/20 1:31 PM, Mina Almasry wrote:
> > Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
> > usage or hugetlb reservation counter.
> > 
> > Adds a new interface to uncharge a hugetlb_cgroup counter via
> > hugetlb_cgroup_uncharge_counter.
> > 
> > Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
> > hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.
> > 
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > 
> 
> Thanks for the suggested changes.  It will make the code easier to
> read and understand.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com
> 

Agreed, thanks Mina!

Acked-by: David Rientjes <rientjes@google.com>
