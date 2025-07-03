Return-Path: <linux-kselftest+bounces-36417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0CAF6F23
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B69F1C82632
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B92E041C;
	Thu,  3 Jul 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBdPgt8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADC28E579
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536033; cv=none; b=a7bbMInfxZXZ6a8XeNGNfVcO3A80zLLWy+KW+auGNa8TWNANWBR9x8wbUnVE6VXp/kIFssBuz7nwjIc3ec1IBgSd0j52tYWXfTT8FnXXkWMW0wnvq6sfPus6CVKOSuaA1qS5hMBZaqk4vYGEtBNH9o6jgnKYpD+JEvsH29UCbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536033; c=relaxed/simple;
	bh=vAUqcE9WHLgFLocug0JQgsHfQyTephzjFLwqPNC07jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLP3SaIIPnqqOt27VqLkiJKb9AY73+3Blt9MgEbFzjra0BxMmecTrg4rJxML7yzFZ4vwywVdg64vt+tAQp2tC316KtQviGSTtT8jIiW3j8T8/QifWXUPPakELr5CcuUyJeJbAl85ukQKpf5eDdapPj2MjeC9aM0B2/+CwBO+BOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBdPgt8e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751536029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdONWkev/uzh24ec7UGP8PGlZlG60mDJHMOgMeP9f20=;
	b=TBdPgt8ev0KT/H7Q7M0MN7XtypnoOQLOVmWta2qalBaJYeGa+iQr9R/L8vPEYk7qJu9JLv
	+bjXVofNEBWAQ9QWiO0hT32DzR4cJ13LRINqQsMkNV0xgvfPuEwIHC17Rp/gqCs8wa7+u6
	Hqj/HohXtuqOCqlvIVqkhbwZNQ/v43Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-D0ClVfObM7KHRoGoTPvBbg-1; Thu, 03 Jul 2025 05:47:08 -0400
X-MC-Unique: D0ClVfObM7KHRoGoTPvBbg-1
X-Mimecast-MFC-AGG-ID: D0ClVfObM7KHRoGoTPvBbg_1751536027
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso30992335e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751536027; x=1752140827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdONWkev/uzh24ec7UGP8PGlZlG60mDJHMOgMeP9f20=;
        b=n8chhAovbgQf8edVnYQJV7Hf0AO2+y7ApJ3FSdc7fCJCNhbuLg70cxbb0kP7xTT4aW
         1C76EJ1sFEcTaBrrmouOmDjp+xe49x84X/t6d7mgVfU9RFb3xpQiP8tVQeO/1ekxPi/r
         gKD2uQvVLnmiaY6PhbI3YiI0bqnRgFhJcR/zWLQNhjh2LbQxKrg4Xk0HMjPA5us/MqsS
         QkxpkW6BVace9CUwb/zJtIHFxCOYM3FC8cZmT8gZZJ2x12qorBgsIz4nTSQC7ZxcGsYM
         ZE42ZmlxPijzqwZZ3dZ0CH2RADuFMSpBgp2KsLTk+xPxhnfQmS2u0pKWGeTDP1yt1Rxa
         kuDA==
X-Forwarded-Encrypted: i=1; AJvYcCU0hSXTPjYeEqOcroFqCf8l+76FRH3RoNVXsFWxJ8NUFVpuDQfblBBPYo9H6PRTnR3HOnL4yafvTKW19+/AsLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSfxU+LiWbWCbLD5NWh4dJFzRtRA1vcAgH3JAxBQ4F/CehMS/
	oyOT24fQoDqHRkD3MNEhItrKthiiTL3MihIChdHFfHAmLgH7Kn5rFssnviyH4KdDU4JmrnwLtqC
	jHvgNdKUkOkAVTJ4YpwBKuS/a/vfHMzdc0gVzOH8JD/PWuh8PC8+S8xfIBkwB03Lw5FHkuA==
X-Gm-Gg: ASbGncu6SZSc7tnVgsergtE0PnhkWcS70lMkBYiAA4YV59RsZMTT2pNPbtF7ZmSXwL3
	sl5/uF0y2ILZ7rbE98qbTDxt+Au1ArbFClYFTDEe87GY8/sw0WfmjFnwDxwrLbE43x4X0jLNe3v
	IGwR76A5sWQ/rPq2MyTsfLdiVrXlWJw5aejaUWJ9b6ksy6SPSPrnQHR1nHnYHlVwToRRHpQr2ax
	b8Hg+qqfxRl2T2k8TnrtWzCbuFacUOoRtDP5wosOmEdvIYtETy2rqy64n1B+c5idtStXEbhiRXZ
	V4ojVEqy7mMW4861f9C58OQh8GraoEOTKcMV+Y1JBbpT/obSqGf+kOhCCbbJgy0bRSI=
X-Received: by 2002:a05:600c:3f0e:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-454a3728d1dmr56455925e9.25.1751536026749;
        Thu, 03 Jul 2025 02:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTquN2HQ6ykNf+B6aChu4ZLFvBv5XnqVUeKx73fDJCojdl+3JrMQRzkT7i5t5oqAJP5BLuGQ==
X-Received: by 2002:a05:600c:3f0e:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-454a3728d1dmr56455635e9.25.1751536026306;
        Thu, 03 Jul 2025 02:47:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9989328sm21313015e9.18.2025.07.03.02.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 02:47:05 -0700 (PDT)
Message-ID: <509f34f9-5eee-4ba3-bd09-dfd2d47df0bb@redhat.com>
Date: Thu, 3 Jul 2025 11:47:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: net: fix resource leak in napi_id_helper.c
To: Malaya Kumar Rout <malayarout91@gmail.com>, edumazet@google.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAE2+fR_eG=eY+N9nE=Eh6Lip4nwWir2dRQq8Z-adOme3JNe06Q@mail.gmail.com>
 <20250630183619.566259-1-malayarout91@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250630183619.566259-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 8:36 PM, Malaya Kumar Rout wrote:
> Resolve minor resource leaks reported by cppcheck in napi_id_helper.c
> 
> cppcheck output before this patch:
> tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resource leak: server [resourceLeak]
> 
> cppcheck output after this patch:
> No resource leaks found
> 
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Lacks fixes tag and a target tree ('net') in the subj prefix, but please
do not resubmit, as there is no resource leak even without this patch as
the kernel will close anyway all the open file descriptor at process exit.

/P


