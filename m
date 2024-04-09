Return-Path: <linux-kselftest+bounces-7513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB189E679
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 01:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF82928764E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 23:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679DB158DB3;
	Tue,  9 Apr 2024 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naEikCrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD61EB5C;
	Tue,  9 Apr 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706804; cv=none; b=BUI8wFflu+RpEGnZcZ1/Z/ESLOqynMYNBZYy67uKTOx6uzwq3mmQlUTzAHo7Te4DBJTTU9efxNmNBBsL2NpeqI9YU4kHSIBnf83pUNjuimwzWQjRtrxSF2712QTkT9hZEzLhnY5azrPj3d3M2haIj6B3CXJqFhs8MYA5ZlbJB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706804; c=relaxed/simple;
	bh=d2JlSSzg7fvVL/MPAAgkaaEpRGccUssPU5uIiZerKmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ5ID47LyO2+UeJJc47pubhFUyZo5sRCEvsUob8daRZhq6dndtxHGce7Z9ii9jSd3ErCkQnc8CU/91gViQLUVtgEvwhPTGbxu8m+JbYEs/Q2oRnlnCyE9JYr/G2ba5QwG8AwYhIxL57CvmOROcjP7p1TU5o+SqQhFAUABvPglN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naEikCrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE3CC433F1;
	Tue,  9 Apr 2024 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706803;
	bh=d2JlSSzg7fvVL/MPAAgkaaEpRGccUssPU5uIiZerKmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=naEikCrZJLwa2e4s14QNHzroCD+4520uCwiRMpO6eAiSrKimNqKens3UgVB+/sXex
	 Pr6sdUHBsmsAOrR5iA5OIzI/fdkBHWCuKuvDD+TT1MXG46AwXClumgPZV0X0zaWPx5
	 ic0bVc2HoEZCtc1/RIawGKXqIEfuHsqRljF/fRctfTqVDPPcpe/8zgA60jYI47NmJZ
	 oaTnbbpz1plp5Dwk51AtKGZ1up7S8Ve6cCsAaCDJS8VEsTAHCUKWzZ0v0CBZVXIAU9
	 3CZC2oTWoQ9jiDbM8+VNAfZjJzTe3YxHYcnStMgMBybJ9r2BicDA1iZK758KG4ff3w
	 jjxwwYvHH1m2Q==
Date: Tue, 9 Apr 2024 16:53:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kselftest_harness: Print empty string, not
 empty fmt on PASS/FAIL
Message-ID: <20240409165322.60f1bcbc@kernel.org>
In-Reply-To: <202404091644.9CFF82A@keescook>
References: <20240409224256.1581292-1-seanjc@google.com>
	<20240409160920.3bfe3eeb@kernel.org>
	<202404091644.9CFF82A@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 16:46:40 -0700 Kees Cook wrote:
> 	ksft_test_result_code(t->exit_code, test_name, "%s",
> 			      diagnostic ?: "");

Could work, but we need to change the callee to extract the first arg
after format from va_arg, which I wasn't sufficiently familiar with :(

