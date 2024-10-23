Return-Path: <linux-kselftest+bounces-20465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB79ACE4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4C0282515
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A51D6DBB;
	Wed, 23 Oct 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyxQfkZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982051D278A;
	Wed, 23 Oct 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695937; cv=none; b=YtmkANdfx2vaoFCMNaRWC7ZcXeQEFzZV/vHkn5RoTlkubh/1qTblGsMPlkFNF8eORkBiyGi3flPTB5y7I25Ffc7XY9ONwksiGFlZarjy1WSAovGSVJtYZUYBFiOXfDwfBE/z+d8apAII3peP6D5kUPmRcO7SVYu8Ux1tUBWGw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695937; c=relaxed/simple;
	bh=6dqizTZi3MjLkY7UZ5URJEGE70fGc1UGn/v55vian+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj3Nzx1gioR/p6U2cHOD1VPSQ6kp8oH1pQ4hu/ZUTxdQg3ySU8a3hnjOIlQ7dUlb2DAKeiK0sQXAA8ElQfVflGp2WYU25ff58aCesgYCGpScyOZCW4eR0nh8xjEpOUox0C2S7xvkL1ZYWhtY8TsgcbRxB1Bmv5cTRFlHFaBEC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyxQfkZQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7163489149eso5291821a12.1;
        Wed, 23 Oct 2024 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729695935; x=1730300735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/xr6R6L67/bTFViqslA7RLr8Ha+9B35qwhr0RZOMhQ=;
        b=JyxQfkZQTe3JuuY9fJlgT2WTAs5FJBx7noGfvXQcjLIXKLVKLwvvu7dsEbB5DQIkpG
         HbiGUeZMNAfEvDCCuuAxhk4OrWxJscyEUbBiwzvBCl0g9WaSwG90yuS+9kS/KtpB+BIz
         /BpZd8YH1/E7C57qxvfX+tuh2UQ/YyQxiSfA/B8AF1aPM+qhPowaluYjHN149i9Rj9uP
         JQWKvBJs/I0obN68ET9frEdMQd1WiGUsxVtUYlt9jI9KA1LvoYtGUmPkoSM1TwY57X8R
         0a2eZatHwNlDdlubJQVozrbEQtitXvqaDVs9/Utr3m9rjp99tQv0qvVxQWAhcpL6pB5T
         ZAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695935; x=1730300735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/xr6R6L67/bTFViqslA7RLr8Ha+9B35qwhr0RZOMhQ=;
        b=YFe1+9E7ndrs5EE/3NhSJ7JdbB5tILCvKuMr92SKe+8heeV2XQ0uiwfBWdIopHoaC7
         og8HIkLKe0aZIt87vLAYHP2vc+25IdZZ+Do2aJ8TUFt9ozutlG4vQJpGA1bgucCigzL1
         OfJn5cgxqBUj2VsqO/inETQWzbUiyYI/wwYwWlsRiDHDvlINeCp1mT9pxHyWiGfKwGAh
         hP0w5MODVmpgBXbOVvSyyzah16xGKjrv8+I/apuE8bH84NuOrsiazP1HJjUz39UoeaUe
         N8lub/ZGi3YMs7EEdYACAlOAH7v7viBDQdyF6aMhtlfdJ04WzZKh7pKhIJIoh9kXAcAZ
         PM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZV3/+Fg54OOCD1qCj6UwW9A3bZSDMuk1SZNNrmH/qX8dO+6kiOM5WL4c+08FiNBltLkssy+Oz@vger.kernel.org, AJvYcCUj6NXP5UKoA8ihyglBjVXnqIcLJ6/R4qX7BU2CGZkqs4x+iXHljNlItft39B3iThphxPyIfnaQUrI9z8Y=@vger.kernel.org, AJvYcCVOFIyqAdgmdraP+SxjMQaSbMpIYzYI9H5e745KdrX5SmpniFH8M5lvO6VMbrt5Y2n7X4kSOiVnRhhLBREitzmp@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWPPzJkXKd8B8as06Hi/yXnLX0WZuu+BaRvN5acfeleSU+KGq
	oY+1FVFf2+/hxObNc36bFS90cXoRTRx+N7ItPU4nKArn1EcxxEM=
X-Google-Smtp-Source: AGHT+IFWJ753ImcFrdZjWX9Z2JRm17SUYFzy1gfZEpI0eTGGy7td2Fby4f8HOsgJOYX31jMSxkuQRQ==
X-Received: by 2002:a05:6a21:e8f:b0:1cf:6d20:4d6 with SMTP id adf61e73a8af0-1d978b0a072mr3128784637.16.1729695934731;
        Wed, 23 Oct 2024 08:05:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d05sm6418000b3a.35.2024.10.23.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:05:34 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:05:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	Liam Howlett <liam.howlett@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <ZxkQvYNVGA90srE7@mini-arch>
References: <08EFFA25-7C8F-444A-B229-2A9F99B0C028@oracle.com>
 <Zxg6KhhpCGc-5Mw0@mini-arch>
 <39B736F3-F7E1-420C-9567-0447464A95BA@oracle.com>
 <CDE1D110-A3F5-4BB7-A8DF-4D24E2AC98B0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CDE1D110-A3F5-4BB7-A8DF-4D24E2AC98B0@oracle.com>

On 10/23, Anjali Kulkarni wrote:
> […snip…]
> 
> >>>> 
> >>>> Yes, make sure all required options are picked up by
> >>>> "./tools/testing/kunit/kunit.py run" instead of manually adding options
> >>>> and doing modprobe.
> >>> 
> >>> The environment issues are resolved and I am able to run kunit.py, but my tests
> >>> are not invoked without giving options via —kconfig-add. Other tests are also not
> >>> invoked. Running with the manual options runs 413 tests, and with just kunit.py
> >>> runs 389 tests. (I have added 6). Any idea how I can make it run my tests?
> >> 
> >> The runner does: ./tools/testing/kunit/kunit.py run --alltests
> >> Is it not enough in your case? What options do you pass via
> >> --kconfig-add? Is it because CONNECTOR stuff is disabled by default?
> > 
> > No, it still does not run.
> > However, I added to tools/testing/kunit/configs/all_tests.config:
> > 
> > CONFIG_CONNECTOR=y
> > CONFIG_PROC_EVENTS=y
> > CONFIG_NET=y
> > CONFIG_CN_HASH_KUNIT_TEST=y
> > 
> > And now it does run.
> > Should I make the change above? I will also check with the kunit guys.
> > But I do not understand how it ran for you(and run into the error), or did
> > it just try to compile?
> 
> I see this in comments on top of all_tests.config.
> 
> # The config is manually maintained, though it uses KUNIT_ALL_TESTS=y to enable
> # any tests whose dependencies are already satisfied. Please feel free to add
> # more options if they any new tests.
> 
> So I suppose if a test needs more dependencies, it needs to be added here.

Let's try and CC a bunch of kunit people to confirm :-)

