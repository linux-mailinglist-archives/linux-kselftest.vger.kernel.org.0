Return-Path: <linux-kselftest+bounces-10310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA6D8C7BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 19:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EECC282533
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A2157E94;
	Thu, 16 May 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElkqVF1i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001F156F4A;
	Thu, 16 May 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881540; cv=none; b=B+nE6cFrf+7gfLwHolaLasS8+uHF07O6+Gwb0nEOC1yWuGulv1NMZ4FZ7ZWtoLgG9UAMxzzUMO6Aoh/Bj6xb8SWSi5u7WbOXua6RjNFXOhO3Zia0lrVcz+iDI1VAJ3MXWPhbaHHCkYB38RRqJBHgvuPCh71dDNEo5rieq3LGpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881540; c=relaxed/simple;
	bh=E/3pnk2wvJWbWjkCIlp3StbecE2krkUxne9N/a4lTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4NQYnyHSQucbcYOiZ77A870xWTj60mNz7EW2mdsdG7FyCXcyUcK6TInxW9BETqz2K3Ix2KU74zLHV7j4BSrVqsmYLDqwsE3KombOcppfWpirfj73bqKXjhT6LJyBHzhX1FwByQuR7fW7kwj7B7IWG/MGL+8tLtL1rEOLktYqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElkqVF1i; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so372096a12.2;
        Thu, 16 May 2024 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881538; x=1716486338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OKXT2yQV18smkMXEV71PWPVmMK2iX3mlxflAHtbH2E=;
        b=ElkqVF1i8aE1zecFUWp7W6i9yhLP+w/pKj6eFy/GC0cWuD15bQ4q2hiRz9SqCZ5Cm9
         SiZyNGY9SXC4JY5Nn2wC7pskmtCFqJ3NwwjQBCiQrpmQkD8oDyzZKgglsdCOYRcHevTe
         42nETO6MyMvn6WAOS7EaAYGQKJT4jl9MQFo+XPvJ3cF2kXtT+x2In3ySuOdbU4Y9r6s6
         RPhnN9IyTEO9cYIkkXvWP8lfMojtRmcKgK96nhLKoV5t6winSGWhQwDvCgOg5+JbKEIw
         ZpYlcflYN8t1j1X4THWRMvVZxYJJaryOU1J1IUr+UrwQZTeP1IZu/L625BbQcw8CVHo3
         aoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881538; x=1716486338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OKXT2yQV18smkMXEV71PWPVmMK2iX3mlxflAHtbH2E=;
        b=Yew6iKRflHo0hGAH5WEJoQkbdy70KSQ7GMbwAGwCPw/VwHid4Jon88D6poNh03diQM
         lDfHKc/o5Z2rI5mrhg9uTO7Af7pD0b5/wfEcHMl3vbkNiv036ciPblhxdTrpwPbkgtvd
         K9hh7DJFNySKNh2rQKwwGeamp5MOYZwWBZsl2+JfxZfdJ7YNWtNXhXJv3V8x+e6K3RIC
         eROnTJxsroffgPuxfGpXY8+M9Po/IDoiC42EBzRfbqBGSR7NEZxkA2zN7mGUNYA01mQx
         AbCZ6NO1coKPQRZLvXa64DM8lIuV7GrC4+HLF6+X5+ARoEjnzfL9ctmJ9VHSoy05UB+J
         iXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZRGVnejs6kymSUY1FOskmlshRkjWKFu3MdYM7tcOO9riRlXH2RY4Jk2U03S9uxMp4H350IejWWS97eOC4TUJRD33Mx1JF3mPtzHaGCqSYi3T8HAc/OAFZ2ap7pPIDhoPCeUe9DfRG6/VCrlsHKlRMjw6ykxYq02AKd+rxt9HeWR3E/s0TJUeM1PbdhK++z4s2rBCtckKIjlyVdaBW0w+CInIL5YkAI6R4e6u5XL1EGnLpdKRnOtrRcg9OUm/bYdUoH/GWcpX54Ax93ZwelwmH+2Utb6sBydzhw==
X-Gm-Message-State: AOJu0Ywpy5VGPNnOIxaTQ6oxezUS6+DPAD2PiDZFFpnRBRUhMsJ8WtiA
	R4i2tibflMXY/HAY+rR9wmFPBukoiVQhg3zQ2EfwSZA/Cl7+5/W3
X-Google-Smtp-Source: AGHT+IFlZdXQSAQjhwGSUSzAdvLTZnp4jX0Virj/NxOh9XLSYQQ0tW9XIzm5+SdWPO+zhn0VKlQUZA==
X-Received: by 2002:a05:6a21:3d85:b0:1ad:746:3f61 with SMTP id adf61e73a8af0-1afde1159f2mr17942555637.28.1715881537769;
        Thu, 16 May 2024 10:45:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f2f0b6absm10208151b3a.76.2024.05.16.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 16 May 2024 07:45:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
Message-ID: <ZkZGP9Io6o9Dhh36@slm.duckdns.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
 <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
 <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>
 <ZkYymMDd690uufZy@slm.duckdns.org>
 <9e72d97a-9a04-4423-a711-0c21c1c8b161@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e72d97a-9a04-4423-a711-0c21c1c8b161@linuxfoundation.org>

Hello,

On Thu, May 16, 2024 at 10:31:13AM -0600, Shuah Khan wrote:
> I am exploring options and leaning towards reverting the patch
> 
> daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
> 
> Your amending the PR helps me if I have to send revert. I am sorry
> for the trouble.
> 
> I can all of them together in a second update or after the merge window
> closes.

The cgroup commit is already pulled in unfortunately. Can you please handle
the revert and whatever's necessary to fix up the situation? I'll ask you
what to do with selftest patches from now on.

Thank you.

-- 
tejun

