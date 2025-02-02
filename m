Return-Path: <linux-kselftest+bounces-25526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D6A25009
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 21:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC07A2260
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B742144D6;
	Sun,  2 Feb 2025 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="L42OCAub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC72144CD;
	Sun,  2 Feb 2025 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529776; cv=none; b=pgenwbFD+SIfK1+FOy43vDq4uzFvyStpr23clxAVZ8d9w2RyoOFctJSd7iP6Z0ax5vuFT59Ono2SGvFhcMePxT7fWEI3xvh5lbX3l7mNABRC/2LmxkfbiP0qsTIfaxESLMoi80hbmUNqKW8jdOccqsmsZyXKqr0taKW2LCNL+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529776; c=relaxed/simple;
	bh=NqzZIztwz5lBbo58Ip+9/7S1pquqe0cSeyhOB7C8qjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egwzc0ibTLVN6T4xRBxsYsYNDSG/gHL3PiSx/D4jOOGLZSbOb+fHg/JUFDAGlADKYr/PUgkFwLuP/6bTl8/KMYgWhgit3qGeA7q/SFZxGpjupRau2EzD/UYJz3TPLGCOH5pjIKed9t9vCZ+YcFq4txnk8GFVgnoGnJx0at+i23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=L42OCAub; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738529762;
	bh=NqzZIztwz5lBbo58Ip+9/7S1pquqe0cSeyhOB7C8qjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L42OCAubWgKDcBS+qLuzO5RJu7oaGDTQQ2Dxyrfgl52HHrSMdr0V+DZaDtzENzld/
	 CQTyhMCUn1AbbUgayWxuz2b6GkZMHyvaSitL/BZjNZtaqXJF+d9Y8lcah0EcoZZT44
	 gEhg3hJa4wmKguBxv8iy807fOmOoWeNCtn4Ohg14=
Date: Sun, 2 Feb 2025 21:56:02 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 2/2] tools/nolibc: add support for directory access
Message-ID: <4d670db0-eaf0-4151-b98c-1e5c84e1f275@t-8ch.de>
References: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
 <20250130-nolibc-dir-v1-2-ea9950b52e29@weissschuh.net>
 <20250201103438.GH5849@1wt.eu>
 <58dbcb3c-5d5a-4f81-ac42-494b1fcaf932@t-8ch.de>
 <20250201104659.GA8168@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201104659.GA8168@1wt.eu>

On 2025-02-01 11:46:59+0100, Willy Tarreau wrote:
> On Sat, Feb 01, 2025 at 11:41:58AM +0100, Thomas Weißschuh wrote:
> > On 2025-02-01 11:34:38+0100, Willy Tarreau wrote:
> > > On Thu, Jan 30, 2025 at 08:54:03PM +0100, Thomas Weißschuh wrote:
> > > > From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > > 
> > > > Add an allocation-free implementation of readdir() and related
> > > > functions. The implementation is modelled after the one for FILE.
> > > 
> > > I think you'd need to mention/remind the two important points that
> > > come out of that choice, one being that DIR is a fake pointer that
> > > instead stores ~fd so that it can be turned back to a valid FD, and
> > > that subsequent readdir() calls will only work from the same file
> > > unit since it relies on a local static storage.
> > 
> > Point one is true.
> > Point two not so much. It is fine to have multiple directories open at
> > the same time. All state is kept inside the kernel.
> > Only the *current* return value is in the static buffer.
> 
> Excellent point! It also needs to be mentioned.

Unfortunately POSIX is more specific in it's definition and forbids this:

	The returned pointer, and pointers within the structure, might
	be invalidated or the structure or the storage areas might be
	overwritten by a subsequent call to readdir() on the same
	directory stream.

I see two possibilities:

Allocate one 'struct dirent' as part of DIR.
Only implement readdir_r().

While readdir_r() is deprecated (according to readdir(3) but not
readdir(3p)) this seems to be due to ABI issues, which shouldn't matter
for nolibc anyways.

Personally I would prefer readdir_r().

<snip>

