Return-Path: <linux-kselftest+bounces-38011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2394BB125EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 22:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C962EAE32C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A825C838;
	Fri, 25 Jul 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrR2gbKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739525C813;
	Fri, 25 Jul 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477139; cv=none; b=KaeVWaJiItxiJVDbXkkG0EkAxCUU/w9uxcJHH05L75xO+xw0tjKrxIPLmXowWbHxvMfx1ITQhgSCpSTRYhSIovQ0cNC4cULoI8MEOcPAWcCf2rHgcI0f6Kfw+qVb7xxyhykL9NsRK6CokhId0PblZfxTZxgNzjH1qRThNIRmxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477139; c=relaxed/simple;
	bh=AhjYxuVt/FQKPxpoTiF56nGspyPkpGQIFbH1Rp3/uds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDiR9qhZ+exs8rcHElvMAjdOD6SSnDTHomQACaLRmtm3TF5JBxhtCnIuXW15gjsti2LNJZYGry8J01caTUX3gBbK7UpewolHQFyP5XEnseJkTxdLq8jYNrMRECZxcbptnjnA1fz/HaavOgviAtfobpOtM2018+3FmqT9e0zsWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrR2gbKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7999BC4CEE7;
	Fri, 25 Jul 2025 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753477137;
	bh=AhjYxuVt/FQKPxpoTiF56nGspyPkpGQIFbH1Rp3/uds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrR2gbKKDvlUFa8CAiDZyO3jjKemISIYTlOx63YCPqsQ+j5d7FQDYJOzGB+tLpBMA
	 u11QsV6cy1O0aXW0df03Jn0rztZGxYvYX2AIACGhCoV+3Tkb752aeIDy8rHR6um6Xj
	 jJmRTuYjIxvIp65VU/MI2jnjoy2BhanNtOw+Qf4lmBnkBC88AhjTY9TtKkQEvV16hz
	 zuy6p5QbkacqTbynb7nRT6KkiPOC+79Mln0KFDXIU74KXeZVXsoNxQzgma3WqB/AUo
	 wEpgMQzNIXGiUCSYU9A+GR6A/BpIbuRksiNgzmJrEHH7mmyJTabziBt6IjLcNkbxAb
	 ppOueImV5RUHw==
Date: Fri, 25 Jul 2025 13:58:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
Message-ID: <20250725135856.6854f2a5@kernel.org>
In-Reply-To: <6883ed7aed06f_3f184b294c5@willemb.c.googlers.com.notmuch>
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
	<20250724182427.5ece92e8@kernel.org>
	<eutsqoc6f7xcaez2ttuce4uqtfvs3hyit6dradikvfcgxdev75@3senqada4nzn>
	<6883ed7aed06f_3f184b294c5@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 16:47:54 -0400 Willem de Bruijn wrote:
> Less opinionated: the tests implicitly depends on the config files
> in the test directory. Do we have to start making the robust against
> situations where CONFIGs in that file are missing?

I was considering adding something like this to the test guidance.

  ### Ensure necessary kernel config knobs are set

  Each test directory has a `config` file listing which kernel
  configuration options the tests depend on. This file must be kept
  up to date, our CIs build minimal kernels for each test group. 

  Adding checks inside the tests to validate that the necessary kernel
  configs are enabled is discouraged. The test author may include such
  checks, but standalone patches to make tests compatible e.g. with 
  distro kernel configs are unlikely to be accepted.

WDYT?

Primarily trying to minimize the number of patches and adjustments 
we'd see, as the matrix of systems and kernel configs can easily get
out of hand..

