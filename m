Return-Path: <linux-kselftest+bounces-27452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E12A4405E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7604172C47
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06415268C4A;
	Tue, 25 Feb 2025 13:11:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D681EBFE6;
	Tue, 25 Feb 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489113; cv=none; b=W+fkG1Bf+Eu8h2eGlfMbIPP9DEcHybxn++0zD1Gmssz9PCgzlbt5J9hFkiGJp1kjaULSTyuo9n4PmpM8eXtWV+P9DWjvl3othYWZk/qSjEa8ajWTkQqnrXnJvJV+jvN7aql5TTgQbHD4iRvGTgfD5PzerWmmXqgz/Aryx6wEwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489113; c=relaxed/simple;
	bh=Tc06KpHhdncY5vHPplX6+roo60GBAPDBnABoT57FjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndxiqQHTqEEgFSLqSShj/ERrVAbkc1z13ALCzDdiAtWFZrIOd5CLlfPcxI28gtfV9I6XhfCx+8MBZzAXLjuFTt1EDXuaLdTzjNnYh5ucXcVo5bUisCBuxSLhMynT02L9hGRY2zpyVbzMGWbd2QtfhxBsCqrXpbBIaAnlDRmNuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abec8b750ebso214848666b.0;
        Tue, 25 Feb 2025 05:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489110; x=1741093910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWZOk7RRTPc+ZkJlzirhO5rrxb3g158YcdwUTbEdDw4=;
        b=wrbTf7ye80IbNV6wsoXQuylnFBcomRrzkUdugE8PXgSOmOWxbACLt33khj1WxaOHZi
         c5bNt7c9MlUcwDgH2/VF7dNs8pDZFwrmSysgZHHkhnGwdGFj/bPp1u2yEir2o0Rx+xi9
         RRSTMy5ojbyHpbvclS7Yk4CtsBJDncTvZvVgPmoT5NwN7cALuGlQunLy09vOE4iSG7I0
         NMpp4FSBfsWpWHsisuKOUHaPhOV+Qg1yfdaotPCjWNrGtcCXn9FWYjd7mMVA0DIz9Lrc
         Y56IWOTicshOOAIBbfharFaC7MahfElwSXHYgOGwpBBomKAyDyfPiLwnByWoT8HoEYKL
         9Lgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ykirT6upriIeMshKlZjdsFfoXh7zOT7qLj89Fxz1glTpsDqQjAEj53GgpCAttZ05ChKMHrSymQM1ZauQIwLX@vger.kernel.org, AJvYcCU8faJf3v2IGYqkMn/dZId8hI9U9vR2mZspGh88izXFgkHkYQUuHjc/z0t9mS++Twu2i6RoAww+WgM=@vger.kernel.org, AJvYcCVnPZM//mx8FozPXR3ZJBqG34tuZdun8Gd9VIN+BzVVKYsVQrTatsF2dg+ob8YlwrPLPk2NCHVk@vger.kernel.org, AJvYcCWeIBz+8DklpxHTH6jbpNhtL9csjfm9rST06lJKiUMYW8C4GqLKgiQWnQH1nyUz3W7FDkG8IeHvOqQQAxkS@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmhaqZBB+2Z0KPczejHjjDqTacTLwHtg1B+NFaFuGnkfQe7E/
	U4USfjXBQCuYNVMpQugdgFeue9YMOmz+ITKypABu5pWj6nt789k5
X-Gm-Gg: ASbGnctGGbNN539bejVkkf7cZSdsrPx9YupE5neCQtZSkxRmOCWCYQZ/Gckycbnb51K
	XAu4JgtX2AhBswMKsn+V9yNYJDz+Vqn9P7W2uOQ7K4rSRdpfsYra3PdqcCZuPbp/8eTW4JyvpDA
	2OxHs5LwWUXA9rUjkBB2pD+iTk6cS7j3b9KeOMgmeVhdyknHTgs6Iz1cWs8EWsshvictlNfg8jO
	43HZtAbXQIZgD9ClnNUfW61fpgjXw7SbLJ2zym1I2X6Y/ruT8TnJh6hCQqeIJcEB/Iv9+qL85FH
	v0S/8epvRg6Xuw7I8A==
X-Google-Smtp-Source: AGHT+IGFvHYwvYql3mUsikF1Ks4rOTcJOh62lrefJB9Zvc8mdhl4bBBxZZYSPaW8NxhpSJFjRt6GQg==
X-Received: by 2002:a17:907:724f:b0:ab7:bf87:d9de with SMTP id a640c23a62f3a-abc0de146b4mr1561996666b.37.1740489110209;
        Tue, 25 Feb 2025 05:11:50 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm139993866b.148.2025.02.25.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:11:49 -0800 (PST)
Date: Tue, 25 Feb 2025 05:11:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
Message-ID: <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
 <20250225-doberman-of-scientific-champagne-640c69@leitao>
 <d0e43d0a-621d-46ee-8cb7-1e5c41e76b8c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e43d0a-621d-46ee-8cb7-1e5c41e76b8c@redhat.com>

Hello Paolo,

On Tue, Feb 25, 2025 at 12:53:49PM +0100, Paolo Abeni wrote:
> On 2/25/25 12:17 PM, Breno Leitao wrote:
> > On Tue, Feb 25, 2025 at 10:19:10AM +0000, Simon Horman wrote:
> >> On Fri, Feb 21, 2025 at 05:52:10AM -0800, Breno Leitao wrote:
> >>> This is the core patch for this whole patchset. Add support for
> >>> including the current task's name in netconsole's extra data output.
> >>> This adds a new append_taskname() function that writes the task name
> >>> (from current->comm) into the target's extradata buffer, similar to how
> >>> CPU numbers are handled.
> >>>
> >>> The task name is included when the SYSDATA_TASKNAME field is set,
> >>> appearing in the format "taskname=<name>" in the output. This additional
> >>> context can help with debugging by showing which task generated each
> >>> console message.
> >>>
> >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> >>> ---
> >>>  drivers/net/netconsole.c | 14 +++++++++++++-
> >>>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> >>> index 5a29144ae37ee7b487b1a252b0f2ce8574f9cefa..625f4c0be11d8deb454139b1c526abc842697219 100644
> >>> --- a/drivers/net/netconsole.c
> >>> +++ b/drivers/net/netconsole.c
> >>> @@ -1179,12 +1179,22 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
> >>>  			 raw_smp_processor_id());
> >>>  }
> >>>  
> >>> +static int append_taskname(struct netconsole_target *nt, int offset)
> >>> +{
> >>> +	if (WARN_ON_ONCE(!current))
> >>> +		return 0;
> >>
> >> Hi Breno,
> >>
> >> I gather that theoretically this could occur, but it isn't expected
> >> to happen in practice. Is that right?
> > 
> > That's correct. `current` isn't expected to be NULL in practice.
> > I've been running this code on several servers for days and have never
> > encountered this warning. 
> > 
> > While the taskname feature isn't enabled during early boot, netconsole
> > might be active at that time, which is why I exercised extra caution
> > here.
> 
> So `current` can't be NULL here. I think it's better to drop such check,
> it's presence would be misleading. i.e. like adding checks for UDP stack
> being initialized before calling send_msg_fragmented()

Ack. I will remove the check then, and check if the UDP stack has been
initialized before calling netpoll helpers.

What is the best way to make sure taht the UDP stack has been
initialized?

Thanks for the review,
--breno

