Return-Path: <linux-kselftest+bounces-6332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F8087BF8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 16:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676A41C2281A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CB7173B;
	Thu, 14 Mar 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y78bywA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850A70CB5
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Mar 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428785; cv=none; b=Jjl95gyCPP6N8JarlFmR2D0aufmtMOnC8QcUh4jLzgXzAfvHy0vAF3i7izZq/GSE87Zg8GOESixetKxvJ5w2bqujHCA5hwbhabPT4r6P3JAu+uH93pET7KZD1Xov8Xw1GI21OUqd2/LOFLxQO30AcSJ/VeDyPtPav2GqB1uY4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428785; c=relaxed/simple;
	bh=qAF098DlT+6JM10nDKjNTf3V6FncHjyrZW3EwN8ISP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p38H9S5F0HnD6WF+8hXcXzRa2bx2+krvOmy82Zv0sTn8afxKBE2oiZnREgpyqXqAUrc0H49ee9tyiWNr1rPzBkPQZtpsG82ioz0KV4hu/V1R15rCSZR2PijSnuFHbn1nCJU6H0D8HdhAKW3x8UBASx5vfYr/ni6PLfj3IuTgGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y78bywA4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1604603276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Mar 2024 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710428782; x=1711033582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sHqI9hK8jeRVoeWIaG19PRjQ47Chrrt5p/7K3x2jvg=;
        b=y78bywA4kP1dXfRwd6QZGbKseNx07BaWLN7NpgvXPEc7TolnPbu+AGurVRJ89jEJv+
         ezd6+mLLugczmiaAVi79SmFwn0JwzjAKg4lL/TQvc0JZ6KwnH9fLpGJtnR41C6+adgK6
         EEbho3rvLl9nI168yXo9Q0oPwUDBXXE/njID7+XQnw16uG9W68akYqZw/yNhlaJBRKPa
         oaL5qmQB+agKGRVnClHD/rs3pJMQvV5yeKtlGAXVvw2Pc1662i3ZOiMTgBAXKn6euak6
         UEPYi3rVy76EaIP+KIGOhO0KGbiYQxWLJt/J3njX1FgfZxG4YYqu2/X7WQZlBPbg97jw
         CG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428782; x=1711033582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sHqI9hK8jeRVoeWIaG19PRjQ47Chrrt5p/7K3x2jvg=;
        b=MhNShTpnOgzsnwK30ZYgO/IM4FHk84+l6IPGCDJmqedgUYwdln0VuhrnPku6DtIrCG
         95tt0JnEo6r0nWmgRI2wZdkX6BgPi62C05GAstP/3kxMEeTXuEgq3fIlyiyRALnSc6G9
         JRr7y+jkkT0P/on0TMpYzS95rs4P23wEZYO+iPmCIwBnmlph5zNxyzPH2iYqOBEH4PZH
         6pcoVdKUU/YsjBcw651MSKcuQ/540M1/ISDj2UlvylibQQ11GOiQgYrOvnWO7XGhhMnM
         2CX8RqRCxsiHb/NVzIG6pWqmj5mWAd/Zt8aWkxbvRhW2L3DvK2QQhgadO2lEt3LdVpqE
         pLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3lfwstkh3hXF76Sw5gLsq7TP3ysZYsCyJB/4VkoOaoDpHZ2sHP/of1R836MseBB0SHz6rt9zZ2wVWnKEztxwmDgdZKJrb642wxdQTDPnR
X-Gm-Message-State: AOJu0YxvfFn2B2OGsWMbl9gtQgJkyScDwoA6SeZ2oAWNz7PEY23GngCz
	Ot3zXKY02QerSXZ84y/hcgEIPFo5NDDUv0dgvdGlfoguuDtPt2JpTcZiJ1rrEtxOQl2s0Fc0lVX
	F6w==
X-Google-Smtp-Source: AGHT+IGIHnvNXsJY+h0Oj+c1Jth/LNRun/lFwuFNkYAKkEBK1aH8bI0QN3CxQRqDBwbgmhCUDXK2Ny6/WBg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2510:b0:dc6:ff54:249f with SMTP id
 dt16-20020a056902251000b00dc6ff54249fmr543415ybb.8.1710428782630; Thu, 14 Mar
 2024 08:06:22 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:06:21 -0700
In-Reply-To: <075ff472-67c7-4cb1-a344-9c1066821eb4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307054623.13632-1-manali.shukla@amd.com> <20240307054623.13632-6-manali.shukla@amd.com>
 <ZeoF2vfrUMCja0x7@google.com> <075ff472-67c7-4cb1-a344-9c1066821eb4@amd.com>
Message-ID: <ZfMSbS1oalRPZ-MF@google.com>
Subject: Re: [PATCH v1 5/5] selftests: KVM: SVM: Add Idle HLT intercept test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 14, 2024, Manali Shukla wrote:
> >> +#define VINTR_VECTOR     0x30
> >> +#define NUM_ITERATIONS 100000
> > 
> > What's the runtime?  If it's less than a second, then whatever, but if it's at
> > all longer than that, then I'd prefer to use a lower default and make this user-
> > configurable.
> 
> It takes ~34s to run this test. 

LOL, yeah, no.  That's 33+ seconds of wasted time.  From a *KVM* perspective, this
is quite binary: either KVM intercepts HLT or it doesn't.  Any timing bugs would
be purely CPU bugs.

Please adjust this to have the default runtime <1 second.  If you feel strongly
about the need for a long-running test, feel free to add a command line option
to control the number of iterations.

