Return-Path: <linux-kselftest+bounces-47866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92308CD6FE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53133301DB91
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D833375A;
	Mon, 22 Dec 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2J48MZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EC1EFFB4
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432256; cv=none; b=YXPB5dOiXFYUH77qQo4Ej50DesYRh074uh1tlW1qgAXO3DlfiZ0KS+Ql1XsukkfzrUee62ElV/CkzRCB5/WXPjADyUxLcqaS2DHkuvRRbId1i+fYJw6CkXNyNkQNDE+hG/1OHwq+KLdvhA8KrTpBTQdUahkLZJgf86MB8PzvBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432256; c=relaxed/simple;
	bh=0KukHGmlHzsumzcaby0/6QI0jB4SGO25iJ5bcDCqLqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abJJsuW+ZODWc07HIm8I5RdYa/aUWnfpJXuwvh5sdmqEY0jifvZGna02S1zdgLVRo0IVAAEJbb78+WmjkhY+K/Hl0kdlkozy/PeHmHZnjKFT0tr6zbk70s055Rbw//GvCGVxNy8J7xE54twDQM3DQ10aSnJwXDkNel7IDrx8INw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2J48MZq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766432253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XktKFfQ8uJsVluMD3VHEpq7VzmUmMEGAbNz9VTvAGk=;
	b=L2J48MZqgW4SvxKPbMQnNT7zrgC4eEII8psDvaLrV8+C27qLfAF+VLE65Xg0O3pqApdQgk
	0RY04XmPW+SDz/EcjOISTWjwuK9q0oGu0qRT7mjSZPyH/0iKiO/UvIJq0DEInnkXDRzUp0
	TzRlNkhMZbqVujz1pHBxt3uh7kLUtnc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-tFbz79TuP12RfGSMrJSWJw-1; Mon, 22 Dec 2025 14:37:31 -0500
X-MC-Unique: tFbz79TuP12RfGSMrJSWJw-1
X-Mimecast-MFC-AGG-ID: tFbz79TuP12RfGSMrJSWJw_1766432251
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a2ea47fa5so117089706d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 11:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432251; x=1767037051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XktKFfQ8uJsVluMD3VHEpq7VzmUmMEGAbNz9VTvAGk=;
        b=fbIf8Q0wpCrKjrIY7C8Z5J6gAxmuyPC7+J/Yza4mhWq0TYZmyLgVC1KRZxQ75HQlct
         +dmieApjx/gHLKfDJAtaZQgP4ypnBR0wSdQY1Im7V15usr3OUnZP7m0NX5JWNKvafWWV
         pWszWK4wXhk1ykCMqP1WjdEhgjcx1rwNxaw13vKU5/ywR/SaWj3PiBOjKw+Mdxu786cG
         BWTh40y7LKQeXJRCnst+Xzmf/rg0pj5Ts5XkOswD986/0rFqWrHJ8ymYNH6YM6WOT7Ag
         XME5D1BcxqkiwDJzxxCP61mvoHTZl47DYUIir/2bF3NxJtOryQfC7X+EIBxB1i5UjDA6
         1+8w==
X-Gm-Message-State: AOJu0YxMifm97MmPffHTQEINYjtV4MrN8tj4DFbF1XN3SPNvQPiORft2
	f67qkKtiKblkAbU9OcCiwTANGviMSMP9ejashK9kfMAr4F+fdgFiAOEpRVe5YEHXbT7ySHOK9MO
	DNYs10t+dNBL/NGeXKsvhEpxM2PsQ3ZBlsiFaAkghKnoUE9CytM0x2TWp3DppCmu8+o8dlQ==
X-Gm-Gg: AY/fxX5r10ChF9dhseUqMBX93rhC6IEeCHXQSTiujZClXReG1j789LeBrw1E8dnwufs
	mFtfLeTIkA1H2UHtLkLmtnqNbUoZFYN6UCUpkkhV+8+B6DMAU5SdPbVj98GS85i1htAJbdFVq8I
	f5xczSAl7Y2b/ge+nm0/75MSn8BCONaNSGyXOT3YuMyH5p5PL1Gsi3zNB+qZMRXTEM/oZHR0M2w
	8WT7zhS7qinBdQ+NU1lrdM2X/fEsafnyleS2/x1NH0cwwhiuWYUp4AOZY883brA3g6sr4J1+ytA
	c9TsGzNRjFNeiO+m59m3c82n64WsrD7wtGzX4PZMeHlRorAoQau5/B0uQCiWL8uHgNmkgmASzQq
	51bmAphI8W5s=
X-Received: by 2002:a05:6214:1cc5:b0:888:6227:3e77 with SMTP id 6a1803df08f44-88c5001ff71mr280547106d6.4.1766432251302;
        Mon, 22 Dec 2025 11:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRXC9/ZSKqrXplj4ZTnSkhC+GYjSHWSB/3j0UjZR2/CilRiGnbj5SN9Coz7NzYDjkORfBbzA==
X-Received: by 2002:a05:6214:1cc5:b0:888:6227:3e77 with SMTP id 6a1803df08f44-88c5001ff71mr280546756d6.4.1766432250935;
        Mon, 22 Dec 2025 11:37:30 -0800 (PST)
Received: from [192.168.2.110] ([76.65.77.217])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623ffd2sm88370666d6.9.2025.12.22.11.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 11:37:30 -0800 (PST)
Message-ID: <cc3c5224-e012-426b-a66d-d4c7bd945bcf@redhat.com>
Date: Mon, 22 Dec 2025 14:37:19 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] selftests/mm: fix comment for
 check_test_requirements
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 david@kernel.org, shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
 <20251221040025.3159990-3-chuhu@redhat.com>
 <20251221040025.3159990-4-chuhu@redhat.com>
 <20251221040025.3159990-5-chuhu@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251221040025.3159990-5-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-20 23:00, Chunyu Hu wrote:
> The test supports arm64 as well so the comment is incorrect. And there's
> a check for arm64 in va_high_addr_switch.c.
> 
> CC: Luiz Capitulino <luizcap@redhat.com>
> Fixes: 983e760bcdb6 ("selftest/mm: va_high_addr_switch: add ppc64 support check")
> Fixes: f556acc2facd ("selftests/mm: skip test for non-LPA2 and non-LVA systems")
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   tools/testing/selftests/mm/va_high_addr_switch.sh | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> index a0c93d348b11..9492c2d72634 100755
> --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> @@ -61,9 +61,9 @@ check_supported_ppc64()
>   
>   check_test_requirements()
>   {
> -	# The test supports x86_64 and powerpc64. We currently have no useful
> -	# eligibility check for powerpc64, and the test itself will reject other
> -	# architectures.
> +	# The test supports x86_64, powerpc64 and arm64. There's check for arm64
> +	# in va_high_addr_switch.c. The test itself will reject other architectures.
> +
>   	case `uname -m` in
>   		"x86_64")
>   			check_supported_x86_64


