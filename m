Return-Path: <linux-kselftest+bounces-46753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49338C94ECF
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE404E11EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58627055D;
	Sun, 30 Nov 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="E2jJtIXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F94A23;
	Sun, 30 Nov 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501028; cv=none; b=DdGQkgj/QQHXdbiso3YpDJfzPy4o3iAE6TjnLLaBEdhxMrMygnhb2gtXjH2rcueQCNOpKl6yC03A+uuU5WYMic2asM6gAoNo1ijg+j+Z4Su2lDX0AOqmwtc45rYCWr05aiffwKwsXRDEnYwp8lc3jmqO8nFhq0cYT6hiK6p2ggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501028; c=relaxed/simple;
	bh=P3f1ZBUx6/MNzw2gGNkqxpbw/lCLYiS/hoqQ8hFfj/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9KMF+uOk1YYMneOXaogocHa2uUuD/oTXQonIjIaJLgoRepYck9bvu4BiG/i7F94qmDjizQCIvc5f5dFJV437Rh0OEOmhQDQK/zkDChF09pkdblAizSZQybjfEfARvaT+1JfqfEQAswDaIuQXRy1WTrg0wuvEZqmdnYXWv8EBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=E2jJtIXS; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1764501024; bh=qG8Yii2+TswSd+R2mmmIR3T4NSGVrdaAF/IKtA4ZyIs=;
	h=From:Message-ID:From;
	b=E2jJtIXSa0FFA2OhXFJ4AfKKjxUMQYI0gFf4q32pOVmFnkkbZGUMrE6fSXQtZD0Uu
	 SErvCF3AdyCckmYgM5IWYljH2quEqg6yBELmqFHfVSrTcQu3NrHpQBmPoaWrPUgJsq
	 mqAq7csni1iEgJ+WXXTuJHRBHIeYQv8lIt1TYb34=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id DD9EAC04AB;
	Sun, 30 Nov 2025 12:10:24 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5AUBAOW0000680;
	Sun, 30 Nov 2025 12:10:24 +0100
Date: Sun, 30 Nov 2025 12:10:24 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/13] tools/nolibc: always use 64-bit time-related
 types
Message-ID: <20251130111024.GF31522@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 22, 2025 at 05:59:06PM +0100, Thomas Weiﬂschuh wrote:
> nolibc currently uses 32-bit types for various APIs. These are
> problematic as their reduced value range can lead to truncated values.
> 
> Intended for 6.19.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

So overall I'm generally fine with the series, with some minor
reserves that can be dealt with later if needed.

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

