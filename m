Return-Path: <linux-kselftest+bounces-36210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6382AF0377
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569A03BA715
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136B2472AB;
	Tue,  1 Jul 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bw5vtEz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16269245029
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397421; cv=none; b=FhdcN6PBmd6KttFzGiwaVHwrURx8LgSkqH0pOAm+7+71Pw3fBww2rgKkvsIdCW/1d04VzhpkqiDAMGgKciRC0lQVf90a9Aoc6q5prAddXQCkFID7ZDDObIWinP38uGTGkDUupBDrRyFRVgpLdwVsPvbuYZZ3hOqUqWtzuag9K5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397421; c=relaxed/simple;
	bh=FcYa0P68tMu4irkQQIVFEWw6CjVH7GiWKQ0vAIynfuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbKtRvZLJmteIBFBsg2fB8P8TilM7MJ4KP+5E40YONh2BUf/1/9s7zdL4ijg8gQiMrsKOdd4MO4nX5RWWNPlAJWdKVG82owsZ5BXLF5qTxKZ42o0s0pp7fzuMg2slTJ1PTEbqtOrSuMZmhCFCwahNFrj3HrgvhkD9vdbyePTxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bw5vtEz2; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8733548c627so207302739f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751397419; x=1752002219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9WagJ9l2OBOz2LHi7f/cwLGTFcCqNNX4A8nF5wosIo=;
        b=Bw5vtEz2+uyY5TVm1bEkX1IY7F9mZSZVRq6VRJ6ezFUf1L9yQ8ISH7LViepaaUcAbL
         WhUFf70oFkVQKDr20Qv8PSa3kfApytQL1/4cYXKJyOe5R7CMFYMBs8XHsvifZPDyjZNA
         ZA0tbx0qZ9iYA1k8t04vVJ5hB/eDY8cXoSvQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397419; x=1752002219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9WagJ9l2OBOz2LHi7f/cwLGTFcCqNNX4A8nF5wosIo=;
        b=k/x1zFxlHXD2e8URK9EBfTZujgqSPDXMpSV2BSHZyfbvY6nX4tETnkxWniMRnpMNRZ
         qXmUg13zR3MYcMkGQHUE1H4z8dIlXxkkYTYLAOv2fCxdSQiO8BnAB1NzlZE/YB+6Dcs+
         L+3XWZZVTG6zSYrgcqlkjJW08Jyvx164L/Q2Y7ol0DJxDAmLWVJroDRFjGRTsXVkLdBx
         Qt8iv9yuVfcL83GI0KvBVXAcCL1agjngOF1XLseM0j7abJ9wYTQvPQfflneMBiuJN4Dm
         0YQ6+oP8cgjJNBflb9VAkvZ4Ke0VFyXUTlj2dXftpCmjwNGrdJLnyBy8V0wz7BfcxJ+6
         1kEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBgghqGRVCSwoJJLTzcGOQJHRUn5MVZ/l28rrg6j0abg7VBpFH+CNcRbqitIUKrxkNBKxAt7dN2yDY12Up9HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMFwY7c7NIACbwctExpopzW03SU0JeWsc3WFfjRKebSypo6tB
	7/OvTX8E4WnQvIlwp+gQbxM1+m44r+Wm1rNyhevwGa2pMvnVBXR6tW97TMgTMSNcTIg=
X-Gm-Gg: ASbGncvUfp8cxIgvOJrgjR3lgvl9sz/I2iKwOzuKA4YMnNBbc4+j/mjDbbPN4TkPclA
	OQdBnjV7a6VWw7wwikpOFP5RUWmPu/DIih6eWiQfydXxNEqHCT4LJUyLM50PFOcDbG8CUAIpaij
	Lcmtc76ynm6xkfCBdjxboYOsUXSPgyGZCrc0NQJcOOcUY5jqM3uOKDLOkRaraEnFSyqjghidGuh
	Qsmf3tMKeEVJdjxxMSHgvnVUfrM5ShOUlCYbEK33V+VQQZubzgVUeMZNBxLuwJFf1rgHgJgmLbx
	aL3el+1MHx3wulJlimTSFRquqvDAk+xGJUzHPx9LBWCslOHI8d8578/wUVYFbH2O1DwxRVuGLQ=
	=
X-Google-Smtp-Source: AGHT+IE44w/SVGV9VP6dFhYt54g3cS7ykKIhCvzjksCEeynlm/mCTHQaDqHedT31nr9Tl1C9TYKb4Q==
X-Received: by 2002:a05:6e02:3108:b0:3d9:6cb6:fa52 with SMTP id e9e14a558f8ab-3e0549ae93emr2275695ab.12.1751397418976;
        Tue, 01 Jul 2025 12:16:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204aae3ccsm2622022173.116.2025.07.01.12.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:16:58 -0700 (PDT)
Message-ID: <ebd094e8-2b7c-4267-9a6b-6e2c821988dd@linuxfoundation.org>
Date: Tue, 1 Jul 2025 13:16:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ptrace: add set_syscall_info to .gitignore
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, shuah@kernel.org
Cc: oleg@redhat.com, ldv@strace.io, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250623183405.133434-2-moonhee.lee.ca@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250623183405.133434-2-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 12:34, Moon Hee Lee wrote:
> Add the set_syscall_info test binary to .gitignore to avoid tracking
> build artifacts in the ptrace selftests directory.
> 
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
>   tools/testing/selftests/ptrace/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
> index b7dde152e75a..f6be8efd57ea 100644
> --- a/tools/testing/selftests/ptrace/.gitignore
> +++ b/tools/testing/selftests/ptrace/.gitignore
> @@ -3,3 +3,4 @@ get_syscall_info
>   get_set_sud
>   peeksiginfo
>   vmaccess
> +set_syscall_info

Applied to linux-kselftest next branch for 6.17-rc1

thanks,
-- Shuah

