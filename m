Return-Path: <linux-kselftest+bounces-10003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD18C22AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574DE1C20429
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F8616D326;
	Fri, 10 May 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7JO9ne9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11416ABC3
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339079; cv=none; b=Yhbo4GyENceg9x4xM4mJVKzgJHu2aMCM3kKEy8giQA+1ERoNkafqGI3SPkM0IsjfxArMOozaPhr9y4WRO6FzSgX39UMSUElz+Y0HODL1/4HmJpqj7VVEfLCvu05F8Cft85Gu/OE27Iw9oUqFO1fCqev79D19fYZFhu4A0VyTgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339079; c=relaxed/simple;
	bh=ZSxrkHhk9TQzCx8yCadXPeLHHj/w7sGguiT2L35q54o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6M7wRAj+2cclP8MPjCbRbUsUnexG7rEQG41LNuTank7cRT6SOsrtqAZlkuMwNVxmxp8UG2jYvrYI331IzWZkrCRVgmE+RCAImV5C5/toI5niPxxeIGrvFa/WdY5W4/XUIb6Uh3879ehGHTbzHdxQwwbPHxlmoY+wHFQzL3zn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7JO9ne9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34dc9065606so1005093f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715339076; x=1715943876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SK/dC7x2I+p3FAI3gVYVOnVrviG0LpG4AN59Ccpo1M=;
        b=F7JO9ne96MhbVVd/Uv+RYRxXgA907sKyXLHwsj5kUR6i0H5T9Nv0xkKorPZll4p/CC
         PTbMeEooDxeHFOYh2GeP3s7LMd76r8FvryPHZnheIpRtxFjiWmG5FMnd3QdAavJdm/WC
         RDzBxNFobVONKsOuVJMtYeCTrazFTC8I5NWfAhV6GAo5CZBkXStAe8Alf1viItRBrfVC
         wXVWs0NtB/mFI1vRUU3kspFt+DmZgqLVqN6wi+QBgyWqmHqvbz6YTiJ7Owz8Ms9T6td3
         09HRgXigr3FGHYuzg5HPkBYddUGWZPmDBnnKnDEcJmwLr5cCCPLBfzD5ggVEapxOpJNI
         54vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339076; x=1715943876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SK/dC7x2I+p3FAI3gVYVOnVrviG0LpG4AN59Ccpo1M=;
        b=tMDWhz4hSm3Ekf1PKShT1IKzn7OEmaXU20Xzl50nYdjj2C4RF+/zTDNeIcrmNhpdB5
         x42QF7TJN9ZHWx9eEoB6wb7BGwgHA0CX21cGtcPS7qVBAGFHe59RXptoEtVAO86qElgh
         OxZN+9fw6DGT98BJboxFo6coGhVAEwsKWW6qN2Rhn2gu++rpUR59NtKgMEzqGZqcUP7V
         KmeleJjeV9L0m6S7yYooW89dOmqeH+KFiDGkbRHerTuHtWXj1t2xJ2E4hqGDF8rXhe/M
         kvMzOOSa+UCWFNEC/6DqFuHrgxS+Pd34ElTEJqBXxxS135HUyUVkugAhXI9S8HXsQt/H
         krUA==
X-Forwarded-Encrypted: i=1; AJvYcCXu28s4fg0KThgCqC+0ciEyKVn8EUOfayn6dcU13plH66CInT+HwzvMjHiq/g0uJWENo+5mbRk0b8BzTGULTgFsABrJK5ytGMIn4z1lPESt
X-Gm-Message-State: AOJu0YyhLRqNlKBCtt7xOgANrJFusNBcjaLF18mljZxQLtYrDhMGFJTk
	jIhxmoZLAI/eSaR9lpuFlPYlQcEMq/tqV6xcaKGO1o2xziOWEzk3R3TLaU+j+g==
X-Google-Smtp-Source: AGHT+IFArYCKmX2D8zPFkyLcEZmPLkBX+LQfN8jrF3BucrLTmsxbO8b0CqbXFMxsD0gLsQRXXd9jpQ==
X-Received: by 2002:adf:facc:0:b0:34d:7a55:5060 with SMTP id ffacd0b85a97d-35018113a95mr4886918f8f.11.1715339075493;
        Fri, 10 May 2024 04:04:35 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm4267905f8f.27.2024.05.10.04.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:04:35 -0700 (PDT)
Date: Fri, 10 May 2024 12:04:31 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v22 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
Message-ID: <Zj3_P5UsO61yp7a7@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-6-vdonnefort@google.com>
 <5bdb08a2-0740-4ea0-be24-a948332d60ac@linuxfoundation.org>
 <20240507193555.592a1e28@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507193555.592a1e28@rorschach.local.home>

On Tue, May 07, 2024 at 07:35:55PM -0400, Steven Rostedt wrote:
> On Fri, 3 May 2024 13:12:56 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> > On 4/30/24 05:13, Vincent Donnefort wrote:
> > > This test maps a ring-buffer and validate the meta-page after reset and
> > > after emitting few events.
> > >   
> > 
> > Changelog needs to be imperative - refer to the following:
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > 
> > Update the change log and describe what the test does and include
> > test output.
> > 
> > If the test requires root privileges - make sure add a check to skip
> > when a normal use runs the test.
> > 
> > The rest looks good.
> > 
> 
> Vincent,
> 
> Can you address Shuah's concerns. I'm starting to test patches 1-4 so
> you only need to send an update to this one, unless of course I find an
> issue with one of the others.

I will do, as well as with the VM_ flags change.

Thanks for having a look Shuah.

> 
> Thanks,
> 
> -- Steve

