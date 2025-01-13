Return-Path: <linux-kselftest+bounces-24412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A0A0C4FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 23:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4883A1333
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C91F9A95;
	Mon, 13 Jan 2025 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSUmBqI7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6C1BFE05
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809168; cv=none; b=njwV7SF4C+L8RpcfMT/ipISi4FpMb+YNjO33t1QuxI4ezlG07BN/d8A7Xvozvu0xVH0p9Sb2zvNeIf9Zp99nzd8ApS72v9vO662sFx6xIqi7gxlD/cUSqEnuvtm36OHB2QPYmoKgJFHlOFJzDr7W0yQn0TzeczYEW3cwRU/T55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809168; c=relaxed/simple;
	bh=Y1Sf8wRGQ2ymwBDVZ2CefySURUrE7CJVRkTHWYLe6Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4iJWlHb0UZIjJiY94UukleOAEksO/FBDbDloEfQFg6XSvCvlYt87WEvRD1NmIZuiineSq73DAnWJlIhqISN9tp3VDl87IN2gyBxsZOB2FEnGoK//j5nEBWcrKh0vGEw5M2r2wwjZLGAR8VL8JmoCIn0814LXYjd/O4gzdfkkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSUmBqI7; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so383018639f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 14:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736809165; x=1737413965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQ2gkNd4r9DMxTqkbVKwWo3rDcj05xjd+dF6fL8Gq6E=;
        b=DSUmBqI72hPk9seFSWz3nk3/xvRtkC1lbakZJSo3O/F90kACpsCJyOoLHQmMbdSlWc
         ZKq5+PVvZ7+VIRMFkMJl0Bwp9JYf0ME3gQrZgZIdcjbvqM2Pi2GQXZAX/hf3RT9L7+aP
         Bd5tbrdtBKocLBZ9/Es8BkCjx7CrnI/mBaaG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736809165; x=1737413965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ2gkNd4r9DMxTqkbVKwWo3rDcj05xjd+dF6fL8Gq6E=;
        b=a2xarr9N4BEqydLq+TqP7JTUXOGt2nxKdW5Gj/68aipUGVzIVnZhd14c0F3q7junTz
         ghMqYt+46wDlTTGnHd9v1cyoLExKvqTL93Azwe6L3bxUDsKx9YDCDTFhMyV53512O6Nt
         U6E3j1/L9fZLg3POveOFNM3CdJ0beDLBP3gCLh7CtL5J+ajtBTqjnRd6djo1pfL1xndM
         K/TfbIQw7HT8Xh1JvQV/pMFXV7WLIWyUkqYOzIelewHDqVSnbVTgOkzy8J1Vxo1miuDp
         InMs0xzxE9ih3zjL+zSXyqCIh0CH9VMxt40EcFb3UKt8JIZsKWdAcjq1kzlFI89JGAJ2
         TtXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1dSjQZpD9M4vo6cjFl7MusKCrcNAic0NTSVVng0GQfbWtZr5iLhVX8HT/97VTyyV/WKDqyOg7ldCoXgZWV4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHK57eiXoom6YUqpvmow1zddfsekPW0tVAizmAaTexOQwmVDZ
	NpXx+LmCDaCnjWBcTO3zIxSmd3WeR6ZdtQ5VoKVnT5NdbrCkj9STjwQWlY9jrQo=
X-Gm-Gg: ASbGncuel9RafRGJQZKk0eDIlLvdWkIDImGg8HXwznoIM8U5fWJQ7Ik2QM/pqqne4Mr
	kcbBZuerCGnM12vrLQcl5FSk1k21vlbDQMJBmupNjzB8ZplArBnQaOQY94R8oKw98/i+8pfv2ie
	OnBm7PmmjZDcOfbZB6me+eAM7QB278wrSLrs8jxqclpZLpW8t9KjTmGn3h1W1zoFpfyW/VeEOcr
	/rcLhPhdFKZn+WhNKyLGNZXfh5JO5Y/NGlinmlIMlGAi6aavrtGumYS3oqBdrKi/TM=
X-Google-Smtp-Source: AGHT+IHOuxI2cX2rWco2UdItAy0w43rmA9Z7pNHw9QLL1Jzj184Hh3jFHAinlOQ+DJl0iE7GLseE7w==
X-Received: by 2002:a05:6602:3e8f:b0:83a:a746:68a6 with SMTP id ca18e2360f4ac-84ce0095b54mr2190395039f.5.1736809165348;
        Mon, 13 Jan 2025 14:59:25 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d4fb403b7sm291636339f.24.2025.01.13.14.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:59:24 -0800 (PST)
Message-ID: <3bcdf139-81e2-4ef3-8e86-1e22b4df6d49@linuxfoundation.org>
Date: Mon, 13 Jan 2025 15:59:24 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq/selftests: Fix riscv rseq_offset_deref_addv inline
 asm
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250103040326.2603734-1-shorne@gmail.com>
 <44f202e8-dc35-40aa-8dc3-2f2e4c28feda@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <44f202e8-dc35-40aa-8dc3-2f2e4c28feda@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/25 09:22, Mathieu Desnoyers wrote:
> On 2025-01-02 23:03, Stafford Horne wrote:
>> When working on OpenRISC support for restartable sequences I noticed
>> and fixed these two issues with the riscv support bits.
>>
>>   1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
>>     passed to the macro.  Fix this by adding 'inc' to the list of macro
>>     arguments.
>>   2 The inline asm input constraints for 'inc' and 'off' use "er",  The
>>     riscv gcc port does not have an "e" constraint, this looks to be
>>     copied from the x86 port.  Fix this by just using an "r" constraint.
>>
>> I have compile tested this only for riscv.  However, the same fixes I
>> use in the OpenRISC rseq selftests and everything passes with no issues.
>>
>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 

If these are going through risc repo

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

If you would like me to take this, let me know.

thanks,
-- Shuah

