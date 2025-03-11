Return-Path: <linux-kselftest+bounces-28760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11587A5CBE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 18:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695543A98E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805D42627E5;
	Tue, 11 Mar 2025 17:17:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1C2627E4
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713476; cv=none; b=C6ZSX356jNLuA7qCoFfRop4m0eaVJAiDkI2sj/P9GBtBo3wjViJW7lKRdbyiLKuo1vX6b/9mcVJLiLf01jrfd+ts/EEmRrZJ4+W+gfdVgLdXUpSulTnOPwASneWMxuDXn/aij/Yn+VHK4WP2Nflp89XlRwFkDxDMWaq6Zssxqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713476; c=relaxed/simple;
	bh=H1uvH5qnoaLNaTo59tjqN8qCBqrXqJz9EA3aTCWGBcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNxu+DV4c6xuUned3U5fa9Ovma8OOe76zJxUuiwh/vpptvbXYzJBmX75C3wnw8ungip3C/1IdcnYInE4HJ66eXi2w9aaQHVOIXZhO2/B4ywz/jrIJTo2NkpkB9+6E6u3qBXZdZilrM3fSHamwVsKYc/4Co25sXtUv/20dv3vqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BB2C4CEEA;
	Tue, 11 Mar 2025 17:17:52 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: shuah@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	yury.khrustalev@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] selftest/powerpc/mm/pkey: fix build-break introduced by commit 00894c3fc917
Date: Tue, 11 Mar 2025 17:17:50 +0000
Message-Id: <174171346335.3659993.17442583301270023148.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311084129.39308-1-maddy@linux.ibm.com>
References: <20250311084129.39308-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 14:11:29 +0530, Madhavan Srinivasan wrote:
> Build break was reported in the powerpc mailing list for next-20250218 with below errors
> 
> make[1]: Nothing to be done for 'all'.
> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/mm; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C mm all
>   CC       pkey_exec_prot
> In file included from pkey_exec_prot.c:18:
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h: In function ‘pkeys_unsupported’:
> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>    96 |         pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>       |                                  ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/pkey_unrestricted), thanks!

[1/1] selftest/powerpc/mm/pkey: fix build-break introduced by commit 00894c3fc917
      https://git.kernel.org/arm64/c/73276cee1a25

-- 
Catalin


