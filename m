Return-Path: <linux-kselftest+bounces-42680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C88BB46A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91E17B0ADA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF52367B5;
	Thu,  2 Oct 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN/J7XK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA93224B04;
	Thu,  2 Oct 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420690; cv=none; b=pC4KzDD4jmveVLPe++3ZCC7//1Ol7oaeXyhgH/UGre6uy3NopTpSvHlW2qcC/+9sfRtt7n6x6iPblbtg+3gWwb08YwJbgXGi4Tv+HRnJ8iBFz89trpxGIh4F4m7ocejzk06jwN9jm5vdvpKLARmfE3+zB5H+AKnhyoHBd8EpCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420690; c=relaxed/simple;
	bh=upa1GvZmHmlG/mA72xTRebfHNbGgqPofAGeSYsMoJPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXbqqWRszr0V1DFcdlk9J7dJruE4nywa47OwRYR/KWDpDjhQwGXWHEogyPkSqZokWrRngtfC6IrMt70sJvcS3HW70ftSRhQfhfxFodufDNtjfzs2W/EPevdI1CKqCdpckxB+6jEYrrlDzP8o0JAQgAIjSgmncOLXUCPnBzOPN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN/J7XK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70DBC4CEF4;
	Thu,  2 Oct 2025 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759420689;
	bh=upa1GvZmHmlG/mA72xTRebfHNbGgqPofAGeSYsMoJPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QN/J7XK1tXuRzJsQE5dT22wmK49IHJEqj9WUC3nFeXApHTff6GM/G1QuUBM5cJ/nx
	 5vPafjU92xDYagHTps9YZ6YwK3Kp+pS+D/8fNE5rg9M7BtjMBRz0bqjFkNTM4nRTmX
	 aurwf0ZsE2IcBA4dkyN0XSfnlWOjHTaPSNWJC+vR5o077A+gSqBbvUihh4bx0Traen
	 SmV+KzXw7RVGWw1mV8tUwafSR6nlvGH4H6rZr7Z0SWss/HRPG1LK57lpvcJmoV+WoA
	 wNxwPy3ZjuYWtmW/VbyXmYPa2vhg3U8sSvQUMrYmAQVYrMFRVCeVQvkB6zMV9FpQFe
	 hH2H85aF82KmA==
Date: Thu, 2 Oct 2025 08:58:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 jv@jvosburgh.net, olteanv@gmail.com, jiri@resnulli.us, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 kuniyu@google.com, martineau@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, antonio@openvpn.net,
 allison.henderson@oracle.com, petrm@nvidia.com, razor@blackwall.org,
 idosch@nvidia.com, linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 davem@davemloft.net
Subject: Re: [PATCH net] selftests: net: unify the Makefile formats
Message-ID: <20251002085807.370bee93@kernel.org>
In-Reply-To: <138fe27b-7ed1-4065-827c-01e6df483153@kernel.org>
References: <20251002013034.3176961-1-kuba@kernel.org>
	<138fe27b-7ed1-4065-827c-01e6df483153@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Oct 2025 12:48:59 +0200 Matthieu Baerts wrote:
> Strange, I think all other blocks are OK in this patch, except this one:
> the order is the same as before (so not sorted by alphabetical order),
> and the last line is not "# end of TEST_PROGS" as expected.

Well spotted! I typed the comments manually.

The checker was just checking if there's a comment at the end, let me
make it also check that the variable name is correct if the comment
is not empty.

