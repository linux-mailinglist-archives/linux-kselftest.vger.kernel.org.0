Return-Path: <linux-kselftest+bounces-28098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3AA4CD8A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B877163524
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125991EFFB5;
	Mon,  3 Mar 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIkWaAhM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F011CA9;
	Mon,  3 Mar 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037506; cv=none; b=BsRmbjS76bEgiA799U0P3tO1qraySNyYgI61sadw+Z+AfmUsl4p3UIhHmsl6Mj/I6rSvMPgMY4YSzetwtpJLe57yZGMes7E0ji6lif/EakU3A4dp7+h+KZfGtNXSKD8vvOezWyd8+mjXTLJqn2wO7G8s4WH588YdyHtTnm+EiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037506; c=relaxed/simple;
	bh=uWQfP+RSxpBjZc3BSFy3XGe/KlVXmpee2pNIlD8ualQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usw2hCB+NRkRsOaBnat/Qdagu4H1j/legKvQeu74pn+DnQxTYvUJMzHjTKKvowko+QWpvnvB6OhgViSjgo62MMVgTUFp4NER7KlnoLA2qv+AqMSJyYkL6vqmWExByNHV4qOS1iDSjbZJwTx7qLTK1CcWMXtuCW1pgFfrZTDNqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIkWaAhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0137CC4CED6;
	Mon,  3 Mar 2025 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741037505;
	bh=uWQfP+RSxpBjZc3BSFy3XGe/KlVXmpee2pNIlD8ualQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIkWaAhMBUHgOP+UwCLGy594R+N2r5gK8kImHedUsTxghM9RsouWNg5BVNXeKoZFF
	 V80eoCSbWppxET7frebA6q1veewYG2dgfvHh2cqENDhNLPvZO8zyGKyhJzWTTMvCM8
	 hAVw0xDWjLaRX7k5MZ7qoMCeCHcVUsVr4DN9DJSSXC0eDqx9ReiYydudG4JLt+cNEa
	 O394dAwwBBhByoEY1wgzk+uihwJM7rXQRRDIc+S+Hz/GlyG4ZUCdyVnxYO8dvpyjy8
	 /w9DqWV1PJWXVOa+by2TdhHKgSXkH1mb8WfhhoXsFyU4w6cnwFYh+yrjTUPllB0fQz
	 r/8GkEOhEiFkw==
Date: Mon, 3 Mar 2025 14:31:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/11] selftests: ublk: add --foreground command line
Message-ID: <Z8Yfvrk-SNCITpDS@kbusch-mbp.dhcp.thefacebook.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <20250303124324.3563605-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303124324.3563605-4-ming.lei@redhat.com>

On Mon, Mar 03, 2025 at 08:43:13PM +0800, Ming Lei wrote:
> Add --foreground command for helping to debug.
 
Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

