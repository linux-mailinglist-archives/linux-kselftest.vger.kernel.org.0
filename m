Return-Path: <linux-kselftest+bounces-44334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1DC1C5A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 269FA4E4544
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B434AB0B;
	Wed, 29 Oct 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krDnETPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA2343D9C;
	Wed, 29 Oct 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757223; cv=none; b=A4JOK9gP6WSMiIYrbdDw4jxkJGsbjJaXq4R9MsXX+Kg8+A3F09rOuHaq/j+U7djDZjs80dXTptfoMnRTzy3UZtZ5h9sBUE+M/+dRgdaa2zqZ6oD7SNCeZ+XbcNHybZkkyJbkgE73hLjrxCGeeWNeW8ZGJpGMyh+WpG7Q4vMmYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757223; c=relaxed/simple;
	bh=3YjwXMUdHYIYwvxw36Z3CaQGre+w1u3dtCWInRXnsx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEN4znfWJzaWtrr1ZSauc0ht55F68ZeInVMYPhg5tcD0dXIOpxYBdasoApnkD+KxX0nmQP6j+AJaTHUQedJFkOhqFjscisTZqeJYFS5K5mVX/ZVqKHsPVjJUFWlI88UeuQz6Y3B0KSeN8hdkiD6n6Z4OvGGNukhWpVJrE9gXhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krDnETPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E323EC4CEFB;
	Wed, 29 Oct 2025 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757222;
	bh=3YjwXMUdHYIYwvxw36Z3CaQGre+w1u3dtCWInRXnsx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krDnETPeF43ddu8bdd0n5tO3a/rQ9jm99OktnjDqi1jQY3i/gcJYj8jGHY3L02kin
	 V/rZOGnIwennY2nC0NgqoU9b2nQlPb0Eah8umyXJtI8nnBzC8yleHzRNeiqJvC+PSp
	 uqt4urWsgTuB5NEVLQxMNa9W/dd92CPpwn4pr1vnfVAW3FIAZL82wm2Ra5BKoUu7aF
	 P5CZ544i6E2kziDh8jaKMfysR3gZXI45/k3vFD3I+KZQhqkdtukCFssfXy7e2otpo2
	 GhrqLr64mDtgHQppudMC8eR2CsoaRyxWSC++aSSEnqbcCs0hCnEF4hoVx/3whyiYPZ
	 21yScyW9Ly3XA==
Date: Wed, 29 Oct 2025 17:00:18 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 10/12] selftests/vsock: avoid false-positives
 when checking dmesg
Message-ID: <aQJIInvGb7a8_i8p@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-10-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-10-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:14PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Sometimes VMs will have some intermittent dmesg warnings that are
> unrelated to vsock. Change the dmesg parsing to filter on strings
> containing 'vsock' to avoid false positive failures that are unrelated
> to vsock. The downside is that it is possible for some vsock related
> warnings to not contain the substring 'vsock', so those will be missed.
> 
> Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>


