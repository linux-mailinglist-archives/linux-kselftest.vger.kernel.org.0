Return-Path: <linux-kselftest+bounces-22803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9E9E30B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 02:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE82838FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 01:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46555567D;
	Wed,  4 Dec 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHM4qnZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BA523A
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275284; cv=none; b=A55hkbGmeOtH+fXOu7kZlCdspE+eZe0J0/Xlc18+sJ2QFFXEMjlXdkU44ns3ntOr3NKpBKGeb3YNUXN6JOoJQp0vT+IKb5kf9G5JhXUc1loRf3yRtt8dEh5YOp1pDKMUlrsp9JPT6JlOjScf+BPK2fvfWp7XV+trmq0WJbsb0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275284; c=relaxed/simple;
	bh=47+3mMULP6NaG5bFnDnhGZuBok5PLxqX879HrL19F2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvjiuzKNICNtsh35xdi9BYSlO++Fq6KKMj6/KQDwTVpkDkUeTuNk6sxOZZj6jDzhImip5ektHWTTqRf2oCQD4m+i/jGYWTfQHdyIdFjzHxJxdoRXM0SEykZZVq7j9BJWPiA3nLj9XLgghcBm6wp2zVLk19DgTkydbWIxDzDUZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHM4qnZ1; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a7d94b545aso24049415ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 17:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733275281; x=1733880081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ujwYaTWXcrxC/+8OO/sj3lkfmCwrRVJDVmYLthQFSU=;
        b=WHM4qnZ1HvwlXd/ByArwtjDEu+m11VleAiLG+1HG+JKT3bMS88QTq7yzblr3vD5X4k
         CJRgz2GKdPN15LdQ/YkPcVNmjgjASWb6NAQ+luwwv8wQzke/KEQhnWuuvQmU26Q46LXq
         AJSZq8+b2NKAtkegLfYXYd8nCNQ4fSgr+mBKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733275281; x=1733880081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ujwYaTWXcrxC/+8OO/sj3lkfmCwrRVJDVmYLthQFSU=;
        b=FUEnwB93+L0+ROsT05POF3PMLhk4Ysm8sZ4W5etGi6GuYd+EhxhhPSS+/tldfe0U3F
         aUNCmj7jwHzmREsLr52r3Yn3By92rXFZ2SxsrcawvefU/fVbvMwA8vrrxwTcYyLEc72c
         w1hddhP9mlKsDJNyPQAGpq2/pA4Rtu44/TyneoqP7lamHi0VHaZz4nx0xH+OmftY6Vyt
         D+Hid7U7QDkUA/IXlGRISDbjTxUfN1SKQ4Xg/002JXf9fnLxJWJ8eWKqaNTxyOLz6oAN
         3ZCWLiVJ1Wl6i1/I1b1U5ye+c8dZ9t/Vok7w9Sf/v7EVg/EIDt5rl/nR3MkNQwQJafQ4
         1/jw==
X-Forwarded-Encrypted: i=1; AJvYcCUiAn6SXP/EHzRh/ABHUG+1pbZvv0NO/DxlUeLYj6usc6ePkOzjpOZR+Q67i8jDUnQZxtAUCEPWDuBzPVeER9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4Ed+dtN14c9eDXKIQAdVf0bskQ0CbOygMpuKFy3P0H54jiVf
	RCMbzBCK0EJmuixPtHoFHpDu6QAnE1XTqPRnKDJiTKimkv94XZXvut641vv/gL8=
X-Gm-Gg: ASbGncvKvEk5wihlsZ9daJYg2OCh1mQhRcRIklYhwn8yGMDHQeZUztwhy5jxJPz36Yr
	MlQfsqsxcwgJ/82bd8xHpGltmvzNSQwGCySmJi2gVzoG5j5Sz+YgUBXAbcC6LOAYyxS1m17SqNn
	NS55Qg6qtptMOUEOS7rwN9EQRl5ZymELpDQFOwJ65kZIi9kjWFdlwpk8eGPVMo5KiWMjFI3sZqi
	qkt26IvPQoaiObAY/2+GAyiLnRNzJBcZ3badaNL8GLmJikqz+YxmVT3NCeI+w==
X-Google-Smtp-Source: AGHT+IFNn0gAM1mEU1FV0XQJ8uwXjvG6MV1GSwfecTFfL7kSyvjIz6QPSghHA25UuOk7f9bZUeL6cQ==
X-Received: by 2002:a92:c54b:0:b0:3a7:8c3f:edce with SMTP id e9e14a558f8ab-3a7f9a382e4mr60545865ab.3.1733275281643;
        Tue, 03 Dec 2024 17:21:21 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc0b9b7sm28983935ab.33.2024.12.03.17.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:21:21 -0800 (PST)
Message-ID: <95484cb4-b2fa-49fe-889c-03ad64e89c91@linuxfoundation.org>
Date: Tue, 3 Dec 2024 18:21:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/zram: gitignore output file
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 00:49, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>          zram/err.log
> 
> This file will be cleaned up when execute 'make clean'
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>    Add Copyright description
> V2:
>     split as a separate patch from a small one [0]
>     [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/zram/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
> new file mode 100644
> index 000000000000..088cd9bad87a
> --- /dev/null
> +++ b/tools/testing/selftests/zram/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +err.log

This doesn't sound right. err.log is a generated file
when the test runs.

thanks,
-- Shuah


