Return-Path: <linux-kselftest+bounces-45086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98565C3FD6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 13:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6371893F20
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1922F49E3;
	Fri,  7 Nov 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="inxzjPlD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A22134AB
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517012; cv=none; b=Btl9V1PUmCV3RJtAdq/0F2ryFWZC9SIZpQPpDpIrUvztSPgmquVqMAAqJbo9P2U39F9Gu30MTp3cewe0OkjNiBih+E9puKWFe2tbAm73cjuITC9iPn+Vs6uPC8mVSY2ORNHarWrvC5XF5jtr21M/Z18q+FHcO01hTOX0+Ct3z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517012; c=relaxed/simple;
	bh=zvcdNY1dfl6PIDXQiKalJN9WhqV+X8+nmHiIlMH2ayQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyZl2HEWUe+zu3f6Wm6rkdLRTyDl6QzScd4gJsoAwQZR6HfGmLoZzwThVYOC8mhQI5kbxxf2ZfaSIifdUGAyuDeWZZ7hAeNF+RLJcz5MAuyyOVrCWcnwPTorwfAglCErgW6TqRwfpMAWQRFZ11daeez+DoQS2fn4ljFroYVQaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=inxzjPlD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so107560466b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762517009; x=1763121809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0SUZOwa2DoxMDRc3rqTByEvMDEEitrrZ2mKWUz1yRw=;
        b=inxzjPlD/tqPM4cZTx3QeOfVZIMCjxANY79Ec3mLhl/pE6VAB3Igg1GSFytXnS0hLb
         hZNRN2LdkMyT4MMmnOD8gxOdS+xnAppV2lDTqYj6AvB4kkw2sdJ3OHB/H610y2Ozi5Y8
         7a+rxCvjdjM2eP27RWDUSmGwyyYAskTccDp+JKvYXmZa5mQPeWiDBbNlp/GcGxL8qGXa
         a2TZIDXZ3BeIcEztf1Q0raABWgJY5a0/ApAaFXRqau9I6rIBqLhxQhs9tJX14U+8Q0NI
         BcLHRN4Puj63gkKqjJ34EgBWwaPLIKmoDSd7CQcCgtOwoM2Q5DqtRRAep+5h7jH/3roi
         UNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762517009; x=1763121809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0SUZOwa2DoxMDRc3rqTByEvMDEEitrrZ2mKWUz1yRw=;
        b=od9VPEDwuDgQMK0k/FwoR+HKNFdlD1ZH9jOwxmXTnJQJ2xrfUqUJRG9RDEGPcGMNkU
         7UjM9t5KGukDrl3kEIMN2lMLqv4tpr4H/ScD8W4+Hsd1ygyTbRPTfeKVlGfaMkTqGBMv
         zS+o+T5owaYcIGVsKNU2MmzUtDGVD18BCyxVY4ndtPXM5ejPQgc5O4szMr+EbgRGnpID
         72XHBIECqDoSLQ4MgOndwqrxqsyv8U5r+lJQ+r4aq/s2GLpAT/8xISLXZSjA4BsTtA4s
         Utv6GCJhHyfWyEBxtxjP8K3S6zYWzMa2JC7kfHV5QJVjyM7MwqoIvnw8z9d/lDPWckTT
         Z2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVHSC+4gyDfxl66vPPkzhmKtG6YdouxeE6wZdy3VcSY4fmU140TMHTgqAdX27y9k6JE78+I0UMKhedqD8D/RV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxgGyIwszBauuo80ut7MJrbmlTp5TeEpfOpHL3BgMevqjIsIQ
	lKsh5Q8003ZNKNKQRdubmGu0crhhBoeeojAwEwlwyHtWM3yKt7YNV7FfnYU/dnCvRyD7oTtTAoS
	GGvQJMUNzwPXca6xB5AUNIENxE3vrrTLf9t8NWqzd0g==
X-Gm-Gg: ASbGnctqKnvMJXMId/xGYlr5HFH2EYFCkf37XBMUbyzIqp1dnWj0vdGkUhhGKh08j5a
	DeSMmLzcbzuA7/+w2DG6F26k5mvu/TVnZzAqKAsnA6cmTZTiNyiMVrkdx03hQAAZxOkrBnX9/jq
	7nk2jzaQU2P1MGqXcmlaRz7YG2BfolEGmk42NUuAXC2bW/san1bWi/dNH7bnp3hFTT7Ch593qcj
	P6B9DTVjWyTDuU7RP5gLAGUkbwzge8+g3QFryoDCeTfJyO0J/a51dx1DOKcJyqSM7CW
X-Google-Smtp-Source: AGHT+IFqhmWJ0cizgg2FabCJ2Y+psCwYYmTaIqkaXVpc8XQgBzLaJv45nRBMIXurahATrE3jLrd63/YppCZUaEvDwmI=
X-Received: by 2002:a17:907:1c0a:b0:b72:26ec:c8db with SMTP id
 a640c23a62f3a-b72c0ae2034mr313773866b.30.1762517009090; Fri, 07 Nov 2025
 04:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
In-Reply-To: <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 7 Nov 2025 07:02:53 -0500
X-Gm-Features: AWmQ_bnQfOkuuqF_U_UCQyVPI35A_f2RSjbVr-3UOfrbEvw6xE0HnRxARqEhO_0
Message-ID: <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> > Hi, Pasha
> >
> > In our previous discussion, we talked about counting the number of time=
s
> > the kernel is rebooted via kexec. At that time, you suggested adding a
> > variable in debugfs to keep track of this count.
> > However, since debugfs is now optional, where would be an appropriate
> > place to store this variable?
>
> It is an optional config and can still be enabled if the live update
> reboot number value needs to be accessed through debugfs. However,
> given that debugfs does not guarantee a stable interface, tooling
> should not be built to require these interfaces.
>
> In the WIP LUO [1] I have, I pr_info() the live update number during
> boot and also store it in the incoming LUO FDT tree, which can also be
> accessed through this optional debugfs interface.
>
> The pr_info message appears like this during boot:
> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
>
> Pasha

Forgot to add link to WIP LUOv5:
[1] https://github.com/soleen/linux/tree/luo/v5rc04

