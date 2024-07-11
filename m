Return-Path: <linux-kselftest+bounces-13609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F992ECE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DE92842D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1D16B752;
	Thu, 11 Jul 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5NLKWQg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456915EFB8
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715838; cv=none; b=MaNtwjtgGKB0M6BG7bz+/WJUuKdRvjtewN+2AVPd6e1LP14VRHj7UR4zcT6Edp4Avxb8cgJj6MJJSfvQfiRtKidzlalBwZO/BIhlBsr+A9jM25AMWU2ICL8DZs8qoev5SpcXiRkkyMjMRBOa8LZqdOEUiuvYxTpkM+vaERPVzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715838; c=relaxed/simple;
	bh=sw6NFyAxPQG9SgoQi7ntnSGcBxWYo5n661eTkWI4QWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCj+0CpzJeOpRuLZKeRApwcbJf+jTk1pSC/BjTAEak19vFYqQfDrgm1y/hDc9Clrm7WEL9CDvZ8PnoSLKbh6qk0omdPrup6SYNWKit3gYhBqf32kK76rswM5w9DlUoR8KWJwVgG8tRkNVr6YEWx2iQouJuqKPUul+0wZILZovPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5NLKWQg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so14193a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720715835; x=1721320635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sw6NFyAxPQG9SgoQi7ntnSGcBxWYo5n661eTkWI4QWw=;
        b=x5NLKWQgdpI8BU2lMvIZR+YefWmDNXiWA18f5pJ/BFVeJry/UwipyQBna+TI9M478P
         D8l9AfU6WgZ9eZA1cvvKNzw5bgf/6NYKYlTL+AXN5TbRtKhIKOM6nrso7kli0PJgmZDI
         3B3hb4yyjltlN/VYC8LN5LxGKR1EV0DaYiFJDvVDqhaqUS3Pq0mwWup8gCPV+M0Z7jna
         s1IXdReJCjmnjn8UHIfoBSXJmZD2yNwSNuUyNCaHGAlVOS2QOArBRRAOL/Am+HHC5iYo
         XFppMX8Zegm35v04L8ZBSptCh9P6BcIftIvNXJFiJcY2HSHPd395yEgjpflx50ZyyRhC
         2HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715835; x=1721320635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw6NFyAxPQG9SgoQi7ntnSGcBxWYo5n661eTkWI4QWw=;
        b=pqiJYfErrMaeWAtFqni4cAk0kATLVf8puRqAVVHitvzcECR8RmQOvRPA4BIQCxQ2Sb
         o8BJrTzp6RyN9FtyMtyEFA3GJf+4IH9Vpy8c0+wU8My+pq2i1OHctFkMu6w15yOqMoYp
         xl/Oe+9hr+XuCXqV6pjfAyWyjCKqke0rBk5axr31N6/iXTHBNge7TFIYWig6Tp0JllnE
         vqDdq4NGMolZTMhjjrBEIO0uoRda7bdo2hijP5SxM94cGEODZM+RQ3I0hYFMJuwxvspT
         5yqB/qLt+TlRFSZOjqinHR24JQB3ypaaO3WF6yFw0HPAGeUyGbf4RCyAm5eMEDX65uEE
         03YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPM2ohcmwVPLAFRe+okb5dELo3Rekkzk/z2MJ9z5xZGGrBrhufh9GluIyFSYdq3W2dSXRl9ra4aWRTITs9JZTMD7HbiV2vvb+9l9as3tD4
X-Gm-Message-State: AOJu0Yx5STJb00hZjw7UNjN7tMuRQCpRiPAce5+FpdDNBCdEc0fTVCpI
	Ahawcr6hhvWt+pCQoaLZz8sa1LW60RLuVwEyKKI21+/CMpfWmCmF89wD4dmGJ6ge+f8JlQ+Go9f
	78wcdaGfV+WeZ+gBFAx81FKCB8eMp+G7KSVoN
X-Google-Smtp-Source: AGHT+IHtiJy6OQLBWRW4yKIdGNf4hW68cJ0U12QD5JO4a+6PpsB8/9axlkrzIp2dh9e7/SRf3uk+kBQCmt5TOrC2LLw=
X-Received: by 2002:a50:9eef:0:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5984e518b37mr207048a12.5.1720715834639; Thu, 11 Jul 2024
 09:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709182936.146487-1-pgonda@google.com> <c0faf3d7-2589-4c51-a3c7-4e4a33c3baf5@amd.com>
In-Reply-To: <c0faf3d7-2589-4c51-a3c7-4e4a33c3baf5@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 10:37:01 -0600
Message-ID: <CAMkAt6rk3r4gdoynEmOhZvsQXav05VNzg1G1WJFBvpOJJvsD_w@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Add SEV-ES shutdown test
To: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Alper Gun <alpergun@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I guess this case also applies to SNP. So maybe once this patch is
> queued up I could spin another patch in my SNP kselftest patch series
> that parameterizes this function to test SNP as well.
>

Thanks! That sounds great. I plan on sending a few tests for the
sev-es termination codes. I can base that on top of your SNP series.

