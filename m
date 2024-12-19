Return-Path: <linux-kselftest+bounces-23612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BF19F823A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9075A166301
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB119C556;
	Thu, 19 Dec 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2l4WGbp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A281A3AB1
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629993; cv=none; b=l36RqFjoR7/rPMGoYZNSKNiYgO6GroaiNQ2P0MSMmO6HQANRYgOsJnpXXHWE2emAvVWLXl9HUOE8bsJHHWb6pLe01bpxn2sqegXc5RFfK3pEnOaa575/89RFRY983TN8068SficodhKdmS8FmLnRcuPU/pUWWdFoZZGIRpZxxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629993; c=relaxed/simple;
	bh=GR/uWJKqfuUptg5jQIG1vCwpxee3zz95uINQM0tNaBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9khExYNXLl22ignrVOOfAWvUOATLe4rAJnmY2EHYAM/GOqRuaGb3nKY1dnUbK54P6SmMD7WI18a2YBEIKD6d3a9KZ6ht6gOnPPwO2jImj3pmXkcgqOdA/PQjOYBP8O5+S3kVaSDGOmFWAB6q4UoMMb6cTio7EfYIT5swW3XZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2l4WGbp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fb966ee0cdso791599a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734629991; x=1735234791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y29xOEEZNaf8fpYWw+CocgTMeTOdKZFSo3jDeYO9am4=;
        b=s2l4WGbp3rYYT42DObUkMQEnbjFxPu/03SEgXWXt7gsI0YApQ5f6qaZRf3lCVVzVSr
         Dl7wzpwt3QC+sRdRMiFfkbhm9neBxebNX4mHVcGissbuwd1cv1zPHq68C5xneQM50ZQ7
         iYEdV6TB8/QflcfLBQSssOyGm4NV7BiUd3l/kkf57ZXidEdn4pSIlU2xmB8kD5m9btL2
         oQsKILXDG7NZ5WFRElZu4TlV0NLOB6p6Ex9f7G3f3HfLv1MLabcayaA4Tuh7SKpfobi4
         fbesYSX+S2Rd1A0fTBt7YF6PzSvpj0geG78HDD2MxW0hcSZz69ph/g1RwH1/S4TQkGik
         mtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734629991; x=1735234791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y29xOEEZNaf8fpYWw+CocgTMeTOdKZFSo3jDeYO9am4=;
        b=qur3Rt06N/HP+JszGe7WwkBd0VAxwUB9G/2gEeLMEdTnUBlen7Wywy/MI8tRxocZYu
         whX30/1Hu8HDDd79vfsioZGHzbLrDaCs1imqmafRE6yIsQF0fkus4Ed/UW/JknAArPGO
         8WdXTZ6W1Bd8/koxs5Gi+l9j0PFBd1MzXtJPaE5pvn7R/GY4T3DUfqIaOEAOownwYMYw
         NPVY2wRPbz16y08MSSq1jtsGJtCPHTREqmQmzmx7VGyoeh8XxuwhtQP76GC15XeGO0cB
         Y1I7eedoMhqU/RYTor1zjjGmJRwIpSuoKvKIcKwhJrXOhNtsZ/112VOiW4Lpdj2lkpXB
         sz9A==
X-Forwarded-Encrypted: i=1; AJvYcCVD7HIr8LSWNolgroPUywXY8zX6vwR954P5XXIoVu536J1DQQJUKlSNmLf4aJdNefo/tZSZAkDEFzztm+I3m6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOUzCB6kyZUN5EDtV51xwm/iUu9Ey/i3MpJZFNHNmGuyTvtfH
	kMBDWQSZI+CwZ2g1bdHGLngQx5s89XQbbMXfksuQUlmp5eJG6BMPe6pC24UwMo6UUUjxVgDJHLd
	Yxg==
X-Google-Smtp-Source: AGHT+IFpj2bwQM+JLjr7NiNYlO/Ef9GyFhIRSDO2fxXKeXZ4gDryavMs3JKpTqLzIS+ZG5M41xb1W/wmJ/A=
X-Received: from pfaw12.prod.google.com ([2002:a05:6a00:ab8c:b0:728:e1a0:2e73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a28:b0:1e1:a920:225d
 with SMTP id adf61e73a8af0-1e5c726570amr6997092637.19.1734629990745; Thu, 19
 Dec 2024 09:39:50 -0800 (PST)
Date: Thu, 19 Dec 2024 09:39:49 -0800
In-Reply-To: <20241021062226.108657-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021062226.108657-1-manali.shukla@amd.com> <20241021062226.108657-2-manali.shukla@amd.com>
Message-ID: <Z2RaZd-5jtnsfFDP@google.com>
Subject: Re: [PATCH v1 1/4] KVM: selftests: Add safe_halt() and cli() helpers
 to common code
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 21, 2024, Manali Shukla wrote:
> Add safe_halt() and cli() helpers to processor.h to make them broadly
> available in KVM selftests.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

The whole point of adding helpers is to use them.  I'll post a patch that adds
all of the helpers and uses them where possible.

