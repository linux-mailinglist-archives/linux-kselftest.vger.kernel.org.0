Return-Path: <linux-kselftest+bounces-17949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D504097830C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB3B241B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A4A5B69E;
	Fri, 13 Sep 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evbdHCti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8C1EEE6;
	Fri, 13 Sep 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239418; cv=none; b=ZNqCgCbFwW1Kehw2MfDVyXkL4wIjrlwvjPAo5nscvwCS1/qi8vKbkEVfqbxHa/hndgsJDTcGJJXhaX6CQtONXHM+HqXzvcZbVxTroykqlue4k03+tzbtpseAEtHKOiqDSsEshQ8aB99n/5ChTZ9dUsmmhdTP6YFzpM4xQmfRRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239418; c=relaxed/simple;
	bh=NCdjJCJ0ZIj5gtppWyq68KprL6Ix4U5xy2TvUU3fOp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjhoUUXN2CNr9lbbZzXj7hGQ8C9EmFuEptQodkndG1y8BRWRmCYW5N1KNjjyp7tfW2ffXPmqnaIMML/MupjkSpZS0XRIf6W/XnSBVcMhR72ydZFgU3kNkdCtEceqsFmF9nODxOKwhio+JEI8ol2CBhB0epLXXqprBaqNxFG/ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evbdHCti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065C8C4CEC0;
	Fri, 13 Sep 2024 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726239418;
	bh=NCdjJCJ0ZIj5gtppWyq68KprL6Ix4U5xy2TvUU3fOp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=evbdHCtiKvZ+iWRwGctlekfnIR5ieEyGejDSV1sCQxLV+/hOoi2ECye4PjKcEQHt/
	 PBKq3ojc3tWDhXZjajXozziBt6KjlUvbyn3zzoKhs2weu7IRl/UFrQvL+R0m+Fgq/s
	 r5CegLuUW68AVrEMW5+ARIET11620yAKrKHLjjWpRl0hUbOAs3nMCoW+44ysZ+B8//
	 ava2huQAPOs057SY0VCF3/MK1nqMLWCgLJfqFNekC3+rMfeXaDWcM0acLbKqWF7kFG
	 dxcMxpaCVzOUsjthRNRGe1q8uL5f7C4TOhjibVWP95sSF5HNIySl98Wla7tJ5NSwLa
	 R0DwwK62D8vew==
Date: Fri, 13 Sep 2024 07:56:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: forwarding: Avoid false MDB delete/flush
 failures
Message-ID: <20240913075657.6062ad40@kernel.org>
In-Reply-To: <b77ab871df2475df37aa29672c9bbcc33d03e90f.1726220359.git.jamie.bainbridge@gmail.com>
References: <b77ab871df2475df37aa29672c9bbcc33d03e90f.1726220359.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 19:40:04 +1000 Jamie Bainbridge wrote:
> Running this test on a small system produces different failures every
> test checking deletions, and some flushes. From different test runs:

This increases the runtime of the test 1m 25s -> 1m 35s sec which may
be fine. But unfortunately it also makes it reliably fail with:

# TEST: Flush tests                                                   [FAIL]
# Managed to flush by destination VNI

on x86 VMs.
-- 
pw-bot: cr

