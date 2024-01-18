Return-Path: <linux-kselftest+bounces-3189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D08315D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 10:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58D3284CDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC561D55A;
	Thu, 18 Jan 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv1sz9XI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2D20338;
	Thu, 18 Jan 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570290; cv=none; b=gyy75EnnSyD9cq9ojX7i3e4VfFgE9H027AH1h/br9I0tYyQz8WSReeJZsQ99rvl2HxrzqynYjf+ceFC3P3/zpPLlYgNQN4JpAKPbCkS1DYmIk7y00OM15UHoVF5b+cMhxw8gJ5U9ABJe3hq2Fu+gCpD5YPejQfi4uBh2z+c4cdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570290; c=relaxed/simple;
	bh=6xh4ffBeTb64NrHfkNkNDdjf9W4dqgPhPg10T+46fwo=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=paa0OFbhfFEJkBM/+4lhQGiWoWkFCpxOM5lA8CucGY5JQv8ilnJLYBDcYybAQNoESb0GPpUm1uJP8Rx4A7FSniMZXHGDNcJqwfvX/xK2Wu20sqQl5IDiY3MngKxgA8pFjANNqjMFPcdzP/i0yrT9P79F/EV/r/zn2PWyZZWC5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv1sz9XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AFFC43390;
	Thu, 18 Jan 2024 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570289;
	bh=6xh4ffBeTb64NrHfkNkNDdjf9W4dqgPhPg10T+46fwo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lv1sz9XI8maAXYEd3DCKMcvqlhIMLGvuvZdpS3hs8gW8TbZ9i6Gdgm6xsW3+c1gbU
	 RoddzyN1vjVjUTNam4Q6yfHhe/WD3chRCR7XwCfvjCd82Kairce8D56K/sT0qERmqe
	 uxauvkDl0HbINHRPtGYYlxEnVBIZL8TvUlajZ7Sj/Lb2KO/lcfB0KyXyG691L+I0Kp
	 EnnnM3clo8lEKVA/riDuzgZSTx+1zLNfFX9aobnuJuT5gsm2LYSvfhAFkcNFK7IuXW
	 E0gztQ1X0xhVB3FWfo7yFvmtMPDYaxou/1gODU3pMQ53EkKfkEQ4Xd4Mmfe/uIL//h
	 Bzg+AyfsFO4PA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240117-b4-wip-wacom-tests-fixes-v1-1-f317784f3c36@kernel.org>
References: <20240117-b4-wip-wacom-tests-fixes-v1-1-f317784f3c36@kernel.org>
Subject: Re: [PATCH] selftests/hid: wacom: fix confidence tests
Message-Id: <170557028800.2036094.8723176991668141114.b4-ty@kernel.org>
Date: Thu, 18 Jan 2024 10:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Wed, 17 Jan 2024 14:27:15 +0100, Benjamin Tissoires wrote:
> The device is exported with a fuzz of 4, meaning that the `+ t` here
> is removed by the fuzz algorithm, making those tests failing.
> 
> Not sure why, but when I run this locally it was passing, but not in the
> VM.
> 
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.8/upstream-fixes), thanks!

[1/1] selftests/hid: wacom: fix confidence tests
      https://git.kernel.org/hid/hid/c/4d695869d3fb

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


