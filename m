Return-Path: <linux-kselftest+bounces-3619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00E83D77B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192482987FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8920DE1;
	Fri, 26 Jan 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP3fgzxI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3220DDD;
	Fri, 26 Jan 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261453; cv=none; b=F8U+B3gGlQDaPRDq4UBCeHu+ksSgPMxYAY4hsVVaI7GPMyK7BGrOjf56U6gSkrlQGQEYDCXOcN6cud+G19JtJiLdx92nnDF/MK7hqdG2TbBYuYYu3bRn4E52QKxM/qnioZjJeN3KkTvGcGEO6eBq5WnVvJNGcGcBt26icw+mz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261453; c=relaxed/simple;
	bh=EQlnSjwdkbMTK1Hei9049qtlGhL8+GKk+SdQBIhfCbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4ak4Gwz+1q511qe3q1C1LEXTraswnbdFsKfFZTQmC5irARNuktx9pYoDwpr5ltv1UwLGxAkvcspNti8YrHtO3p3X9ZO2JSruzmEuJtsMylQfIyZUtSNBMlXmgtSw3PzzL0b1hR2OoRJ8COu7A5GF4qie8RZsVxjEEDmT+o9lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP3fgzxI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a349ed467d9so16300866b.1;
        Fri, 26 Jan 2024 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706261450; x=1706866250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyCwzR6cEtSB975BcF7aNrr7jzUtGmL/w0YQoKMEhQw=;
        b=EP3fgzxI4nQ8hwpr83/T5YZcNcoc9ct/TM0098CUcfwaMGV61p8xm6Y1fQWxO1dv3B
         cTFlbwXJ8AsT7l3SaBqUx6rcRoaGcQ8CntwyQnoNpsv3O7+BAFMUL3DH8uZ6EfYTDPvk
         rT//UqTRI2vYOG2+vvztmzHWgV1AMrDkCaA80IzNWMPidP221Zr3QX0v45EJDPPSY4U8
         rkeMyv5/14QLSmh1htftHzj+fCz2YC/FSNP+TQ56ftqr44dMEDl8o3Xi6edVN6C4IoMf
         NvOLuM8eQedYwqjh58Mf99D8mFAb4QZVlbk1gUIqLr9e4lLrlgVvlWIjZoxB3GCN2Kc0
         k7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261450; x=1706866250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyCwzR6cEtSB975BcF7aNrr7jzUtGmL/w0YQoKMEhQw=;
        b=LlmGwDcVOQdFO0oz3aiCNkdN1BkQPdQU74Mhs3H57SaBjRsDIWWMOfF/hPgajOo7fr
         JUy9fLRZuuadGWRvdmkOCKecRZKUsR4hhpVKNtDJJiAjEBacYnTZZI8q5ye/SJFTEUVX
         H1SCgya3lm7Z3dxekv51zPx45Ndx+YMhFVMaaY6lpxKrd/zGIPiyh9pn7SWX7IeeQizL
         ZTaWyYnR6DAjiQr9wTXuwZgiH6R1Yxu5rhDOUe7rqSJtSfTQMQqYdWQ0vgncS9s3au3t
         K4giQyo9WhfQDHJnPQKooK50VWnv3tLi9+bxdl3nK8NhPrP04Z/ju6F7QfuNXx+AguUS
         3x0g==
X-Gm-Message-State: AOJu0YybNokRILoLXhRipYi4wsCQFhvcz6u/gV75WJ8FDwq1LsIm2u64
	Lrktib1sg7HL6rV8Y9ezFI6u4Muugogy+McIevdgHm+nREnBoq5O92y7E5XG1SM=
X-Google-Smtp-Source: AGHT+IERXmy52ha/LzOPfKtuNdvBqHZ9wbjnlcLsw1dGPpgZxN4eeUtjQ4eQ2kUH1oB6jTPW0pV2NA==
X-Received: by 2002:a17:906:2dcc:b0:a28:5901:70dd with SMTP id h12-20020a1709062dcc00b00a28590170ddmr531735eji.17.1706261449481;
        Fri, 26 Jan 2024 01:30:49 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id mc4-20020a170906eb4400b00a338fedb9ebsm424059ejb.54.2024.01.26.01.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 01:30:49 -0800 (PST)
Message-ID: <137e1805-ad32-4123-93ab-16ed810845d9@gmail.com>
Date: Fri, 26 Jan 2024 10:30:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftests: add missing gitignore files and include
 generated objects
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.01.24 01:41, Javier Carrasco wrote:
> This series aims to keep the git status clean after building the
> selftests by adding some missing .gitignore files and object inclusion
> in existing .gitignore files. This is one of the requirements listed in
> the selftests documentation for new tests, but it is not always followed
> as desired.
> 
> After adding these .gitignore files and including the generated objects,
> the working tree appears clean again.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (4):
>       selftests: netfilter: add sctp_collision to gitignore
>       selftests: uevent: add missing gitignore
>       selftests: thermal: intel: power_floor: add missing gitignore
>       selftests: thermal: intel: workload_hint: add missing gitignore
> 
>  tools/testing/selftests/netfilter/.gitignore                   | 1 +
>  tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
>  tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
>  tools/testing/selftests/uevent/.gitignore                      | 1 +
>  4 files changed, 4 insertions(+)
> ---
> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> change-id: 20240101-selftest_gitignore-7da2c503766e
> 
> Best regards,

Gentle ping.

Best regards,
Javier Carrasco

