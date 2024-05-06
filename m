Return-Path: <linux-kselftest+bounces-9498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9358BC4C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 02:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB6F1F218A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574D140370;
	Mon,  6 May 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R27pRFDq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979521DFD2;
	Mon,  6 May 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714953624; cv=none; b=sisIidLHxk8yQsUrB4eLl4BfgtwjgoJaIT7nWYhCVx/+hxktx2dIXSLQmhE04W75unVvcCXpYGha9Jh01wGEv5MtstPynAhHrWwC4zD9wTZgp0MjUkWAA7hao2Ij9hWx5ef7JCbZkouK/rtV2PBgt2QjfQ8YhCv3uEFM+puafCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714953624; c=relaxed/simple;
	bh=2u1/3kvJAWrzdDiPXie4fyL/1DuNBTp+COTkLBv/rTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6DaREwArJyDUATwWkAljIOx3PxgjzFTGvJrNviHrGBNgyvNpMCT5GO/ZBBI+6pkBlEPJsduSR7zqLLah56fjGGIdsMNNvGboo+v3GRPZLVWKcd2V6+sW0+CDu+lq2QzF6mvyIUpfUy+H8mRdivuzHYeyzgdJ3eo22vNZQuj5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R27pRFDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B08DC113CC;
	Mon,  6 May 2024 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714953624;
	bh=2u1/3kvJAWrzdDiPXie4fyL/1DuNBTp+COTkLBv/rTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R27pRFDq/Qe3lrvLW6KnlINluIevql63lzk5Lr2whN/TVj4YSrg6l6zbtQFG4o+fq
	 fGGiYfPjMhuSg7M0GJXdXq3vQBpZzHUjM0V6/K6UVoAjeWmMDooDcsrG0jICve8vbM
	 KpGxLJmIWqhJVGyoQfC5XW23jZHloeKr4if9QxZ39SGxcNO9CfPjtRFQTCa74/Bung
	 TVa3VZjiVXd2jVr7C/3MLhvZ1HkTrkJRBBs/U5R9bk74bTdWRiOLRIN5a8EUWN2xI/
	 d/ZbKqaenxmw56whNLFqgvsXga57WTpHn9OlFFOPnupY7K0/HCIEiHfaF+kZ3ZHsYB
	 /24/YlnCsqeKQ==
Message-ID: <d9d6c08f-ad8a-4456-930e-9d2179a490e3@kernel.org>
Date: Mon, 6 May 2024 01:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] bpftool, selftests/hid/bpf: fix 29 clang warnings
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 Peter Hutterer <peter.hutterer@who-t.net>,
 Jason Gerecke <jason.gerecke@wacom.com>,
 Joshua Dickens <joshua@joshua-dickens.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240505230054.13813-1-jhubbard@nvidia.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240505230054.13813-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 00:00, John Hubbard wrote:
> When building either tools/bpf/bpftool, or tools/testing/selftests/hid,
> (the same Makefile is used for these), clang generates many instances of
> the following:
> 
>     "clang: warning: -lLLVM-17: 'linker' input unused"
> 
> Quentin points out that the LLVM version is only required in $(LIBS),
> not in $(CFLAGS), so the fix is to remove it from CFLAGS.
> 
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

