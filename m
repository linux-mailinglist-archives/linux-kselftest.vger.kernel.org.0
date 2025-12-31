Return-Path: <linux-kselftest+bounces-48036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3EBCEC834
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CE4E3000EAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723430C620;
	Wed, 31 Dec 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HwOhoTps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E728C5D9
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210870; cv=none; b=dwsuyx9zf9xBn4YC2aJKCjDiByHKpLVCk40t0jSAq706WzOcc7SqRpqUalGDgib3aNKBhsJO91PXLbeSMTxmCvqGCXReTANxKaihO9iDfiCkcyT1AXkBr5sr7Sw46i5o1TwZcQn9kOvNlNGQmtXic90N1wFnzGwgyYO8ek4ePIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210870; c=relaxed/simple;
	bh=WSfdyCdtIuMoC2fL/hkBeLmc6RRRkGKkq3+4Lwm0rIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk1zv4c1JWtubGT3cmCPE244AeDwvOV2VbX1V/JQx6ad8MhMq9jxscqIqBEJjm/ml2eXIl4WLBH58kcsKS1l330sfwaB2v3q0q8RpzILy7rmSGa4fZ1uVV3eW3gmo7dLk2zy9wx2PdnHa8mPY/lIcRcFW4zoAMj5Ikrjq3+VI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HwOhoTps; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c75fc222c3so5187679a34.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767210866; x=1767815666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sASNS75d8oeieC7LwzssKWA6/tt1IEz1D0H+agWml8=;
        b=HwOhoTpsAxuZnLHQUMHezJfY5gOaS06rijLsoob/y1ixrYMJm3F4GxsZODkepKl4on
         ZkvyvdBv9qtJE/53Et9DX8T55syy+iOoEHk9s+LoMwFyDrf/l6ckMcE5AqN8rTB3NSpR
         NGyJKipajLRHQuIlSb+f/B8FfzKlNOGlHIB5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210866; x=1767815666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sASNS75d8oeieC7LwzssKWA6/tt1IEz1D0H+agWml8=;
        b=Hs5L0dNIaCyWaHS6Vtc5QdgjyQg3DyK3dLCXxMU/KVLlqrBaiAo5TOc6sub9cMP3A1
         3U0llXpOGxwbyQ4MHCQ8GvEc9ceJU3Q/UqkX3WzkOhHXO3zJ2B/Citdl8e9A8rUjg0Ls
         onm0ta8Bc7V29y8i25RDw8i6VUZxbAwE3ufBJStUHp0W6nTcOHwTHMtK0JBkIGssLxIz
         eB+8ggsIsmvvfyfE+NPja+eQD1xg6/hGVaPnaQn4ECjZncU1lLpssovZyljt3Z8AAP2V
         NeUpSywZPxNjSaKsV7/hYZ/f9rCGLTgcPKBTsu4IcclYvC4Sxb0OIX7WhGk2bkSFm3UO
         ezFg==
X-Forwarded-Encrypted: i=1; AJvYcCWFCVKdPdQIV10fCUErChjscWL7Ur3KVmJ/1H6qaUxN1l02M1QQQY5BU8ys5mz1xDNwq/cBFBOBQnOiHOKfKJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoWJ3tA6nd7BfIyjPn3FIskaMgwvX9VTGssHJNd/qU1yQkFZx
	oHgbbo0E60nYIgqDvnFEiEpZYfjDAoD43drwbmD7lEua+jT8o8brraEHVRXcsJID8T0=
X-Gm-Gg: AY/fxX5dghQW4N9c/ybAL778N2z9m/c6Ls31DDzeCqGy1fVDiQJUjSlooEhrlXJi8Q0
	honYbmv97Lpi+S80kyZTvCf6s+8VcUYorMRcm2yJd40wU8RBiWsqY3rMyXzIqkPBPEin59vcTGb
	ifK88o243Ng08v/dv+azGcPIXm076w14ilBOvpH0lE2rhT0MkQEODRLWcq68faCanOPXNEJui93
	mg3aOYCGBLXGBcpfmmwkKDKaZaNRoKJMFgPrD94DyLI+dhj7rBPrxVWo7g8tS3Ybdy1tpZ47XyP
	F5xYs/wHSxlS9GsBotuhyFpsxz7VQH/30jvhuctDIha0K3DMYEUeS6yy1nGxEH/EPvqtUuycjC7
	R3qEP+gE+k8ZV9DxWSmr5IEH2FT4Q/NSIZMTCqYaOPOsxQdqwDZfBORIEi0/L3A8Xrym6C7gKy3
	3l6V8OkpdYAIUi3CK1H3hDBxQ=
X-Google-Smtp-Source: AGHT+IE+MRCg7tt58ATHUniAPuuohDW64UNfPn61oT0N5rB88TRX79/V7dYpMCr3KNHiiFLrpdNG/A==
X-Received: by 2002:a05:6820:f015:b0:65b:579c:8474 with SMTP id 006d021491bc7-65d0eb4caa8mr16488297eaf.80.1767210866211;
        Wed, 31 Dec 2025 11:54:26 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f3f9d15sm23496900eaf.4.2025.12.31.11.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 11:54:25 -0800 (PST)
Message-ID: <025a3cd1-ac6f-459c-8bc7-79b336f10dee@linuxfoundation.org>
Date: Wed, 31 Dec 2025 12:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Support FORCE_TARGETS
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251219-kselftest-arm64-force-targets-v1-1-cf72d6d27e99@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251219-kselftest-arm64-force-targets-v1-1-cf72d6d27e99@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 08:29, Mark Brown wrote:
> The top level kselftest Makefile supports an option FORCE_TARGETS which
> causes any failures during the build to be propagated to the exit status
> of the top level make, useful during build testing. Currently the recursion
> done by the arm64 selftests ignores this option, meaning arm64 failures are
> not reported via this mechanism. Add the logic to implement FORCE_TARGETS
> so that it works for arm64.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

