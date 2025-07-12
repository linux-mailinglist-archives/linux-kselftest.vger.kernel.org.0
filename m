Return-Path: <linux-kselftest+bounces-37191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C90B02B97
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F2318924DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EC283FF5;
	Sat, 12 Jul 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjL2GuBz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95A1A255C;
	Sat, 12 Jul 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332577; cv=none; b=J7UhH89llamIGV6oi0dEUMHXXTPqpWu5w8Sr8MCNVmXae+Wkg7OfI+arwSOLJETUgGlZYhEsNS/avNfqMjfv+RGax49s8i1+yxfE/d5qZHzyeI9KFUKmkiYvRZnvk7pj3FZQvMFaY4nGo2LDHrHeCws+2pk7NnMO+R60ser9Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332577; c=relaxed/simple;
	bh=BdcULb/oRnsc/1lUeU/NQ/l0n1BKRSHej8pR3AAesns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzbWNLKXVOqYmzAu0M3EuIcyyXpWyqScuUgsFCAlu8R8hCbCuDeFtAAlS5BtBn5z2+BGQ+NZgA90HYwxN5XCAIoz6TJaLyQhS7F/RSupSW6U69h3rvcl2Ai8T4eOf8Bn1Be3hHrstJq1GtXWgyopqcEGhKOXvWsnQt1qQjwitk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjL2GuBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD031C4CEEF;
	Sat, 12 Jul 2025 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752332576;
	bh=BdcULb/oRnsc/1lUeU/NQ/l0n1BKRSHej8pR3AAesns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjL2GuBzYX+eh2aU1guvcfFDYBGDR1WnQBpqIR9usLuIE9hLsC2p2K0cs8uEloGIM
	 GNgpvG/iGuVNn7CQQCIZD20j8+MWzH+dduEGTWdfum8k6xXxYDSAcrIZNPx+l1CeSM
	 LA7/bLWAO9iq7Zl9D2TApcestGXIq/WbasY9mUn/SItLcPpST/EeoWomTT/ovdpKL5
	 Y67mUlAHW1l4c6HJ9mknlGaGuzzZdYFKa+ebr0ZGZteMcR+bwsWp5bA/kiM4/o1+fH
	 MhPVtdNY8fhw6TzsExt/BaiOaFJiwfN2Dd9U5eAybv/bOdoFw9zH3DRYVkdUMwiZzQ
	 uASkJZAA7SsOg==
Date: Sat, 12 Jul 2025 08:02:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V3 0/4] selftests: drv-net: Test XDP native
 support
Message-ID: <20250712080254.4ed08842@kernel.org>
In-Reply-To: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
References: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 17:26:44 -0700 Mohsin Bashir wrote:
> The results reported in this series are based on fbnic. However, the
> series is tested against multiple other drivers including netdevism.
> 
> Note: The XDP support for fbnic will be added later.

Hm, but we need a netdevsim patch to support XDP to be part of this
series. Right now our CI tries to run it against netdevsim and all
the tests fail.
-- 
pw-bot: cr

