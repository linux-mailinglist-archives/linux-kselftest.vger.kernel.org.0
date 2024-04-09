Return-Path: <linux-kselftest+bounces-7495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1689E00B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14691F24019
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5713D88F;
	Tue,  9 Apr 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STelNkvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5D13D885
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679008; cv=none; b=HlA/sqRXonkCQHhrlqr01gIXirw9GYLcfyG9Yv2B/fN/8bUliaFwwXgq0O4YBYFB9uuxWDjQ4Fc4nGA+8M37Y5cKSYKp3wcMXgAU2CWCbzhYdRQ+uPRopUOSjtbHSpjSjVWQxY9AEH+5OlUFbdfSW2qwWEOBtFVl+sG7ik2t+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679008; c=relaxed/simple;
	bh=L54kcvC7tM5k3CHEDDLLg9GL0uS3slGoj9IlpaeX31c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=olFHfx0IF2DoLnMZPL4ei8He4tFcxVDQxc0rH7Q4tM1UMmMVIjBwY0Yg8moULF9y8oG87RYDiN3guwKOaxp6KBb4Qv/M5E+gA1D8f1+Smk3ZY/ll4F39CM/QPyMIYx5o2pBzD4T4B4H/cOu2H4oV6A0nrv2haMNGP+CWIBasqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STelNkvp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso8049985276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712679006; x=1713283806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzBA8vCpg1bQoyDxMrjJAPBioScXieCvpaS67N6E3s=;
        b=STelNkvp2N8Jd5d84GuyhHp6kqSVAW1feJpsZMatiLuhHAU7nAVYJ5bIOpOQRufdAX
         nKrai2HEUa3TCCqEOynm8fh0JFSTzxbMYL/SLmHmXSzhcb5q1/Pwh1odwl5hF3G5CFI1
         /JRa2A3588CE3F+c8RbpETqB+tjE0Dp3CjlHuSQju4mMQr89ZgbXo0g32DUCeq4T/+ny
         bai34qX6u4PnOJ/zP3CFQJD2h9IgIAyxe05mVvhUWbB4iwiIcY4+S0UNroDPHFy3RCMK
         UnWgzK/w0SMsmgc2hJO7HjIi9v8AHNHHX5CpC7AoySgPvNqn/CUtqiphLRICRBgabq4Y
         ur0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679006; x=1713283806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzBA8vCpg1bQoyDxMrjJAPBioScXieCvpaS67N6E3s=;
        b=ar3c2QjajUW7n5ANJqvEP9s+9Glx4ukK41viF8Edy6YpVuCwFy0G9BsMGa3nC5HM0E
         qyE4uUBi3W8x0MMTeiF6DoOVA4hcc/ZY6OobKbk9cKsdZXHGZTlGmkxJ8qptsm+pdMXl
         RmkA6QCWfDnYhmuLPzG5YAkwECiahPzW1PE29/sZfL6dclrAKjsJyJ+UjlCKxba2DAya
         0Dv3WVpLTeXHBOAY3wfczQlPfcDUomEH6WplwJ5JgROusabyO3CoRJorioseq80omi7C
         MGY0txIY0hIDVodzNQQeozSk5TwK56ASVzBONYvkGmCinpDvMpQ3DVTYDWiFuKiuplHo
         oSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfyZO7jgPiOB3YGl8RIsK1z6YzcSEPuF37lTYUfpiCXssYsNmgTeFnVHDSJnbaPRg554fcpqiYhk+wDqpp2744gGpuekb80feZXeE+tysA
X-Gm-Message-State: AOJu0YyzQMkmkAs166KObxFOgwGM6nxCAKl8Z9Lx/6IOe7AhZWey9dnU
	VmAglWKyX2zMZAMkjLgdX8RMq7aeq/WBJNKvvVM3PGcAQENPt6n/dQGuXoUwtsWNfQ==
X-Google-Smtp-Source: AGHT+IE38beRAL/GyZV4u501PGP7OFfQCcNi6umKaAXPP8K0ga6UOvT4QIR9eYTeiccqjAl5Tf1y/Cw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:2b88:b0:dcd:2f3e:4d18 with SMTP id
 fj8-20020a0569022b8800b00dcd2f3e4d18mr14472ybb.12.1712679006109; Tue, 09 Apr
 2024 09:10:06 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:10:04 -0700
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409031549.3531084-1-kuba@kernel.org>
Message-ID: <ZhVoXIE9HhV5LYXV@google.com>
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf to net
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com, 
	eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 04/08, Jakub Kicinski wrote:
> The test_offload.py test fits in networking and bpf equally
> well. We started adding more Python tests in networking
> and some of the code in test_offload.py can be reused,
> so move it to networking. Looks like it bit rotted over
> time and some fixes are needed.
> 
> Admittedly more code could be extracted but I only had
> the time for a minor cleanup :(

Acked-by: Stanislav Fomichev <sdf@google.com>

Far too often I've seen this test broken because it's not in the CI :-(
Hope you can put it in the netdev one so we get a better signal.

