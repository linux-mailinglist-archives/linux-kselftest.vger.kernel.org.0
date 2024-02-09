Return-Path: <linux-kselftest+bounces-4465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC884FCAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3ADB2179D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FD80C1D;
	Fri,  9 Feb 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC8LTYeo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE080C0D;
	Fri,  9 Feb 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506152; cv=none; b=nVkUKHGoGE8fGVegwc2s0zqFeMIkgmmgNkjENQ40KcDnGbr5qvTDg/yclxekHAi89PHy/6/c9CUOiVgeS/6w0FcGlDEG34/SOrvTH0F0F0Pz+SxRrljVTR8SPBPzUdGCOj+EwDuD4M3xrSTFlQJMTJvNBXYu0MwMstw1fdNoDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506152; c=relaxed/simple;
	bh=hnZoibq6VowpGXrqCPprVW09fLGCep2Ypy/Awucoa5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yta9fPnjM0749m9bSKJEqnTw77pajscy1/BJt5zzU1nQONi/YUfMrFbMhQVnhUDUOwTVDYp9gQKTNce+AkDJkTZODaRPyi7/K9ZsJ6wom5QLxcFMdeo/OUJUsdaIj0hHhkvxBjPdVMMZ7EYpLDi64yTGsRiqrhdIP9+VuwBLGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC8LTYeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B03C433F1;
	Fri,  9 Feb 2024 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707506151;
	bh=hnZoibq6VowpGXrqCPprVW09fLGCep2Ypy/Awucoa5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NC8LTYeo+7K4WnAxSO4wUSMB1zFyqH+nA9Kp6XhGW0GOI6q8eWgecURSwMvZFjqOG
	 UMI4PrYCuiZLcdUOFH1nfaAd0r+eU7RvJ2HrjgNm7Y6Iu+uOJ4p8dfucP+my0M6FcQ
	 sg0CfVEP9d7gl+IIbU17YWoPS2bD9VnpQIq076zydRiTvK3fr/78gxp0vQQYvqSkSz
	 Pu0mtMHKwotZuJHpeMap4GMtlrwCC4VPc+6QQM/jG3lp+ipV0YWwabkKL6mXrkDYyJ
	 DUQcGBqBKuaxhMV5wHS0wnzJcZtZVUkoYJL1gRL8Clh2j5aP9hzVUOBY3CZ/vHGnVv
	 K7a4+rtRXZmPg==
Date: Fri, 9 Feb 2024 11:15:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Coco Li <lixiaoyan@google.com>,
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH net v2] selftests: net: cope with slow env in gro.sh
 test
Message-ID: <20240209111550.1880ac56@kernel.org>
In-Reply-To: <c777f75ac70e70aabf1398cefa5c51c0f4ea00f2.1707330768.git.pabeni@redhat.com>
References: <c777f75ac70e70aabf1398cefa5c51c0f4ea00f2.1707330768.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 19:36:46 +0100 Paolo Abeni wrote:
> +    if [[ ${test} == "large" && -n "${KSFT_MACHINE_SLOW}" ]]; then
> +        echo "Ignoring errors due to slow environment" 1>&2
> +        exit_code=0
> +    fi

Would it make sense to also add "&& $exit_code -ne 0" ?
It may be useful to see in logs how many times we actually
ignored the error?


