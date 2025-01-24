Return-Path: <linux-kselftest+bounces-25092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83955A1B66F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DFA3A63D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB68493;
	Fri, 24 Jan 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW8u5gxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BC6AA1
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723507; cv=none; b=f6oj9semO3tpy5H+mc2qJo5N4iEFbDi2ptSCiZKrYpJj6fLG+b8GtRvdCxttNxLCq3/CZUc+IccDkQCirMmbu7yMR4HKHlwn14Rb0+uKgcv5s+s9Jz/Mrz7Cm1kD1L634LdNNzR0VbsklLB6W9Xi1cFPsKvF+j+HYcTUauH6/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723507; c=relaxed/simple;
	bh=9vhLVgSJvkUzp/+ZDz8AjHfj93ayZ6e4etxKDQgKZ1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc81E8GGZN+tcGQ5umQyECvjkdIEfspTH91UGD+4Hq6L9q65OnlpQZ1hBFvbjpDq8IyrW+H5UH/C8fu2CauazjFHkLeg0E0DT97CMeyYQrmKbrU9TyzNR/CPuq5GAgf+4jJUBPXHfnHzLMN1TPCHPEv68WGbg5uCsWd7J4skwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WW8u5gxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737723500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0J5Z2SBoY0f55z7emiVbfYnb6Y91DGR2ecZHMgdiZ4=;
	b=WW8u5gxVfB7fNEPbftWXTlLBjMjBdgZ/XRHq5UQuAC2exOLa0nUxFLD+eL7isujAXBtzfA
	d7G0odA1ByZpggsqMcRwdgpTneoqSEOuOiNkdX8K7ygllJCfqPQRe+cz7/EV1lgsCYBIGF
	QHLNX4tJp272sf2lw6qMiFi7g6CKdDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-YVHJTkUVMU-hN9gsvQPRrQ-1; Fri, 24 Jan 2025 07:58:19 -0500
X-MC-Unique: YVHJTkUVMU-hN9gsvQPRrQ-1
X-Mimecast-MFC-AGG-ID: YVHJTkUVMU-hN9gsvQPRrQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43619b135bcso9799825e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 04:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723498; x=1738328298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0J5Z2SBoY0f55z7emiVbfYnb6Y91DGR2ecZHMgdiZ4=;
        b=Mcs+NEFPjx4lCGNzjS0W04kftUauyoKs2syeGZU0lmQgr2f0vXG029QQ9Yb6ZWbhvz
         Sl2S4y4cRFaF8D3Ng/TNDcicyycsznLGVC30wAzUbxJV9ihhe3Yv5VVZlpxMa88W+PdQ
         zO8LkbHz0+hYML1CDftxBdB6cNhftXktO1ryHSkmPsxGvfsEMHHbNwTENo/spMohm7WV
         ms1pzy3gxACV4DJXh2TAZIUwJG/riKLoPdJo8wXhlRcxfaVs23xP2rjmyU42f3RSJe/t
         6Cl7HrHbLBCYipHfr4eM2n2nZ6rb7FPATfULpUjno3M6j3gFfoB64za1nYWqyUtPryeI
         9ORw==
X-Forwarded-Encrypted: i=1; AJvYcCXzR4cEGTNOR3YpzeT8BU7BWOJyjA4kSCNS2RMzijLp1F6BzXJRdp0gTLgYtS9ET+uTVbltfa3mRbETu0e4wMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+KBIYUhfuFbJl/Z1Lece4ucTWv/CzIbSQAhHieQjXS4pTSW+
	551woxLtv6IXnv2lWCP+7cKcv6ozROXHJQt6o4jLV9xPVfDuQpHBDfHjxa9FsScKw7rOVULyZTq
	ejdReYMywHTGmj07mHdj35FOlplFFGHIhynhH2zVO6g+bCnLzJtKzlRJfkekc/nQsbw==
X-Gm-Gg: ASbGnctWDytcuA0RGwr6TMLl5wucK2kIsemy8rwJGB3d1YQiKFU4aKf1hPTfD37nfsD
	4HgLr6WR8MG8CI285MppZ+tvfnqpf06Ota6PJFytgCA6EMbP55utppdb8c/sQoYIVMOLcdID2X9
	+SRbKNUIluv4k1tcCHMrgWdLWbs9zWGLEATjCDpScxCqPKS/Lb5WB2v804ukj6VD9rztCIUWD5F
	/OZfk6Nm2eH/OPEk9QvxKlvQ3IjYQQ9O9vY1RoaABj1EwTzajQcrnXoszYcgWFpwsERgUgI7b8W
	AfzjXqePWcrY0iRMqF0D4nmnhseiN+kIw3h4XoNJTwevvw==
X-Received: by 2002:a05:600c:4c24:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-4389da1e6c7mr254283305e9.28.1737723498248;
        Fri, 24 Jan 2025 04:58:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRs0Glx89jQkSNFnV105jdUfXdwoCdvq5qiGz1yC35tKkgkMxhavVq6LlrhT4jZWikxY+ngg==
X-Received: by 2002:a05:600c:4c24:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-4389da1e6c7mr254282705e9.28.1737723497800;
        Fri, 24 Jan 2025 04:58:17 -0800 (PST)
Received: from [192.168.0.167] (h-185-57-5-149.na.cust.bahnhof.fi. [185.57.5.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47eecasm25576245e9.6.2025.01.24.04.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 04:58:17 -0800 (PST)
Message-ID: <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
Date: Fri, 24 Jan 2025 14:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com,
 laurent.pinchart@ideasonboard.com, broonie@kernel.org, leobras.c@gmail.com,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
Content-Language: en-US
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jarkko,

On 1/23/25 11:30 PM, Jarkko Sakkinen wrote:
> On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
>> We are working towards creating a generic, upstream GitLab-CI pipeline
>> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
>> is designed with a distributed infrastructure model, making it possible
>> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
>> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
>> integration.
> 
> Why can't you keep the next version of your great pipeline outside the
> kernel tree?
> 
> If there is a legit motivation for doing that, why it needs to be bound
> to Gitlab? Why can't you make script callable from any CI?

Greetings from the (today's) sunny Espoo!

Of course we could keep it outside the kernel tree. However, the point of this
contribution is to provide kernel maintainers and developers with an easy way
to setup their CI pipeline on a GitLab instance (the main one, FreeDesktop
one, or any other). Basically this is like a template or a library, if you
wish, which helps you do that. Approved by Linus too.

Why GitLab? Because it's one of the best, if not *the* best CI system these
days, with lots of flexibility, and it's Open-Source too (well, at least
open-core, which is still very capable). And also because a number of
maintainers and companies are already using it.

Sure, a script could be contributed too, but the value of this contribution is
a ready-made integration. And we want to make it easily discoverable, and
easily contributed to.

BTW, here's the talk we gave at last year's LPC regarding current use of
GitLab in the kernel and surrounding community:

https://lpc.events/event/18/contributions/1728/

Nick


