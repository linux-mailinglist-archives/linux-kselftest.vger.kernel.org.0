Return-Path: <linux-kselftest+bounces-21343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2949BA216
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 19:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981EA1F21628
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1131A4E9D;
	Sat,  2 Nov 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEcjD+fK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A95198A3B;
	Sat,  2 Nov 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730573676; cv=none; b=igWmPh+vUOgPnnwl7VfYg3O/9EGI294q2xT0YgI/fiYgmgYq8wMwkHwlpjJg/5JyY12r7n3nFo+rzzzN8IXoz8LYsx36TUJFLNqGEhutA4q4FDl5Vdo2qnrl2SsE5NpGUfly5Q8kmQy3EG8YP2UOnhmjZNlGAUhwUg8/3PNvD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730573676; c=relaxed/simple;
	bh=xvbMKhKIfftgVFbGMplgg5M5ZbHPyAJ7GMFTygfp88I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfX2c5oRyhy2KG4ap6eY9Fy8LpCQki4uE8LgfGuTZ/+q6669cz3UVWqnlOlnK6OJeHgozO/CpPfJ8K0hGa8Mg4CEpIyNEDcqoVfqg2WpnJh2elTmlvhuc9OFql6XxSmQ/FSV+tpJIM456BVF7uEd54HjmMQ1UoTBKN+vsYOutnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEcjD+fK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9acafdb745so494558866b.0;
        Sat, 02 Nov 2024 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730573673; x=1731178473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrdVwB3FUhelW6bhn3CEYZXWJmo+iDnom/TBDKics3M=;
        b=OEcjD+fKhygjOr8SK6O5jjlfon6UUsVQbtlt9ShffK+EdgAjv0FQk1FjV/grc2VOOI
         KgXC9AOJNcsEHuTjzETtehGIv+DNiugEbHH1Y9JwJkUpm/aP4OLS9/ZzmjQ7Xst2tavl
         eZNtmmgYypPH5O/AIPPIIfomDaju7l9x+m+8q09iqeaordRoETEmheWUmPRCfZJuxEo/
         0rhVPgj+8TMZJTf8okaX7ALbQFZatEfeF9aJ/IXvOzZXK2JWelACF52ZYWGw0PcLsHlf
         nF9pyUiI1PdSlQa+497va8XFDqs9vKOP+KWrfwENpfhCEbduv9d0ChdPBh/XNCh7noM/
         Klzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730573673; x=1731178473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrdVwB3FUhelW6bhn3CEYZXWJmo+iDnom/TBDKics3M=;
        b=rGa9/pNjrWSltrpC0v/ky9oqTSrEteMZH8fA6PZCHGo7F/Ss8zewxou9T6Fx8vmHvg
         aynzJG9ySkfavKkk2zlCbqMDsFSjSvCW27Sb4U4x7JP/+ifHAMaJ3p/4J9CZyM7r1qLf
         kNMiLFO8CoQlJhjU88LVqbcrWShqaPbq/PL+jSnm0dNncrRoXf0TCC2WZUHk9u6tfBo/
         +jDZPxNuw+efxQ13ozSFQWeGDxFFUhiELz8uh0PsUdSpF2NsZK/PwFKeDq6cbXnLyfrF
         D8jyNVG6ESIE2RkWWJfuC2TfYixb5UGpBzli1thc0dY9clxb+0DkfXLLXVnXyUX1fCh+
         vnQw==
X-Forwarded-Encrypted: i=1; AJvYcCU8uulDdhF71Ely0rYlrnyl6P9YQJZSydv7uqohbAtYrvn9HNyZbQyd23hWF06+LlCzI5csKxnnRu9m4uYXAfo+@vger.kernel.org, AJvYcCVxQacy8TgMCVGr+PiQyM5ps+FjEu+LwK5ct9OhfKgO/naORMDfTr1bz1E9mUFxjQK+IaXYSw/uPKTnU7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5H/1wlhWX8Oh5qF4XGaAnhdIqmNiEdS6eN/ApVovOkOJIya42
	1WjFd2RUqGrcxtRhw7hGbPT5R2HEc1xbtDLYhjymfImW8zqKLUT/
X-Google-Smtp-Source: AGHT+IHNgtABKm1LUDN7uw/n9ma9s5rH7jmrD1y2b27L8slJujvWmQbjWhnwIQi+et5u8ArKWsPEcg==
X-Received: by 2002:a17:907:3e1a:b0:a9a:1d85:9d31 with SMTP id a640c23a62f3a-a9e55ab71d4mr1007630966b.21.1730573672732;
        Sat, 02 Nov 2024 11:54:32 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-94.xnet.hr. [88.207.40.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4e2esm337764666b.53.2024.11.02.11.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 11:54:32 -0700 (PDT)
Message-ID: <4550a796-5463-438a-bbc6-ab07a68ae415@gmail.com>
Date: Sat, 2 Nov 2024 19:53:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/mm: fix coccinelle WARNING recommending
 the use of ARRAY_SIZE()
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
 <20241101111523.1293193-4-mtodorovac69@gmail.com> <ZyTcJHUXWWaTIA7O@x1n>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <ZyTcJHUXWWaTIA7O@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/24 14:48, Peter Xu wrote:
> On Fri, Nov 01, 2024 at 12:15:25PM +0100, Mirsad Todorovac wrote:
>> Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
>> to improve the code readability:
>>
>> ./tools/testing/selftests/mm/uffd-unit-tests.c:1484:32-33: WARNING: Use ARRAY_SIZE
>> ./tools/testing/selftests/mm/uffd-unit-tests.c:1485:30-31: WARNING: Use ARRAY_SIZE
>>
>> Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> 
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks for the quick review.

Best regards,
Mirsad


