Return-Path: <linux-kselftest+bounces-13615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05892EF1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75F41F2320D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABD16DED6;
	Thu, 11 Jul 2024 18:48:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB028FF;
	Thu, 11 Jul 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723723; cv=none; b=ddXpnVNGWnQsclUiwZYvnqGobqcwls1LuNxtnFrgqVrL0fRVRGlSP0gWhAmxrSCzO+oaLJFnS515ZcMZD7I55oIN2gmS5L8RXxMC1eGll5BLNutGERhLSDr4oeRGRumNGpTM0JRBG8SD5eJiqgfkZC5YHnm+ylHQYrTpGLJV8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723723; c=relaxed/simple;
	bh=sSiUuHwRrN953iIT1k0HyXI4qDsxJw/+8MnuSvQ+M3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLOUNpKpBcHPkYI3y+GZc+pP6UoaYQAmtugIE4v9f9NGPzcvpBGCfXu4CX71rcrMOtg4QUvqz7iLRdDYpXht++aczSoQOSoC6VhGIGr7bWIdnZvZz8b6byiCeSEy2yQKU/RHKRliZFkYi1UsQv72HbLIQr+n/x8WV1gxUq5H4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3337C32786;
	Thu, 11 Jul 2024 18:48:41 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP output
Date: Thu, 11 Jul 2024 19:48:39 +0100
Message-Id: <172072371445.3245131.6528700363196535344.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240602132502.4186771-1-usama.anjum@collabora.com>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 02 Jun 2024 18:24:59 +0500, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/2] selftests: arm64: tags_test: conform test to TAP output
      https://git.kernel.org/arm64/c/9de9c4cc03ad
[2/2] selftests: arm64: tags: remove the result script
      https://git.kernel.org/arm64/c/6e3bc73be02b

-- 
Catalin


