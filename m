Return-Path: <linux-kselftest+bounces-45311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF3C4DEE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 13:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0518C17D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD13A5E72;
	Tue, 11 Nov 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaT6A4Kb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qMSKEmH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73F3A5E6C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864399; cv=none; b=V7z+UXqI05lAxq0dQlphiRHTfaSM2ZsaQ7Du7m/vqsayaU1Xdy8arEIEDZaS/8N5e2t3zhOKj9bvYY2j9Gron86YvRmDZJzvEXozkGjUKMFk6c7/NV2AFuzqifSIjfjV7l22PON/UIKovZ7fj/+1q/NCTg10YEcP4P/Mu4qTmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864399; c=relaxed/simple;
	bh=iOWBNEkhaYulz60fd9nqYbYaUth2lUkhdRV+MRZ+GSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1KIRlrPxORwrBmIsqrk/v8whHZyMbV76Qukhcc97Phsh2ltK3zxq9p5Z2CGPGoiS/Nq2jpi6iWte8bq23CiqjdsQ+0FeLbZBlNveHWbup1rUe6VwFhOSQF/AMYI7ea4AYBz/NhIOJUhpvy9p7YLHsB8Ij7B5FGae17udUJiBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaT6A4Kb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qMSKEmH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762864396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEMqTiIls3GK+BcBgDdLsrWg6wcMid5JirlC8x4cCJQ=;
	b=HaT6A4KbAtUPsaV3KjuB6fdoIR80uKtD7yDGnJjr6MhJDzPxajOECkbaprtSAD/H5hn8pv
	K3BTCvd87F8qBpvTs8rsvyI8m6630wqK98zjKcFXfO3nAhq1D4fd2i/8nuqiyd+0PGU5pv
	bAIwJf/bqfiuPYCOM5oJWUT14/9sHKc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-z1wI-ob2PlqpVEF-VWaYiw-1; Tue, 11 Nov 2025 07:33:15 -0500
X-MC-Unique: z1wI-ob2PlqpVEF-VWaYiw-1
X-Mimecast-MFC-AGG-ID: z1wI-ob2PlqpVEF-VWaYiw_1762864394
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c93a28ebso3093258f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 04:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762864394; x=1763469194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEMqTiIls3GK+BcBgDdLsrWg6wcMid5JirlC8x4cCJQ=;
        b=qMSKEmH5zh3ctqKDwnt6cCK2+TpyDorwqW+f8NzcPEqfJ4MLx0ndMhrwyL7zZLp1zt
         16zSbtXJ0s2I2KcT6CiFZNzRLm2KJOFSuj0BHYqi51ODGXmNF3qxzivmpGQrYbKbCuES
         3wJy/skHPhdtEAk4Kw7EkNtROAvRgIlLxDZpD5GZURWN6EUGEKEV5npVlLk0/h10kjq4
         BeN+znXsUmWfOEDrJK2NmRGjJ9sa+3EqHdM5feeSgyzjeHSlfq+arBRMCZVBZdD0ZhR2
         VFnnE+6qwQewC7Ta9i81j70XtYWHLJdQ0V8GKCQNzF4+t+HH+780qPkFILuFjgN/WSc6
         QDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864394; x=1763469194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEMqTiIls3GK+BcBgDdLsrWg6wcMid5JirlC8x4cCJQ=;
        b=wbYdpQKeIopexj03IQIyfM5+ZlDg/VaQ7xsTrLjROwQ6hAnJniFAkXSWG+Kw6h2xc2
         WQUbWmCiUHuDxLmulbxnyA8DKUytxfLYZuLAAfz5hYIE7WdIqhVaJwZX9liUthhGKFa4
         loARUINcRsiyLB7GQZZ1d+RrLPU4xKTR4YzDtcAao7YjJuN6ua+3RvQ1ks8f2Q5L9uxG
         ahbForkk+16lff+eEeSmG5d2ewNJ6BQrJQPKlwj7WsBiGqA5svqG4Y6EbZafwa/7Q+wD
         1Ae/fI2QXs+mmHMdPwiUdTnsDhpLpzdowMCdtzH8nroRsJWMSXfy+dOsIvx0g/ELpWX/
         MN9A==
X-Forwarded-Encrypted: i=1; AJvYcCU4Q3h1LvoHohofi/7vPdw0Kz3YB4eftBfBBbq7lKNz6YgEcaEH10zGhNP/2FY7VS/7fRblJe0meHTZbZ5+AKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3gpFTn0tMpUBDLrblTombjYiRdG61syhzNOs0iRhpOijYBkG
	KiugfwR38NLn+62ZbXZl0Fkk8T3fgmXqn1TTlB6AfwdzKDQjRYMCw3CUhbyVL+sQrEkK3ncVxfs
	yIH3GpASheUdhp4gP7Ob6Gtjuw9Ax5WtmS2q2tjpv/XOBOnDdcvUfYDB5mXSvTXvG411wmg==
X-Gm-Gg: ASbGncv/ajMxWStvixErtDymIWSvH0r4ma0EwVtXRFEHIly8BK1Jwz5BXHwERLZBnqj
	UuBxXf0ROhroFqBAMho431T3Z2EdZaXrgNv1R9bshpZ9pU1gyTUU7eVDrEOeGCJnG6QaqA8N451
	pr04JdND13rE+G8PM44M+FAhIxLp54mFLIsaA7MhkVZWhg4J+lCHgtihr/I7sWSwFgyJdMbSd4W
	lc5rXgojPsJTZhr4hCtso3g/6j+UujXEEE4dzKt8A3tgo/95+tXfi0xRTA36RH4kbBSeVp5KRrG
	z1tEYY/ejyZIWVfYd8tCtO5zGxEKeMXUhARNmdNxf3X0m53F1ujt8hsKzPySNiMiXWv3+tQurxq
	Mlw==
X-Received: by 2002:a5d:5f53:0:b0:42b:32c3:3949 with SMTP id ffacd0b85a97d-42b32c341e4mr8571490f8f.31.1762864393735;
        Tue, 11 Nov 2025 04:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEogtUOY4yTdf1DuIqascBGW9c45+fo19oaNrpbIqMX41Hc32xWFtKascZRxunxinjoalWo2A==
X-Received: by 2002:a5d:5f53:0:b0:42b:32c3:3949 with SMTP id ffacd0b85a97d-42b32c341e4mr8571452f8f.31.1762864393278;
        Tue, 11 Nov 2025 04:33:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm31385653f8f.41.2025.11.11.04.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 04:33:12 -0800 (PST)
Message-ID: <d19c7bea-9b4d-4f00-a6bc-35247011e788@redhat.com>
Date: Tue, 11 Nov 2025 13:33:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/25 5:00 PM, Bobby Eshleman wrote:
> This patch series refactors the vsock selftest VM infrastructure to
> improve test run times, improve logging, and prepare for future tests
> which make heavy usage of these refactored functions and have new
> requirements such as simultaneous QEMU processes.
> 
> These patches were broken off from this prior series:
> https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/
> 
> To: Stefano Garzarella <sgarzare@redhat.com>
> To: Shuah Khan <shuah@kernel.org>
> Cc: virtualization@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Simon Horman <horms@kernel.org>
> 
> Changes in v4:
> - fix messed up rebase (wrt check_result() and shared_vm_test() patches)
> - more consistent variable quotes style
> - use associative array for pidfiles, remove after terminate
> - Link to v3: https://lore.kernel.org/r/20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com
> 
> Changes in v3:
> - see per-patch changes
> - Link to v2: https://lore.kernel.org/all/20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com
> 
> Changes in v2:
> - remove "Fixes" for some patches because they do not fix bugs in
>   kselftest runs (some fix bugs only when using bash args that kselftest
>   does not use or otherwise prepare functions for new usage)
> - broke out one fixes patch for "net"
> - per-patch changes
> - add patch for shellcheck declaration to disable false positives
> - Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

Series LGTM, but let's wait a little bit more for explicit ack from Stefano.

Thanks,

Paolo


