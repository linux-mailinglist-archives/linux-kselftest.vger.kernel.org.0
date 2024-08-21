Return-Path: <linux-kselftest+bounces-15828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D886959677
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42C22823AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A41B2EFF;
	Wed, 21 Aug 2024 07:58:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4531B2EFA;
	Wed, 21 Aug 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227109; cv=none; b=sR4xrPCFSvZCktEsyFGPBEw3OfOSmIUXKokEMBr0baGPEJDzBVIyWqLxID/92mg3+jHaeHodt8Dok7eUeRMGp3GR2iPJi5Whd1nSAgJ/MCk+zgx6bNOYAT1Gz/upzSFg8EZf9Psy3pgG6xqA7QCY3Tm7pklNmSXJ05B8rBjAnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227109; c=relaxed/simple;
	bh=qaA9LDkVTpB6zKpbqjfKDnd8fD/vtH6o5U2dLJdQN/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJppM4zUAgXkaCzrLZc3woEgK5UhiBS56/yE6fO+L2HVFlGOdUDRbKUbN4N0WswC8yQqBYxnpIjv0xl7CY7pA4+sTDossTeguW3EwBsp0BKOQqANcgm0MbZ+7aVjgT5+OxAYXQl9n7cPxo/Y2HbJ8t1ZlcrYCgLdDiwy1rdj8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so8351252a12.0;
        Wed, 21 Aug 2024 00:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227106; x=1724831906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RShFbEYNFQY48yjAx+ODktdIfsmubJvW1HlIJEvRsKE=;
        b=eNuITiKBBFYFcoPvPpi44colkCLvb+YQPH1uttXEEpOB1cSCVueX0+983NdzuxkM8U
         SDJYi+0S2NSPN5r1BcI86GtwSXlgri7OzyTNVqZBUf3bB0iLokCY+8CyZJcWkW534701
         hMadzP279gxJhX4ErWtbTA6NT2RbRnOwd1rHur/TEi89sRV+9MiNo7PGigIUNi+dz0G8
         ZoVbL3qy+sH/brBe7PGAmPs/mxxY7CrVfAJNA6oJqQIr3ivNclgvNJfqJnfZY4hKMcHG
         RClY9dbeeHDQF1S+QoeB22o5NnH0eZhYe3xshjhPAxnYlNpapJhYZOdVQ2iwBQ83jP/V
         2ogg==
X-Forwarded-Encrypted: i=1; AJvYcCVdcex1b2gwCyn4p5c3i490p9o/WA5t9WpKv5hkh4yJZUV5lEI14rj4+ydcyBGWeq68nXhXwlhEAXpXbYk=@vger.kernel.org, AJvYcCVuOmO4sQ+OvEFxuT5Q6VwXsMsjD1dhKJTBdMogUZb7M3Twn9rtZZTLi804U4uoEFsyr09jmt71@vger.kernel.org, AJvYcCWO4Y1XoGQG0f9sYzJhdtfK3GD07J/Hz/0FrlByIt4Sh4boJcR2QpBtORGt1y/syLPDbn0/yV37ewXy5cNXCOZ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuwdh9+Mx1iD4jlrmTvA3DCjNq+PJmVk+okhg3RLES6QUCJVWh
	Nwo/V/s4u3QqLpKMGkiObXhSUQlHZm6R+nT1k62QG8gjy2FeK6H9
X-Google-Smtp-Source: AGHT+IEOwwXqRkw5vduGkGD5RzcvHrVwCj+rozd9kUquJeMaeB4vKvbG2/Ll62EIMJLTX3Ps+7Vg1w==
X-Received: by 2002:a05:6402:2186:b0:5a2:7f47:c729 with SMTP id 4fb4d7f45d1cf-5bf1f0d9350mr950881a12.9.1724227105914;
        Wed, 21 Aug 2024 00:58:25 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfa3d4sm7729308a12.44.2024.08.21.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:58:25 -0700 (PDT)
Date: Wed, 21 Aug 2024 00:58:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	liuhangbin@gmail.com, petrm@nvidia.com, matttbe@kernel.org,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>, David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v5] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <ZsWeHpPZxUh3I1Op@gmail.com>
References: <20240819090406.1441297-1-leitao@debian.org>
 <20240820160636.7bfc4d5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820160636.7bfc4d5a@kernel.org>

Hello Jakub,

On Tue, Aug 20, 2024 at 04:06:36PM -0700, Jakub Kicinski wrote:
> > +# ========== #
> > +# Start here #
> > +# ========== #
> > +modprobe netdevsim 2> /dev/null || true
> > +modprobe netconsole 2 > /dev/null || true

> Main reason Im complaining, I see:
> 
> [    6.686720] netconsole: unknown parameter '2' ignored
> 
> in the kernel logs when the test runs.
> 
> Is it expected?

It is not, the reason is the space above in `modprobe netconsole 2` 

Let me update it. Thanks
--breno

