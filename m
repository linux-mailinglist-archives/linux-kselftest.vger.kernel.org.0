Return-Path: <linux-kselftest+bounces-26557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F0A34860
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF70161CDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC618F2FC;
	Thu, 13 Feb 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptli1wtL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259044C7C;
	Thu, 13 Feb 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461361; cv=none; b=Lme3QwxTb75Ux6VJOvAUN6jMbBOq4cEkOn65F2xbE/bzGDScVock+l4GXXwUX4ZmD2zIuSpci0mIpYVKm/TuHg5DyvshYr4UtAd8wV/nzd4GWTCTnHTD1ebSwm8RRrTyn9h4dYbMvFRvq9xwkImqaLoDXfwpRZDQ7xt/eeBZfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461361; c=relaxed/simple;
	bh=l3sJWwKrw4OzLrEqtYxG06mg67elhQprBIDBDNdmalw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOoVFLL2wERmb+ll3sX8LZb/OZlIeRuAIiDMhxBLXnNF5Lmqin9RMN8pLHCg4b9FB6jhzPj+TcALUh/fxZS+ua+/PWg75PdKWaLNKZMxeu0tTIYAnvC87mMKyZ4FC5kjorcyk9LRIDYJso8nKwmfzvmJdUn2cNTI+V8gARji1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptli1wtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9659C4CEE4;
	Thu, 13 Feb 2025 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739461360;
	bh=l3sJWwKrw4OzLrEqtYxG06mg67elhQprBIDBDNdmalw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ptli1wtLiqEu8zq4WOrYBYXFCgnND+iK0xjwlV0lJ7SFcmMcR+0ZvChlVrLcSvQvc
	 QUyERxD07eR5s9Gs5EyIzzQrNZS5MU5KNqsYO5Uaqoyh9avGWFqURbCSXIa7rrnpSW
	 4Y1F1c+upjW+PJv1G2yqIq9IqXRQpke65+oJEtDAvqkviFEV72KAtrFuyI5xl92c3z
	 kQ4vmpFYgiyoAymaQJUhWcgjNucZ3isFZazYZ/0Icf+m2NBMvDEYyUJep3qcK8ee//
	 QZPm7roG4/TT+u16mRenlCBT/SlVW/I4RVmqqPXeUnDNw5ssx5X/wqFG1Qa/NhsmK3
	 DTz1S+XKA11Pg==
Date: Thu, 13 Feb 2025 07:42:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Artem Chernyshev <artem.chernyshev@red-soft.ru>, Nam
 Cao <namcao@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 0/8] Some pktgen fixes/improvments (part II)
Message-ID: <20250213074239.7fee0a1f@kernel.org>
In-Reply-To: <20250213111920.1439021-1-ps.report@gmx.net>
References: <20250213111920.1439021-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 12:19:12 +0100 Peter Seiderer wrote:
> Patch set splited into part I

> And part II (this one):

Automation doesn't know how to track dependencies so this won't apply
for the testing. I'll mark it as RFC, you'll have to repost..

