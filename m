Return-Path: <linux-kselftest+bounces-13050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F2E923B35
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 12:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3FDB24306
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE41157493;
	Tue,  2 Jul 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4wdjhoqk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3D15749C;
	Tue,  2 Jul 2024 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915463; cv=none; b=jGanv22NWlTA+QFC9BahEDVztitRda2n/uIWgpJ+xTEdxE/SHpZJ4XxA8wGzBnAHvVi4b9i7f7losW9frrmtqCPcFt+wJX742vVgdiPDYrOjYaAN9+lpXN6KXXum/yxZsmQ5k54AIGKJqi+DM56RXf1CG+3x3Y9+d6TpWtzHif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915463; c=relaxed/simple;
	bh=l1Jbp/GpCO/hk6T5uQ4gxgDy9ClqWJaMhxVtIwAnasU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ig8NzdgYUgCIJfF9H4EQvqB84m/WhesJZgpk+0qzKiR6Ihz9FoDZVgJb7R9RHUBBS7wAW+4yTCQUG71SBsmpIbVE6iOqTmXkbBJSNo7BDQlT2DDt5cJFVbf1q1zj5D9TGFut3yOZ+ahJkUZKpxNgrN9U6ZPBk2TR7X/MIQXMVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4wdjhoqk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719915460;
	bh=l1Jbp/GpCO/hk6T5uQ4gxgDy9ClqWJaMhxVtIwAnasU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=4wdjhoqkb7oOKkDL7VCb7chUYwf49AlCto1+2Z5GSaZjJTxyrct05+rrGPuMhjBAS
	 V0yd0CaJHEDRHuhDS1vpkvq6U1R47fZiw26mxgypgsZuf2aIKWlVu/tQphLG+ENWUH
	 ZFklB+0ZzKpDTloN3qZPqYDV9Y0AGwxnA/Ycn4mVWANfZlbb521kppe+d5M6KbA1zz
	 JcJiSI+tdjAwlgCOSR4eS+YN9zc+03erIF3blexuVNOrjt7pLD662mz/RnJbK+vfys
	 fjFCFYRJEWgDqkTBQREiKLYIxBTGwfOfvr8mGYo8/D1yobQ1UHNGZdcsumIU7gZe8e
	 HU374TYVjeqcQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 930E1378217E;
	Tue,  2 Jul 2024 10:17:31 +0000 (UTC)
Message-ID: <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
Date: Tue, 2 Jul 2024 15:17:26 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
To: skhan@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240610052810.1488793-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kind reminder

On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
> There are no maintainers specified for tools/testing/selftests/x86.
> Shuah has mentioned [1] that the patches should go through x86 tree or
> in special cases directly to Shuah's tree after getting ack-ed from x86
> maintainers. Different people have been confused when sending patches as
> correct maintainers aren't found by get_maintainer.pl script. Fix
> this by adding entry to MAINTAINERS file.
> 
> [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 523d84b2d6139..f3a17e5d954a3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24378,6 +24378,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
>  F:	Documentation/arch/x86/
>  F:	Documentation/devicetree/bindings/x86/
>  F:	arch/x86/
> +F:	tools/testing/selftests/x86
>  
>  X86 ENTRY CODE
>  M:	Andy Lutomirski <luto@kernel.org>

-- 
BR,
Muhammad Usama Anjum

