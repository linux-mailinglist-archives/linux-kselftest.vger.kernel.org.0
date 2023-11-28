Return-Path: <linux-kselftest+bounces-728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3177FBF79
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973B5282A02
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1C3529B;
	Tue, 28 Nov 2023 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUfLZDq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40BD60;
	Tue, 28 Nov 2023 08:46:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso42380835ad.0;
        Tue, 28 Nov 2023 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190016; x=1701794816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QF0jQrbImKsqRryD9dUhKvVAunTRGm29eICOfeWxfPI=;
        b=ZUfLZDq6RMZix/CxUgi9IQckGXS0aZBdtFussqFoYabtjNrTqAWWxg9ACy/N3r3Bcl
         rbpAnMunOYmTyoLAwCJeDirt6ALYuTFNxQHXBqzYwzCpO6A3I+w8VOxDFP9QbyN3d/9U
         6hVQDtKRNCseRDR7l2uGt9Et05Y6JS0BymYGa27JbYKm1RKPcccDUNxQeiqqTr47ziRH
         uiYWuPjgkTfl7dVUgzF4Rl9cWS24nUet3XzAS+6Ptuj9w8O7TghVcRyO4zJkAHgOKL5f
         DP48Z/C53jgxdkodQHzXV/xw2Bx1b8WcHemVlTdJ2DtfJBjWSTd1lgWwvOneVBQ6z5Yj
         GwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190016; x=1701794816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF0jQrbImKsqRryD9dUhKvVAunTRGm29eICOfeWxfPI=;
        b=tQl0kqLXMSD+pEo0bVpnoYRWvLzdrNa3vG0A7GwNSmABBgIAUG9yh+wOyrwlv6+cSl
         tEEhpWIcJvIjsTE5lmym/Ra94oFki3RSeR+cNJOmVO9Wcuvj3pZwtgY5doDxR2sS1YvS
         MHIKeG64KckhEunhs4nIHPf9XCqsz8be2k3WPYmOE/fbiAaKjXCxgYhS5xQ8cxtgUMAB
         BuhjgiqCoSWSf8clWRwF2PV8Wd2L/TrOryfQJ8iWTdCtXerH48bqE+fPMC5EEkejT9Rh
         qopbHRUpyG0Qew7waMoktWnmj/kWzTAc5qDwj8I8S5Juu1sxNgzTx7eDORoHYH/T45OQ
         imkA==
X-Gm-Message-State: AOJu0YzFS7Cq1pz5pyB4T5/KkDZtw9UF2idgzGjmt3KA/o0maOxjfDNB
	ueLkdZpPuyeP0R/QZiRgSMg=
X-Google-Smtp-Source: AGHT+IHC0Z/LpbadDOSSKuc66dS0Spd9JiEzilUwBkxoCjJ2rgnU0DbzPG8S1hC8sSmFhIL7b+XWww==
X-Received: by 2002:a17:902:c407:b0:1cf:8ebd:4eae with SMTP id k7-20020a170902c40700b001cf8ebd4eaemr18129335plk.69.1701190015917;
        Tue, 28 Nov 2023 08:46:55 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ecc100b001cff3536e51sm1888091plh.303.2023.11.28.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:46:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Nov 2023 06:46:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Expose cpuset.cpus.isolated
Message-ID: <ZWYZfqAtObghsqxS@slm.duckdns.org>
References: <20231127195105.290402-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127195105.290402-1-longman@redhat.com>

Hello,

On Mon, Nov 27, 2023 at 02:51:05PM -0500, Waiman Long wrote:
> The root-only cpuset.cpus.isolated control file shows the current set
> of isolated CPUs in isolated partitions. This control file is currently
> exposed only with the cgroup_debug boot command line option which also
> adds the ".__DEBUG__." prefix. This is actually a useful control file if
> users want to find out which CPUs are currently in an isolated state by
> the cpuset controller. Remove CFTYPE_DEBUG flag for this control file and
> make it available by default without any prefix.
> 
> The test_cpuset_prs.sh test script and the cgroup-v2.rst documentation
> file are also updated accordingly. Minor code change is also made in
> test_cpuset_prs.sh to avoid false test failure when running on debug
> kernel.

Applied to cgroup/for-6.8 but I wonder whether this would be useful in
non-root cgroups too. e.g. In a delegated partition which is namespaced,
wouldn't this be useful too?

Thanks.

-- 
tejun

