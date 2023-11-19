Return-Path: <linux-kselftest+bounces-276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126D7F0726
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE701C20869
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7912E42;
	Sun, 19 Nov 2023 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeQbKLfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B083;
	Sun, 19 Nov 2023 07:23:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ce3084c2d1so30669725ad.3;
        Sun, 19 Nov 2023 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700407438; x=1701012238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tv0VTetN2szhDW0NFHpW4LPgqRp7VF2ULeCrw/emRPA=;
        b=XeQbKLfMSUQKK9wlczxl6DD5Tkgv6s1ykn0QpaSI5/D34vtuVtqaZiHRHIs3TtNnF5
         IJFE7Z+YfM4WyrLl2zlOeldhsxTgJ1RtbZeKyNKdLCe42A//8kAMwOIMJ+K4PHbV+Pzh
         axuQ4hVTykQax+0kWABv3gs/TxhSiiJD0iwnOLODpJRjZw2yPQVtblteJJ36tRIO97bm
         MmmIeFHntmtquyFKy165mKLZnVMhXBOZOOI9kvNzpOPLWtNlngG33jgTE7k145wlRfYK
         IT4mWPSj78gqpqne2TSH4nqEHo4VuvS0AGMKz9R1SswCvV7hEei/55Z6oyMH03ASFEtG
         XnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700407438; x=1701012238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv0VTetN2szhDW0NFHpW4LPgqRp7VF2ULeCrw/emRPA=;
        b=ODSF1uGkumB1ISUbIZylo6R2SjDQILMJUIpshTQIwYGqy1WkrXlEitkX/JayLLbJ6S
         RrK8uIMxzzz50+FVhnLWhpdK/YGHFRrm7qnp/2pxQZ5BTsWC3OnpDGpQHvm1BX1MPqsh
         zDG5v5f5nBZC3ogG5uIvFXe9L7e/fxWZrxgjLxwoiVfNVeXX55VgQDtVae0i5BsP0Sx1
         +i80alRCqEhzlbZvddD5toLhZH2wjrL1f7dHrUlW1piryW2Xkrw3Q9x2O7oraS/A+hUW
         WbN0FmkUG4aWzqZCynwOv0OQddmVzZdFBvmT12jwQxCmPKjLcMiorb6sQNQC0NZcBFvF
         jfLg==
X-Gm-Message-State: AOJu0YymZtfbnn6DVNxcTx3IIrU+1R0J5gAyfcv1FpoFSw3GzZfwOzG3
	8Wg3sa1e+lbkAvcRYj9O0+Y=
X-Google-Smtp-Source: AGHT+IExcv92wwInt1GmYQ8oG/8BC7LdnS0mPL/DN8lWJXybR2jk67h/NQWBkjHlzOO/50DevV90QA==
X-Received: by 2002:a17:903:1108:b0:1cc:3bd3:73d8 with SMTP id n8-20020a170903110800b001cc3bd373d8mr5563344plh.59.1700407437484;
        Sun, 19 Nov 2023 07:23:57 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709026b8700b001cf57467ad2sm1604403plk.91.2023.11.19.07.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:23:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 19 Nov 2023 05:23:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 0/5] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Message-ID: <ZVoojBi4ZoVR2mOt@slm.duckdns.org>
References: <20231116033405.185166-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116033405.185166-1-longman@redhat.com>

On Wed, Nov 15, 2023 at 10:34:00PM -0500, Waiman Long wrote:
> v4:
>  - Update patch 1 to move apply_wqattrs_lock() and apply_wqattrs_unlock()
>    down into CONFIG_SYSFS block to avoid compilation warnings.

I already applied v3 to cgroup/for-6.8. Can you please send the fix up patch
against that branch?

Thanks.

-- 
tejun

