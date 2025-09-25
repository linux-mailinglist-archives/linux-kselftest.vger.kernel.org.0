Return-Path: <linux-kselftest+bounces-42409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A97BA1280
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50EB3A5B19
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97CC31B828;
	Thu, 25 Sep 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrYgpZpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEF2798F8
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828228; cv=none; b=oQ6p2b8zZtPX2FifbuhasNiUiCBgcxI5ZV/GJXaBsnFIPe53KQNLyi4hJpYiP6Lw/pSJqXlcjAYNGCbBqc/3aarOKc8SWrCG8dQislVuMfooc+0mUEGTEMpuo85Fe8/xVvGr2LzaaVfOrP/UO47NH5MDFSlZGBz4tNJGlvUVQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828228; c=relaxed/simple;
	bh=SlcgX4N0sT/oAXGKeqfxd72c1+OLj1emBHILemBx3fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUymAjCZly21QHgaabi2LvQwll2HwNUHkCIuG3lBWycVuMgvjYe8/LOp5MeElDz2OH/TKD5awK2silVTPTFumpSysMRXhHGC9kR3CF7sdMTUVFfze7M9m/XLlxNZ8gv2NUXuTiqybTNRHrJjt653rmhMPGE1ILUo0AGkhGCF1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrYgpZpR; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-621b965a114so727818eaf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758828226; x=1759433026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4KMcB5gPgh88FQEiiX6SUAlDyQQTzfhsAxtb+o4J7o=;
        b=IrYgpZpRG1Znqezmei0zDxXNpdFr/fIZ0GGi7wPya4ZVmKEFL2G7IT6oCw9cEnP1md
         5mvho159o2LDS3Lc8WlAY42g6EHYmJrwySgqPRBNzFJQokS2AuOH7H8UiNgEU21CoNZP
         ZT34Ii6JEwSRCTGV/OLbYt6c2fkAx/KIbylJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828226; x=1759433026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4KMcB5gPgh88FQEiiX6SUAlDyQQTzfhsAxtb+o4J7o=;
        b=WdW25AElL2iTO0IU2gPEkyQtkR0+3A6hCfZtI3xPNWv7ob3dzCnCEdlyLQrnyjuCUh
         Z3ZaU5gjLEQjCWiIYd1sVwHR6E7gQodAU6d6fKxdg2GmoEbHsJuW/5ZZ87z96vnvhqS/
         ONlU/6HetKdzFb3f8qKmeguE5JXcD6nnO0osZcTSYydbP8yQ/6LhACqxUayMJQgg4iwA
         xr3htnMxe8L53nhw3B1nECX7prEMUbcl3fhBoxWOTSL/zDuk1e0CppIlVLIfNjmnt5DO
         VVd3/03VSSuQHKUqvdcRqp/uff4Nsl+Dygd4ei2VxPEQb16ipNu8ybk3fqqfUDk0Myd7
         cCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4mUrigU4/1OCYhPtyCecZfUtFJOsIJGX/7+WjTNCl1EU1P9eaG2BXozZVuWZYqrmR9Dauju4XRYezj+eNfO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCd+ZtQf1lL2vpOV0Nyaj5gx8mrFxXAb9QpDarQlYumPjEHPk
	ZHhi+i76JTQCda/90RV5dFhCWK2gLOC+ykfkqOIlkN3KD9thu5r1IBNoIwwLH2hJGeg=
X-Gm-Gg: ASbGncuxAY+6Ygv7rIuO6WEp3KaS707mhE+0stYaVZ3G4UM//QVe7vb6m0NaT1iiYAz
	r+RUg3QFdYfGK7vCAIXTnaZHGuE9G/zwwVF5CqO2puhXERanoHP8isVSNabWNlNqC9xgquF21DY
	VQf8FRWhwalPu9geHN1VtGBzmX67vXfbr/4zwxX2IsOwPFGo0/SZW9xLnfRlWvQcWAOTID6uZBj
	ONMRnccxMjO1Cr9RrCbJMT5SPqhCOJSd9Z2SA+Yl0Mi/Inz6RLiceQLl5ueK6wQORyBAcglVkGX
	4OCn8QxX3vnJcKcOkXUaS6bqPw/P2ocQNOVzEl1K13lWVDUySSrx2cQjXkO8X75aIN4wnYo62Zn
	ljuS65oEFy5YoYMhBuvPd3AAWk9stKlTg1IM=
X-Google-Smtp-Source: AGHT+IHA1OyuHnLSdTTrF5+wUswOWVcuJY3KaVBScT10A5tAdHoQNHqXJsVDvusdIQAv4smHLolaxg==
X-Received: by 2002:a4a:c588:0:b0:63d:bc20:a61a with SMTP id 006d021491bc7-63dbc20b6bfmr543382eaf.7.1758828226054;
        Thu, 25 Sep 2025 12:23:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-63b28448e7dsm300861eaf.22.2025.09.25.12.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:23:45 -0700 (PDT)
Message-ID: <fd575fd2-f246-469d-9276-bb746b554e19@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:23:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/acct: add cleanup for leftover
 process_log binary
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
 <20250925083445.172571-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250925083445.172571-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 02:34, Madhur Kumar wrote:
> Some kselftests generate temporary binaries that are not tracked
> by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
> during `make kselftest-clean`.
> 

This information below doesn't belong in the change log

> v2:
> - Fix newline issue at end of Makefile (caused add/delete in git diff)
> - Code otherwise unchanged
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

Add patch version information here.


>   tools/testing/selftests/acct/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> index 7e025099cf65..fd14128bbddb 100644
> --- a/tools/testing/selftests/acct/Makefile
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TEST_GEN_PROGS := acct_syscall
>   CFLAGS += -Wall
> +EXTRA_CLEAN := process_log
>   
>   include ../lib.mk

This line below is still odd.

> \ No newline at end of file

Start without any changes, make the change, commit, and send
v3. Refer to a few patches on the mailing list for examples
on where the patch version information should be added.

thanks,
-- Shuah


