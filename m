Return-Path: <linux-kselftest+bounces-24158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D430A07F44
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F31884E86
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72118B484;
	Thu,  9 Jan 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkKzdywN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417C17B421;
	Thu,  9 Jan 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445049; cv=none; b=UtELYwT82/jqJnhFys7OrHo1pWzfAQ0ZlXuStzIuMXkgVvV4kaXez1KNEfL1XvAvTpcHHc/POxpgNqq5CKD4HZmrjs9cpVMqtqDCZRts73r+XyVMb1n5KPrNFIwNOssapz1Bgzuwm+yL7Duomr4Ptvn50IvAbP4vZUd5HzGb1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445049; c=relaxed/simple;
	bh=+VmR34GkdqkkxBn3H7GkFY2zqJQCS4x+lDjQUH0jTMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ+buePRWVk2iioYitALgKrp39XHBoHOUhMqzm2TnLZy/3+h7J5L+FXNBdMC2lwl4wqu1JIm2K4f+qRptm+N7uiAi0Lq9cMHdulE094RjMuFQClc8sn5rL6rBnr5x8r4S1tq4Aa4hEQzs2RhZ2ZsC6l/bYIouTZzzXHJ2s88w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkKzdywN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA07C4CED2;
	Thu,  9 Jan 2025 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445049;
	bh=+VmR34GkdqkkxBn3H7GkFY2zqJQCS4x+lDjQUH0jTMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkKzdywNFuYEtI8r5OHdB5TPKQuuuf5dAIP185gk/uZmroXONxcZtZ1hnW3Bci0vK
	 zzxm8rBSaCmlMMEOz7hAVo6sLtsUCRyz0fomQgiO1VjHpkafe5jRRSPHqLunUf8n8q
	 7IGOqbidS57+DgCHd6WQralDlYx6rYennGytGZ14ijTrMKwn+Pb0Q4p8yUpHKTSRwM
	 zGDMSYRZGIo2lT9eqKUBShlvEztuu3AtXO/Gqe9dFyF7nO58SBrdyrAVacAn+uyva9
	 h8YEVclO5NFyFASn5sC1h3zTO50OcEtD+SBVHtrKkCs1UrCfpiEj2nQ2kdnqec1OJX
	 KlgehVK5P+1pg==
Date: Thu, 9 Jan 2025 09:50:45 -0800
From: Kees Cook <kees@kernel.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
Message-ID: <202501090949.793D9A0@keescook>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
 <20250109173842.1142376-2-usama.anjum@collabora.com>
 <202501090941.5289E7444B@keescook>
 <843bf743-4005-47bc-9e39-8ea49255b152@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843bf743-4005-47bc-9e39-8ea49255b152@collabora.com>

On Thu, Jan 09, 2025 at 10:48:52PM +0500, Muhammad Usama Anjum wrote:
> For the all other case, why should we keep argv/argc and mark them unused
> as well when they aren't being used?

I'm fine either way, but my personal code style instinct is to keep the
"standard" main declaration with argc/argv present. But it's mostly
aesthetic.

And if you think use of kselftest.h isn't universal, then perhaps we can
avoid the macro, but it does seem nicer and more "normal" feeling for
the rest of kernel development.

-Kees

-- 
Kees Cook

