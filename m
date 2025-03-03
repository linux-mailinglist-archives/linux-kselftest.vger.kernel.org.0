Return-Path: <linux-kselftest+bounces-28099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1FA4CD8B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D716A3ACDA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4D1EFFB5;
	Mon,  3 Mar 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA6pXzOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8C11CA9;
	Mon,  3 Mar 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037526; cv=none; b=GjsPUwQqDo8DEiUs2kEuQ9WrYTOFI/cP8cgP007F/CooIpxKWNifE0wdfElN1PN541EK+sNvTqnDslTPmcisUPFdekayNwi5Af7Qp8NSgB/X/5K5/WaUceSt3zU1z8m1b50g8VRWM9BSHvZNiD+6jKvQBBHnmXB0E518YdoMyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037526; c=relaxed/simple;
	bh=Vcd+ny9KyTXAiNNkli8C66fTV/0JsOLLGoj8nL62uLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVreOOG3Up/8Zeou9Zd1EUkWh/XJMkXAcZl0JriGY7B9QBepyzntOWf0qJeUZ4OA4MPYSDcnxBK3gDqMnSBtsf+Exff587sogQW4a1Y9KDVbGkqimEPb7NWs6VVGr1NqF5fSxrvfwsSs+yrL4HwkpPLdiAarkuhJHTPBTdtgIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA6pXzOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5337C4CED6;
	Mon,  3 Mar 2025 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741037526;
	bh=Vcd+ny9KyTXAiNNkli8C66fTV/0JsOLLGoj8nL62uLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fA6pXzORNoCqp2fdEWfu5v3yNNdeUQbsyjTfDXPOCBq5b7v7jnYa7zZ6vILx3+mFH
	 neBNAlO4DPV9yGxEs4uh9Nej6C7XooE55vOMk40NqflsrnPRssQQIiOLi4VgrxkCGD
	 ewgyb/lHwdvvTDb9Tu0bOfAtF44+A16SMLkoX+XqcpPbZsr97K5YyuEzcGAsHxODjw
	 s+D4bAGNqlPbeSFmwc0YHy2U3SdCSTBHxWvZhDMzEGxlPS0vJtcHSJxUJP4teg8iNp
	 SSuagAXGwLhYAYB+ARK/vcRmGVKTqutaaESMx+r5WJPr4+p2ST/DThgJRF/1YDReVi
	 ApCW50j0OQ09Q==
Date: Mon, 3 Mar 2025 14:32:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/11] selftests: ublk: fix parsing '-a' argument
Message-ID: <Z8Yf0yIKs4pFcg1A@kbusch-mbp.dhcp.thefacebook.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <20250303124324.3563605-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303124324.3563605-5-ming.lei@redhat.com>

On Mon, Mar 03, 2025 at 08:43:14PM +0800, Ming Lei wrote:
> The argument of '-a' doesn't follow any value, so fix it by putting it
> with '-z' together.
> 
> Fixes: ed5820a7e918 ("selftests: ublk: add ublk zero copy test")

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

