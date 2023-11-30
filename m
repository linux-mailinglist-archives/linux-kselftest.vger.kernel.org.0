Return-Path: <linux-kselftest+bounces-924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494CA7FFFAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 00:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444011C20AA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8231A59557;
	Thu, 30 Nov 2023 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UtanHwiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B0129
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 15:46:37 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35cfd975a53so1362015ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701387996; x=1701992796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zh250x7hPWKm3cEtn7H0ENDaWoHwP+xH2vXQISgMTVI=;
        b=UtanHwiHwk/u9K+5iJi35mi1S9WgSFOIWaGjJQH9uFkppBKHdAIpfNJiNes6hJa28t
         Xhe7GAl6IPdW0WTIeaAJi+uOg6rh1nCndzazcB/tRtoofn4Kkxr8fGtNOxTRcbN56IUw
         bFkubbkM0y6cSzvw2R0KVRVsTcteXnkZSpa6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387996; x=1701992796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh250x7hPWKm3cEtn7H0ENDaWoHwP+xH2vXQISgMTVI=;
        b=DzVKRRVnd4q1zt+ht+hynLL5t49mHvgYjlzuAdtomL0Bzd72p87aaZkbH3Kqksv/ay
         bgK0oVSKuN6aSC5aGggMSBu+Sga6tZJI8eT+Mk2hp/v2aq+6oYFNF58NNVDz54EHIeNA
         D6rKEQ6qvrLxajfHEmFcTyFe3rp84KFtYc8ljOPUfnS880U8uzSCWbFkDBbgR+FdMT3m
         SnGBvLIdfsr4mKyD/RWWZVOhAR+GuE9yAPYG6a8tpIAxoBOr7jasZWzma/hh856SDwgM
         dvIthhFfmv1vYnx5Pi7FnhUUbganQ+BO21zJbrrT6Wf9J0gwI4oE5IJuXtkhgtgDhuC5
         Gr8A==
X-Gm-Message-State: AOJu0YwWF7kbMjl+seSCgsSELT6lvSQHmtuw9TjNGU9Mw/OQbJsngiBv
	MgVBlsp55qZMj5qYzHjh7Q6KBw==
X-Google-Smtp-Source: AGHT+IHZwDGqqHcfAVap/vf6pHAy9YoCKCV0f7Ge3jlcZnLyFIzigfI+bN6GjaopeCQk+k0HXwJOJg==
X-Received: by 2002:a5d:8b98:0:b0:790:958e:a667 with SMTP id p24-20020a5d8b98000000b00790958ea667mr25499298iol.2.1701387996280;
        Thu, 30 Nov 2023 15:46:36 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h5-20020a056638062500b004562646b66bsm579254jar.12.2023.11.30.15.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:46:36 -0800 (PST)
Message-ID: <e13a07f6-d251-4510-aa3a-3a90583bd404@linuxfoundation.org>
Date: Thu, 30 Nov 2023 16:46:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: cgroup: Fixes code style errors
Content-Language: en-US
To: Atul Kumar Pant <atulpant.linux@gmail.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231106181144.117188-1-atulpant.linux@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106181144.117188-1-atulpant.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/23 11:11, Atul Kumar Pant wrote:
> Fixes following checkpatch.pl issues:
> ERROR: do not use assignment in if condition
> ERROR: Macros starting with if should be enclosed by a do - while
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>   tools/testing/selftests/cgroup/cgroup_util.c | 14 ++++++++------
>   tools/testing/selftests/cgroup/test_core.c   |  3 ++-
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 0340d4ca8f51..e165c4a703a6 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -411,12 +411,14 @@ int dirfd_open_opath(const char *dir)
>   	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
>   }
>   
> -#define close_prot_errno(fd)                                                   \
> -	if (fd >= 0) {                                                         \
> -		int _e_ = errno;                                               \
> -		close(fd);                                                     \
> -		errno = _e_;                                                   \
> -	}
> +#define close_prot_errno(fd)				\
> +	do {						\
> +		if (fd >= 0) {                          \
> +			int _e_ = errno;                \
> +			close(fd);                      \
> +			errno = _e_;                    \
> +		}					\
> +	} while (0);

Did you run checkpatch on this patch? You are fixing
checkpatch errors - :)

thanks,
-- Shuah

