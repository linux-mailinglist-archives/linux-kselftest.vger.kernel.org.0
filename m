Return-Path: <linux-kselftest+bounces-9571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B58BD8D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 03:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAA21C219DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 01:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1215A4;
	Tue,  7 May 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN4PZtao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807F19E;
	Tue,  7 May 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044376; cv=none; b=kXk1tbY7mqRaoK1n9Sl7CcYFVQkKJZJodxIwi0X4WlcfV2sX5BFGMPe4rr19fMLWf5ytRFU+dz1eJCD2k9/4wM2F0uKWxHIZiDzvn7qFb5PwhorB2Qksj2Ruu+3J2z8cxVqovYf64FYZVzNx7mh0oo9EGBKPRcOc/d+evn+aC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044376; c=relaxed/simple;
	bh=GHWqAsOdX5dGe3K6Z1eepgzRll/70gW0FYVGWvCPvEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMdyZmwzwX19ycZpvLlR6naugoh8WYOWqJlAGCA9IkisNDKHss2xTn4bD62ZaSeZscsqH0zcJ3IdP9szaNnp8AkQoAv2Hsc0vVMuL+Bq1ISOrUR5Rv/Q+pluK5lrzpVgKpYRitZaiuEEipako5HHPW3zldbIZdaz2KLgq7sew3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN4PZtao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A23C116B1;
	Tue,  7 May 2024 01:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715044376;
	bh=GHWqAsOdX5dGe3K6Z1eepgzRll/70gW0FYVGWvCPvEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PN4PZtao7rnNksupi4w8fkBRG7e0f4Z9i7i2IdGHY6e6qUv2J7OSD31264BPDH46a
	 SFUaQ/Ci2qlyraviF+uYTG2ahVAPRYXMWFe0IUHcIt91/7CKeDJa2ryed8MRLWgrdW
	 zjKFFKFoQMwplNsiWccDAkGD+7gzK4lauxdlLIdHb78P+kvFIuxyMiMg9jSqtddrC3
	 SVtdpmEQX7JFu8+6WkwMYu1cOfSJqXqFVlGIbSOQNkzJUIg5aduYLyp8uIlp4aL+Ew
	 M/UAi2RIOJEG1m8O/5SpNjC1BEmXUrkFGH+kX+3PQERQ7pEaw1u8Ln1rQnwbsXvTM+
	 BSeLT06GkrOPw==
Date: Mon, 6 May 2024 18:12:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v2] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <20240506181254.09f10699@kernel.org>
In-Reply-To: <20240506205326.70502-1-jdamato@fastly.com>
References: <20240506205326.70502-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 20:53:22 +0000 Joe Damato wrote:
> Add a simple test for the epoll busy poll ioctls, using the kernel
> selftest harness.
> 
> This test ensures that the ioctls have the expected return codes and
> that the kernel properly gets and sets epoll busy poll parameters.
> 
> The test can be expanded in the future to do real busy polling (provided
> another machine to act as the client is available).

Hm, we get:

# timeout set to 3600
# selftests: net: epoll_busy_poll
# TAP version 13
# 1..5
# # Starting 5 tests from 2 test cases.
# #  RUN           invalid_fd.test_invalid_fd ...
# #            OK  invalid_fd.test_invalid_fd
# ok 1 invalid_fd.test_invalid_fd
# #  RUN           epoll_busy_poll.test_get_params ...
# #            OK  epoll_busy_poll.test_get_params
# ok 2 epoll_busy_poll.test_get_params
# #  RUN           epoll_busy_poll.test_set_invalid ...
# # epoll_busy_poll.c:204:test_set_invalid:Expected -1 (-1) == ret (0)
# # epoll_busy_poll.c:205:test_set_invalid:EPIOCSPARAMS should error busy_poll_budget > NAPI_POLL_WEIGHT
# # epoll_busy_poll.c:207:test_set_invalid:Expected EPERM (1) == errno (22)
# # epoll_busy_poll.c:208:test_set_invalid:EPIOCSPARAMS errno should be EPERM busy_poll_budget > NAPI_POLL_WEIGHT
# # test_set_invalid: Test failed
# #          FAIL  epoll_busy_poll.test_set_invalid
# not ok 3 epoll_busy_poll.test_set_invalid
# #  RUN           epoll_busy_poll.test_set_and_get_valid ...
# #            OK  epoll_busy_poll.test_set_and_get_valid
# ok 4 epoll_busy_poll.test_set_and_get_valid
# #  RUN           epoll_busy_poll.test_invalid_ioctl ...
# #            OK  epoll_busy_poll.test_invalid_ioctl
# ok 5 epoll_busy_poll.test_invalid_ioctl

https://netdev-3.bots.linux.dev/vmksft-net/results/584001/98-epoll-busy-poll/stdout

