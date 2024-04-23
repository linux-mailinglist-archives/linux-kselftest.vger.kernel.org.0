Return-Path: <linux-kselftest+bounces-8668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5468AE03F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190591C211EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5956444;
	Tue, 23 Apr 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1Ks9Dv0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1208320E;
	Tue, 23 Apr 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862169; cv=none; b=fLtq6fjFzjgepgX7m2bcuDE80L2GVSVPFYJ5cdx/KOal1QyNiGOSCyVaEESLziaFDg7Y2Vaj2JqkOl+1EoOPTt/e5he4mGEK2kveuh36elvLJe8QlkKqKl07hwRlX1o7+1w8sIOWSj+rph8krv35/2djVHygc3i/ImQRos3PomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862169; c=relaxed/simple;
	bh=jaQKU9Q+XiXAoGpDDMhf/NT3bVROuB+z0bWHqhTkHSQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FW4Fl9Fcb0apZ0MKPQGz/W78pO96DjDI/pQy1v+5/rn4ie0s9zvxjeoloYgtkvcKS+Fi2oRPXiE2uDUx5vJJ8VwBQa4dCmxtSm2pxwKVWb3qxMJ4rm0eDTSfB5aSIJUWiFpPzS0PW6IfeYTreI6pmLHl69G3qBf4RLm+DcRR2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1Ks9Dv0k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862165;
	bh=jaQKU9Q+XiXAoGpDDMhf/NT3bVROuB+z0bWHqhTkHSQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=1Ks9Dv0k7unME3RDGOlAL6jZbnOxB764t6ypc8y4P9RwygOYdAemLXPK/6d/ZCoHy
	 EEfq3j1XXnT9NQoC4jdQSqeXCuIPxvuHU8j/emHEg2lSkznxUezvGXPCSU53PmSOaF
	 eSysWLMAyy06zq/2XN/smd2ULIgaZrHUjUajGQxybg388mlN8S3m1yP1My35FfLhkM
	 qIfzCTFeTyz0RgrZsVqG6ZZ+dn1JqMfYoU7Lni6RLDdEZkYAfu1EFTZEYhPMtgisa+
	 4YS7y+LAIOwwTkgaBGOdpypykxuUKiY4792/qMHYDacFDDt8LKfKVybM3WucL2mOsM
	 jJjUVqR5/6qJw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1A7CD37820AB;
	Tue, 23 Apr 2024 08:49:22 +0000 (UTC)
Message-ID: <440693ad-519e-4956-9ace-701bc1c3593e@collabora.com>
Date: Tue, 23 Apr 2024 13:49:48 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
To: Kunwu Chan <chentao@kylinos.cn>, seanjc@google.com,
 kunwu.chan@hotmail.com, pbonzini@redhat.com, shuah@kernel.org
References: <20240423073952.2001989-1-chentao@kylinos.cn>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240423073952.2001989-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 12:39 PM, Kunwu Chan wrote:
> There is a 'malloc' call in test_vmx_nested_state function, which can
> be unsuccessful. This patch will add the malloc failure checking
> to avoid possible null dereference and give more information
> about test fail reasons.
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
> index 67a62a5a8895..18afc2000a74 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
> @@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
>  	const int state_sz = sizeof(struct kvm_nested_state) + getpagesize();
>  	struct kvm_nested_state *state =
>  		(struct kvm_nested_state *)malloc(state_sz);
> +	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
>  
>  	/* The format must be set to 0. 0 for VMX, 1 for SVM. */
>  	set_default_vmx_state(state, state_sz);

-- 
BR,
Muhammad Usama Anjum

