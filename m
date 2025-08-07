Return-Path: <linux-kselftest+bounces-38483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F1B1DBE9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AC272214F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAD101F2;
	Thu,  7 Aug 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejy6su2w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA2BA36
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585143; cv=none; b=QunYWTvE1ahdLMra8KgKxdakP6cq8AUtwc+KrPNiEYSwBQpgZEiqm93nON5xR3V37GHReCTN4A2vxtPqd7YCKJk1/I7YJyfXkBnRgMIR8kk1S7EFQQ0xLxWDrLLUSBazjrqHW7FjV6AcYMhFmN+6jnAwK8izZXEjWP9UkoxYxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585143; c=relaxed/simple;
	bh=DnbinLqQ/SZv5MEYtpqvtmUWrOq+jq1hEaDbmqBlBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6oMSc/v0eh/IfsCwSoPextl5IJF8ShvvUn+pdK3dbsKw9BxlCyXhFGioMsDifvG+HFplLLOE6RTchmoO4NbVbWRl6JakKq6JAA3cynERMzZclLHP0MZZpKYdEJ1JSsVm9/9WcsdLySK05p5zO5eoy3kZeJxG3zLfzfMxU9TQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejy6su2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754585140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ5oeu3kAg6HS4OVA9rb//xbi40No26cZ49UiO4tWTM=;
	b=ejy6su2wN5ZJAfDkGH1leOaJEVgVzrb4zi82Z41vH2G4hzi55FGQMl3nxrntcIL6yT/bBd
	9MyjxCYjW2uPShkpKC/QxN4Cgs2iEP5KXuknvgo5DTyT8AdpxadIZjmN8K0bFxABQdLka6
	O06fJpBJOaWx9iHh8nmRQhb7CfoWiq4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-gsHcVQqpMHOtwknZP4RCqw-1; Thu, 07 Aug 2025 12:45:39 -0400
X-MC-Unique: gsHcVQqpMHOtwknZP4RCqw-1
X-Mimecast-MFC-AGG-ID: gsHcVQqpMHOtwknZP4RCqw_1754585139
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-711136ed77fso17213537b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 09:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754585139; x=1755189939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ5oeu3kAg6HS4OVA9rb//xbi40No26cZ49UiO4tWTM=;
        b=H92V8QEg/OktbmzL4ticXuASbOJ8SnM6vv+SRgqomfKTkjQ9WUSx2shYWkFEkZlGJ+
         Nj9fazC8ZZ6dJatJmOHBbGY/m9kg5hktkL5x7pl9baURhrjZZwv4BKrdm2WU2hMrlSIb
         EAAmEdtuM4i9HOfAfroxMRMDlDfb3rWZ1zy2CX4HgYaOkzfMXNXoSynctbN13oJzqIl6
         WbkQQUoDJyVsARMdzZftWyKqUlpifUOvytV+y6D2ePQ/ztJXF8BassHwQ7tvbVIf1elH
         +eYj/xr+bSnGrrLWzxCgzP+TNArp+8U97ka1LT5AfOG2k5AVRBU0x52VSlSLvAMgVOgf
         dSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmBakde4T1GM4b6weW6Z2cDzcwLelLXB6r+oswHwE10pZET4xicv8lcbkFQNsbrzHLwcyWu3JNo931/kZlgA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaERUUQt7ioKE57njzoyThANNWQcl2p2f7m/ZmaRHfl3KBdrK
	ypoNb6yBvKYhd11fEsSN2dPS3LXDUKMoBoglSC2wpIZvQTD2Ug5Yb8tRfIgkQGzEB7mNL0BzU4h
	KVh3kpWOnsSHAaQQyN/pZexJiqh3sHBOI8HzEjiERvaVUzIdnQTWf+yuJ8O6bBuZk7osYfA==
X-Gm-Gg: ASbGncsDYBR9agy1BXXLZNH6spkL85PE8Lr5kSOLLzz6IDZZqbubDNI24YOUE8SMfOF
	FTHsJZl7aK35FbAN6R7pOcKw1cxn3Rbb5WAH1Y3MUnYF4PzHYag9iYr91gqcx/YPp8KcldthoMe
	+JhITWAsV081YuIYYvHd7yc1e0s5YIJsnvdPorvM/wmu+YnuGXrzKAeG5JbyWxe+NvxUkdqrZ8z
	pWYFphE1ztNGyJ31GS4xeGVnoICJ17Usx8c/YKV8BkCqZxeKtqIVBy9X3qa4CSXV8YoyYoi4oVe
	aIsyTE5Es/pq3IyhqQWrohA4wqrtHxO0OM93QzgMrkXbJu19+LC1m610xoe8GRUHwHMDwO7ZDcp
	fsfmn3GJ89LV+K13+XxWaqg==
X-Received: by 2002:a05:690c:2701:b0:70e:2d17:84b5 with SMTP id 00721157ae682-71bcc53c148mr93209407b3.0.1754585139003;
        Thu, 07 Aug 2025 09:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgbSqJY7+1sIhtBagdJKAXgNAdJDwXw5O7GuTQuwI9yzsV33fmqqWR2xnGe9+z9PsGvblgNg==
X-Received: by 2002:a05:690c:2701:b0:70e:2d17:84b5 with SMTP id 00721157ae682-71bcc53c148mr93208937b3.0.1754585138431;
        Thu, 07 Aug 2025 09:45:38 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b83fd71afsm34285437b3.19.2025.08.07.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 09:45:36 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:45:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, jackmanb@google.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <aJTYJjj1pCWr-q62@x1.local>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
 <20250702152057.4067-1-ujwal.kundur@gmail.com>
 <aGf_W_ZgIf63dmAz@x1.local>
 <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
 <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>

On Wed, Aug 06, 2025 at 08:33:06PM +0530, Ujwal Kundur wrote:
> Ping -- please let me know if there's anything else I must address.
> I've ensured v6 still applies on mm-new.

You can try formally reposting your patch, instead of replying to old
versions.  It might be overlooked as discussions.

Thanks,

-- 
Peter Xu


