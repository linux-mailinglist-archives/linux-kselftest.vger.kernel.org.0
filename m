Return-Path: <linux-kselftest+bounces-24642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067C3A13A41
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C82F1653BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399831DE8B7;
	Thu, 16 Jan 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkTm3tgt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE31DE3D9;
	Thu, 16 Jan 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032044; cv=none; b=WsXcmrFK2Xj5LzYX70ecg7fE24vKPNWfb8pT9UeO67hyaqtC6eLnWs4DsMYOTN76BVXOUO/nXUVE2LiGFjqJs8z5LyHpfHids/UlgMpSWAGvx2E6BN5oCZxBPk5102KkxRHITBlBln+ZzXwXLvYIo7nfxBp0t2Dui/VWAfYhCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032044; c=relaxed/simple;
	bh=/smTJtfyV4jnOqCiO5F5O17FS608/jSCKpjgFAeV7QM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=N6eD+rwjuD281Y/tq/Izetz2j0VpWAiPkXCG7ZWFM7oQ0XCG1He2w1FIxzqtn/J4STcDpLGPp3JRsDSE4l8v96kAG92Q7Ccz5MlJurdAG5cCYXWJaw1yMmrqNhrlwyDfDkDn46CnlE4TPT2leVo+KRLWE4rZ5c49XU/JDJZRRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkTm3tgt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a8d2d7f1so7764171cf.1;
        Thu, 16 Jan 2025 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737032041; x=1737636841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQMffHB5V9jp1w/KCByUeoZ7ulffBvZYTaCL6OedkWM=;
        b=YkTm3tgt/CqcpAZy8iDtx/pb1BgLvdvWORKFQvJXC+G+HBDmqP1BLWZ8yM55EulMbZ
         XOIgjHTZLjayyltUDBLwCXWQkakWUkXT4+dWqeWXuyEKYbjXEqeW5rYuezZWfaMlj+O9
         J/nIX2vW9x0ZdlvbI+qqkumCZtHqq84ObS9henHvGDtW77hrHEz96mC214wVq97FJQQD
         iEc11AsZmG3sitUMNQoGokwssnhRaabQmMvhLDHJ/vKyZRXDso8j7dpEN4+y68V7BUD6
         SUnrm8153JslZ5gYwH9sgXE4DhtQIAGjrI3nb22WkVcxizcL57tCyKrLOWKnMcrunRrx
         H7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032041; x=1737636841;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQMffHB5V9jp1w/KCByUeoZ7ulffBvZYTaCL6OedkWM=;
        b=cOX9KcIjJELthFhppyo3R6UglxLr0LuYxssDrZIRsxT24AEEfJF0wkWR2cDZ/ef69v
         gxaGiLdhSku1B2TZ9FG9RBCQspmza85ZnkpKpmkULHocqjRlFiLm0n0MCgigjRrunCnP
         rUmNJlo7tj16APWb08R2xBKgCi930KdeC1H/5IhhVKYFk91GROKgDIOgbOImzINtfX0L
         lc91G+JFapKaddFUPvMqZMREAl60BaihreCh8+ddo8XQHpylM8Tm2g+TBetfvL9fL+Zu
         EJKfArQqyoYiHgoFBFWnVtvTWQuRj2Pg/nZ8RBQ4blvv5HG0AU1VDArekc0k1w/lrraQ
         us8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZouIgwORy3VW6fFkyxHrvJvCJcOwj8xda3a68t3MEGJbAa6FdwhkXtRtIqA/RWcbtw3pFMqAj@vger.kernel.org, AJvYcCVXFVHnrqdp8psi8otYsSx89uGkdqOFjte9evNp+sCcXxDkDM3cvTSPfpsGQmL3rY2J7xR16Nw5sRUfiVIoT7ZT@vger.kernel.org, AJvYcCWN5W/WRBHnWJJkYQb/lj64w4jLKs9ZVDVM+YRPA3JhZAPJi/vbfL8aAyYiqT8Y7MMZput6S+Ezb0wAY4yL@vger.kernel.org, AJvYcCWOEHmjxEaTV9lrWvr0QywswI3je3PXjoATyeWmrP1tfaOmlYk8NZwcajzzlwF5ji3jttM/zSxZVQzY@vger.kernel.org, AJvYcCXxPfg1go9vizdvYEIEFZ40N8IG606ug46kSLFm2n9naGIHcy/4qIAudkjLebkh9cvmdWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0WeEmNicoFXrMiQdsVhgErcoFWDpi9WhkTUz8u1hqlLhPwEu
	vuk76nMMp6QW26ppNifRyIBvmuz111paRmw1zL2slk/3RMu3t8+1
X-Gm-Gg: ASbGnctJhibUyjptfJp1/y5YyhZ13t9u6PjBdrgcplc0Bq7MZfISrDv2L8poGiMs0fC
	dqRn576agwbBy07UFROMaURRf+8COa8N+8FN11Tfe8/bsElQlzLa41RHyLhk+QHXNedF86o0jML
	Oayc6SkPLKXv9lWnZCe1KtWHVKRkR8NcVcuruUpt+Ch/e/Yc9Bqfj8bjlpgUN8lYQPYhAGf/DKd
	AG1E69fWE2sMTWCtcQnPvxxiVZNqklnV0IjAaLRNWP8v/GGK0PzD4F3z6abXQHM6T7GOG+bW+bN
	GvR+2QhL8hVfedNAqI0y/7udtFTh
X-Google-Smtp-Source: AGHT+IGAPwHCulVk3YA3srEPPAkpgIxRZlbJrc49E6sk7X4J2EiUFlVkp6rRmzHsvgqlARBJ+pjj/Q==
X-Received: by 2002:ac8:5705:0:b0:466:85eb:6123 with SMTP id d75a77b69052e-46c71003317mr520830751cf.22.1737032041353;
        Thu, 16 Jan 2025 04:54:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade72b59sm75303556d6.87.2025.01.16.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 04:54:00 -0800 (PST)
Date: Thu, 16 Jan 2025 07:54:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <678901682ff09_3710bc2944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116031331-mutt-send-email-mst@kernel.org>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116031331-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
> > When I implemented virtio's hash-related features to tun/tap [1],
> > I found tun/tap does not fill the entire region reserved for the virtio
> > header, leaving some uninitialized hole in the middle of the buffer
> > after read()/recvmesg().
> > 
> > This series fills the uninitialized hole. More concretely, the
> > num_buffers field will be initialized with 1, and the other fields will
> > be inialized with 0. Setting the num_buffers field to 1 is mandated by
> > virtio 1.0 [2].
> > 
> > The change to virtio header is preceded by another change that refactors
> > tun and tap to unify their virtio-related code.
> > 
> > [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> > [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Will review. But this does not look like net material to me.
> Not really a bugfix. More like net-next.

+1. I said basically the same in v2.

Perhaps the field initialization is net material, though not
critical until hashing is merged, so not stable.

The deduplication does not belong in net.

IMHO it should all go to net-next.

