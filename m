Return-Path: <linux-kselftest+bounces-26145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF00A2E42C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41321664FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AA1A8409;
	Mon, 10 Feb 2025 06:30:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB0E1A76D0;
	Mon, 10 Feb 2025 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169007; cv=none; b=t5bRol5Iq69ZD/BehukdmzYHd8RR94qGvSpsNBzwynwKOPetaZcMeVwYydIHSvr8uoGF45Eye8R6YnoyZR7SHw7W4G7X8U8H0gCe/5fWYYY0tobdL7u8KfpwVlGciJYkRwrBywGgc03zZxBiFsD/ggI02u0uKG3eqFfN5yyrHbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169007; c=relaxed/simple;
	bh=j6QKN50XY6rP/vn976G/CwV3Z1nQWXZZyHECgp5G6s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shCYdS36geOLZkEjk+3ehdMm48oJd5FNmBGdYbrY4Lcfmsl237WsYX1WpsYp4hYPyAhdraABRzst0fuA0WWuN7sHZUQp2w7k8X85xwM8ImbteZBLScxIvEXQP/1VINslRsiGfoMove1oS2jY43fR+xQ4fI5TPrlC1l14b8+Gwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51A6Tqkx014081;
	Mon, 10 Feb 2025 07:29:52 +0100
Date: Mon, 10 Feb 2025 07:29:52 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tools/nolibc: add support for [v]sscanf()
Message-ID: <20250210062952.GA14057@1wt.eu>
References: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Feb 09, 2025 at 09:27:11PM +0100, Thomas Weiﬂschuh wrote:
> The implementation is limited and only supports numeric arguments.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Return __LINE__ from different testcases to directly point to the
>   failed testcase
> - Add some comments
> - Expand commit message
> - Link to v1: https://lore.kernel.org/r/20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net

Looks good. For the whole series:

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

