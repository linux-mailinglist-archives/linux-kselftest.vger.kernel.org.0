Return-Path: <linux-kselftest+bounces-28751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD175A5C5DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556231893D90
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C51E98FB;
	Tue, 11 Mar 2025 15:15:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C511EA80
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706125; cv=none; b=nPeF4+UNv65shhzSxBP5EvXyIymSbjMVwcQW5Frxc5PGV7E0Vl8Zn/T7tNK6xq2tpNWOKjxTWGx+6qe6fUbeoPfDvpkkZl2ipd9JHTubAl+x7n2RdWcdTt8hmk38Bcl3ypQ8uU2nSUlS14ju9wZO3mBZWcW4JJxiE4yZz1K5Gn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706125; c=relaxed/simple;
	bh=X/lU0TlKLrVonrxyWwQKNSpkk3hEBUDkg5hb2G3vuVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXKhCJxQNx/9uW5DNBFCdIlyFLVybBTRL88FCp/64lZtJjmWPxpK/UInVvaREi9f9fnR7YQ07Ao9eF/+Na5Qr51XoB2hRY4bthlo9tA0uQVElPzUHaqOqNRDAbwuvcu3XkSPd3HXdz7v3magP3BS9JouChNsYwCp/H2MN119gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE924C4CEE9;
	Tue, 11 Mar 2025 15:15:22 +0000 (UTC)
Date: Tue, 11 Mar 2025 15:15:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: shuah@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org,
	yury.khrustalev@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] selftest/powerpc/mm/pkey: fix build-break introduced by
 commit 00894c3fc917
Message-ID: <Z9BTiOh6DkstKZ53@arm.com>
References: <20250311084129.39308-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311084129.39308-1-maddy@linux.ibm.com>

Hi Madhavan,

On Tue, Mar 11, 2025 at 02:11:29PM +0530, Madhavan Srinivasan wrote:
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
> https://lore.kernel.org/all/20250113170619.484698-2-yury.khrustalev@arm.com/ patchset
> has been queued to arm64/for-next/pkey_unrestricted which is causing a build break
> in the selftest/powerpc builds.
> 
> Commit 6d61527d931ba ("mm/pkey: Add PKEY_UNRESTRICTED macro") added a macro
> PKEY_UNRESTRICTED to handle implicit literal value of 0x0 (which is "unrestricted").
> Add the same to selftest/powerpc/pkeys.h to fix the reported build break.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/3267ea6e-5a1a-4752-96ef-8351c912d386@linux.ibm.com/T/
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> Catalin, can you take this fix via arm64/for-next/pkey_unrestricted?
> Patch applies clean on top of arm64/for-next/pkey_unrestricted

I'll take it, sorry for the break. I did not realise powerpc duplicates
those definitions.

-- 
Catalin

