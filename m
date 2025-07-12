Return-Path: <linux-kselftest+bounces-37189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B83B02B8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 16:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE521882112
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C528688E;
	Sat, 12 Jul 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHLiFOml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0634CF9;
	Sat, 12 Jul 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332341; cv=none; b=ETmuHSzRFZ/bNbN49OGgtstGHf/G/EzQ7yOGxWxINbdjmRCzZqA/lrCkBl65p1qe9O8UC2wFWNIaCkqJaDaNCPXE7iVux0isWfrneW9KLImwAMpaqrIS5xcSJssh6xoRzv26+AcfJFeM6W2fo3k4YNR6OmlxCb6MCOLyp7u8LcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332341; c=relaxed/simple;
	bh=f29WdkUiKhK17HGKJ3LJj1Cs/1+azC6Hp9njEEWsP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lrujy7pJ6ZljzXShHKfVKaIlyhaxEAN1AmWpW44bZdh8pe2KYwbI0JqalR/PMfKj+X0PXBMab6mr79ZWXsHX0YfNNonOgbEiZk8PT8QE9XRFVQPlF2XSMQnfQp8XRPdr8K3F8+hZFZpndsT6R+xj1RtR0Fq/gJTtTSnIlcB3hUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHLiFOml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AF3C4CEEF;
	Sat, 12 Jul 2025 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752332341;
	bh=f29WdkUiKhK17HGKJ3LJj1Cs/1+azC6Hp9njEEWsP/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SHLiFOmlm3943dTRkiNVGn9/2xKvIYrhoP0XQnJ8KBzbgIUn7bJxJhKeu5VN1FCB0
	 BJ1XXNPjjehyRoH+TDU1ycBnMaDrxZs87mwaRhMCIQ1IKI7HNdal1Gd6Tknorez12T
	 iiL2yjHJKhboJPHHPlegRHKt43p6blcGLieiZv4Q/HDkLez6RtrB4sfe1XcMvK8349
	 l+R5JqRbuEOAVxJpfTS4M/zn2tRL7A2HFQfY6YpLca9VElfEOh4YOmwJ2ae2S2DSSp
	 jaAUM8VD4Qz/rOm1YYfF+ujTItWt0ZF8YnTxYrfgikcBgfIYd+QDLyFWuGxAd6C/JZ
	 GgLrvbtR7MD9g==
Date: Sat, 12 Jul 2025 07:58:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com,
 noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V3 1/4] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250712075859.1667219a@kernel.org>
In-Reply-To: <8b37460c-8812-4427-ad54-2bab02058413@collabora.com>
References: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
	<20250712002648.2385849-2-mohsin.bashr@gmail.com>
	<8b37460c-8812-4427-ad54-2bab02058413@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 14:25:58 +0500 Muhammad Usama Anjum wrote:
> > ./drivers/net/xdp.py
> > TAP version 13
> > 1..6
> > ok 1 xdp.test_xdp_native_pass_sb
> > ok 2 xdp.test_xdp_native_pass_mb
> > ok 3 xdp.test_xdp_native_drop_sb
> > ok 4 xdp.test_xdp_native_drop_mb  
> n exit a summary of passed and failed tests should be printed. Probably
> a exit api call is missing?
> # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

It's there when we run it in the CI, I think he just missed quoting it
in the commit msg.

# # Totals: pass:0 fail:9 xfail:0 xpass:0 skip:0 error:0

> > +from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne  
> Not related, but we have 2 ksft.py libraries currently:
> tools/testing/selftests/kselftest/ksft.py
> tools/testing/selftests/net/lib/py/ksft.py

