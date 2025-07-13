Return-Path: <linux-kselftest+bounces-37217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25856B032B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4DA179F57
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CA1289346;
	Sun, 13 Jul 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFCTIA+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095721991B6;
	Sun, 13 Jul 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752433893; cv=none; b=i/MP8LMW8fwTNs9qbmsqCWyQdHkPrYKvXy41DGLZu7s9K5qU7gmWuKpPkGHMc1omNzlsva6Q7YbmEvfDA1LIBcEv0KhZSfdea6c6W1t44Bx0MdwT/yrPB3jMODR4GlcheLVAoD/1SzpVZPYYLIZ6d4R8zBfeoU5ZsTIKvO2li0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752433893; c=relaxed/simple;
	bh=D/n+aj8yWr1p+NrK2Yk7Zovi5B1o/dGZtA6X9WWPtBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTpXp5XktmOOiCH0ciC1Rv5kvZQuW8PHdN39czoCB5Inbsa2uDZtn9Tdu80A7k19JMkVd+79hjueMyIqLLz+acaGcf/jBEVPSiWZzai2AYjNjLo0IOJqKX0heLTUAFMmWxEamsNHjW15eV9Gq6v1c8qfPc1S9K13+Fh9pZYU0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFCTIA+A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237e6963f63so20192335ad.2;
        Sun, 13 Jul 2025 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752433891; x=1753038691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ucp+lH4q8byODsutqQqfT9rYZNWZwNGt4JdVhNxXMwM=;
        b=gFCTIA+AibY35FrVQv7XJgN+oki7StFSmV1/kGgBD407XQLoYjoX0Z57Hllhn4O/Ll
         4bubH0kWyMHYAC4+mZnak00F+BJGtZzx+z/XYpfjMQrD5EPdE6oBe7H55DOqMSHYVv6N
         n/XcBjcUstXUseOSuYdelD3B3mNLTPxb+0AHjdENlI7dNKP1Z98snDiSmDd426aFLrsy
         ZoEAtJ2KkT70/G3+oW9DVL4C254VtHO1PyosygB4ibW19xlr09Fl1fa1k7vpV/4fdisk
         FGFFpUk1hQMRaVAC1JC++q0xbH5SFo44jrs4QQBPToq1OMJ8YglHXirxKSgd1HeWUEC+
         fW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752433891; x=1753038691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucp+lH4q8byODsutqQqfT9rYZNWZwNGt4JdVhNxXMwM=;
        b=i8UD1FE3/BG/T0lRHYVn8NbYnerJ2uHGdjGFvuNeYoeWMvHrVfxPz+2Cys3OBzMb3s
         x415b8UWJh1PjmwyRhQNa8pSFz5qd6S7aJmTZG5hX7IoF8UR9hGOKLtcwAr1EEdLJlqX
         zgQ/7c3Dsz86vAbzTHNLSy4ETFG2mFLqRBIWSu+vSGWr0pg7Fj4vHsrcSHAbrcoZI7DM
         AoMd7ID8+tX07UzXNYPDT3DTvWK5TqcnqRdTtujlCkTP7MYmBavY32EiRbnPRqIJ4aiz
         VWOGE/ZOqKR64NDoD42+5DHqJoFATQ7ExrtPTylRd85j/KOpzYsMJnQfsqsn4X1PHSlV
         jHFw==
X-Forwarded-Encrypted: i=1; AJvYcCU056gMpEg5/kpnyUz+uVLCu0BtPiajAkbfC+i6NpOLwUqZEImPNT7WsM7nAIxTuv9azDGa2e4ZwqnynDK3xvRt@vger.kernel.org, AJvYcCVMZOtcqGtWOQFTvB8oJNdqIrKhl0Mm3XLs30nxt316cb5Gc4+ze4wbjeKpPMjjljiDhz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYEvVWSbTrSpanY5/Z6PZPJr8dgsXaW6LiQXnpvo42himafoC
	2fUOdFXvEXLj4V4wpfV9I/YHJF2R0XH1tYMxA/Ck/Zg6qs+9sKCc+cZr
X-Gm-Gg: ASbGnctKQD+z0+nozFjXIGtfMQENkQ6BhucqjQiIMbT7q7y0LHtzCyDMD12oKV0w6Zi
	MzGsNWQVhy4kzWh/MUl6YOoOENsGHRI0reJyuSzbNWEJAQ2z0GDF3zeJjWIwk09F86KF4HtHUOo
	Fay7BSYzLL6vqmr8n1TprE2MEFup3xLNkvC5SgcXOFotXe2E0HnVAtOhkB5evLhV13n7F0KNtq1
	oOFYgYtM86vGOlnyCcSShIP8pgOYX1gOzUv/7yGE2V5uardVvo/tHQVMgj1xou4hYDQ4+svCmX0
	sV5LRIDhOcOhdAOg/9/0owFBR/VVTpU2UTZk2a2LLO3cG8ilYk0e1P0qHssuUMNTr2zq15CsZ1+
	nX8yjrn7emwDVBPttDrnsYtyY2Oq1iFLrVYmM8KJ0uBC9dUpWT9QOjlrXdcftcfdTzKSskkCNFc
	I4pSjIHYs=
X-Google-Smtp-Source: AGHT+IEbMv5h2s3kiTLjziHVUL0nnviXG1K2HsZOFVl3JxhHwtuV+FRoVb7ZH3A23PTAsSh+WauUjw==
X-Received: by 2002:a17:902:f691:b0:235:880:cf70 with SMTP id d9443c01a7336-23dee1e8c82mr136722115ad.14.1752433891227;
        Sun, 13 Jul 2025 12:11:31 -0700 (PDT)
Received: from ?IPV6:2601:646:8f04:30:c0e:994c:1a00:bb33? ([2601:646:8f04:30:c0e:994c:1a00:bb33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4347d82sm83373645ad.197.2025.07.13.12.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 12:11:30 -0700 (PDT)
Message-ID: <2311adfb-e3be-44dc-b724-1af18c3e50a1@gmail.com>
Date: Sun, 13 Jul 2025 12:11:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 0/4] selftests: drv-net: Test XDP native
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
 <20250712080254.4ed08842@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20250712080254.4ed08842@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Hm, but we need a netdevsim patch to support XDP to be part of this
> series. Right now our CI tries to run it against netdevsim and all
> the tests fail.

Yes, we do need that for netdevsim. Should we make part of this series, 
or hold this one until it lands?

