Return-Path: <linux-kselftest+bounces-25642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D13A26A31
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 03:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E9F165D94
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61761428E7;
	Tue,  4 Feb 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqTz8KL3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7DEC4;
	Tue,  4 Feb 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637125; cv=none; b=PPb7uNweq/LerSFtk7HNe88teCe0g62S60hAOMhyA0zjEVT8QJKzmhPq+Iz4yzs8tvMQ15XOHqCScnA2O7qlqBxFvFTYOcF2IZw3A7kPhJJbtbqJVHeTg429+xw97SD/ykk1TL3mtv3b5KhD8e89+gHZ82pPJzcHROL+WJzdg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637125; c=relaxed/simple;
	bh=m1RF4XomatnHgBjWRolxSQEe+b9UxVhiLunv8jNDikg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TStLOroHaHkUHlpUX1qr/VyuL6TnfCOkCapOssyjyN+G7ZYVerE9aVKR8aeQJ3He61CpdG87/XHpuNnSUojFysOisyNGDKkE4yjIW5hKsXo5sHDqWfpRCrwHrb3IOLwWZgC3S1FrX/W0zkTyHty2XmPOofx+Q0/5XIiZSTqu7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqTz8KL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84801C4CEE0;
	Tue,  4 Feb 2025 02:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738637125;
	bh=m1RF4XomatnHgBjWRolxSQEe+b9UxVhiLunv8jNDikg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqTz8KL3istERH4xwphDzrfoZYgWr9C5/vynap/0hC3pIYpCfmWtYuZoF81jC371M
	 Sz6ZlD8FHJi6zB0fMdfeCyqkdrU5L0fWrCAi4/19OX/VxUymYI8DzsyyFKDKwbmAzp
	 g1YGLvGFsUewcLX05TjNepbo4+a60+nqCVtNoL0ZP6mo++LWhvsM4S08vT1OR401WF
	 60+fj4Zy0k/RTQC1CmPNs+QvQIEepUlwW8lSS78xpF3UhmKeOhCnRUYCLM7wfgjnr+
	 aM+HEwQSfrP9sJS5WpgfcOrnRSSostqQ5dkkTKHEcTfsfuCuSV90dk5nj+nhBaVzMQ
	 r4SVzsRGphPPg==
Date: Mon, 3 Feb 2025 18:45:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open list),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
 bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH net-next v2 2/2] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <20250203184523.5676eae6@kernel.org>
In-Reply-To: <20250203185828.19334-3-jdamato@fastly.com>
References: <20250203185828.19334-1-jdamato@fastly.com>
	<20250203185828.19334-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 18:58:23 +0000 Joe Damato wrote:
> +/**
> + * this is a simple helper program that creates an XDP socket and does the
> + * minimum necessary to get bind() to succeed.
> + *
> + * this test program is not intended to actually process packets, but could be
> + * extended in the future if that is actually needed.
> + *
> + * it is used by queues.py to ensure the xsk netlinux attribute is set
> + * correctly.
> + */

code lgtm, one more nit: could you replace /** -> /*
Our scripts thinks this is kdoc and complain.
-- 
pw-bot: cr

