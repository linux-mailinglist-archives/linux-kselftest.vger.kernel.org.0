Return-Path: <linux-kselftest+bounces-25191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17FFA1C76D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FA9165D7F
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DC7405A;
	Sun, 26 Jan 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLpbbQlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066159476;
	Sun, 26 Jan 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737888607; cv=none; b=mETa0qwEjiot2t9Tqfco2wWLh+4oYVSACCGNRAgZ+Pc6JtkineV95j9IKqXPOCzIgbie1K7HH2GvImqz1ahM7zSmSYHMYGkeYJKn+5mmwu90PU/gAZR0wm8QnvoDPdVjpnymy1wqhvIlGWN4dg8yQOHPxoD43TJh7v/RxnAC2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737888607; c=relaxed/simple;
	bh=Om8nVUyVXqmlHGfxAx729NR+w4TRlZZSnwrcXmxuMhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bn2WA2CShx4ooyq62F+yZKJwdw4HR5xEJRbDWQCsmnSAjqag30QLVWGgZsrJurOWeS6yZiHBeGXOcQRoZxg49uuPqNSNUDMZzD/Ln1TvMAZoGmDcCoUtUzx2cT0b6g+rRZKu11DhufBygC1SbTi4hMULmdmBZzHpvRgixHMth7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLpbbQlo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so3029060f8f.0;
        Sun, 26 Jan 2025 02:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737888604; x=1738493404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7jWmIojbdmuZRJd16H4kgqu7RTMXhsXAtI4Z0TkZ9k=;
        b=FLpbbQloinlgPyCiCMQeodu2yxJvaAvF638lTwjgZbcyZtJ/mZXAtCh0jDGlYmnncL
         QR77Gexu2oPowySBrRYrrLB+CrJOCtxfIr/7wRORrhAc08E/zVBW3HKZU/MC5tpoAXjb
         lMALqge6OfQcERGhAHhiuPPYoXZFTVgO2VT+IgXKgzODuy5u13Qpnwt1LUYTtB1/DnlQ
         rCGrTB9DoIv1XmxZa6+hj5fYxtGcZN+Tv3ryNDJU4bfYspsoB56tVK6JHgetbKO0GL2e
         sI1wYIryLmgz0/V1h8hIWNPaXfXvYoshrk6yI5JUUH+KWdzQ+f2ttaXCuSD+0GbIM+8q
         cUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737888604; x=1738493404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7jWmIojbdmuZRJd16H4kgqu7RTMXhsXAtI4Z0TkZ9k=;
        b=GtcvhoChkMMeGaAbN30U5dz7MhjXxIu5IFjQOmWzE42bGPZx1auEVgZ4LDUbpGEnrv
         7xiSjBBKekAvdhUHEuckjvfNrPGfpOSJathtHr1KS2OTpptiDsQprttYImUmVnvnJB4g
         KgUzbmdrC/McljLsR94Uw3fhR5SjRHxePknuhHF4SSyJlFkxjBIuFN9uQCx1nLDEK0m8
         oXJTk/aE0KZvW13Mp/KX8zBASa0zYgU2ydA1oFc5ufdA3dZOC/TaqYoPWX2wuvCLScJ3
         8wFx7J/WGFC42bKZbHAX4vELYeBEveOyykChHY6ZwDWrw6Z7rT/nWEuAsCZVNe9G+ztf
         GF4A==
X-Forwarded-Encrypted: i=1; AJvYcCWUVY8UWBr30A4k/XdmQEZOT4WMQbzopM4GkUBK/wyEjVRnRjF37qhEqB3WuJIRoFuDrOahPo/fKZqyhfjt2n4a@vger.kernel.org, AJvYcCWzp5Al/8wkircYuZCMfbIxR5qYf+glhZbPdCl8/AYCYAQb12J+E3kN6C7zVy/pV40SQxdPRgYPip011WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFN1/JmyaTH6LT6Gf9FqTuDKylhsutz3BpA94xRskl86lny8XX
	/Dlxp0i7182smhb9/LMOZtDUGx7HuxYQASKbVULiVvSeE0+lRBpN
X-Gm-Gg: ASbGncvEB99aXoFA6RCWGpsjN6ItdflJAsULAVaThWe++HH0PGPZX+Gozq0qeGERPPF
	OODH9IZe/WD3iddadm4xsmtxgkyBtSaQJJ59HuKEI+MzeFPDcMD5SylCkaSIhB0J0GXbjiYwD+I
	oim+6I9Xqj0E4QmSZyNSrs+57vbhfZCBN6fGM5qyORPFX5kAvp/l3bHfxZmi0AjMv+3CRXl0ZSJ
	3JB8XndzkYbKeAcGgg2z5C0UGiQU4idAkRk+CQ8sF/M5cB7zTc6PjbclJM3eEeeKGgfozaSW4hE
	KnmWqE1cQs8iCfhXFfDKFQ==
X-Google-Smtp-Source: AGHT+IFTfvREDtC5hAb/lw4BKzOEcPg6EqqG8I47b7SeRwHEd6722G15gFrEcvj/b+YPnSo+ACGwPA==
X-Received: by 2002:a05:6000:1445:b0:386:37af:dd9a with SMTP id ffacd0b85a97d-38bf57b76a4mr37027363f8f.35.1737888603866;
        Sun, 26 Jan 2025 02:50:03 -0800 (PST)
Received: from [192.168.1.14] ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1764e9sm7906145f8f.17.2025.01.26.02.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 02:50:03 -0800 (PST)
Message-ID: <26d1ef6f-3896-425e-b279-6c62d8b18ab2@gmail.com>
Date: Sun, 26 Jan 2025 12:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
To: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
 shuah@kernel.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
 <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>
 <D7AG8K6T8KRI.LZFD4J6OFGGZ@kernel.org>
 <D7AGBYQ5T2P2.3L3HM84HUCS1V@kernel.org>
 <518c6b84-63f0-4192-89a1-af0e8000318c@gmail.com>
 <D7BEBJ4R3QG0.20NP9ZJ3NWVP6@kernel.org>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <D7BEBJ4R3QG0.20NP9ZJ3NWVP6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/25 9:20 PM, Jarkko Sakkinen wrote:

> Ya, sorry if I sounded rude. My "why" is "actually why", not "WTF why"
> ;-)

Oh no you absolutely were not. I actually dropped you guys into the 
middle of the change without providing context and was nervous afterwards
as it is my 2nd time using LKML and trying to get everything right. 

You've been a gentleman asking for clarification, providing guidance,
and showing compassion. It's a welcoming experience.

> BR, Jarkko

Sincerely,
Khaled

