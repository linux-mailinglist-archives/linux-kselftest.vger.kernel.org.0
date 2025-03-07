Return-Path: <linux-kselftest+bounces-28449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D694A55D27
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 02:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C93C1894234
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 01:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F81624E9;
	Fri,  7 Mar 2025 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7S242Jk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57871624E0;
	Fri,  7 Mar 2025 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311326; cv=none; b=kPhpKd5eB1Um2XJK+LWpU1SFGCRFkFbEZsV3ePO8gaWgvRtajM4XWvFeEvXMVGma2LZw0rjflyG7SNhd5Yngx6TsVBn5iWNRW2CCsLxySGGkj6fytFaxa/DYAff+7Mru6TRhWUQqcjtuMskJUcwarRM1Kp6IgSBlZIqa99k51Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311326; c=relaxed/simple;
	bh=uoNOKp4tAcKXN9P0cFOznFn6Il+0clSpMIvC18lTfcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNV9z15ghWaIzQiTtweH192jt6qK7Q5+g2+hU+vul+ehJyekW2zgdiTKVsN41XPM8g8uSY/AO6DuC/ijdmUfqsSaRFp9hZa742J2nxXE5n8+tBfzYtW25aDeq/wHNFkSW2DNnYwvbX0FZY1gSq9Iqx+CkLwnY3/+dWCXo6fLpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7S242Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6A9C4CEE0;
	Fri,  7 Mar 2025 01:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741311325;
	bh=uoNOKp4tAcKXN9P0cFOznFn6Il+0clSpMIvC18lTfcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7S242JkxA8KBOKnWV4Sm3duhOAmFqc9ZidmSVc7cwK+vNeJPDru9BAHRsqz51OXG
	 cIbYG+XRn2SSX0NHaRYFTTxVbVl/wNGw+wyNVao8vcdznVjbFzMT8X3UBA0c7MtqLq
	 LBSAFE8ymKxbrOapdg0nvFa0qwTqbBNogZtSl2tlLQztNY8b5cyUHXHgjPc02SoEw4
	 Bjz2qLar6uxBsOjmVmDwDy4MobXNDj9G4EWabLiujEGKs1x2xMNNHIPYwbEsvMMN1L
	 ziQ4tRb8Atrxq+eg6EAIQ3HhSFkP3cUBlbj6yEIcRLoWTe9i97Ufhkw7KuPoWt9M+o
	 TMjCgOBptaAkQ==
Date: Thu, 6 Mar 2025 17:35:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 almasrymina@google.com, asml.silence@gmail.com, willemb@google.com,
 kaiyuanz@google.com, skhawaja@google.com, sdf@fomichev.me,
 gospo@broadcom.com, somnath.kotur@broadcom.com, dw@davidwei.uk
Subject: Re: [PATCH v2 net 1/6] eth: bnxt: fix truesize for mb-xdp-pass case
Message-ID: <20250306173523.20b136ea@kernel.org>
In-Reply-To: <20250306072422.3303386-2-ap420073@gmail.com>
References: <20250306072422.3303386-1-ap420073@gmail.com>
	<20250306072422.3303386-2-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 07:24:17 +0000 Taehee Yoo wrote:
> +	struct skb_shared_info sinfo = {0};

> +		memcpy(&sinfo, xdp_get_shared_info_from_buff(&xdp),
> +		       sizeof(struct skb_shared_info));

This may be a little expensive, struct skb_shared_info
is 320B and we only really need it in a rare occasion
of having multi-buf XDP.

Can we update agg_bufs = sinfo->nr_frags after calling 
bnxt_rx_xdp(), and otherwise go back to something like you v1?
Sorry if I mislead you.
-- 
pw-bot: cr

