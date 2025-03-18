Return-Path: <linux-kselftest+bounces-29375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C22DA67AEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BCA4277E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13F212D83;
	Tue, 18 Mar 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHIDtWpw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C038212B2F;
	Tue, 18 Mar 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318713; cv=none; b=Kq5c2ZBC3/e/53gRwsLTp+OHZyxCSP50OsrFHP7dDFFipsPL1pe+mVKKiD7X1Ca2j6vNLuf0hQQ0XcCUZD1DsiY+AMlqmFJ3BjSzp0K+FfvRR5TGCFHv7qBe736dk2Vwsyihb99CKZcptCBem4UK+gIIkTzwL4MaF6hNT2RsY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318713; c=relaxed/simple;
	bh=+JGrZaKDcqHFC83e6PGUPM23Myi2VS8ZTFr3mBv8eF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXBKMB0yRQY9msO8MRD7NKDn6eP+7WbS1KQaRe5EpJ7BHVgtvPuxCp14BihktGvbSOII9QgYl06bczcnP8abcAa0DCXS4i95jI67de5LXpD4Ki8hu9twgPusl4a2kkZI5JMWmj8LwcBs07enOAT5Ui+7u1Xo2xJroaGam/APsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHIDtWpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587FAC4CEDD;
	Tue, 18 Mar 2025 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318713;
	bh=+JGrZaKDcqHFC83e6PGUPM23Myi2VS8ZTFr3mBv8eF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHIDtWpwP3uiGF0YUXgBPZBiLmN6Y49NlyddnaNFgRwFwUflssXpf28umRv8ehqng
	 QE9s3Q6s5wLS7sspbbxthfQJ7+4gUuuKsLmYOSKbEBaQADeGuLKggQygq1ZODG66nR
	 0dar5QsJwDcGYuiWZo5U2A/U5pxhZs+4RyYYqCb5q0lh1P2zg/SWXBy9SFgd4SJwrb
	 7LD0v3sWGsiX50jl3DxP29mD03AS7bttbXe9et5pzq0IvVvj3c8t+dIBKzgR3Ev3jj
	 yGuvfMwypQDOnQXUZm5dKso/pz1zlNQtRRIhrODlc1uxqKE/7+BNrsKdoZRnK14U07
	 tniEX/Oh1GLsA==
Date: Tue, 18 Mar 2025 17:25:08 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] selftests: mptcp: add pm sysctl mapping
 tests
Message-ID: <20250318172508.GQ688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-12-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-12-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:21:01AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch checks if the newly added net.mptcp.path_manager is mapped
> successfully from or to the old net.mptcp.pm_type in userspace_pm.sh.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


