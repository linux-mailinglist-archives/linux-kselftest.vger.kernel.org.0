Return-Path: <linux-kselftest+bounces-44204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD8DC16376
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C2CD5002F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E43451AE;
	Tue, 28 Oct 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1mC8cuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920D204F93;
	Tue, 28 Oct 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672829; cv=none; b=ATgR2fLQNeMl81niHxXtX5oooEtc39pgjfTFbNDF93TAU96sDWO730o2dN5M2Z09JdO0SZJFbHrf0H2Vk8kd6ZpnwkzaYjbHsoqJWl0pO45kncUH2ns5bq0WGlJtvijMBL1KKdzctjJoyf4297ziB/5e6I9NiaVlQ90eDiaK1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672829; c=relaxed/simple;
	bh=mcsf05i8u4J3+oFVqtIoZGziu63YltUoJ/4sahdqeNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUlN/VJbDkbLo0FK28ce4b1++izUhfLy2z9Bm+uTD1JEj9qSUTRrIvo4FK58FY8NAuBfnjXPJ18C1NRdxO0GD++eibFzMBNnbVMnLONPC8zBYZdIiN/QRINbZleCkAoVB0cQMrGFyj4ERLjAQW7vDuPgXkj2o5qoZgwgd60/y6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1mC8cuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67ACC4CEE7;
	Tue, 28 Oct 2025 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672828;
	bh=mcsf05i8u4J3+oFVqtIoZGziu63YltUoJ/4sahdqeNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s1mC8cuUGQOasLd3sdNHuWbrTIpe3FxZLjTcAJ32TkJz6Mwhhgw68S+iBGqxPRpMd
	 Y1LT7B0VyaMXQMTm4vR+dgC/IxImJZ7axvSwFR1Ol1Kg0KVN5uqrHOfnWBScGts92B
	 dbTHCUK40OwzjOkC24tMtFwJ4iwP+parvjj6EXq5sdmqSf98B4gwapW83gfUbrY4LB
	 AOwSLdbE1Ls/rmdD93m/HpANQx/PJ78vw/nXgF0j65wt+RKHGHJaOLWJrA1xCC2ZHo
	 +wUPdMBM48xuX8SZMguJMt7hdMzhxxK2n6iEcqzJH4Y15MzXDUL4FA84umjUAZ2mm7
	 oa12hQn6AZHoQ==
Date: Tue, 28 Oct 2025 10:33:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Boris Pismenny
 <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] psp: add stats from psp spec to driver
 facing api
Message-ID: <20251028103347.67a4dbf3@kernel.org>
In-Reply-To: <20251028103001.7cafeb03@kernel.org>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
	<20251028000018.3869664-4-daniel.zahka@gmail.com>
	<d4c31a2f-590a-4b83-b6b3-25f33a51193a@redhat.com>
	<20251028103001.7cafeb03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 10:30:01 -0700 Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 10:02:16 +0100 Paolo Abeni wrote:
> > This makes static checker unhappy:
> > 
> > /home/cocci/testing/include/net/psp/types.h:167:6-18: WARNING use
> > flexible-array member instead
> > (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > 
> > I think/guess the warning could be avoided using something alike the
> > following (completely untested!!!):  
> 
> It's not a VLA, it's an end marker for calculating offsets.
> The patch is fine, we should have added in the commit msg that the
> false positive from cocci is expected.

I guess we could avoid this problem by naming the union.
Let's do that instead..

