Return-Path: <linux-kselftest+bounces-20504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4545A9AD4A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 21:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF73BB22A24
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A16C1D0F73;
	Wed, 23 Oct 2024 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PscmWCtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A611CF5C4;
	Wed, 23 Oct 2024 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711422; cv=none; b=sroegCzSvWnIjAhFMw3EYf1bV1HBYvUIPZsPlQgWHlPfSZBhOkq/b7yH5MUmUOOEooOWsLMwSQAiUfxFiAFEZg14iwVAasN7OL6RSctVWAaxIuwwxEbO/Q7ciAern65Yt5R23qDcWg3Ij97fN05BSPPzlH+MTWPD3ksosRA3HkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711422; c=relaxed/simple;
	bh=sPfz92NuqVMcl0WPpJLWF3CsZ6CK3oRhlFyq95s1ySg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs4+GD3ZeFfZOA2uv+UmLYAUM8Z/ZK2iPeg5Lt+aQxtqZ6+xkMUzwhrdvxQeWItizEYYxuwN6JsyiM9Yy77rMS9awJUVeZl+V0R+9a2IW9LDxHvv6TDiHwGGcBO23CAgGZuLVkFhPxFUaw911P87JTcNNbOrwiBYk/76wC0cVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PscmWCtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A401C4CEC7;
	Wed, 23 Oct 2024 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729711422;
	bh=sPfz92NuqVMcl0WPpJLWF3CsZ6CK3oRhlFyq95s1ySg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PscmWCtF9+/e9Flxg5m4gTdZp9vbxMfC3cldavLD8I9kpmDB0OgT9eV/loAZSveMS
	 /Ny2vUea5GeBPj2NP4wPNV1Ra/Gb/AvcJ77Hq7bj3l7IRWGhdDQmI5Zih1ZcFVCypq
	 0S3WjZzqMrsgE8WUwSBMZY/ADslkHwbBdQTm/pKmTKeaEaM8VssZn/HXlGpeE8FqDh
	 ncqAQ2/hwL9SLtzezyvdYQ0L1wgyhMaH3rhr/sHPnqoK4sHZfO6vgih8vEYKpDmQO5
	 rIkqhFyMEZ7OndjFjp9MQ8sC+15mVCk70fb5E/Gf2duaq08Onq6bVjN1uS/TaGspal
	 ydL08eonhLJdA==
Date: Wed, 23 Oct 2024 09:23:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix function pointer type mismatches in BPF
 selftests
Message-ID: <ZxlNPQSbACsrywmP@slm.duckdns.org>
References: <20241023084500.291484-1-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023084500.291484-1-vishalc@linux.ibm.com>

On Wed, Oct 23, 2024 at 02:15:00PM +0530, Vishal Chourasia wrote:
> Fix incompatible function pointer type warnings in sched_ext BPF selftests by
> explicitly casting the function pointers when initializing struct_ops.
> This addresses multiple -Wincompatible-function-pointer-types warnings from the
> clang compiler where function signatures didn't match exactly.
> 
> The void * cast ensures the compiler accepts the function pointer
> assignment despite minor type differences in the parameters.

Can you repost with Signed-off-by?

Thanks.

-- 
tejun

