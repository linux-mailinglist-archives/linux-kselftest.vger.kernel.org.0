Return-Path: <linux-kselftest+bounces-9573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11E8BD918
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 03:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E237B2212F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6745441D;
	Tue,  7 May 2024 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Xzm0fw1k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A051366
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046006; cv=none; b=RQkFJNBXUAI/sSz/hx1+c0gGMIY7hrZY5w+vnAVxjaY2xcWq9iBd5RxZRCz8dcyqG8hTZ5u+NBFpB1YV/bfSbG3bBMSZa+WxKuYdmJQ3euiWwi54bu/JkhcXUMvfoXegmX9gn4v98hTAgzAaM8MA6SnXyWhOsdaQUqwkon0QPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046006; c=relaxed/simple;
	bh=XwFqs7H9duiL5Kq6JnyeSZY601RSrLaRvUN7CY94yI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbjnp80TOP1sbAMr9gV5kHxYRzd4sZRANT93wprhyQwiqCXE/g89ESwRN4lf9UFJBpk9bYoepFV5+GtTkshJW7iIgMqWTu2unROq6gp51dPxXH0aTy9A+uYz+BzS9Ho8kaPY94rn+cqyHapY5x9XZsINQf45W/3XvYkO66Z+wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Xzm0fw1k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec92e355bfso24616195ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 18:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715046004; x=1715650804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzLw+wrhd4HeF6P/SeLSLWJ4Lt1ry+nUaNYpeb2dTV8=;
        b=Xzm0fw1ky7ZhLQusgeOgaO19ghvAsmRF0HurEqVpb2Sadbia6uIETFg+tPKJlQFT/Y
         S6x/E1ZvODDBM8dj8ivAOsam8y+QQVOV3tYAKnob9Tx9Dhg+Qp+Cqzj7jlk6EhDFXefY
         yp4rR/e5SH8yS1arL5roVmj4TukI04yVEYs9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046004; x=1715650804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzLw+wrhd4HeF6P/SeLSLWJ4Lt1ry+nUaNYpeb2dTV8=;
        b=G2+Lg41YajjpOMvZ+Oaa4MBYAf09p+6verz/gI6KYs9lecmnYSYc16Ljjwppd2hXM5
         onXAxs3cNezhVcmfwx4605PIiYUKK0JIKDZ/2jIuCTyXi3lWWOd9T8bK6nXtCSpJjrqm
         RXMySyRR//aGYR304aQ3YhqlWQ9mxzgFoSIxyxEOSyWoKWerP98CQUWpOMBhz5B2PQ1+
         CKZAYUwbMS+Knn10CCohsuCXkkSSELOWNcqoDjm6JhW6sRSRDv4C0VpIHiIVghX141lo
         q4aUsMZ52vpC9w2NXCh0px2KFtC96Iai6GqY31FTzeWw9QEHMa6VP/pgIm5EcH24RIdD
         hwRg==
X-Gm-Message-State: AOJu0YxLLNmZ8JaUx5U2g8xz024sKkHLXhMHNfdyBaEpmb1OFSDE3yY4
	+X63GEKO3whSnkgPf0uKinxG8J0Py68XVdiTvQerbMzXDiSqap+WkTZokMLVNn8=
X-Google-Smtp-Source: AGHT+IE2hS3Ty1wgX0OolAQ+BEaLPzbJ71bQ/5H3QBdVZpMmvE3sG0x9J34Rt+wP+t9UBfHPmoBANA==
X-Received: by 2002:a17:902:d3d3:b0:1ec:e3c2:790e with SMTP id w19-20020a170902d3d300b001ece3c2790emr12536876plb.19.1715046004243;
        Mon, 06 May 2024 18:40:04 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001e29c4b7bd2sm8961427plf.240.2024.05.06.18.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:40:03 -0700 (PDT)
Date: Mon, 6 May 2024 18:40:00 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v2] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <ZjmGcPrxhm3mZnCS@LQ3V64L9R2>
References: <20240506205326.70502-1-jdamato@fastly.com>
 <20240506181254.09f10699@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506181254.09f10699@kernel.org>

On Mon, May 06, 2024 at 06:12:54PM -0700, Jakub Kicinski wrote:
> On Mon,  6 May 2024 20:53:22 +0000 Joe Damato wrote:
> > Add a simple test for the epoll busy poll ioctls, using the kernel
> > selftest harness.
> > 
> > This test ensures that the ioctls have the expected return codes and
> > that the kernel properly gets and sets epoll busy poll parameters.
> > 
> > The test can be expanded in the future to do real busy polling (provided
> > another machine to act as the client is available).
> 
> Hm, we get:
> 
> # timeout set to 3600
> # selftests: net: epoll_busy_poll
> # TAP version 13
> # 1..5
> # # Starting 5 tests from 2 test cases.
> # #  RUN           invalid_fd.test_invalid_fd ...
> # #            OK  invalid_fd.test_invalid_fd
> # ok 1 invalid_fd.test_invalid_fd
> # #  RUN           epoll_busy_poll.test_get_params ...
> # #            OK  epoll_busy_poll.test_get_params
> # ok 2 epoll_busy_poll.test_get_params
> # #  RUN           epoll_busy_poll.test_set_invalid ...
> # # epoll_busy_poll.c:204:test_set_invalid:Expected -1 (-1) == ret (0)
> # # epoll_busy_poll.c:205:test_set_invalid:EPIOCSPARAMS should error busy_poll_budget > NAPI_POLL_WEIGHT
> # # epoll_busy_poll.c:207:test_set_invalid:Expected EPERM (1) == errno (22)
> # # epoll_busy_poll.c:208:test_set_invalid:EPIOCSPARAMS errno should be EPERM busy_poll_budget > NAPI_POLL_WEIGHT
> # # test_set_invalid: Test failed
> # #          FAIL  epoll_busy_poll.test_set_invalid
> # not ok 3 epoll_busy_poll.test_set_invalid
> # #  RUN           epoll_busy_poll.test_set_and_get_valid ...
> # #            OK  epoll_busy_poll.test_set_and_get_valid
> # ok 4 epoll_busy_poll.test_set_and_get_valid
> # #  RUN           epoll_busy_poll.test_invalid_ioctl ...
> # #            OK  epoll_busy_poll.test_invalid_ioctl
> # ok 5 epoll_busy_poll.test_invalid_ioctl
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/584001/98-epoll-busy-poll/stdout

Ah, sorry -- this is because I had assumed the test would run without
CAP_NET_ADMIN, but since:

  epoll_busy_poll.c:204:test_set_invalid:Expected -1 (-1) == ret (0)

succeeds (ret = 0), clearly I am mistaken. Sorry about that.

I think I'll spin up a v3 and I'll add a test with and without
CAP_NET_ADMIN to check both cases, which would probably be better anyway.

