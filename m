Return-Path: <linux-kselftest+bounces-21442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C339BC4EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 06:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6997F1F22251
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 05:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2D1B6539;
	Tue,  5 Nov 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxQJwWW0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FD383
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786025; cv=none; b=PeBjk66IQL8S9w1WklO1CC6piXhyANFMU8YZs7gOwDhW3V9xEZ3OmzfhsfzuJ4d9QSZSoOQQ1LKHlLTT9/PdIQpiyCGPFduqNI6RiyN9siwZFHwl7hjvmHQY+rmive/dLQvYKBMFjMYzODmLHnet4R+uVQw26l3S6pftzftVWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786025; c=relaxed/simple;
	bh=eFIgYsyVXpLfwNZ0WDZ01Ek7Ywd6Wo8hby6mzO9UQ28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bK//40h0L4w7lmrWHOPJJc7QGOPNh3VfDd6nPcobqbcvoxAJKHVfQiAd11jFqoV8Rv2c4cxRhYZEXwI6xGSKlU8hNwjGPQN1O3B7ir9pJ3xAEUmAYht3YXkrB0kHBRWze4u/7dOavxmZRgBzEZ/Nl79RXr7QWTnYHPNvD6PtIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxQJwWW0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7edbbc3a9f2so3488608a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 21:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786024; x=1731390824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CATQgkxqet+kiiFl27IyAPicUnMOKGQVJB4zHUMIsJU=;
        b=WxQJwWW0bBorU/RgtNaMe/adMlP+7npWNLuq4eubpBdbJE0XBldq+PudesMj1/17MM
         FFU9uKodsG4EPHCPn5NjZackp2T2ltuinh40BUYacp0sQuU2yzD2gYR4n59TDucxGnWV
         0xMB9XYH7mDY9Ee7f2jUIC/wz7jBNqzWnK5HmfCzaiLF+FPwWjV2OiG3hKPZR6z39JX+
         i2YehwmsULwsfbyN6ehX5pyLx6Gcm3aagbCl2L9PgWFgIs8Vo2F1nUcJeFwnycf8We63
         ImPEadZ5hG99y6KtG94zt941YT+/awVjM3uK7rEuVBb7gpMGSy09KxUAFqYJvuk96B/S
         vPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786024; x=1731390824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CATQgkxqet+kiiFl27IyAPicUnMOKGQVJB4zHUMIsJU=;
        b=woWiPOF+Zm0YSQ3z2gFjl+zLR28Z5hIrVRbJfXXkaQZ4ljHw+whKTjZ9mtoDYqjrgv
         AHZvQl2KeDyI3bO2yi8DQLDpCkNs6W/qg6lt0kxRST4ygTo6/zYA3pnwoWSt9/zQOo2m
         9ZJ9zbdxY+2GQTLhieIcldw9Wura6iNLX3YiCOYb/ipcJc5XpZxmGGgCJByYgq46UXx5
         HPT85BmP1RFSNOqyOwysvgA3KhSz+ardOIDIcO2+3U0E3TDETTI6hwtL7IbuNFhgbgvm
         LwzPL8LiNIkPwX+BNkbAkirbFT77aeZRQhng5/Vi0h9zpAD7jP0Fl2QaBsMm556J1yTP
         bzAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUFTBThh6/B9ZkUeHIoVFlOAsEcXZjIB1X0Z/E2vZfzTZcrAOIRvOclWMqFtQWxqjWk+ZjoZERILRXiVHPZFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyNI1zZR2oPIu2AES/h6T8LxRw9xOjnIwGRoQRSorwi7ARr56
	G3f+lSWX4lhyIEGk3k7q+OYO+l+3U17bWVhOKbCzOJD23qgDKNirTT4s07C2NU8RdUMVn9poBjX
	v8Q==
X-Google-Smtp-Source: AGHT+IE6j+o01T6Bqwps+9UMPoL+PueNwC77slv8kXJ3ii1dNkE6QY41DyYsvleelHQM84FbAugxCqQ87JE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a65:4389:0:b0:7ea:618:32b8 with SMTP id
 41be03b00d2f7-7edd7c9109bmr51755a12.10.1730786023765; Mon, 04 Nov 2024
 21:53:43 -0800 (PST)
Date: Mon, 4 Nov 2024 21:53:42 -0800
In-Reply-To: <173039504313.1508539.4634909288183844362.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024095956.3668818-1-roypat@amazon.co.uk> <173039504313.1508539.4634909288183844362.b4-ty@google.com>
Message-ID: <Zymy5hjgMSMT64uI@google.com>
Subject: Re: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
From: Sean Christopherson <seanjc@google.com>
To: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Patrick Roy <roypat@amazon.co.uk>
Cc: chao.p.peng@linux.intel.com, ackerleytng@google.com, graf@amazon.com, 
	jgowans@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Sean Christopherson wrote:
> On Thu, 24 Oct 2024 10:59:53 +0100, Patrick Roy wrote:
> > The loop in test_create_guest_memfd_invalid that is supposed to test
> > that nothing is accepted as a valid flag to KVM_CREATE_GUEST_MEMFD was
> > initializing `flag` as 0 instead of BIT(0). This caused the loop to
> > immediately exit instead of iterating over BIT(0), BIT(1), ... .
> 
> Applied to kvm-x86 fixes, thanks!
> 
> [1/1] kvm: selftest: fix noop test in guest_memfd_test.c
>       https://github.com/kvm-x86/linux/commit/fd5b88cc7fbf

FYI, I rebased "fixes" onto 6.12-rc5 to avoid several pointless conflicts in
other patches.  New hash:

[1/1] KVM: selftests: fix unintentional noop test in guest_memfd_test.c
      https://github.com/kvm-x86/linux/commit/945bdae20be5

