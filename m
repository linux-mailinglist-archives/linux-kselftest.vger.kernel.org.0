Return-Path: <linux-kselftest+bounces-8018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421908A5A19
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5980B2110D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232C91553A5;
	Mon, 15 Apr 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0PZ8YyFB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52176033;
	Mon, 15 Apr 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206766; cv=none; b=phFToVZ894DJdR9pL3o0k9vW3bnNkyi9rDyuu/xLlYQNAbeuTi/WTI0pnYH4itCtZpCDqVp3h4PzF/EXwGe+CC+q3n+QyoMe1szIB7ccS9rEV4KKjzGVsvc5YZh3yj18yZ4du52IRgp32khgsVpT4LTmPqLx+KKaCaSDpGtJB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206766; c=relaxed/simple;
	bh=69RT/IkhsWBiEuFer2f2cAg8rb7JmpafPdZ9yxk8YMI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ws71uSBEopGEaCG6qzn1JOi9lHZfCsWo3EXp/F10A9SJS1zB6n8//GJyiiU0NwZSUY87BJPiE8kJQpxTyBLSfXIoCUU1fHPQbLM19vo0sYiX4uSMO+5n4kjf1J7W14taEGFs+wU9rH0J9tNyvzY/aFsDa1It4j1Nxv8wve78ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0PZ8YyFB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713206763;
	bh=69RT/IkhsWBiEuFer2f2cAg8rb7JmpafPdZ9yxk8YMI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=0PZ8YyFBkVZfD2nFve4zdaUhqrTAq0JmcNKiw145XumD/FIySK3wFWY2fcB1g4x5w
	 rxAlQ1+yP+OdGtrxzpOUlPWX39hfzcFluEkD7HIT9+nxLih47f+8cyX3ubig9Kkz0C
	 bNN5PMVPFPjI5FkM0vUBYdcypOzfgOooc+fid/lDnZrjmdGXJhmYHQMZRqG54oh74+
	 z0ug1b0EBsara+yCrNw54oHNHfP/a3LsE1z+YEIaeTl6Bbxui8QJjayzXlwexZiTdN
	 84IY0k5sbvYqWpQGuLONF/NvyI4NClin4TN7ueOVyIEeaIY2CcAbafVbP0BBUcXOAY
	 TRCULaV5drbxg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F3943781107;
	Mon, 15 Apr 2024 18:46:00 +0000 (UTC)
Message-ID: <b7d0e20c-ba3c-48c8-a31d-0ab42a384328@collabora.com>
Date: Mon, 15 Apr 2024 23:46:33 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Avoid assuming "sudo" exists
To: Brendan Jackman <jackmanb@google.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 7:43 PM, Brendan Jackman wrote:
> I ran into a failure running this test on a minimal rootfs.
I've ran into similar issue before for another test. Its clever solution.

> 
> Can be fixed by just skipping the "sudo" in case we are already root.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> index 7cbb409801eea..0e56822e8e0bf 100755
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> @@ -13,10 +13,21 @@ NX_HUGE_PAGES_RECOVERY_RATIO=$(cat /sys/module/kvm/parameters/nx_huge_pages_reco
>  NX_HUGE_PAGES_RECOVERY_PERIOD=$(cat /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms)
>  HUGE_PAGES=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
>  
> +# If we're already root, the host might not have sudo.
> +if [ $(whoami) == "root" ]; then
> +	function maybe_sudo () {
> +		"$@"
> +	}
> +else
> +	function maybe_sudo () {
> +		sudo "$@"
> +	}
> +fi
> +
>  set +e
>  
>  function sudo_echo () {
> -	echo "$1" | sudo tee -a "$2" > /dev/null
> +	echo "$1" | maybe_sudo tee -a "$2" > /dev/null
>  }
>  
>  NXECUTABLE="$(dirname $0)/nx_huge_pages_test"
> 
> ---
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> change-id: 20240415-kvm-selftests-no-sudo-1a55f831f882
> 
> Best regards,

-- 
BR,
Muhammad Usama Anjum

