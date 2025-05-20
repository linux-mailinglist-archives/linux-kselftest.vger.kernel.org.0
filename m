Return-Path: <linux-kselftest+bounces-33405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E90ABDDD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4DE4C7273
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36524BD00;
	Tue, 20 May 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAX6qJjP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3621248166;
	Tue, 20 May 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752013; cv=none; b=nUFG5gG1Y/hS53LxdIQ+zUZsctjdD2Tkuzvy2/pdLdK29bmqkn9hM6eBaUhyTJ1lzwiXxIwhe+3KgWG263zygthsW3XiZ0SzUoHP/APn0Iyg7t2sSrnxu4OOvkL+KKOF44305Kk2sA0lptErC7gUjrhdSlbwQdpwrd79csl4tHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752013; c=relaxed/simple;
	bh=h3PEVXdDXZNqXtyIXoCQMZ2uLekttkQ3kJBFBUtR4jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX9Wz3geoWFEj5/P08C1H774f/wvIYH0o1L3A3SRtmHaVy/hMfIv/Sabz0NRUmUYQVIC6q53EWVmTqU03yIvnwWkhU1GR40fBmjuH+mvicbwI6omeNWSUWA44mmWtcD1GLH1WqSyed1VFtsCipjvTmQi/Pghx85XRnitt1fn2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAX6qJjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D256AC4CEE9;
	Tue, 20 May 2025 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752012;
	bh=h3PEVXdDXZNqXtyIXoCQMZ2uLekttkQ3kJBFBUtR4jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAX6qJjPAG3kZx8PsxpGyVTfLQ5pAJiHsAAYFALUOL9Sm8mGPd5W9tqC9KtPC6WBj
	 8ugOLCR1ciFpFLRDi9KH+2YRvEZ45hlqLjKTlSQVjHry2QI78MEOd3+RgRfI2K4KXw
	 K18od7m19MJw2JQ5em/7KAzqN97DmptDolGVD4ZUio9huBCDVp1i5RgBMblHuTiyXx
	 54FDaW/1zaY8YBNdcwLq3GSUDj2OIEliDLLFUfkP/Y5nNwUmNQFdVtnc7K0hYqAfvz
	 /HnUbDZshZlhtFYLY5X9SSWpjLg4kQmhVHBCvOzHS2rAbz7FvFS9JCpHolUf28yqbt
	 5nYaSJcxMFY8A==
Date: Tue, 20 May 2025 15:40:08 +0100
From: Simon Horman <horms@kernel.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: skhan@linuxfoundation.org, bongsu.jeon@samsung.com, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: nci: Fix "Electrnoics" to "Electronics"
Message-ID: <20250520144008.GU365796@horms.kernel.org>
References: <20250517020003.1159640-1-sumanth.gavini.ref@yahoo.com>
 <20250517020003.1159640-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517020003.1159640-1-sumanth.gavini@yahoo.com>

On Fri, May 16, 2025 at 06:59:37PM -0700, Sumanth Gavini wrote:
> Fix misspelling reported by codespell
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>

Thanks,

With this change this file appears to be codespell-clean.

Reviewed-by: Simon Horman <horms@kernel.org>

