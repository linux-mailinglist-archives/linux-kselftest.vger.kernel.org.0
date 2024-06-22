Return-Path: <linux-kselftest+bounces-12498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4B913219
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 07:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E651C21D1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 05:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F9149DF0;
	Sat, 22 Jun 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2v+AvDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8A8BFD;
	Sat, 22 Jun 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033329; cv=none; b=ZfOdTsPfTCiozTCPLKHmKodCfVgi0fKV1xM4bXK//eLf+oU/kaWsa4d6VRJ6Ep6IQXMM8hipAt8S/5WB0PA0n55PAJzyPSkiLH+ZG3WqwORp44HKP/GqMY6kckDyvN30z+WDD8hvHRlScO/ubvKFLc8MUl86lhEWo2M/fE7jDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033329; c=relaxed/simple;
	bh=hOBr8Yoglpe017vf/QzOMnh6U1NcQxcpkXD8IIZSYuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFTFZbqtEWlIPnQtFzV8NsYiLzOhb+mSg1NcRM8DcTO8XLR8MYyT0U+bAJT/jPqahPh8xoMmizv/YqaaZpDxvq1E6S1ZBZ5+Xa3TB73oRgu+4HvJVZN/ASSbbGWei0NovxJRTFy2lZ9wqu/8ABMTsBwrF1OI6WMvq17axJsMiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2v+AvDB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VGXfg765V2x4CLXoBU8YPGUaona+iSh5JOxRCHGDWe0=; b=E2v+AvDBF8zEwsWk3DGRk9Lm88
	fAJr/0WOSKTI+iUQ+KcGpnxMZED58Voofp2f8RRniTUWcUVj84AsJJpToR8EX741hukpeSfVKKJHo
	hx1JEtza/xX6wF5oOpqdkeruImPeDp1xqxgD2/KwyqpoGmu5B9ufgJ7kELhZvFF2DXgOTXvWgRBTz
	RW85AcLdlaem3iDDwS4kOfHTGB3NHAz61+KjMS063lF6PKtvn9vzdL0as6KtKqe1bK7GkHTfjNR3s
	ZHF6QmRJGBWMTa3OrbrLNmPUIxCy5pTZkZruG2MHeKZ9ZnTWZsucS3MXRVl+MeiZdKF/D6TnM/sQ5
	NhFUiJCA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt5x-0000000BQio-0AoL;
	Sat, 22 Jun 2024 05:15:25 +0000
Message-ID: <ebb2d230-4546-4dc6-927d-073a4425daa2@infradead.org>
Date: Fri, 21 Jun 2024 22:15:21 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: kernel-chktaint: Fix bashism, simplify code
To: Petr Vorel <pvorel@suse.cz>, linux-kernel@vger.kernel.org
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet
 <corbet@lwn.net>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
References: <20240618090641.359008-1-pvorel@suse.cz>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240618090641.359008-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/24 2:06 AM, Petr Vorel wrote:
> '==' is bashism, '=' needs to be used for comparison.
> With this fix script can work on systems where the default shell is
> dash, busybox ash or any other strictly POSIX compatible shell.
> 
> While at it, also improve:
> * remove "x" in the comparison (not needed for decades)
> * use $# for checking number of arguments
> * cleanup whitespace
> 
> Fixes: 4ab5a5d2a4a22 ("tools: add a kernel-chktaint to tools/debugging")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/debugging/kernel-chktaint | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 279be06332be9..adbb1d621ccd4 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -18,11 +18,11 @@ retrieved from /proc/sys/kernel/tainted on another system.
>  EOF
>  }
>  
> -if [ "$1"x != "x" ]; then
> -	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
> +if [ $# -gt 0 ]; then
> +	if  [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
>  		usage
>  		exit 1
> -	elif  [ $1 -ge 0 ] 2>/dev/null ; then
> +	elif  [ $1 -ge 0 ] 2>/dev/null; then
>  		taint=$1
>  	else
>  		echo "Error: Parameter '$1' not a positive integer. Aborting." >&2

-- 
~Randy

