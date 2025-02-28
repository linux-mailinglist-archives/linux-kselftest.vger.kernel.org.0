Return-Path: <linux-kselftest+bounces-27948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88268A4A6A8
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 00:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77220189C9E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31641DFE18;
	Fri, 28 Feb 2025 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qot7tse1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D221DF268
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786063; cv=none; b=RGCIFD472irGrseD9m2Yz4eA24dW+Qh0KjMHYyQWWQZYMU3rDQhgazTy0Udtb1zuVVJ9BkfmSfU1qp0+L25b9nGudRYIZI3ENPEibR4yWiccO5HtC2LJwOWTnxLnEclVMeT577IxZjNvH9+ijiA1SspO+7zDaSAZYRKVkafHy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786063; c=relaxed/simple;
	bh=czHtOKFbuWT4IFwIXGB3dzoMikaoJb8csCThNc+R2Tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROqj6V9h8wFQxSv1X7U03vhSHOIao/C8wywP2QlsWb3FNEVuFfVHaHzFlQWhkHKdOlue4ueWAHJvHhNrVVOFwd4hPyn2s4IUGP6pVZiiptGSVsnA7pCHTYdsfUZgb+UZirUYt0r7jSdyJnCX9qAuO78+Y5ErntgLLqqngDW8H48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qot7tse1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38b60so1853898a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 15:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740786062; x=1741390862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rd2zkA90OfrPC56kZ5TgBkpFyoSsKiSMEhRKLUnwKE=;
        b=Qot7tse1Mzw2ETR/1mp9X6jcUp3fC+TzmauBU+FMS/A0f65iDRuWYD1LCpZ1K9oVDR
         GrMlgrZlt7755lqwkJHquj/f59KFVmaYV7JDFxWSfk2CUBEUvVPfYMnLldrs/wKCWFZP
         /1zaWQkSapYbGWlPOXGjPwyNhS3m8RLgLjNaDWKJgVT1LNiLVbJSv4GJfMmLnwMj8mwp
         DUQyQtouu9TRfoVvXxd1Fsckj6BM1ZkV/Fid5MX0c5tXcqllCFAKy5T2UJYZILKNQIp0
         XQD8SZMM8I1Ovzqdz0TOhOXo7Ki5kH5JD4CNYOsNCBUtleB9W/AZcHyYEig+onmi191p
         a85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786062; x=1741390862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rd2zkA90OfrPC56kZ5TgBkpFyoSsKiSMEhRKLUnwKE=;
        b=GzEsb74PKvgGOOr2TY5m0Yu8c2C+arw3jqsJ8XM24tMTWfvzyXKH/IdFNe6CJ9DD+I
         FLko082lrgIurJths/8JpBmSOArdzg7qPLiUi8ACR1skYsxwRpU62EnML6NaF5e1IejL
         mxjl5Vz4hunYUdwVuEn5ujIFMxKkYtbIATdh0ep/ZOIdqfDLOFoBRF1nwjeHebCkZhJ+
         I9hcGHJzHWj2hwKxI21sKCl7HlP9S9FOcpF0d+jgY/KoxsUN2PoazbVjxiyFViy+CrmT
         kGywZv3KRewLoWfAiccLRQ9PgLOqx0loPmVfJp7o6hVW22zTSC16uqqHNvBUskjPS09N
         W6iA==
X-Forwarded-Encrypted: i=1; AJvYcCUzcm+pQDv6+zbwIxPwD+UbbDJZgxe/yZ4SGX3SYD+OELN1iY0HN1CUxmrwrhcGI6XbVJbahLx0cwhVRwSN6Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZYbiE+qKYI6bzzwXwYH8t7DesiCTO0XNhnrEc3US0ONtyliy
	rLA6U2cCjH8EGUb0klIW9n14BypWpVQQVqFjH6Y00DSCDjYycermCOHwVHJtoZG9l9hP79+4smc
	5Bg==
X-Google-Smtp-Source: AGHT+IG7CvYyko2UbVPuAkNZZPDFMXpjB4wXlD6Ru8cf7no7JS4XUdhwodgR3HqRriolKmpqFez0BPUdclk=
X-Received: from pjblb1.prod.google.com ([2002:a17:90b:4a41:b0:2fc:1158:9fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:2ee:a583:e616
 with SMTP id 98e67ed59e1d1-2febab3e417mr8593663a91.9.1740786062022; Fri, 28
 Feb 2025 15:41:02 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:30 -0800
In-Reply-To: <20250227220819.656780-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227220819.656780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076278043.3736049.13548260851648046331.b4-ty@google.com>
Subject: Re: [PATCH]][next] KVM: selftests: Fix spelling mistake
 "UFFDIO_CONINUE" -> "UFFDIO_CONTINUE"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Feb 2025 22:08:19 +0000, Colin Ian King wrote:
> There is a spelling mistake in a PER_PAGE_DEBUG debug message. Fix it.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix spelling mistake "UFFDIO_CONINUE" -> "UFFDIO_CONTINUE"
      https://github.com/kvm-x86/linux/commit/75418e222e30

--
https://github.com/kvm-x86/linux/tree/next

