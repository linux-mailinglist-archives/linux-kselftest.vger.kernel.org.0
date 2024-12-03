Return-Path: <linux-kselftest+bounces-22778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9419E2E69
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF42281D0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12436205AB4;
	Tue,  3 Dec 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SD64SAqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D571F8906
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262606; cv=none; b=iSsGnbEDZKCONMhSPXpzHsjSjN8iO6pJ9NWKVXTMimngOt53lvz45LA2BBC/UatFinsNwrZB38UjU6Zp7M+ZUMWm26dseHhHk/cBJAMhd0RJeoKrb8ILo7U3KAgOvT4AoAj95Z3HOl3QGbWAspW1WoMVjfoFZxmoc9bVp2Zg29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262606; c=relaxed/simple;
	bh=S52DfKwMNGc5EiRkh/HfsI5lbDqe35eUnjhynS4EPyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9IyWaaT17wAL8rutar1nvMLqFlfEITx52J22CPm9XBIw5thCAe72KSIxqXvfIda3dmFHv2QYP7LqzhP/UPqSZdY1IdUGTa5BRbJweUrVZsRSeJQvv3JJErRaP0jSxcQalaFM3iDboDZrrf5wHgyQ1qC1ciHbfNJRixsw113bjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SD64SAqH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-841a9366b5eso222261439f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733262603; x=1733867403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hl74QNFi9+204dN29m57Rrn4d5enBoTw7nPdzuHs9Rc=;
        b=SD64SAqH2EJs7zCx6T0WmaYsT5T2MyVRVCqGflvyos9aSjXqEjh6lJp/393L6n8S8J
         ciBWzZRUyP9NgSCo6HEe+sx9kr4kKZyZOpb3uaKYLgo9DMQrAHw/Dy0HS27BDbiplqt0
         rFoUlyz1tKn+v7RwS5410Pj5mgjAcmVE99fsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262603; x=1733867403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl74QNFi9+204dN29m57Rrn4d5enBoTw7nPdzuHs9Rc=;
        b=NZAchax71i/rf2u4qKumgYTr9uKotCbiFV4UIxiLxrgfo73FBWyzkF5BHHypYXq2BF
         BqTLBLbAvwD8FSI1beeCVLr+1rCu0dSVRF463t7EBd4mL4ZpF7xG0xCCgf5XXqI7/N3r
         FrbQ1g08C5sEc+8QkSsDvha1NweJg4sTD7D7CJyrLj0ErBI8UCXgOYGr8JraCtO9a380
         lx5p/lgLixsuAoOqaUFGlMvDd3MMq9E4bjjDerDSv3fWtKDAcTfH/6pC8EG9hGowBAU+
         mtFCG7t3m2Mlsg5H//gG/mccH/p0vUooRcFoI5mQsUAo2ZCdddIFIa1UEv8IjAD1fIX/
         n5Hg==
X-Gm-Message-State: AOJu0Yz75OQHvMYZi1ac3OfVmNiSQTG5r5uLGUIil4hRbYbgpuTBD2DA
	2+4yeTeCV7ye1q5FgEAxQvuyITpJCXFKrOzPUWsLzMtvt9w0RR/obVmkjoO7r2Q=
X-Gm-Gg: ASbGncujqHqnUanHcIxrwyREqL4Rs0Du+lKONIhODvPbD77MWDw+SvosZIUJJV3RmBp
	96B4ggEZqjlAqpU5zg7qOf7xVaU/CjsLCSmYi4z8bA3udoEFzSrScMSubge4x+zOYYuXANGeuF9
	xiXfIsHjPxtN6iZcidTYYVbIuDby/9r+l4NpVsSlYrFSDOo/oc5CaqSG8YGjlqVTDYCkJ8rBCIp
	8hu4XzphcH2IOEdvTmvHKTuomFlMIrpZMZ9R2iNT4OhKJtcWMGqHA+Zc0Oa3w==
X-Google-Smtp-Source: AGHT+IG7nNwe7zA9gJvUkLM02efBSPZHgWiV5Pu/3sPNlc7wpYvQ76+GXzXV+MXJxcQdj+NfN1jKOQ==
X-Received: by 2002:a05:6602:2cd4:b0:843:e8d0:a728 with SMTP id ca18e2360f4ac-8445b54e8b3mr575381539f.4.1733262603303;
        Tue, 03 Dec 2024 13:50:03 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405ec8d88sm269933739f.19.2024.12.03.13.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:50:02 -0800 (PST)
Message-ID: <c74c8f0c-f8f0-4005-821d-c0897e5c3f4b@linuxfoundation.org>
Date: Tue, 3 Dec 2024 14:50:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests: tmpfs: Add Test-fail if not run as root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112143056.565122-1-cvam0000@gmail.com>
 <20241112143056.565122-2-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112143056.565122-2-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 07:30, Shivam Chaudhary wrote:
> Add 'ksft_exit_fail_msg()', if  not run as root, with an appropriate
> Warning.

This should be a skip - not a fail.

> 
> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
> outputs more effectively.
> 
> Test logs:
> 
> Before Change:
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After Change:
> - Without root
> TAP version 13
> 1..1
> Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)
> 
> - With root
> TAP version 13
> 1..1
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..f0b36e7a152e 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,10 +23,21 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> +#include "../kselftest.h"
> +
>   int main(void)
>   {
>   	int fd;
>   
> +	/* Setting up kselftest framework */
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	/* Check if test is run as root */
> +	if (geteuid()) {
> +		ksft_exit_fail_msg("Error : Need to run as root");

Use ksft_skip call.

> +	}
> +
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
>   			fprintf(stderr, "error: unshare, errno %d\n", errno);

thanks,
-- Shuah


