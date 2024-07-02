Return-Path: <linux-kselftest+bounces-13073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC07924377
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 18:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485CB281DDE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCE1BD02D;
	Tue,  2 Jul 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7DeL/sh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B715D5B3
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937381; cv=none; b=tCcMy3G02Ufe3ATAqbtU05K6nyrP9lgi6F2or3K1OkVYRFLBAUmX19U4ijKlA9SBZNf9pJMkdBnfB/4DICTeSf49+AuhUIO+n07NJdgGQurGHK/PsTj+DmlpJR2+EVtNeQpdqJjAsIZkTwf2NoaCtQGDy3UEgR7HYmHToVqh6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937381; c=relaxed/simple;
	bh=aj7Fh5tckyx4zu/F74GNuIwtbH6bAWyEVqrM39kj9s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSKZi1n/5wJgQfV+/DIt4rj6fF6AhvioatkDLGgZNQ/kaItAMEKIp6fpI123fZQEQddgMWffURg8TaDOeVqk/7xqh7H+Wdm7SSxhS0/wTKEADEU5v3wU5gs+F6ou4veY49eK59i3sVUdFZOFI479z6kFEoRDWuw1Sf1OV9jC3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7DeL/sh; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3758686ef2fso2545725ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719937379; x=1720542179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rbjjRjoLEssCm6u4+AV7tPUfRxSj6hss64397RvroU=;
        b=h7DeL/sh5Z6d1HLDp08A3MD/4P3jsy/7Nx7QgbFHfcP0kDWZI9U+lECd4d5jnSww65
         rjG/SkAip3XTpY9+TQ/asOTa381B4B4DpjqN8FMqD4licLeFCOCX97cjtc6A7VoQlNiT
         4d6doZpJv5Ef5PZwR8zj72mmInQZ3iSpTLkpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937379; x=1720542179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rbjjRjoLEssCm6u4+AV7tPUfRxSj6hss64397RvroU=;
        b=HyMTdjea/5oGwwL42Lxlrw3HaAFeoxWo5p2BgEZviSeG2SYYTQjeRbUpyE44G/1Sk+
         NTEOST5vMMwvx2hP8NMPrJaPYdUML+7P6P0fexy8IZ1ZatIGcvLHsdd4/xOx/2pBI/AX
         t1e3uIXWJ394PePJttoBJd5W9rvDV6uxnDk5FGWJBjGOHUrK4vDQwvzRazWPPqPkFEx3
         JLCYx9jFyCq9ln4BiNckU3TOwvvxS4z0YgHXhhbq8j3uQnvHkZwIPEutlYEGZexsHByI
         Jqp4ZrxKa1SEjPjPSu0y7f7cxpKmPh7+kexh97Ua57mZJCc9JrBeP+6H8uIsGKXoKQPy
         fbMA==
X-Gm-Message-State: AOJu0Yxu8+WCG9+YlapVS4c2VznJ3jgDHfKTyagjkO18Rbu+s7iZ9pGY
	CskqLcQF3Ovl7E1sSPt6JpIaGd2n1w7mGY9dK2RjW6Vexi3afzcQdPWKeBYxgLB5vbLNw+Tl3/7
	G
X-Google-Smtp-Source: AGHT+IFaE6xtD3QoZ0GJUmaljKznWWghEaM1pxbA7lx4mZdmW5LUG8WeCqAieecbB73l+pYHLBf7vg==
X-Received: by 2002:a05:6602:2581:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-7f62ee5c6a1mr876430339f.1.1719937378696;
        Tue, 02 Jul 2024 09:22:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e05e31sm2811216173.73.2024.07.02.09.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:22:58 -0700 (PDT)
Message-ID: <3d7e1a06-28d1-4d78-b04a-ff9cbf85aaa3@linuxfoundation.org>
Date: Tue, 2 Jul 2024 10:22:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
To: Ma Ke <make24@iscas.ac.cn>, shuah@kernel.org, usama.anjum@collabora.com,
 swarupkotikalapudi@gmail.com, amer.shanawany@gmail.com, kees@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/24 07:00, Ma Ke wrote:
> The open() function returns -1 on error. openat() and open() initialize
> 'from' and 'to', and only 'from' validated with 'if' statement. If the
> initialization of variable 'to' fails, we should better check the value
> of 'to' and close 'from' to avoid possible file leak. Improve the checking
> of 'from' additionally.
> 
> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - Thank you for your interest in our vulnerability detection method. We
> extract vulnerability characteristics from a known vulnerability and match
> the same characteristics in the project code. As our work is still in
> progress, we are not able to disclose it at this time. Appreciate your
> understanding, we could better focus on the potential vulnerability itself.
> Reference link: https://lore.kernel.org/all/20240510003424.2016914-1-samasth.norway.ananda@oracle.com/

Sorry it is a NACK - without more details on the tool and warning,
I can't accept this patch.

thanks,
-- Shuah

