Return-Path: <linux-kselftest+bounces-34587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39574AD39F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31573AA73E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C628B7FC;
	Tue, 10 Jun 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0Yn2Zwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762423ABBB
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563460; cv=none; b=EcJgIrIvoI0p99NG1N/RPQYkY+m2PbVZvsCJmDJc1IJqzFZOjoHwFmcbgQEAFpYQY/btW3/CteN2S+U6faEBXBPRx7NCWRmRyuqk5CKoxXpCmahzlt6QQztm3UcUUi5od8s9+JzYtgu4nmqPAl448aoNsLxTMrP+p+/DSs0ZIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563460; c=relaxed/simple;
	bh=h4S4qXsxNClFRPavFrSL5VPIFTv8rXbohKWGXFSTiEI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bWqrAQvf5Wpz7c910LAp9mQrwajWMQrseMvRkCdJGX7BHHJm87TI/KE6LRL+D5HRURf1MQkAMEpwl+C7DyfIBHAJj7Wc3zODs0jIwdrzQ1NhIpGExDe5C7opqXI94YoKnLpIlfv5ubBwcixsJGKyJjbKvj7tlfBue7I8K23rVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0Yn2Zwu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749563457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8AZiv2BWFM4GhtysbZzbwwVGm/Lo1Gm6qrn3+2ylp4E=;
	b=C0Yn2ZwulvUaDHql3SezRUSKmbP82HvHe8XZ9k5ZU/WD1kxbPyxVdOc6qoItg9h/9lgHOk
	/CUGk6KxH/vaU65oEgR4kPSFP7eNzciDTBbViB2ZXAXzXqhEUyOSPOKriLJiUfUZcsGVk7
	k42gFAozzvvDuBUBWRbMWVKZIipoXZ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-26N8tWS4N96atGBaSPjH6w-1; Tue, 10 Jun 2025 09:50:56 -0400
X-MC-Unique: 26N8tWS4N96atGBaSPjH6w-1
X-Mimecast-MFC-AGG-ID: 26N8tWS4N96atGBaSPjH6w_1749563455
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso33858565e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 06:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749563455; x=1750168255;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AZiv2BWFM4GhtysbZzbwwVGm/Lo1Gm6qrn3+2ylp4E=;
        b=pAjWHv3KQfHQvZg3qJgD+io23sHNSZlBuu9q/o5iUkJM1/8wA+O+6t3NjJA5QZ7td3
         AIDVnlmvF3nzeiD7RCvxHJqpggPwAgYe+CPZ6aaXmfqMnhM5Rnjn6htQIE0Y8QhWOlmv
         UD+quXsWzHqC+V4A3I+g/Wx5Q94DkjRIhhyK6FiV+pBdhFChzSr6iZTXbmFQeOFNzdvE
         Omiirjcw2Bjyby3D6aI3b+v4puEkppx7WfKdzXdB9+zIESlybF5nIAJ9uZEEoLiSv2Ev
         KqxQnX3tmCZkoekcAjYzma3HUnuNqPdWScucgQ/sW2tYMRL7D+f++BTteuigPyPI2fEj
         M8sg==
X-Forwarded-Encrypted: i=1; AJvYcCUSkVS0K0LF2V0/bpc/d/uI5AlgOSBjyOBoMQrkTsXa+cp7VBnsak5uGJPvx+Wq/cB6n5wXSzDP1pseFQg4yyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVyiPjGe275+CagJYOhEIhCl3M528YZae637CmgZsXgbgca5Up
	OabhNswHd893cHyWjdlfDbMsyI1eIbYvWHRYfZfKVyHa0CKoN6/+6fLuvN4VHxiwHOrsfEQ3hNL
	K6mBBLmvSXi4FolZl9psLflDKfBJ1Hxdx50BG0I0vwmTRasB+ir/LU5Dlp7W/W+5sHPEJpg==
X-Gm-Gg: ASbGncsb8Eq6b1C9LLf2DLCWZDJCkhzvtETGlrpyZ4j0xTWp26A6oUEQsHzxp377RXk
	6UkIEqwsTGTfAvGq4kGxG7cDmvg7w91JrCkmVN0gGjvgBsOTK/44yAlsC/QEOfjSfp2QpWGoRz6
	xV6ijloaGTk/ufXvYQkRnmkmzJ25NeDfhOYzafbkSpsSptQHAkZ2dCO2+ebgS1D+B/fkUrdGSig
	8umsauZ1NwBHvlRG0NspKCoI7VQ/K8gKNIN/zQ0xCt5y2gEKqEZ4WXEtBQaF+/eQNomek9xo1Ot
	huejaa/K3hx0NTnxa+q+xb102w11WjLwU7MWvHauYr6dIc7yskMTIExGEsy0pMFnb8EuErk=
X-Received: by 2002:a05:6000:2389:b0:3a4:f786:4fa1 with SMTP id ffacd0b85a97d-3a5316841c4mr14614321f8f.2.1749563455527;
        Tue, 10 Jun 2025 06:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJKrB4JYjJGiymCLMDjzBOek1jTekdNGl4zWkT4PdFepViV8CQdeLU5rPmaZjMcFcjiosmIg==
X-Received: by 2002:a05:6000:2389:b0:3a4:f786:4fa1 with SMTP id ffacd0b85a97d-3a5316841c4mr14614288f8f.2.1749563455083;
        Tue, 10 Jun 2025 06:50:55 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fba4621csm131448645e9.13.2025.06.10.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:50:54 -0700 (PDT)
Date: Tue, 10 Jun 2025 15:50:53 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Miguel Luis <miguel.luis@oracle.com>
cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
    Colton Lewis <coltonlewis@google.com>, 
    Ricardo Koller <ricarkol@google.com>, Joey Gouly <joey.gouly@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Zenghui Yu <yuzenghui@huawei.com>, Shuah Khan <shuah@kernel.org>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] KVM: arm64: selftests: arch_timer_edge_cases
 fixes
In-Reply-To: <B77F70F2-EECA-4E10-9F00-972F6AE27831@oracle.com>
Message-ID: <8f15a5d6-0f73-194a-8fa2-b7ba8cc8c5b2@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com> <B77F70F2-EECA-4E10-9F00-972F6AE27831@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463806286-426200590-1749563454=:18875"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-426200590-1749563454=:18875
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hej Miguel,

On Mon, 9 Jun 2025, Miguel Luis wrote:
>> On 5 Jun 2025, at 10:36, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Some small fixes for arch_timer_edge_cases that I stumbled upon
>> while debugging failures for this selftest on ampere-one.
>>
>
> I’ve tested this test under three circumstances:
>
> 1) Original (!HAS_EL2 && !HAS_EL2_E2H0)
>
> 2) HAS_EL2 && HAS_EL2_E2H0
>
> 3) HAS_EL2 && !HAS_EL2_E2H0
>
> Tests 1) and 2) returned in approx. the same amount of real time (about 12s) although 3) doesn’t
> seem to return at all.

I've never really looked at nested stuff, I'll try to set smth up and see
if I can reproduce that..

Thanks,
Sebastian
---1463806286-426200590-1749563454=:18875--


