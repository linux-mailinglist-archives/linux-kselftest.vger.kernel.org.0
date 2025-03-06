Return-Path: <linux-kselftest+bounces-28401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA79A54AFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 13:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8665816DCAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA020CCE3;
	Thu,  6 Mar 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0Xl756R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0D20C48D
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264931; cv=none; b=PDGSEaAn92n+1z24F2fsDX6A9Nc1vpEi7NzyxakPTajJwfoiGRivJyy2Y8gRfGxZNTrFRN70z+bEl00b7U1PBYXmJlH2HWMJyvYF5II13kmGNOdtJ4VukTk4SOuKkKu22HXqB6xORp37ov//H/19aVBnxzTWREQ2h4LBnXYr3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264931; c=relaxed/simple;
	bh=22gI3ylpHx/xFFYcb4YRhD6/V8m5GMoSsuIUika6lHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ioj5t8PSK4nyKFzjmEvpfxyX+hE9taxIY32h35hWwW8kJT6AlovjXaYmUkmj8KiDdWWXOWaWo5T+OBosoxy89oRObZ/bxTihHjMiF/EVwuWh4jEdiPjGArePe5GlZXllrEXZ884R4xQ52CcWD0glCJJNe3VwrI168XWjnh14cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0Xl756R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso50215e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741264928; x=1741869728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MRAkaS5reseLkYqY2aSknQ7KzyTvAIpY7HWZEUr9kQ=;
        b=w0Xl756RUrCpaii7yQEnO8R8gkUYHE9p4TFbCqDZvKte+f2aP7Ma36YoC6V6sw/bcu
         8QZUmjDFwZHwitoiB8I3SNYllqP7vfYFtrP8eB9dVp2MjJ7Y1+oWENrJ2RpG6NzfE2D5
         ukgZkSQqX81BcbwEDkizCAbU/zhYHPRf87iow9mAu34gpaWXDDRSsC8q8XQMno7JHdR0
         c9mqz9Jr2hhHY7dU0YKJqtu39dkFUC2BCLgVq1fCiGsa7Xn9jtVrohAB7/bAC8d2/gtW
         IpBwn6yjcjTJxjo7e2Fhmm/DmgY0OR3DRJSz4QPo43f3S52DlcvlM9QYkh0Ar8mg06yz
         Ffgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741264928; x=1741869728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MRAkaS5reseLkYqY2aSknQ7KzyTvAIpY7HWZEUr9kQ=;
        b=vfjoUU5Jr8W1IvJPR+/7FuUETU3mvw661Ri5gA2ZLr4OuJUkI6+R6Hs8P0ewghFNF2
         hTL/Wp468FQVRHn45hVS651os6SiAJdK6WPzelPhl5pAztvErig8H2SFNdlACidpSfX1
         hZoLzCv3FzW8dh3npWKBStp4hT8Hmjs0dEsJy0hvFk2FfTBB5wQzMtwdKVB1mC+ICajh
         Upf2c63q+PSaxCmBR0lwZuY/9BI+vDTiYCq+nkxSA0MEQebbsCAyD9G3Da6KD0KqmSpj
         ELnBCO0XLIwzY2qFEBBa+KDcr1vsC6BuIQT+DDIbFC2n6hze/eoUwHT18wfLOeu3ZUoq
         x0zA==
X-Forwarded-Encrypted: i=1; AJvYcCVr7xdOG3ngIWBrvgbniJ7dpZDqYiCNogBmt0yZuqSpCE5h5RQxts8cK8dfNtQqTkD9l/t6um1Qcmfu07f+UfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+HaiOWKzRhoEfSt3vugRkaK4UDQ+8QM60Sbstfu9IFfHSOjx
	0sjkZKV+kCVdvipPd+FJRipCC1z2OBQuqQ71s/1KRJ2WmnH7XpxCj7CKRb/Dow==
X-Gm-Gg: ASbGncsFju/y06ahq5H6wIBeTaeC0qZem0JxugryOMr6WZPnLiNFZXm7Lb8e1xzGggO
	NkrZ6SOdIYaGqj8NvhdQAZPgNIRUXzYCOD1lWuzl4Rjyn4J+Kz+0OTw39Og1hJYOzTGBw8wnHox
	36J2Q+gHqVc4Gfms6b0Owgy4jsQywHsYSa4qgMoP2zMSRwx6hm9RIebl+3SBsTjs3Co2wsMR3l2
	GFyPAFln/Eip6TDfpXUsz+uFEXRgBd0eqsqqaR6jGs0waMGfn/QNNvq+I0e+KSJ6AQalVgRz3xZ
	cez2rEKmGSpUN9uSAv1oidVwi+Eo0fR1pomsqxCisCI389IRaCw4WWfr0065N+vC09cEjwYh+uf
	yPrDn
X-Google-Smtp-Source: AGHT+IGmNXAcbrIiTndMd8TKLO7wDtMCWMyWdNa1KQz3K3QIoj6wzvoQxrplVkDQaNapk/ITigBdow==
X-Received: by 2002:a05:600c:54c7:b0:43b:c396:7405 with SMTP id 5b1f17b1804b1-43bdce18c53mr947115e9.7.1741264928259;
        Thu, 06 Mar 2025 04:42:08 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm1984885f8f.16.2025.03.06.04.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:42:07 -0800 (PST)
Date: Thu, 6 Mar 2025 12:42:03 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
Message-ID: <Z8mYG8eQnMsOA4c1@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>

On Thu, Mar 06, 2025 at 10:28:09AM +0100, David Hildenbrand wrote:
> On 28.02.25 17:54, Brendan Jackman wrote:
> > Some filesystems don't support funtract()ing unlinked files. They return
> > ENOENT. In that case, skip the test.
> > 
> 
> That's not documented in the man page, so is this a bug of these
> filesystems?

Um...

unlink(2) does say:

  If the name was the last link to a file but any processes still have
  the file open, the file will remain in existence until the last file
  descriptor referring to it is closed.

And POSIX says

  If one or more processes have the file open when the last link is
  removed, the link shall be removed before unlink() returns, but the
  removal of the file contents shall be postponed until all references
  to the file are closed

I didn't call it a bug in the commit message because my impression was
always that filesystem semantics are broadly determined by vibes. But
looking at the above I do feel more confident that the "unlink isn't
delete" thing is actually a pretty solid expectation.

> What are examples for these weird filesystems?

My experience of the issue is with 9pfs. broonie reported on #mm that
NFS can display similar issues but I haven't hit it myself.

> As we have the fstype available, we could instead simply reject more
> filesystems earlier. See fs_is_unknown().

Oh. I didn't know this was so easy, I thought that checking the
filesystem type would require some awful walk to find the mountpoint
and join it against the mount list. (Now I think about it, I should
have recorded this rationale in the commit message, so you could
easily see my bogus reasoning).

If there's a syscall to just say "what FS is this file on please?"
we should just do that and explicitly denylist the systems that are
known to have issues. I will just do 9pfs for now. Maybe we can log
warning if the error shows up on systems that aren't listed, then if
someone does run into it on NFS they should get a strong clue about
what the problem is.

Thanks!

