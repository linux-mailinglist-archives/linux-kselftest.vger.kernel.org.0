Return-Path: <linux-kselftest+bounces-4243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C384CD7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382D2B27E45
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754087F7C6;
	Wed,  7 Feb 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SU6HsbBY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5327E788
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317907; cv=none; b=DoRGxGtOTJyO3MHkjhdCdQo/iue+QOXjR+MsU14Rsc2bJNiLtazlTGzuoURkhujralcoLiwYlWKGgv5EORqzYTz09WdyeLHpwjNeS+3IedbtG5crZW1Vk++qy/+2kZQGrRCNmWlff4P0T5MfxrZAxPDJikt/9ZtAJDbHz1cMNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317907; c=relaxed/simple;
	bh=fHxvY9j/1axe2y2RH+QTdN9Fl0eA2wK3G26jE5p972U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5srkdj4MnoR7HT7/H9IPbEShLqHwtWoDcogkswdn5s4m85UUtK+7Os5ssw3sY4NzEupfHnfA7fty2Od11+Ua9SIxW1CT//DX4bfkuylX4X/IxxNTJviv8aafSYrD/Z0Qm003ZWoebg/INamsZbigABJ3jZh1oy4HA05QPNI1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SU6HsbBY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so1243493276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 06:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707317905; x=1707922705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=022zwx6MCTM2+vKlsZn6bQvDtEHFbRDoI918KeNrDZQ=;
        b=SU6HsbBYACKfMQSVt4o3Eljxgs78Ny9XAxR4wt3KTJXvwLFsdo/j0wJymr6fZMCwSa
         G50doHOSltLcdCGrISd/TSpCWQMZNd92wmRQ+GTIBzxiHwr//oKccmIbcOWgsVDry/l1
         SoiOlcIKtEChrfTju7iV5QZpNeZFJWpKQ7/xqG/06ljUK+mIMntbM9ti2jND4LQT551c
         0ExrMd+hxNu+DcyWSblFxjaTxQ03WFJzsR4AF87n7IOoT2xdioEIi0eoTDmy4FGJGDk5
         M0ccaTWx2FiAiIpi4feptu+wZTyEFnEl7Zt67EQylGuMnUac/U3Kkm97pgtSuPUQl4+w
         4gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317905; x=1707922705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=022zwx6MCTM2+vKlsZn6bQvDtEHFbRDoI918KeNrDZQ=;
        b=i+cnr7KHR8yetJlJBR5BJtb+iOTLvxG+vDektZbo7CFQY23vEQkzVl07834Q2N6DVv
         p9wCkyfayeYhefmKXauI8IDvTm9ht0i+89cnjL1R8id8olhDwbYpsINoCWLFtKpkLS0t
         sVdgVAA/wYh81tDm6HKoAV+UXo+iUR0Pn9rR6IAoY0hTWO0d9SrT0kNfuhVhJB7g3YyH
         y5UQX0IrUloRysccJ/sxgw3qUxhCVwIpvCJPXFLIimStxCEVEwXYhcXunPFFiHq6d9s0
         9FPRMc0FUBULTOrMSbXNJogXKfywf2J6JODACPFYiMrxdOLaYpnjEwY+9YvA7Kg6oox0
         XpQg==
X-Gm-Message-State: AOJu0YzggJfAgNTisN3EtLzjyGAb2EsYcsARLypLS37iZXNKeahahe6l
	Ftpj7qxlrnEKvnJCxQpSP5dkL/mOVeoOuhXzRO7zRJcNKecCz/RwzII0iZPOwhIiaVGFy0WeRMJ
	5gA==
X-Google-Smtp-Source: AGHT+IH8cjw7WA+9nGuzcgqW2xA8Iv7w9A4Dc0/I3ut6wcjH4wqie1YwlqkB90ZuGDFt+lLgxUp28nS+SV8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:11c9:b0:dc6:dfd9:d431 with SMTP id
 n9-20020a05690211c900b00dc6dfd9d431mr1230159ybu.1.1707317905016; Wed, 07 Feb
 2024 06:58:25 -0800 (PST)
Date: Wed, 7 Feb 2024 06:58:22 -0800
In-Reply-To: <e4fd8089-bbbf-4f54-98f5-211eac165ac2@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-14-paul@xen.org>
 <ZcMDjZ2t8XflbIpD@google.com> <e4fd8089-bbbf-4f54-98f5-211eac165ac2@xen.org>
Message-ID: <ZcOajtvik5oU1sLQ@google.com>
Subject: Re: [PATCH v12 13/20] KVM: selftests / xen: map shared_info using HVA
 rather than GFN
From: Sean Christopherson <seanjc@google.com>
To: paul@xen.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Paul Durrant wrote:
> On 07/02/2024 04:14, Sean Christopherson wrote:
> > Please stop making up random scopes.  Yes, I know "KVM: selftests:" is too coarse,
> > bt everyone doing their own thing is worse.
> 
> So what would you suggest?

Until someone comes up with a better idea that at least a majority of developers
agree on, maintain the status quo and use "KVM: selftests:" for the scope, and
call out and/or allude to the relevant test(s) in the shortlog.  E.g. you can
even squeeze in both:

  KVM: selftests: Map Xen's shared_info page by HVA, not GPA in xen_shinfo_test

I know it's kludgy and silly, but it's consistent.

Aside from consistency, the "problem" with selftests is that most changes are
either specific to one test, or affect multiple tests that have no common
denominator beyond KVM.  And for changes that are targeted at a single test, I
find it helpful if the shortlog specifies the exact test that's being changed.

To be clear, I am definitely open to ideas if people feel "KVM: selftests" isn't
working, I just want us to make a decision as a group and commit to it, as opposed
to people using whatever scope suits their fancy.

