Return-Path: <linux-kselftest+bounces-42478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6816ABA3FEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EE53BB332
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907F2F9D84;
	Fri, 26 Sep 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktrufghH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058E2F83AC;
	Fri, 26 Sep 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894934; cv=none; b=bysoGoA7/JUqg4b3c6djW4WEnK9483F6zyCS/mlh3S42bIml1ENkbTFjtbtBAmmcjGmlDtCtqqDB+cBqL2v7kZjhmiKHjrDn+YWsgApf0gYwh7xsPViHu7l23V57jnYamN6KF1Gnxk2A02MSDqSCDcjPMSw2ZNbtbKolZfTu5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894934; c=relaxed/simple;
	bh=S9p4ORGK68YuT84OBNw4sVDI7I/ENZfRQZd65A8+Nrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXAwaJ/dCmO6lrsqQ7pbn8UrCXnnV0FiqOGP4R5oO4SGKR2npAA/3EvbNdhdVnj1WoGt45JwjeFc0IXsdkU/wzK+x0z1/9GxtOuW//B8DlxS2BQnokUfUYVXc006lxwSD8O9KNDBdRHyLaKwLGSW8eihWlwynCzd96QBAeQwIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktrufghH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C5FC4CEF7;
	Fri, 26 Sep 2025 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894934;
	bh=S9p4ORGK68YuT84OBNw4sVDI7I/ENZfRQZd65A8+Nrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktrufghHzGIpz1M90JN6drjqgYq7Wdn6HPAWpu4/cMWJnNELF8ygpHQ1Om098kw9h
	 U+bHpJ8WavZXoCmm1+mLdGkq0bkM8ddRmITBt9AltGAQ/14RjJqIEGpgzmAdHEA2Q0
	 VtZ3Okzkq0nuQzpjYNVhvZ+FoGx4+Cp7L9NkbgjqSoCFtZx3jcZNig31yUIQZy7w2y
	 PRcE7vqj1WEXdR5g3x4+JXi/IjMZK6Fkw3BSGg0c1leAd6IfclQDl1DrG6L1HNmb2t
	 psLZ5ZpPG+POe39MAS/t7D5HOqdnRehOSIWQ8daczwpjR4vQpd1v26ILYNd7JU2HWo
	 DMg7YljCYGkBg==
Date: Fri, 26 Sep 2025 14:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 08/13] selftests: net: lib: Rename
 bridge_vlan_add() to adf_*
Message-ID: <aNabUtWoGgyvgVb4@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <93526ce79e635a3ec34753c796edf0c96711547d.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93526ce79e635a3ec34753c796edf0c96711547d.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:51PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


