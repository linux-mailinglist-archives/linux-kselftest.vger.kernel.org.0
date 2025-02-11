Return-Path: <linux-kselftest+bounces-26364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE0A30EBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE42E3A5EBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568662505B3;
	Tue, 11 Feb 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZA1exyO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5F1F2367;
	Tue, 11 Feb 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285270; cv=none; b=B74irqo25kHibFRK/mhPuRz2zQII+IFTcl1LTbXpOdDjYLnU3RHZxQ9waP0iCg+DfjZRIx8QIYhJ4+vt1cFp6IBqmyjIlZi6l9CgFXjDNekB5pEXXjPmvZ0d0DtPumDHJy76LXlK1N503WTiPG1yyG6Fo7bpn9hN2IyeD3Fu+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285270; c=relaxed/simple;
	bh=7FXmIfHKI0A24C9ZdNlzK1EB/0enzRYaBWrf7AXQ7cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW2Bf+OV0FI+rHPHajN0qc4oRG0ZFB+ZtVs0OSZ64gvLCVpp5upB1ZH1RpfSoQr3k8z/zcJizXHkK+FldgzAAvMmAVX3gJJah8MFFr0RM6oRgCFGiM441oD/Vr5Avr2Ow7jtosx9Kv00cJAYSHB++mo/7kuqagvGt3bfFDwx+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZA1exyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F54C4CEE5;
	Tue, 11 Feb 2025 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739285270;
	bh=7FXmIfHKI0A24C9ZdNlzK1EB/0enzRYaBWrf7AXQ7cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZA1exyObdvvQijM1159sv1Zp6pLGVO6ohzPFABo5GuL4S/yCFo9zu1eVpvYuH/uM
	 t4xiXC2pL6FCRHRdL213SVgavYtWf7j1WiOGvML047g/nvaHGyQaIf5iDqt9eXGEOt
	 3wmHvrAgn3WYDU+ygtgb8cxCzOGSXMly8DUraBWt608Fv8CfDnzEjxCU30rhoIUG0m
	 R847A0XTDUrCtFOun7azHzlkRvdmJ4my0S0sA/T7mBFJ0dKkOmkJ94JEuxtDsyNlhJ
	 suvvJoMIYcD740BIopH9hjDz2xObrCEMPKhmpGL8/V2AwxvsSN2bM9iwAzPYQcEpTf
	 woVU+fKYZ8tGQ==
Date: Tue, 11 Feb 2025 14:47:44 +0000
From: Simon Horman <horms@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] blackhole_dev: convert self-test to KUnit
Message-ID: <20250211144744.GA1615191@kernel.org>
References: <20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com>

On Fri, Feb 07, 2025 at 06:38:41PM -0500, Tamir Duberstein wrote:
> Convert this very simple smoke test to a KUnit test.

Hi Tamir,

I think some text explaining why this change is being made is
warranted here.

> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 --kconfig_add CONFIG_NET=y blackholedev

...

