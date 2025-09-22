Return-Path: <linux-kselftest+bounces-42075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A5BB924A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBF47AEDEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91271F5838;
	Mon, 22 Sep 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDYNnMN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E8192B66;
	Mon, 22 Sep 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559621; cv=none; b=OSWkKB3ACtG834JnL7hJ7aQMyw8RjKTaFCxlzlnLKMrIUy2qc0jz6r0T6e/cinjz38DXWLV2RIZStWyNHasPwFme9tjjlbjZ8FkM6XREEOPVvmJ9dAfy3RsqwWQwM1TMX/UAAeC9LULaLtyCCkoY+tzZMx9oXrGp/n0NQf6HEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559621; c=relaxed/simple;
	bh=QdomiXSmKKhfyI7S8/1T9Bxoqahc2Iwe1BlnPYDwG2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds6uGOaxr4cUZ9nuO0J7+Jt2QAgiuleToVKzNoDJ6S8ktte5I0AAIkoUHsTb/mODhuftU5NOxlTYaWMHKcLpa9C5Dpf8GJE46DA04Bs925pzB2yk1PaXhQWtIeQD9Xk7rLgZ6DoBDHFk1jnS1dLjIuVnGH7qMfIkFb7+DoQHLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDYNnMN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93709C4CEF5;
	Mon, 22 Sep 2025 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559621;
	bh=QdomiXSmKKhfyI7S8/1T9Bxoqahc2Iwe1BlnPYDwG2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDYNnMN1uoXXvW8OrgtVDu/wDHViwD1Nx8hEfWQGncBZ5wjmt7uBf4Vi7/XXTH676
	 fzWfchFIkry6blje8X9V/1SsWqT75JeadtqT2YQ+lKnJGxU51U5WkZ6nuBq2xoKbE3
	 MR12wkVz/8AfpLGM9UD3swLA1fy9UzN9usRioX0vKBnOzZurTj5xZC2KeF1PW8OJA9
	 AIA7CSt5/JkktOOFPgA+xZNepCqlMfcZeT9+tGggnnW6XHwEJw2PwCBGdA3QuEK/dn
	 Gqoi7SxykuOG8EYFzp23QURFCIL28tRiDTOTqAhoezB1nhz7PhD5IamLp6XMP14r2m
	 g54i+ZCplP6lw==
Date: Mon, 22 Sep 2025 17:46:57 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: rtnetlink: correct error message in
 rtnetlink.sh fou test
Message-ID: <20250922164657.GA836419@horms.kernel.org>
References: <20250921192111.1567498-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921192111.1567498-1-alok.a.tiwari@oracle.com>

On Sun, Sep 21, 2025 at 12:21:08PM -0700, Alok Tiwari wrote:
> The rtnetlink FOU selftest prints an incorrect string:
> "FAIL: fou"s. Change it to the intended "FAIL: fou" by
> removing a stray character in the end_test string of the test.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks. This looks like a typo added by 
commit 9c2a19f71515 ("kselftest: rtnetlink.sh: add verbose flag")

Reviewed-by: Simon Horman <horms@kernel.org>

