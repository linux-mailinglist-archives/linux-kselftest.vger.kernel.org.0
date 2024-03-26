Return-Path: <linux-kselftest+bounces-6669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219888CF52
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C27B24E92
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF912AACE;
	Tue, 26 Mar 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQ8q0PNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D187126F14
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485967; cv=none; b=j8Z8yLCM7YkdSYEVyQc53EnWclX4sneRjyH0dO/cKtnEYjw1odaUj2IZEAu0zQHvph0RA/WId4dEwR/JmRo5JNgxZg5q1iz77VeHc9fI4RkwU8l5xO9MOs1vEMOEzPwfQRInqxd5fl0nFFhCCnAl/5WT02JGQAJjniBd5dFo9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485967; c=relaxed/simple;
	bh=uEDRqCJhhsVJuG1lHyDzprVktcDpniqReLT6wXFu5VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgYDEvGZrtCe/g56yA244ygx5hcc6CrpomhHRuVNZSqu/2kQ7pvK6juoJbbA78sdVmnnOkvRsiyI7IPDVBCyqQ2EvQ+afvuoYiV46E0kzkPBSupXeLVuakXwuJZAcUl5TsvCTpBa8CicBGM5U4pGWe0ZIAcA4E5HVuHVTHwyhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQ8q0PNr; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so66107839f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711485963; x=1712090763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJxbjA701dwsdP2q2KPyD0sBjpjzuhiGe9ACSutvT/g=;
        b=PQ8q0PNrl10WPs9Ih0bUQJpFi/hUKbVwCdPK/gWb//ISl++RbF6ddE0edQJmODaYjh
         4O10XNOjPai9pPfDk/c7xqgTW/FkI5j81FV4RdTuF+CI/245D8BZXk0BTWJ3Ntw5uBIs
         05gNNf0AfLBU6WxBwjGpkn+y7uwU2wXdf/Ti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485963; x=1712090763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJxbjA701dwsdP2q2KPyD0sBjpjzuhiGe9ACSutvT/g=;
        b=o8Wgy4rmk/Aot/mFc0q4MJJFUqR942W4CCCzewnbaHeVakjVss/lM+3v0O9Q27sFp9
         uLZ9c+T6k0fKNUFEM2NQOUuWYvlus0RpDb8Vq+0qd7R/S+6O559nKN9jGoMa2yHJHbXh
         jlGI3gred5I8YBsMflZfJ1t0IvP7WMRI5oy5QKNaa4ldF1xeDK2eyJx3ICEp5yFB0Fip
         StkdR5nGJ5emB64422jy6gup7UDck0dYHPg4fpAG672UUDjTv5b3GKXaHnTrhqaYqI5D
         dxLDPITg1WOn4WIFR6Q/Ib7HoqzBqtMojYOqzWIYxjyG/a48+2YbCwjuYbWlD4eiUGTH
         duDA==
X-Forwarded-Encrypted: i=1; AJvYcCUTum/CEnPC5qiSqOsr8crcgPjnK9B/1mQSjj+uKc58NdWmqZOn83qrCDSqS12pvPUO+8cE/OJVHsPtgNm8OnpHocxYeh+Ct2QlS6lSStSh
X-Gm-Message-State: AOJu0YwVQzcVM4TWCh8a0QIXw+La/gxUinjc+oWLo6RKrg9sPOvTm+vE
	ClldEp/fari79vBd7to/Kpgq7jl0QoQd0Ff7wtEkIgOZDuMAk4/zg/gZH64ucPQ=
X-Google-Smtp-Source: AGHT+IFnLbenFAcC5hMRhgWI6w1Lf3ppFDQZj2WhN2OHomt36Dv64FHl5a4Au0OxgKw4A7fv4kfWNA==
X-Received: by 2002:a05:6e02:1fea:b0:368:a043:4a26 with SMTP id dt10-20020a056e021fea00b00368a0434a26mr3689428ilb.3.1711485963436;
        Tue, 26 Mar 2024 13:46:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z9-20020a92bf09000000b003687fba7541sm2287115ilh.79.2024.03.26.13.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:46:03 -0700 (PDT)
Message-ID: <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:46:02 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240313185606.work.073-kees@kernel.org>
 <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 02:54, Muhammad Usama Anjum wrote:
> On 3/13/24 11:56 PM, Kees Cook wrote:
>> Children processes were reporting their status, duplicating the
>> parent's. Remove that, and add some additional details about the test
>> execution.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 

Applied to linux-kselftest fixes for the next rc.

thanks,
-- Shuah


