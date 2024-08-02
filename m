Return-Path: <linux-kselftest+bounces-14695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3BF9459A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 10:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3471F21FBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EAA1C231C;
	Fri,  2 Aug 2024 08:09:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF133D6A;
	Fri,  2 Aug 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586147; cv=none; b=FvZqZNNrqXgzT0StVRsPQBQTLN2VRUqPg98GR5sRwo+xYYoAi5c4y04xFGxeIVxh40sQ7CPFooF22EIhEXcYwc9QpQWw6iGmmhRSSRvsHklfTtLT6fuvCskncPIMLl6WOky67mjTv6rZYtbsTkMSrXUejfL3jX8doYtF4Lh7v8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586147; c=relaxed/simple;
	bh=Zp9EI5OCVN/DrlafofP7/8nWGubayZQSFeHZUyxUuPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAsbfQCiZWd8X4uwuzBIRPPyqzhSbbyY63KAGgwBPlmtn8aJM1UjDKFuWYZdnssRqseyyrdI+zo8woRcwBMpmanLSITC25vIFqNMlvcf5O6QmspSspDDjZ1Z8/uat/H287S+iXl2EDZNKTxfAOkRP62Fd2PS5oUclphPtCoe8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so10970096a12.3;
        Fri, 02 Aug 2024 01:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586144; x=1723190944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k6PCzJzChjhZx4W9GMM2CEphZr+afr1YrAs2NqKqiY=;
        b=voR7beevD70zaZapxJ4D7YJzl/s4/XqyzXUcGyyJq30FaQ2UwjsofqvR8RB6WOaRAG
         huyQFFB4fhdDKQqVjdpgvVK/58N7UjNSF58szzSs0U9mEHExRRvJcj1Zxg9xslVCso3X
         o094Vrei6WhvOSSL2DXiYlr2bCIfZv7jonctsZnkO2KJYRjmKNfjIokdXSOzjmV7qN5q
         cZDBxT5z9hbODXBvBpftJxrCskWB/oTHDIcVMTLXe7YZ50GRIbMJN8yJSLiT2TTUvwZu
         Q8mgbu9liPxuMd0t/3bJuV/mWbgcekYNJKOldZ0hCKERsrzba3Unt5FBFShzowahfJ1z
         BSXA==
X-Forwarded-Encrypted: i=1; AJvYcCVd07E3iZxC57JhIMA3AEOPq6kqtfumiv6EnkVLm7BalnRm3jGKOOGFoJNQXN/rZqXjL5E/KrCJbzYAxZocuXhMR+f3LXDfe//NMPmrc29Eiti9t8slIlnGqhxAvLx1AcO4vl3uvsM8ply+sfGCDyEbIHWTJjLH15s+YlDhfDr5ZmmaZ286
X-Gm-Message-State: AOJu0YyB5I2Qt573n59Mk+3kiGFlEs7vuysBaYUBafOtJEl1HZ7GFz9g
	zQgL7bzLAJqr1QIF0d4IW3FklYj7PpyHRNV5bbESHk5pL2mBVY5b
X-Google-Smtp-Source: AGHT+IHZNov+DE6EzlY3KLu7YZJLxLM4/IJbXU3Go/m5skcb3JZjpjdZVZ/u69FOmgTvF+GuH/+PAQ==
X-Received: by 2002:aa7:c3cc:0:b0:5a2:cc1c:4d07 with SMTP id 4fb4d7f45d1cf-5b7f5414436mr1782480a12.27.1722586143435;
        Fri, 02 Aug 2024 01:09:03 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83be39fa9sm771885a12.82.2024.08.02.01.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:09:03 -0700 (PDT)
Date: Fri, 2 Aug 2024 01:09:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>, thevlad@fb.com,
	thepacketgeek@gmail.com, riel@surriel.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, davej@codemonkey.org.uk,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <ZqyUHN770pjSofTC@gmail.com>
References: <20240801161213.2707132-1-leitao@debian.org>
 <20240801161213.2707132-2-leitao@debian.org>
 <20240801095322.6d9dec9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801095322.6d9dec9c@kernel.org>

Hello Jakub,

On Thu, Aug 01, 2024 at 09:53:22AM -0700, Jakub Kicinski wrote:
> On Thu,  1 Aug 2024 09:11:58 -0700 Breno Leitao wrote:
> >  .../net/netconsole/basic_integration_test.sh  | 153 ++++++++++++++++++
> 
> It needs to be included in a Makefile
> If we only have one script I'd put it directly in .../net/, 
> or drivers/netdevsim/? each target should technically have
> a Kconfig, Makefile, settings, no point for a single script.

Thanks for the feedback, I will wait a bit for more feedback, and then
send a v2 where I would move the script back to .../net.

--breno

