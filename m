Return-Path: <linux-kselftest+bounces-28671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54753A5A4FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 21:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B10B3AAD6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3A1D79B8;
	Mon, 10 Mar 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV1Si1Lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16B19DF52;
	Mon, 10 Mar 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638632; cv=none; b=DozKnLxU7KuM8AMiX6QVsQeobKA2q8BsDA5njRgFiOTF3P2I7dzuSGTDR0H0Cf6820VJOoRqbzxxeQt8m+JjDqgSzDT8ftK65uuqmchFBMaChydkXYM/Gx3WQ0Wl1AIV0nnu9n/w3vf415MO/7XNoF97dPkYmKyJJ63J3kCJgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638632; c=relaxed/simple;
	bh=SfFGenCQKpNkefs06aVAjZzlL5Xj5e252Ap91jBJk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thG1+dFkBsQsE7eDhP3356grPGDa4qUenQmue31liSMKQt1LeL/jG7c/W/5m/yOxKyLn+oJUZ90NtgfCtSltHgMT5f/55Zfo2M5cLvueTZLLj/Tjr+XMtH9SxIt433jnyUFB46p/nBXwTY9uD7iGwwIKOkumgG6rIomT2aGkGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV1Si1Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D39C4CEE5;
	Mon, 10 Mar 2025 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638632;
	bh=SfFGenCQKpNkefs06aVAjZzlL5Xj5e252Ap91jBJk8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kV1Si1Lt468TP3t/h7Y2SNRdlhQM7Gwe5vukk7aqa5HPFiok5ubU0UG/UtlpOSjI8
	 htuVBtqv+OjqAsdWaK2+CyaHxFBMCGe7b45msSUsCwfVhtYQdjeLbOSw3MGssN+Jdm
	 49hblSrxTOOXZJG9OJrzXn8HLFFOeQJ2cmQ+AlZYPuojM/8NMSCARFjB6bXaU4bfMJ
	 9LpR+kIeBWm/nYYeGYHjyi7DovGBlu3YayNZx/JkjEbsRArTBHvqEfnI5AZFc0rEh9
	 qW0+RtClPJmiaHBanilOSnLAik/bpuMqf2NlrZMBvzeNkdwbEYrENw4IhlDOHTLh4b
	 JSHsSNk8vYx6w==
Date: Mon, 10 Mar 2025 21:30:23 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 asml.silence@gmail.com, willemb@google.com, kaiyuanz@google.com,
 skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com,
 somnath.kotur@broadcom.com, dw@davidwei.uk, amritha.nambiar@intel.com,
 xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v3 net 2/8] eth: bnxt: return fail if interface is down
 in bnxt_queue_mem_alloc()
Message-ID: <20250310213023.05da8434@kernel.org>
In-Reply-To: <CAMArcTWv_arQCWSeYehk=uM_=M+Hx0W_2C2cbvogQS+CmJu2aA@mail.gmail.com>
References: <20250309134219.91670-1-ap420073@gmail.com>
	<20250309134219.91670-3-ap420073@gmail.com>
	<CAHS8izPH=FkfGjq_+CzGJhZ3Wt06njM2c6HcBK7W1Xv6C8d5xw@mail.gmail.com>
	<CAMArcTWv_arQCWSeYehk=uM_=M+Hx0W_2C2cbvogQS+CmJu2aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 11:10:42 +0900 Taehee Yoo wrote:
> > Although I wonder if you wanna return -ENETDOWN from other queue API
> > ops, if your driver doesn't handle them.  
> 
> Okay, I will add -ENETDOWN return to the other queue API in the next
> version.

I prefer the current version. If queues can't be allocated while down,
how can free be called..

