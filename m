Return-Path: <linux-kselftest+bounces-14798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3749483BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 22:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C02284686
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B216B720;
	Mon,  5 Aug 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeZX66xb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628B14E2E8;
	Mon,  5 Aug 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891305; cv=none; b=EztCVpox+rZum3WM7tHScgl1yW5M476WQafrrWqHfG6wZUYsIOl6rrscnZjBBbQjk19MCcqqHCllvkX3H/KM0h55CXzIUD6rGbh3cu0KOYAkuPqcQsp4XqIJELwa5SeN97zTC3JyGVGMPhqhncTnaGe5qHDALRg0NQZlEX/wr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891305; c=relaxed/simple;
	bh=yfehb+/K7JEytgsTmreJNTCphiSiiDYakWsvM3kqs34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8T9z7QSNYotwDQ8swFId7sAWuyzG7tkcTH/u7lITq/qJQ6j/i3j7+PE/XsnTPgTKVCsbdQSUesgz+K52qa5yeJyjQ5MPNxU1BE8cvzskjeVWYF6E3KB/9/O+QOeB588Ooc7bdQFmdhTosbVH+Nh+RB1YgRElS/n8fW7aqfdRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeZX66xb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7104f939aa7so5168593b3a.1;
        Mon, 05 Aug 2024 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722891303; x=1723496103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzipGhysRj+IbI54DfvD3aENRSppo3XPVU7foYcloPs=;
        b=FeZX66xbTKRoMpBREt5BqsF3qShEoras4Sq9E7q63KkbLEVNO4s0TKtAiJhCszfoE9
         ZOOBLM4RyGP9oV1N8mm9HqutojVCSGmbVmrC4p41EQGoyJWaMnNh7gVd1sTGunqhJdSL
         aQuDvQwCpNoKOtePOple43zOxRSHfObRoBwtGsszEcpAZTHaNRkTmuWwkLb947mN18s0
         GbW2QUpzCGHeHa9rYe35l8NJTVWwQ7ZVGxWLTktc+/ouB8dLK0M3pEHbSsKHMQcwoUfv
         18/d0ssxSV6s+TZZH5LruSVq2eaY646NfqLAHEfu1ca05G6uv3w+waZYp05OzroFEeEr
         QcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722891303; x=1723496103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzipGhysRj+IbI54DfvD3aENRSppo3XPVU7foYcloPs=;
        b=RBOde3ISkOnDM1FVfmgGCPxyvYmDlWmkjtKuheJVC0+k7RXJ7GTkkirth7qvPzBQV3
         0L0qFx8T5JBmdVqomtKOgy/Pfn/H4dnNig3T+WGUSzN4vNoGM4eCy/JB+LHlnvfPny0Z
         VX6E5BOggjdlCknRfHGh08Etp10FpLPtdWWj5qPtsMyrD0ktkU/4Lcv1Clororgfma4o
         tK+OsuMkXsHwus/I24sCgGvZKEoJlArOZwx7rigXPgbbkC5Z3o67zyg5To0VJZcF4VG0
         h9Jn4ZHG9Ufl8TWhFX9QHCCH14jlpamRyvkgAvENTz2r/e9uxomGBTfz0atPYbyCIhLp
         mbKA==
X-Forwarded-Encrypted: i=1; AJvYcCW1GIeGZhoP3rdOgCIV8lzXRdl/fN4H1em5qh721AwRxH2b6idOW7H1Dt1k2XecBaqb1bo4nM3biGz95UvMVbWD1f8lZSMAY4bm1vRJRKJTmqUvtKIG7B8ASZ9GFCvpDpFQSbBKbKMbrGI5+fTeVdQGJEZnrYpjGKsrZgiJJRW96X6XMB0rbw==
X-Gm-Message-State: AOJu0Ywpk7eHk0xASS4opTuUOb77+MfOHK0bO/Yh+JlnhUKlHZxQ/4KE
	qxwMOhfkGzS79xKD1g9mVNn3Zrd57KxgCeDnGhV5dRWlUKoPCJVGkXKz1A==
X-Google-Smtp-Source: AGHT+IFHcN48KYT1kcKZeuVVSlXLMWD37eHdUQvwWWKcsVpoW9sz74Y6DG0lWyvB/2Hb7Amp7A8N+g==
X-Received: by 2002:a05:6a00:1912:b0:707:ffa4:de3f with SMTP id d2e1a72fcca58-7106cfcfd8dmr18013680b3a.17.1722891303433;
        Mon, 05 Aug 2024 13:55:03 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76393ee22sm4874855a12.39.2024.08.05.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 13:55:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 10:55:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH-cgroup 3/5] cgroup/cpuset: Eliminate unncessary sched
 domains rebuilds in hotplug
Message-ID: <ZrE8JW4Z34am2YU5@slm.duckdns.org>
References: <20240805013019.724300-1-longman@redhat.com>
 <20240805013019.724300-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805013019.724300-4-longman@redhat.com>

On Sun, Aug 04, 2024 at 09:30:17PM -0400, Waiman Long wrote:
> It was found that some hotplug operations may cause multiple
> rebuild_sched_domains_locked() calls. Some of those intermediate calls
> may use cpuset states not in the final correct form leading to incorrect
> sched domain setting.
> 
> Fix this problem by using the existing force_rebuild flag to inhibit
> immediate rebuild_sched_domains_locked() calls if set and only doing
> one final call at the end. Also renaming the force_rebuild flag to
> force_sd_rebuild to make its meaning for clear.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.11-fixes.

Thanks.

-- 
tejun

