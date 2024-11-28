Return-Path: <linux-kselftest+bounces-22607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CAE9DBC7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 20:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1862B20DDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423831C1F1E;
	Thu, 28 Nov 2024 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptjbx+xY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA619882B;
	Thu, 28 Nov 2024 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822067; cv=none; b=Ypr3BLSzOOaUJbpv3D79a7C2E8BmQhciRv/xMFGlb/oQdW3yEZgYPE7jYZgJaBb3AOpGbFWAHiOHXEBiK3IXsUQudI7O9KN1+WmnCkGGBRflZpOSZqRFV/tHn3ccI2ZiLcpuyjwf+SOjwVwdQVuvi5YA73qBkOVgVxhrflUlmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822067; c=relaxed/simple;
	bh=Z4rRwWkzTWkeE89toBz8PfBiyMDM5wnQziMZm/GdS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGnlze3RBjsmjuAFVdRaik3OsZgoMSKwqVgZN8W5BuZGTT/3YxNpk7nM/P5VDcvJksq48DBAY6LcC76LLNo8FDY2eOlFqQChP4lMg0oeyzOyup8/yWvJ83xvJbpm+iQs2Coa+WblgXdnZi8m4WuvKmErTi+GBCyPtamKE1U2U34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptjbx+xY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D051FC4CECE;
	Thu, 28 Nov 2024 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732822066;
	bh=Z4rRwWkzTWkeE89toBz8PfBiyMDM5wnQziMZm/GdS4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptjbx+xYnoUDC1/iPv6PCNuxqTr6lhiB1osfUuvZbR/6ZPX2H9xAT6z0gBL6O11bA
	 Qz2jxsivuHnovkQLm3mBXSRjbW5OcA8i3cRraOhCU2zBxqto2V4LYCvMN5K4shbX//
	 sxuwVbKiKJieeDFeZP/UaHrOeHsLjhYb3pdKiu9xCYGPr5PaMp+YfrPw/93vuuhUhB
	 NVfB8dXWYpmY1VXghUWa5lcwn7Z5mqyLG4kOychSwkD0KaXbJNHZkNsUjg98b9Olsp
	 8+9yfGKtF6yO8G1vsfbMiEl9udScJI0VP37EvvXBSL6L3pi2bOSCoOXcLxdvtmF/Wj
	 EHOu5KBExvlHw==
Date: Thu, 28 Nov 2024 11:27:45 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: find_symbol: Actually use load_mod() parameter
Message-ID: <Z0jEMdis_1pyc1YK@bombadil.infradead.org>
References: <a7f10d132c36f0e0c80a6bf377721e17732e120a.1732802636.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f10d132c36f0e0c80a6bf377721e17732e120a.1732802636.git.geert@linux-m68k.org>

On Thu, Nov 28, 2024 at 03:04:52PM +0100, Geert Uytterhoeven wrote:
> The parameter passed to load_mod() is stored in $MOD, but never used.
> Obviously it was intended to be used instead of the hardcoded
> "test_kallsyms_b" module name.
> 
> Fixes: 84b4a51fce4ccc66 ("selftests: add new kallsyms selftests")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, I queued this up and already sent it as part of a pull request
to Linus as I head two other minor fixes as well.

  Luis

