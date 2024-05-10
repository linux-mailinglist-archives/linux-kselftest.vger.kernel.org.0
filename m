Return-Path: <linux-kselftest+bounces-10013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C68C24F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F2E1C21C9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8298592E;
	Fri, 10 May 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izua72dj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5378C95;
	Fri, 10 May 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344402; cv=none; b=avA7+N4FCGOG2ktdxAKkY/FYubB3itSqW9aS6SP6RBmB7v7bURXy/7Sar+rd1X6bT012Nn3/ygDN22rxyBAy8D+diIMA/0GXjDiMOjdgzlitfum8InDNx4nRgg1oeEtiXiFkU9uK1dA26KIpbjLMtSOQCt9mhyMRsgIbH9jlKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344402; c=relaxed/simple;
	bh=wkw7eMzD7vRY4tjRyCQQEbFC5oX8XBkRF4dbg8g9tI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJGl0NZ6oWw0RBrp+J2TaL/qgOD95gFGlYa6HjfHl1ptGDkVLNJHsYaqMSQnjkKd/tr48iparcQ0jonSmFLjMVb0c6+xG4tytIFE0QrgcwteBZUG48cAh+bnrRiMj0DvizsmXijyDayY8pn701WKCYW26PCOw0q67YB6jZFRTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izua72dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBCCC113CC;
	Fri, 10 May 2024 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344401;
	bh=wkw7eMzD7vRY4tjRyCQQEbFC5oX8XBkRF4dbg8g9tI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izua72djUmTszPGbwVpXBg8DTQHiDkMDjXpxWlB9dd6Uvl+ckR/Kld/XCdT54kAg/
	 EvfW9ylL+FzxqvwTb2/7TImDr6uZSLnbCCBUn+yYuWLX2XoTnI5LAcRu5UgQuMd8TM
	 lb43uVFhs1HU6Plkwe0vfGhKwmjalHcvl0/QqgFdBPY03uOkS5hY+9MK7hYAqYaKe/
	 CdsOrGkczTcW5GCSkRXi/656qnjShgA3S0Hz4oVKrnT54MWk3SM/NkFMKoENGJoB3P
	 /sLNMrMbuoAeF2/dqh2dYivk1VWFdn9lX+MdeOiXlFzz+tkux2v9LASHRquckgKr3b
	 pLG6nYoAyqYQA==
Date: Fri, 10 May 2024 13:33:12 +0100
From: Simon Horman <horms@kernel.org>
To: Tao Su <tao1.su@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
	edliaw@google.com, ivan.orlov0322@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, shuah@kernel.org, seanjc@google.com,
	pbonzini@redhat.com, bongsu.jeon@samsung.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alexandre.belloni@bootlin.com, jarkko@kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v2 1/2] Revert "selftests/harness: remove use of LINE_MAX"
Message-ID: <20240510123312.GY2347895@kernel.org>
References: <20240509053113.43462-1-tao1.su@linux.intel.com>
 <20240509053113.43462-2-tao1.su@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509053113.43462-2-tao1.su@linux.intel.com>

On Thu, May 09, 2024 at 01:31:12PM +0800, Tao Su wrote:
> This reverts commit 8092162335554c8ef5e7f50eff68aa9cfbdbf865.
> 
> asprintf() is declared in stdio.h when defining _GNU_SOURCE, but stdio.h
> is so common that many files don’t define _GNU_SOURCE before including
> stdio.h, and defining _GNU_SOURCE after including stdio.h will no longer
> take effect, which causes warnings or even errors during compilation in
> many selftests.
> 
> Revert 'commit 809216233555 ("selftests/harness: remove use of LINE_MAX")'
> as that came in quite late in the 6.9 cycle.
> 
> Link: https://lore.kernel.org/linux-kselftest/ZjuA3aY_iHkjP7bQ@google.com/
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


