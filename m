Return-Path: <linux-kselftest+bounces-1440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65B80A8A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0571C20909
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1D374C6;
	Fri,  8 Dec 2023 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGS4TmoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94019A2
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Dec 2023 08:21:14 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d0544c07c3so14808925ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Dec 2023 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702052473; x=1702657273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn2js7FD63PZPF5/U2hMAUmYqMluIo8bm6m0EGWnrq8=;
        b=qGS4TmoY9gPpC5+oOBgbzik/oBUuVsjqWviOS/YVQOdiL1QEWoKLdDXb7kbKeA+6xi
         EcFpg1+JrRUdHhqp6YJ4Uf/yoBEn51RNjghzDZZPtaJNitLsyNHm/oIFngU7ItCtUUXy
         3EtiqdBG+lL5nqKiwSOb2CATFZgqjYJr4FAlYIQFUWdEoGcpwWu4WICDfwiVaxB9gGTW
         pWPnr2vE0cK26rYSMWJGH3B4jVFmdPP6Kqw1bLa9hiQ5asORfbSf1qHP2s4hpGTBEtA4
         N9ejwWw/e3vjSSXmQg4gFPYWbd2xbppQyeoZzG7AT9KDQM/efhmYkOphgxV38eOAFPsr
         87VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052473; x=1702657273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn2js7FD63PZPF5/U2hMAUmYqMluIo8bm6m0EGWnrq8=;
        b=vjQYtNGOwagSBwTIY+FCu1AVyrIgrY8Ph+cGs7v2gdYfhgQ6/AObK0giIe++KbrBA4
         w8XQVPQDPL521rKz8LppmafcbIL6HB6pZtACdXz9iUbUK9Jr6XV9SccXOPBJzlZ7L3xF
         9o76haoyyIbfOme7Y4WGVVuha9lYF1aMtVEDF2QfbgkSTDr9lYdibh7ZGjqapODUEdcK
         KBBQHhY4GBLaKWzmWihfKgXJup3bKxJjlMwOFGDCwHzPI7BJPyQg0WLbHVI66dQLdHdO
         JSET7h0T+6h/8fYBuDiQ4sY+lM5Izx29JXuRxwlVgMw+RjiEjdQfnG917hBPRLvnYoP8
         b3EQ==
X-Gm-Message-State: AOJu0Yw+i2T0IGr77GjBEv4ZkRAyY+xMD5UZMvVNBq/0NE0UL9qPIYrt
	c4sHmwXYKBJkTR2qk08FUTUO36M0Jzg=
X-Google-Smtp-Source: AGHT+IFWQtVJ0r4eHGvVtUIeVYSgkmqQlzHfiGMIkd/nLI8qwI88lt5tQTOe7hJPAwvkVngG53ghJy8eGhM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e804:b0:1d0:c2be:3d9d with SMTP id
 u4-20020a170902e80400b001d0c2be3d9dmr3772plg.7.1702052473502; Fri, 08 Dec
 2023 08:21:13 -0800 (PST)
Date: Fri, 8 Dec 2023 08:21:12 -0800
In-Reply-To: <20231208033505.2930064-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208033505.2930064-1-shahuang@redhat.com>
Message-ID: <ZXNCd5UKYS_90xAD@google.com>
Subject: Re: [PATCH v1] KVM: selftests: Fix Assertion on non-x86_64 platforms
From: Sean Christopherson <seanjc@google.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 07, 2023, Shaoqin Huang wrote:
> When running the set_memory_region_test on arm64 platform, it causes the
> below assert:
> 
> ==== Test Assertion Failure ====
>   set_memory_region_test.c:355: r && errno == EINVAL
>   pid=40695 tid=40695 errno=0 - Success
>      1	0x0000000000401baf: test_invalid_memory_region_flags at set_memory_region_test.c:355
>      2	 (inlined by) main at set_memory_region_test.c:541
>      3	0x0000ffff951c879b: ?? ??:0
>      4	0x0000ffff951c886b: ?? ??:0
>      5	0x0000000000401caf: _start at ??:?
>   KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x2
> 
> This is because the arm64 platform also support the KVM_MEM_READONLY flag, but
> the current implementation add it into the supportd_flags only on x86_64
> platform, so this causes assert on other platform which also support the
> KVM_MEM_READONLY flag.
> 
> Fix it by using the __KVM_HAVE_READONLY_MEM macro to detect if the
> current platform support the KVM_MEM_READONLY, thus fix this problem on
> all other platform which support KVM_MEM_READONLY.
> 
> Fixes: 5d74316466f4 ("KVM: selftests: Add a memory region subtest to validate invalid flags")
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---

/facepalm

Reviewed-by: Sean Christopherson <seanjc@google.com>

