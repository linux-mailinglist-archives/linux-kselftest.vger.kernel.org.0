Return-Path: <linux-kselftest+bounces-33159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D322AB9503
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 05:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F784E8109
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58511FBC94;
	Fri, 16 May 2025 03:50:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE972631;
	Fri, 16 May 2025 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747367437; cv=none; b=gw5b+jeOy8+8Nb0TN5sqMF47n5AQJHuQkV7+4KAtxMCJU45n/pnE9vNuJM0QBRiAg36BAEDSZtU1cbJyLIOtW04QXhXyAmxZ9JELmFXbQIWKlhLbOR6XwKA7Uzd3qOsI7YLf/WPlPFgptAOV73ex/sRuzqOoNVJnL9Y+7WBRjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747367437; c=relaxed/simple;
	bh=f3xP5TW/Weg9p2S/LU5naxCVlCkKeiqM4TbBfgmv9nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ/vSSulyr9qmketCFT0u41BFa5fQ1cSbs7oF4lmYHAARiDygaNgmhlVDQWKTP4QwKR9a/RPjGdH40YgrWFOeL9JQWOpEYwEA3KT79I+vGTVc5j1Y8ac5gy+Z/TASHdwHIFPWUuxcfzAo8uHRgCjl+ZwcfxAKmj3Q9uYi8oVL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 54G3oPHv012661;
	Fri, 16 May 2025 05:50:25 +0200
Date: Fri, 16 May 2025 05:50:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: split out more headers
Message-ID: <20250516035025.GB12472@1wt.eu>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 15, 2025 at 09:57:46PM +0200, Thomas Weißschuh wrote:
> Split out all headers which are used by nolibc-test.c.
> This makes it easier to port existing applications to nolibc.

Nice work, it's pleasant to no longer see #ifdef NOLIBC in the .c. I'll
eventually try to do the same in my init code once I'm in vacation, it's
likely that it will be sufficient as well now.

For the series: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

