Return-Path: <linux-kselftest+bounces-29893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDFA75137
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 21:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A2A7A326A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDDD1E51F0;
	Fri, 28 Mar 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ViI7O1Dn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF31DEFCD
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192349; cv=none; b=NY2GhWE5mK1LH0lAV/etkpuBYaGDVkx3vaQtaUxmiahDFEK9r+B8h1zLlohs9kPqOpL+dUqUJvRX2pfqxvhmjNTsLyUYWz6NXOjb74bH8w593SgMdxaJR42wYRtBEP7/28rc1yopghxPFo6xef+mBySOjz4wrSKJEKrZ6MtYqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192349; c=relaxed/simple;
	bh=d+ng6SS3DMpFYw0JXF3SZ+iri7iewWW6WjynoYKoTGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGSnda36DksD8WFkTDtTGmPy7FSFHDjUkam59qrGaTWYs+o9DUvEZzfGdjILB6fhns6sktW1ixF+rgPOvK8ZItRvo/MfpThSFayMMLjWL7GE8TFk4gsv83YZ/kVy6+udoZjMLVgF1MeNGcx/LDhqpnxGYeWBdUUmSiSR44QwLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ViI7O1Dn; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b5e49615aso220568939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743192346; x=1743797146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8Atfv4IVEOUanvfYjqZzwOBPOlf/x7n/JGPGqoqy0w=;
        b=ViI7O1DnHo551fHNMN4ch4TnhhR+EskCsirGJ/22ZOZ2AXEqV89hnyUVMmtiNSj+QO
         iil9qZ6/HScPgZA2L0kPgCiDzMtQ+/PD7R132Rh0EgSD0yf6cXMqp8YhWt8hj7X1aGlC
         zZ7o6s5Zo9TW8vP9jrgg4Ye0qeoCJS3EC9Ofs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192346; x=1743797146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8Atfv4IVEOUanvfYjqZzwOBPOlf/x7n/JGPGqoqy0w=;
        b=roPJYbTUBRzcLXDmiI43ydBqVx1h2uI8tIydnI3GHQuIiMG9V5eoi9epmQ4QDAkNri
         QlXl0UjHuMYCoT4WPqKt86jH9XRz0b1VfKB/qzbbZf+v5JIM/ORWDHWSED5iZm2AQpr9
         5Bz7RS+dTEoTeqtheIkuv9AN4h7Y+oamije3FaEVQcXHXYQx5xCAPicEKJ0I8Gvmn88I
         XqncUAHH00/V195YPuMM1QeL/Orr2jURnwbIR3IoPM2WoJF/pfba1J2OLyfoo+7cP5ui
         UL+6rWTwLqXyq8I83HFRb2nPcnYOvBgkH9s8G0plJnVH21Gmfe9YxjDl7JZGl7t+ukkJ
         Vzbw==
X-Gm-Message-State: AOJu0YzMczyvghd4gMle6QbpNtdF+Y/bCJ9wcdnpEG5phYBdbEjkI1vv
	OrYsUBLuOUcPJEp5OPN9lO7bS3rDhGe3l5yAagYwrgHaC1jcmh7kTQ93Ha4kMJg=
X-Gm-Gg: ASbGncsT0LhTeirNqKFtaEFili4y1Dz6aQKx628QrIfljGKAywmYouDKWc8dZL5jNkv
	/4oupbpf2IBcUx8u25mEzymHoG8LkBNsy3C0uNWCSEwIjmgo9ZbjM59utFdwizrh2Cgkfrmpe40
	cqklPY/wf+AqAi10YatPzPInynzkV59S4tCaHH9dQ5PY8H7wh0Y3+ztQNBD2G0Gqj+63mi6kuFz
	RAWl+gCIQszZFJZze5sfZNOodrAXVwdRsWtg3BoXx7QeLcawHmLwnDrSst9Pa8vhcrWDtHUHUf/
	iuw3/nMaQp4+KglaJ7/oOy8w5yDtN/7WEUeZ70EWfg40Oj5DfPreyFU=
X-Google-Smtp-Source: AGHT+IFFxZyiA9Ag1U7uneUhl0+Bjjfwis0cJdT3pe/r/icCiPwaGKDp4+SCqYja3aaGf4HhiwadPw==
X-Received: by 2002:a05:6602:c81:b0:85b:4154:7906 with SMTP id ca18e2360f4ac-85e9e86455dmr88526239f.5.1743192345833;
        Fri, 28 Mar 2025 13:05:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464751f0csm595377173.54.2025.03.28.13.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 13:05:45 -0700 (PDT)
Message-ID: <4424b86b-b80d-4fdc-ba56-5cea5dc0b9a4@linuxfoundation.org>
Date: Fri, 28 Mar 2025 14:05:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/run_kselftest.sh: Use readlink if realpath is
 not available
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250318160510.3441646-1-yosry.ahmed@linux.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250318160510.3441646-1-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 10:05, Yosry Ahmed wrote:
> 'realpath' is not always available,  fallback to 'readlink -f' if is not
> available. They seem to work equally well in this context.

Can you add more specifics on "realpath" is not always available,"

No issues with the patch itself. I would like to know the cases
where "realpath" command is missing.


> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>   tools/testing/selftests/run_kselftest.sh | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index 50e03eefe7ac7..0443beacf3621 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -3,7 +3,14 @@
>   #
>   # Run installed kselftest tests.
>   #
> -BASE_DIR=$(realpath $(dirname $0))
> +
> +# Fallback to readlink if realpath is not available
> +if which realpath > /dev/null; then
> +        BASE_DIR=$(realpath $(dirname $0))
> +else
> +        BASE_DIR=$(readlink -f $(dirname $0))
> +fi
> +
>   cd $BASE_DIR
>   TESTS="$BASE_DIR"/kselftest-list.txt
>   if [ ! -r "$TESTS" ] ; then

thanks,
-- Shuah


