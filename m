Return-Path: <linux-kselftest+bounces-14745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A92946505
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39531F22089
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496A757EA;
	Fri,  2 Aug 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fNV/uxBQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997561FFC;
	Fri,  2 Aug 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633987; cv=none; b=pAqzv5XKnNMQLkfArToaZc4UXz9JWo04+Z2I0DVrUd+4uFLEgDJFkjByk8XUQcFSU51dapX0Su+KkdYpe02MI5j3J7GLg/lxlUjF/8deYnFZEIu2CWcEqYfIewuaZTr0DWj8TVF1UwOpsmRnljNJEsfQ3ZrG470niFka+c+KL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633987; c=relaxed/simple;
	bh=czed6rSDBSqX7EkeWnepfaYvW/N7TTmqUuvAZ7LaVQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgzmm2xLfzByEFmYEcevtN4ty1QM/MKTAaLuI9uYmweVA9TehxdisTvgAGUXL7jjur4BN6ycsnJ+Qucnh5jqSH5kWB6KqoX6IRF22qIWJ8KW4DlWARHEKiL5/eA0HVClNeMXm3ipwccEQ2UnmNnauG8YiWQ/i16jyWisy5TLT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fNV/uxBQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722633983;
	bh=czed6rSDBSqX7EkeWnepfaYvW/N7TTmqUuvAZ7LaVQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNV/uxBQHN8GKeIboxDMtfMC1RNXycxcjsQMnaRmJOpXH87PPifgnUp5GrhyFsdOy
	 yis4n03s2Fq3zEpCAPK/wcO10sIEZbuaWIWn1V7j8IXDS/sllCphs7Jm2VgbxVz6Ad
	 9QbkJOGvlvHpFq3QTsMouu8l4HYL+7CaNc8KbcHsDyep+wQjiAvNLhzqetpRybfaFg
	 mta2YCSZFAMX9eT20UJkQKnJms7iDL7FIa8LctfPyNSv078rnd/DjsI+qX+P4+8a+l
	 QIahzpLhzcdspN5dnC0xgbwi0dkJ98vX5o6EPN8pa0xLYWtvvPMWSfyL4BTvOCCdWP
	 jgQlEGhuKl46w==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9F5C53782215;
	Fri,  2 Aug 2024 21:26:21 +0000 (UTC)
Date: Fri, 2 Aug 2024 17:26:19 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: shuah@kernel.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kselftest/devices/probe: fixed SintaxWarning for
 Python 3
Message-ID: <9ff21b81-5c5a-4701-a1bd-8fe7067efa59@notapiano>
References: <20240802161339.103709-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802161339.103709-1-alessandro.zanni87@gmail.com>

On Fri, Aug 02, 2024 at 06:13:37PM +0200, Alessandro Zanni wrote:
> Inserted raw strings because Python3 interpretes string literals as Unicode strings,
> so '\d' is considered an invalid escaped sequence but this is not the case.
> This fix avoids the "SyntaxWarning: invalid escape sequence '\d'" warning
> for Python versions greater than 3.6.
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>

Hi,

thank you for the patch.

As described in 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
you should

  Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
  of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”,

So a better commit summary would be this:

kselftest/devices/probe: Fix SyntaxWarning in regex strings for Python 3

And similarly, in the commit message: "Insert raw strings...".

Also, this is fixing an issue in a previous commit, so you should add a tag for
that (before your Signed-off-by):

Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")

Other than that this looks good to me, so after making those changes in a v2 you
can add my

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
> 
> Notes:
>     v1: inserted raw strings to avoid SyntaxWarning in Python3

You don't need to add a changelog for v1, only starting with v2.

Thanks,
Nícolas

