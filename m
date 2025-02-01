Return-Path: <linux-kselftest+bounces-25507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFCA24822
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6787A318C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D91474A2;
	Sat,  1 Feb 2025 10:08:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC872AD20;
	Sat,  1 Feb 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738404482; cv=none; b=YuNWpGqh6SuUm4ZeoBAFylG/zf6/oQ3TY+Vfdo01nQO22tAzCSkuUoIWBru0bAMR5T4O8oAe0TQAIOZAEMfXb8ZpH+pe82wngzIMnOYLeOj0glRC4uQJXrKNQ6HxzEhQLO1iN2gPEM0i0oJ9tdxWzC5cKzCXEAFf6kyTk7km+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738404482; c=relaxed/simple;
	bh=GgiPcK31WrglOOPX49oPVxu09qC0jgc6+ifXUx3AUjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReRGpHVNUpyJEk4TTxird9F1+Dt5ILgeN3QPy9DRHIyePIO5/Zm3VIlO0/jFhltbmiFtA1DHw+aexPMW7Lii3V00j4fNkz8goZfqW2VsimPcQL5Dt1Nu+q9FITCGBG/vj6MzBxT/sIT+zJJoKwr5qjQsFfHUIJmRMMpDol92OZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511A7txl006190;
	Sat, 1 Feb 2025 11:07:55 +0100
Date: Sat, 1 Feb 2025 11:07:55 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] selftests/nolibc: drop call to mrproper target
Message-ID: <20250201100755.GB5849@1wt.eu>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
 <20250123-nolibc-config-v2-3-5701c35995d6@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-nolibc-config-v2-3-5701c35995d6@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 23, 2025 at 08:37:39AM +0100, Thomas Weißschuh wrote:
> "mrproper" unnecessarily cleans a lot of files.
> kbuild is smart enough to handle changed configurations,
> so the cleanup is not necessary and only leads to excessive rebuilds.

Generally for me the mrproper has been needed when switching between archs
or configs that leave generated files that pollute the build of others.
Also a typical case is during certain bisects. It has happened to me many
times to completely fail a bisect due to not cleaning everything. With
that said I agree that cleaning by default is painful and I also hate doing
that.

So maybe better get rid of it indeed, and leave it to the user to decide to
clean or not.

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

