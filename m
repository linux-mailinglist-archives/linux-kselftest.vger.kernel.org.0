Return-Path: <linux-kselftest+bounces-28187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE4A4D5DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21963189346C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF301F9A90;
	Tue,  4 Mar 2025 08:11:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703CD335BA;
	Tue,  4 Mar 2025 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075882; cv=none; b=KV05oZHyVrkGfFfZl11uVngE/ATnLzdRYb2NAa/IXOrgTkC9U2S0iOp8uLfGKunmTDFf4JwA8p9BJOOTkLn3bmU3VZTya+sl0IqX2eYYjf34MhM5M05cVHy8DYGsvRQW9/7u5AZqnviiTJe8XFUe82QYAURa0rYJH+hR84Jmw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075882; c=relaxed/simple;
	bh=89jkUgpeqDYWAZ0jzFSZY8g31zXqi8Gs1z0TqtkcEcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEjcIKxz49PZUx5qSz5H0sPKQSmYwm5jD3RXuz7A4yKUnQAinvaoB6EL58UGCUfCpwK/a7UF7hJ1fKPJ4KzNFQJVp9X5rACBi3/qTSq/suIX/yjBz7rPugvEa5V+5AE25BxWziYAwCzKpyStbvG5gCE5tyYSIT1uYrNclUcmnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5248BGuk010257;
	Tue, 4 Mar 2025 09:11:16 +0100
Date: Tue, 4 Mar 2025 09:11:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: Louis Taylor <louis@kragniz.eu>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
Message-ID: <20250304081116.GG9911@1wt.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Louis,

On Tue, Mar 04, 2025 at 07:58:15AM +0000, Louis Taylor wrote:
> openat is useful to avoid needing to construct relative paths, so expose
> a wrapper for using it directly.

Reviewed the whole series, no comments from me. Let's wait for Thomas
to double-check but for me it's OK:

Acked-by: Willy Tarreau <w@1wt.eu>

Thomas, since you already have plenty of changes in queue, do you mind
if I let you pick this series ?

Thanks!
Willy

