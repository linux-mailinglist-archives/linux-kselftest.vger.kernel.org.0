Return-Path: <linux-kselftest+bounces-4820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB48570A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 23:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56D9285A6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847813AA4F;
	Thu, 15 Feb 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPRTltTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E349655E7F;
	Thu, 15 Feb 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036952; cv=none; b=uv8CSKVxJkhYDagI+j8KKWfRexnD7p54UPYJ1p6+Vkb7zaNSxYAiOuZ6RDpxYWIwXRA20xofOoCKtRU64gz1gDTDdd467egZc58ZlFrBQb6//qJJ9ZPUviuXQ4sqo+3Xb6cBJg4OHCba7+S2T9s2REqToxKex/xj5Fl6H0hcQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036952; c=relaxed/simple;
	bh=Vx0+7lCYeH+nbfnzkhtq+S64ZXTohehqoSm8QQ3L7AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmBLSZ8JPxHOR7tegeAs6N7/NsIUoNcveR7RVurvso4VWoYoU6kl1RSiIaj5uKAAa0gi6zOctKONw2UpvQdPDpd6PoTrZLC3jdgj4cqyxgvTim1HlHdtGfBAu6/ab/J1U9KntDYHD2BlyZAEjMYTOWfFUqGvgnOk7wa6miAkTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPRTltTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC87C433C7;
	Thu, 15 Feb 2024 22:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036951;
	bh=Vx0+7lCYeH+nbfnzkhtq+S64ZXTohehqoSm8QQ3L7AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPRTltTV48bGwnycfXoJGwL395CCxY+gRG8tfeLWaxHit5KfHRLe2d+ffGiVq+IVt
	 qtDlXRJJGBKmqPAFxTKagHnkN+XzruZDfszBM7UJTFRglw8jKDXC2IOVSkodX4IU7L
	 wZ/7nlLppZKOt7sHKiueahb880C/oGkfZNuOJVdr21aDZFlFFze1L+9N78rype3FTw
	 6QumPCqEP/KdwbUcTMwkWtdm/a+yJ1sROVgG/ltqVooeHGpedNuL/bdcHaxZXQu4cg
	 +VUhP5ivik9fBZ+LLmmwYOssSVuS/7cISXHjPPCGVuCfnOQB0WYaLBNC//njXIPADY
	 pukPh422LogxA==
Date: Thu, 15 Feb 2024 14:42:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240215144230.0bad31ee@kernel.org>
In-Reply-To: <202402151404.0CAF526@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
	<20240213154416.422739-4-kuba@kernel.org>
	<202402151404.0CAF526@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 14:06:58 -0800 Kees Cook wrote:
> Oh! I just noticed this while testing changes to use XFAIL, there is an
> alignment issue: one too many spaces after "XFAIL" above, which leads
> to misaligned output.
> 
> 		fprintf(TH_LOG_STREAM, "#      XFAIL      %s\n", \
>                 fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
> 
> Compare the position of "%s" above...

Ah, sadness. Thanks for catching. Let me fix, look this over again,
and perhaps add the new helpers Jakub S suggested.

