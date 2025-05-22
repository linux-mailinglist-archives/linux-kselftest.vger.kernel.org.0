Return-Path: <linux-kselftest+bounces-33530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D86AC16FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01120A261C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410B29A9DC;
	Thu, 22 May 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PX9kju42"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657928D82B
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954187; cv=none; b=oXPArWLm+10cwD8wezdqCJ75rSWqMC3SVCjN/bTuE5Jc+dhWhdA/O69ZjN3iWjc6R1ZSfOVLPkFh0J3R3srW1nrVgbzulh8PDeCiR/KDEBwdaF9Ttm9NQjPdemFYcfDpd86CbuuJCxoQdDO/FKAuphTfQ81ikCNezQXs0R8dW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954187; c=relaxed/simple;
	bh=MpOiOzRLBDqHqB2k9gzP+UZBhD0AxK51yQUlhLwvf8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4YRJSP4Vk6FeEMgFEry3j1XtPyyE1623Su/VFg5thB7EHtjb7Fn0FhTmSwWD5/2tXgLQVpf1mKHpsj2bMvqhqaPdQS8Aadi4ISNhEDEt0Nhv95kH+0q56KWBWP2ZT/xikj57fZpXBAjfVYX5JmuTUamYAaJ89x+Nbio25IyoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PX9kju42; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d8020ba858so81194615ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747954184; x=1748558984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4s3zSEh4snp0xBeK01CCVtJfz7Wl6wxDOdDf1VotpRM=;
        b=PX9kju42Se4jcYByT3jUj7Ppby8Ei8CjFJ9oexJxCKCTsRLDidqC/VI8/LotcVF/zW
         VMjoZbJ1vFlc8afW3s7Gk52e0B0shET2dDZjz2ebu0tY76H7F4eLY+gkrQN35Fn5BqjR
         ctB+2v24C0uj+rnxDUZ6M+ssCv+/GYsYcWhy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954184; x=1748558984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s3zSEh4snp0xBeK01CCVtJfz7Wl6wxDOdDf1VotpRM=;
        b=ctz8Cw18t2K52r6bgT/XHVHkDI09ipdxQtZlbfx5F79+kynydAY54kE6zI17IPuXll
         HeHDvumjvRvQHSlkXLuSzZ0DyKM7EYGa7Rs0q+YS7gSMpaNcXV5J1WHWlWfCNdOput1w
         QEMfnCC0kqwR7DiOPrQAXOCK9uWKCjElxDZVQA3Os3sxBlU1XJuTChh8QvPvP37NmtT7
         Vv30VHGybCS7qYvVVqEo6Of87qA0J3o3KI+jN6UUAfkvary+RiIVFQDPeY8VjWr6LsJN
         MS8bxMj2ns2sTHYjK6wgoNnoQeZrtGD5o/mxD+ChyZp3JADHri0J1qEY8Fn95BmkxJYe
         GL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxkzjNreLEMX5Ex7IH84S9T7DQAJuvl/5BeLPmrztf/nBVMX7cERQ5Wgsy/FLcQwxq5tExJIn9f8MKPCStqDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq12h7JvTVqkilp1CqN+tBsMvDZgsY33nBucdTxDh2t6Aeglu
	/LGi1rLYTXDYI+mzwyVd+XFoQlBARNki8nFEGfV5i+q2dGOffvj5f4EdxF9+A0TbTvYwEtw7TLP
	e/muT
X-Gm-Gg: ASbGncvCvXQxZsZAqXXC0/JU7xDvHw9tiRrzO/sVmQ6uKUBZHkVRFt6hCJ4ZjprZv2x
	LodIaMJyFyEFi5+qCtd+d5niDjJiPJONYZuy+ok2HVLsuNyDg3KHaGHJxwk5cNZWGSx1Y0ruTUy
	/zbJL4ttjzQBHwnLOIwvfrvIOYJdgPVs6MEXcg7M1Zz/NfXOhe3bbMsKIQLsfQ79MQMuO/yUxhb
	56raOiJkysOu7FhFDXNnLJe3cG9c7fkFtY8vX6nzlax5oOaRBFzT7f+G0pr9KzdM0AykzsizW7v
	jo+FcC2oxdu48RicIO2YqdCrIGbu7bj42cjdIsWFzsklXEAeQCZY45IPMATYsw==
X-Google-Smtp-Source: AGHT+IHQS+ZDp8ppQECt+VzLm3Py7wm28k4VQfjNDxyLCiw94PysHUBvarpgdnsCuhzk1t38nuqn2Q==
X-Received: by 2002:a05:6e02:19cf:b0:3d4:244b:db1d with SMTP id e9e14a558f8ab-3dc932664c2mr10876065ab.6.1747954183964;
        Thu, 22 May 2025 15:49:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc84ceeccesm11041375ab.45.2025.05.22.15.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:49:43 -0700 (PDT)
Message-ID: <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
Date: Thu, 22 May 2025 16:49:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Add functional test for the abort file in
 fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com, wentao@uniontech.com,
 Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250517012350.10317-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250517012350.10317-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 19:23, Chen Linxuan wrote:
> This patch add a simple functional test for the "abort" file
> in fusectlfs (/sys/fs/fuse/connections/ID/about).
> 
> A simple fuse daemon is added for testing.
> 
> Related discussion can be found in the link below.
> 
> Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
> Changes in v2:
> - Apply changes suggested by Amir Goldstein
>    - Check errno
> - Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlinxuan@uniontech.com/

Short summary should include the test name:

selftests: filesystems: Add functional test for the abort file in fusectl

Also if this test requires root previlege, add check for it. The rest
looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

