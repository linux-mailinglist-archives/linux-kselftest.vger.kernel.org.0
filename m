Return-Path: <linux-kselftest+bounces-5502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB786A1AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 22:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435CB1C23F5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EFE152DED;
	Tue, 27 Feb 2024 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MViJut8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43D14F99C
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069287; cv=none; b=iOwLKPfG+k8MntjijIVuCjnRKcFYCymKSuExYQxdSLZDatN+e6EbcJMkF2Ig9hUSNPehyQa3k6tPh9v0IuqcQTNwbrXjs+qHyDaRqa7WBx2UbKqcs/uZyfpHAZEuUNYzHsIQ+khQ/0Cuhf+EtU4VrnhWMpRYLG+PPONlU2664Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069287; c=relaxed/simple;
	bh=ldVgS1aR0z42eyCtxT/QNicwlMS2zhb2zcTkrKdh6Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1MLzyW0XxJqaanZJor+Tdv3yn+RR5xaAmlhyUj2vE+AX3tkedaB5/wVOFFd+twVoM3khA+px31atyIZ98U/+dBmeiJ4HD7u5U3cq0WAiFxaFjKysNU2gTySdB2VTGx/YooWLGTcMAUVATscjHkFMsuAifx8PgDD9hDqWT/Qh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MViJut8W; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-365b5050622so331055ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 13:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709069285; x=1709674085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6cYCiTKgel5L8zLDPQBA3bSl0Hw58QwImvNAKCqvVA=;
        b=MViJut8W/ornDe2lYZvhFAcoW4XTLadRYSGrAzk1xMFpQJqWdiZi05CrOjSZGRKd7/
         Itl0S4wwERn3857Miz9Q8TVq0jCa21hao69+bRPOkBYe/eXOGISt/c2MwqIA0ZBkohrX
         bJtnaVQa69nYcmQHAvtc5Azgw3014HN+7mfCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069285; x=1709674085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6cYCiTKgel5L8zLDPQBA3bSl0Hw58QwImvNAKCqvVA=;
        b=bbbzF8phd7BBH4bTRC7c8RPoI2m8BpPCvmC+ZgMM27GRd1ArgA5YZIyd/0/mN6fLla
         gpM1d5HzhUyVKqxpT7OFIL3HDrF2SH1LyYpfL/ZEoLPFCwBerrJ25MlMHmZi9A0z+ryJ
         V9SbURfYrmJ2RSZQNr4CtB3H4UQcMC7je6r7OA0CGdG/qtxJBNz2o6xEMfUPo3x1hwJc
         A2VC+shC+CRqlaNmztTYwOgMy/Dtao2Mtb0kXte4XBoVT0/KlS7QHYzND+SoWUm5Y4gB
         P3QyRLKue4n4gXT10rVkeqqrZRItWw7nS3gWJdfW6BD13qiRxWnTeLpfgn53RH+RnEhx
         lCiw==
X-Forwarded-Encrypted: i=1; AJvYcCUjQ5tDLm2+iLFJAD/O82zyMg+33nECJoLvMqKZIqk4qj1aQUvTQjjLN8QN7Cs8FDh0DCVB0lRa5GGmQeTqDSLM7JkJiwW7bi1iEA0WsLXP
X-Gm-Message-State: AOJu0YxQ/UNXNQTG5YPyeD2UViL5A5jNWmgllbKNCsDmeGGMSIi5XaIe
	zTy1yKw3udtCjLiPaf946siBRnojQBS/dvMQLgQ9ze0q0c9/KUIS98X9vi2/N8w=
X-Google-Smtp-Source: AGHT+IHiPn6i00reN7SlNcYrxsFiS4rLTfePpGy1sBB48MvWIB3eHpdkyqm4V+OCSNxz+D31bA113g==
X-Received: by 2002:a6b:7a4a:0:b0:7c7:9c4b:90e6 with SMTP id k10-20020a6b7a4a000000b007c79c4b90e6mr10237659iop.1.1709069285100;
        Tue, 27 Feb 2024 13:28:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x20-20020a056638249400b004747c4f663dsm1661363jat.0.2024.02.27.13.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 13:28:03 -0800 (PST)
Message-ID: <a4b957de-90d1-4779-b6a5-c6a9c1b005cc@linuxfoundation.org>
Date: Tue, 27 Feb 2024 14:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/overlayfs: fix compilation error in
 overlayfs
Content-Language: en-US
To: Andrei Vagin <avagin@google.com>
Cc: Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
 linux-pm@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>,
 Deepak Sharma <deepak.sharma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227074204.3573450-1-li.meng@amd.com>
 <2aaa2a61-f753-4434-8c92-886fc4bb9aef@linuxfoundation.org>
 <CAEWA0a6D1YQtCuW1FswyGXXWNTrmyerNS3zzcqBPpyQ-GtOopA@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEWA0a6D1YQtCuW1FswyGXXWNTrmyerNS3zzcqBPpyQ-GtOopA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/24 14:20, Andrei Vagin wrote:
> On Tue, Feb 27, 2024 at 8:41 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 2/27/24 00:42, Meng Li wrote:
>>> make -C tools/testing/selftests, compiling dev_in_maps fail.
>>> In file included from dev_in_maps.c:10:
>>> /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
>>>      35 |   MS_RDONLY = 1,                /* Mount read-only.  */
>>>         |   ^~~~~~~~~
>>>
>>> That sys/mount.h has to be included before linux/mount.h.
>>>
>>> Signed-off-by: Meng Li <li.meng@amd.com>
>>> ---
>>>    tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> I don't see this problem when I build it on my system when
>> I run:
>>
>> make -C tools/testing/selftests
>> or
>> make -C tools/testing/selftests/filesystems/overlayfs
>>
>> Are you running this after doing headers_install?
> 
> It depends on libc headers. It can work with one libc and doesn't work
> with another one. I have seen many times when linux headers conflicted
> with libc headers. The only reliable way to avoid this sort of issues is
> to include just one linux or libc header.
> 
> In this case, we can do something like this:
> 
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> index e19ab0e85709..f1ba82e52192 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -10,7 +10,6 @@
>   #include <linux/mount.h>
>   #include <sys/syscall.h>
>   #include <sys/stat.h>
> -#include <sys/mount.h>
>   #include <sys/mman.h>
>   #include <sched.h>
>   #include <fcntl.h>
> @@ -40,6 +39,14 @@ static int sys_move_mount(int from_dfd, const char
> *from_pathname,
>          return syscall(__NR_move_mount, from_dfd, from_pathname,
> to_dfd, to_pathname, flags);
>   }
> 
> +static int sys_mount(const char *source, const char *target,
> +                    const char *filesystemtype, unsigned long mountflags,
> +                    const void *data)
> +{
> +       return syscall(__NR_mount, source, target, filesystemtype,
> mountflags, data);
> +}
> +
> +
>   static long get_file_dev_and_inode(void *addr, struct statx *stx)
>   {
>          char buf[4096];
> @@ -167,7 +174,7 @@ int main(int argc, char **argv)
>                  return 1;
>          }
> 
> -       if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
> +       if (sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) == -1) {
>                  pr_perror("mount");
>                  return 1;
>          }
> 


This is definitely better solution to this problem than reordering
the includes only find another problem down the road.

thanks,
-- Shuah


