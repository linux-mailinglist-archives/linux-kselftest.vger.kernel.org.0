Return-Path: <linux-kselftest+bounces-40931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A90B489B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483573A4505
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF82F7446;
	Mon,  8 Sep 2025 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhd0YNmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A72DE71C;
	Mon,  8 Sep 2025 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326419; cv=none; b=a/WmUzWZTdiNXPMWo4ncWw7J1Qm5IjHMLwVMnE+kZeYhm3ZL7HkPul2MR7ePwrEuJSQGrWcfe6J7ZnWmUYBv0ulZi26eMFzgfjfXaHkKBoivr4Sk/Uk3xOP0wP3O8jd+Gyr83CppxPVJiAJ5HzK2Jc1yoOnGJ5MWypuBjO/uAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326419; c=relaxed/simple;
	bh=2H1ECdrDYniBH9FprGi5MF28pknQmjZ2qAulQHxUrEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7tkRodAW+CDdTaRAxwNNKxta+GaLL+xWtr6tTC770K9dlWR3PE9vj5HW2Gcag5YJAa8e/CTHj7q3AUIFmy6QmJlw8vcs0D7rOCYPkT5c00Y1BhO3MDAU0dXg9bG74IF3fh4HvxlWLRcaiQ6DSnFiXixeUdqJ5lHIDi8wKfkxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhd0YNmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6095AC4CEF1;
	Mon,  8 Sep 2025 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757326417;
	bh=2H1ECdrDYniBH9FprGi5MF28pknQmjZ2qAulQHxUrEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nhd0YNmDycihd6c3GLT16n7Cqb9rLPFBHGr/gqzJ9p/HTckgUMIm8YYMQokwIld8P
	 8HGDE1+V03QLS580cLQtJuS/p+kwLAiFVtDkhO6xLawYIHlOdbAThc4G0cma1CCGXb
	 tAxuChWb6QRMKicVJTYJP7a4cedwSSYXs0nrwYLlsElduYBuAXw+c7JliB45EOwL77
	 M6yiXfCGDahI183LBAV/Vwe6C2XPKPfK1XvhnH0G9Mw5ko6i9ifp05E2Ws2Yaq4AbN
	 C749EWkozavcEBRmRgPg+ey9/mvTauNn4hJ9YPc+8cLp94miPx8sQt198l1pqzzL71
	 EB2QRExQXbpqg==
Date: Mon, 8 Sep 2025 11:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, david decotigny <decot@googlers.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	calvin@wbinvd.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] selftest: netcons: refactor target creation
Message-ID: <20250908101332.GB2015@horms.kernel.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-2-875c7febd316@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-netconsole_torture-v3-2-875c7febd316@debian.org>

On Fri, Sep 05, 2025 at 10:25:08AM -0700, Breno Leitao wrote:
> Extract the netconsole target creation from create_dynamic_target(), by
> moving it from create_dynamic_target() into a new helper function. This
> enables other tests to use the creation of netconsole targets with
> arbitrary parameters and no sleep.
> 
> The new helper will be utilized by forthcoming torture-type selftests
> that require dynamic target management.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


