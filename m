Return-Path: <linux-kselftest+bounces-8899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8688B2FC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 07:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7081C21445
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9882D13A279;
	Fri, 26 Apr 2024 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lSLZZ6YB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC613A261;
	Fri, 26 Apr 2024 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109863; cv=none; b=hs+hwuB1s25VUGIKJOI+tKa4Vv7RKviz/a9SDKjXFQCHakehPe7kHGsAiqMBVtaJ2l0FZGpvFK3bODsid9LNUkxzaFdZsAyfkvfYc6QEl7szknft3tZqTuZf+1AveMIyKNYVXpn/BsuIbzaLzDzL+wVCmN+JkAcwLghxzRBfbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109863; c=relaxed/simple;
	bh=GKtOWhg2ae+RlxbYZGtFto0YazT0Bul5AcJEj3TSpjM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iBo/qsLzXENUmC6y1y1DawVX6G/qioD+P1kvtsNlMNOatg++cTin0gz3qRFvoxm08lHxopYHvVX1nC/bP5BaypySW4TY+G3Ilu1crAkJ+Y8mMWPMA+8as0KV/vTM7deH31GGgIyBgI/32Fk7Ir9hk0TY7BYOOQNAQGQbpxvr2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lSLZZ6YB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714109860;
	bh=GKtOWhg2ae+RlxbYZGtFto0YazT0Bul5AcJEj3TSpjM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lSLZZ6YBArhCkS2XwPabXQWFbq4NQsfvcF/E1vM0/hLYuOipiz4pkPMgyfICwgBJ4
	 +4RzM37OQoBQeTRFPpb8SFTQ4bTokD8+ljlCHSR5VNa6MKHB6OqAvDw1S3xyf5kDWB
	 QH7UM0E83JJ+8w0p98Ac8d7pb3VKdUpKMDAqk59JL2gRX6ltGcciHrWBgykLWj1CQ4
	 NZYXoajm36CQAJjcjO123qrdJ8BMwuCZaL3RkcRpBFx7YLbcSbQrL76sca7VL5YkPQ
	 1Dbw3IiDqxsCViexavGDbodgz/HZ/p21Vnks5KoHrBptymAg8QD4BHu0q49eh3ZrDT
	 03ocGxFDvaltA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8E7D37813A4;
	Fri, 26 Apr 2024 05:37:33 +0000 (UTC)
Message-ID: <e6ad2921-4da8-456a-8a31-a1e704c06329@collabora.com>
Date: Fri, 26 Apr 2024 10:38:04 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: selftests: Add hwprobe binaries to .gitignore
To: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 12:58 AM, Charlie Jenkins wrote:
> The cbo and which-cpu hwprobe selftests leave their artifacts in the
> kernel tree and end up being tracked by git. Add the binaries to the
> hwprobe selftest .gitignore so this no longer happens.
I've been posted comments on patches adding new tests to please put
artifacts in the .gitignore. But still people forget or don't know about it
as .gitignore is specific to selftests and they aren't used-to it.

> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
> Fixes: ef7d6abb2cf5 ("RISC-V: selftests: Add which-cpus hwprobe test")
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/riscv/hwprobe/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/.gitignore b/tools/testing/selftests/riscv/hwprobe/.gitignore
> index 8113dc3bdd03..6e384e80ea1a 100644
> --- a/tools/testing/selftests/riscv/hwprobe/.gitignore
> +++ b/tools/testing/selftests/riscv/hwprobe/.gitignore
> @@ -1 +1,3 @@
>  hwprobe
> +cbo
> +which-cpus
> 
> ---
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
> change-id: 20240425-gitignore_hwprobe_artifacts-fb0f2cd3509c

-- 
BR,
Muhammad Usama Anjum

