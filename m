Return-Path: <linux-kselftest+bounces-857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4757FE65A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 02:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C61C20BD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFF6FA2;
	Thu, 30 Nov 2023 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLCQLMre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A710DF
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 17:44:25 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d015cec74dso5144305ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308665; x=1701913465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lln3JA/pL2zNGG8fnWXWFxt/sDS6XmKq9CUbeWSzI+U=;
        b=hLCQLMreGSsOJb4PEsjjAZX5OBqORQsQ0vhdiAWLZuioy3zTgy6oGMa2s8q+PXMQjA
         OFnirMnv1WQLWdKgACzf+kmNQvDay62Wm4lkfT/2oxPEr7B8otAMdBSSQNw2Kr7ubp/T
         LZnr5wQYJ13pQb4fosgsUqgNv5q3naAnV/U7SDItKHLf7/d4/dH0OavYBrw6IQVT9hWn
         wut9o0kRv8aVgNWaB6VFrtFGVXvyOgXBg6rXqob0GqRUw3jPsw7ICIJ7Tg71PRimIi9V
         zt29wgc0MlnFkhqTAtblLgwPqTIGHqDTeuz7oGxFgo5qZjsg9dAJ00+2C2VsG7JdIA39
         xrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308665; x=1701913465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lln3JA/pL2zNGG8fnWXWFxt/sDS6XmKq9CUbeWSzI+U=;
        b=OiE6LTCUDi/dBtPygs02Rp5NR2svGMvyDHevuvosn4B6ncSRYKHKkLYs8nZDGkuXHf
         MAd2ciCoiEFO3ybVtPt+rOKvenfXPZ2ZtAUSDmEPp1f6uh2u7bdu6ZBeQPE7C1u0HeI0
         lNo1MkTLVJt0Uo6cXCYUvvtNSK6vPJ4KS1KpuZ1HBmWBuvyne/DwLPLPfhSF3JWIUoyI
         OfO/IiRUP2cqIh5Jq5JgC9pAanL7eubtQPphap93TMrbvBq2AK32h3V7bqO1i887+M5i
         kefIuzIxU4aw/fqAzYvEeYlLqpEImJ3EkiRViw1LaiKP2l2tbrTYLTvZnMfKUfk7LUP8
         FFGg==
X-Gm-Message-State: AOJu0Yyz1TiAfHOPVAik9cqIhup5+vmLJNrcfh26BKWXkZNupaXbw/jq
	sxeQD90xIoZ3w8ZYkJSR78HJhE7hYv0=
X-Google-Smtp-Source: AGHT+IHhXzzYXOzUBShDv5PGX0Z4/O+DwcPcBk7HaqSRWwv0r6E6VgrGl95aCT63qnVH61WySbFupvW1SnI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:452:b0:1cf:a2af:ee09 with SMTP id
 iw18-20020a170903045200b001cfa2afee09mr3891848plb.5.1701308665015; Wed, 29
 Nov 2023 17:44:25 -0800 (PST)
Date: Wed, 29 Nov 2023 17:44:10 -0800
In-Reply-To: <9fc8b5395321abbfcaf5d78477a9a7cd350b08e4.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <9fc8b5395321abbfcaf5d78477a9a7cd350b08e4.camel@infradead.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <170129774172.531444.5273351479240082811.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: add -MP to CFLAGS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 28 Oct 2023 20:34:53 +0100, David Woodhouse wrote:
> Using -MD without -MP causes build failures when a header file is deleted
> or moved. With -MP, the compiler will emit phony targets for the header
> files it lists as dependencies, and the Makefiles won't refuse to attempt
> to rebuild a C unit which no longer includes the deleted header.
> 
> 

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: add -MP to CFLAGS
      https://github.com/kvm-x86/linux/commit/fc6543bb55d4

--
https://github.com/kvm-x86/linux/tree/next

