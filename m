Return-Path: <linux-kselftest+bounces-25397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D838A22502
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A200A167D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8B1E3790;
	Wed, 29 Jan 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqwplmzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25529A2;
	Wed, 29 Jan 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181600; cv=none; b=avqVk5wC/QmFDQG8+AbJWdW1H9Ot7IFYwYuFMaMNZc0tSRGaikCjBvZCnfjdtsn/0J4uMUPwIQcBKpvWq9J/++cP65LNqqSKqeSaQcZYyCsGTUYV8w6L2bAhwfNryFR9/7mbDTI/nZ3G3mrmYUiorarX0iJSn1rl2uxy4iD8XwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181600; c=relaxed/simple;
	bh=jWFk2NmkYKMUSK6oUQcdr+W+82tqugnkobd+Ux4WpbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouY7LmZ6ys4OPfxMCUI5yGs5nUu0ysGfW1eZqy+Hlt+uM37J0YgTbslQYEGTqBdPQVSBb03yLtzJEzrJF2HC0VuOWi78X/cAOD3fXFrx/5sl0KrCJXZS8kfjWUwFNp1Vlvgo//uX/n13fXrZfzd7kTNdFND0xmV3A64DbrTYNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqwplmzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D335AC4CED3;
	Wed, 29 Jan 2025 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738181599;
	bh=jWFk2NmkYKMUSK6oUQcdr+W+82tqugnkobd+Ux4WpbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fqwplmzGNiVcRgETJDn5qxPGxpQtmUHQv2fb0BaUe+6XRyERP86tSrMgppMYSpcGJ
	 cm3bue1HOQ9B/egsS2HkdTuKZV7aIGQ1Hxg70khGOwJcwUNSjj4t+2kdNhkodqXHBe
	 4phqulNSuLSh9M5wxL+SHFr6t10rxQqgqFOBMsIRbCwL2WeDqLurD7dPIPSRpqiYxO
	 lJiYXnsfOA8S4fiicZ1kyD+9F4qwEn/BL0bqvgQOLUW2Ki9fqQpS138LSdC5l243Wn
	 B/3atujtwiGy8IPF4UfbrLJk+Cy8yHUSkQOauOK0qJIFHEHGZXTkhu6e+z+TS/dv71
	 0HBPShnaE1PYA==
Message-ID: <5072d959-5bfa-4b8a-8bb4-496df7940919@kernel.org>
Date: Wed, 29 Jan 2025 20:13:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tools: selftests/bpf: test_bpftool_synctypes: escape
 raw symbols
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
 <12d8c07cc7bcea017f67774741f9a59d04c2f20d.1738171937.git.mchehab+huawei@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <12d8c07cc7bcea017f67774741f9a59d04c2f20d.1738171937.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-01-29 18:39 UTC+0100 ~ Mauro Carvalho Chehab
<mchehab+huawei@kernel.org>
> Modern Python versions complain about usage of "\" inside normal
> strings, as they should use r-string notation.
> 
> Change the annotations there to avoid such warnings:
> 
> 	tools/testing/selftests/bpf/test_bpftool_synctypes.py:319: SyntaxWarning: invalid escape sequence '\w' pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi, and thanks! But please note we have a fix for this in the bpf-next
tree already:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=c5d2bac978c513e1f22273cba9c55db3778032e5

Thanks,
Quentin

