Return-Path: <linux-kselftest+bounces-789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876617FCC42
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 02:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81F91C20FA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C6EDD;
	Wed, 29 Nov 2023 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWdzihm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11DE19AB
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 17:21:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da04776a869so6403765276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 17:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701220893; x=1701825693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xaAjFqVU5qqDjrAOLsosHck+47UkrNNUxTMBaKXJJI=;
        b=zWdzihm7yZ+KOfeghLkuomkjljHlJRQk52R+2V8e6aqlRGP1ptAwVNCyOFurj7WCCZ
         1CS8P8Vm5sSYVMwf7U6lF5gCInrTcsGXCTY3EJU4gS5Y0P98VHtR93piKJrIllyaYwgH
         9U9q+pxP8vHxVZ3zKkJ2rqNuxDvwQFyslZtmWAwg+IHCMBG5TMBRLU0t/HhFtHjqAMEy
         UFVpe3azRCaJmlGB1M4X9KEYxYakFHzwlxkw5nt6Y3Aah++0Qj2DkjDyTMUnNgq0ki8J
         ubQW4AWNDpmRfLOrdkniNSkakB6reGQReUyfavA+/qnX5ZDy8C/zj2Sv+9WSFJTXs3Mj
         AJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701220893; x=1701825693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xaAjFqVU5qqDjrAOLsosHck+47UkrNNUxTMBaKXJJI=;
        b=vlyQd9+BC8LoxkxFD++UbpXAFI1Mz9Wb+Vp973yhN/OS502YHFqKcyHXqtms03vDKd
         d0j6/Qtw1DbFcIFaZEBlCV70JGAmvsdQHxChrw+UEKns+KiggSAfdnBbiBmww009XXUU
         fu/DcG1AjM9rQppbvBoM+J2sAuPBSvkWTWqHWydUNUNZq080biV9P+OaWs7iYD5N+gBA
         YMaRkQ8qwm1J7+4A+KUIUZFuNohpPb/5rLkDYNwjwBOXZan4Dbmq/rZXVx2JnXt7be0F
         BBVqkdJERv+h+2HN/RZCM5Nr/xopB/kDgcgr1ozbogW9sCPRdeNcbdKUO6SMGTms0avp
         A04Q==
X-Gm-Message-State: AOJu0YxkwfZCKzRVBHdEONcqGu1HEizQLj+aq3aRb1Smnnl8I1Uaal1N
	XWAtNOUo/eHMtR0+C22JzPW3NLxZq70=
X-Google-Smtp-Source: AGHT+IGpd9WstVZO70Jt8U6PKwHv8oE/6qIUi7h3VLJVSM8jUfzJpaYP6i8qC329knKj6ZItVSI11Idz3Bs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d114:0:b0:d9a:5e8f:1562 with SMTP id
 i20-20020a25d114000000b00d9a5e8f1562mr506949ybg.6.1701220892813; Tue, 28 Nov
 2023 17:21:32 -0800 (PST)
Date: Tue, 28 Nov 2023 17:21:31 -0800
In-Reply-To: <20231128221105.63093-1-angquan21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128221105.63093-1-angquan21@gmail.com>
Message-ID: <ZWaSG4i6dsvj_qvP@google.com>
Subject: Re: [PATCH] Resolve Macro Expansion Warning in nx_huge_pages_test.c
From: Sean Christopherson <seanjc@google.com>
To: angquan yu <angquan21@gmail.com>
Cc: skhan@linuxfoundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"

For the shortlog, specify the scope/domain/namespace of the patch.  For KVM
selftests, that's "KVM: selftests:".  And ideally, describe the impact of the
change in a more conversational way, as opposed to stating the literal effect of
the patch.  Stating that the patch fixes a warning is obviously accurate, but it
doesn't provide any insight as to the severity of the issue, i.e. what's actually
broken and being fixed.

E.g.

  KVM: selftests: Actually print out magic token in NX hugepages skip message

On Tue, Nov 28, 2023, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> This commit fixes a compiler warning in the file
> x86_64/nx_huge_pages_test.c, which was caused by improper
> macro expansion of '__TEST_REQUIRE'.
> 
> Warning addressed:
> - The warning was triggered by the expansion of the '__TEST_REQUIRE'
> macro, indicating a potential issue in how the macro was being
> used or expanded.
> 
> Changes made:
> - Modified the usage of the '__TEST_REQUIRE' macro to ensure proper
> expansion. This involved explicitly passing the expected magic token
> (MAGIC_TOKEN) and a descriptive error message to the macro.
> - The fix enhances clarity in the macro usage and ensures that
> the compiler correctly interprets the intended logic, thereby
> resolving the warning.

Fixing warnings is nice, but warnings are a means to an end, i.e. they identify
things that *might* be actual problems.  The real issue is that the test will
spit out garbage instead of the magic number.

All that said, applied to kvm-x86 selftests, with a heavily rewritten shortlog
and changelog (I had the same fix locally, so more or less just grabbed what I
had already written).

Thanks!

[1/1] KVM: selftests: Actually print out magic token in NX hugepages skip message
      https://github.com/kvm-x86/linux/commit/3b99d46a1170

> 
> Signed-off-by: angquan yu <angquan21@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> index 18ac5c195..323ede6b6 100644
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> @@ -259,7 +259,8 @@ int main(int argc, char **argv)
>  	__TEST_REQUIRE(token == MAGIC_TOKEN,
>  		       "This test must be run with the magic token %d.\n"
>  		       "This is done by nx_huge_pages_test.sh, which\n"
> -		       "also handles environment setup for the test.");
> +		       "also handles environment setup for the test.",
> +			   MAGIC_TOKEN);
>  
>  	run_test(reclaim_period_ms, false, reboot_permissions);
>  	run_test(reclaim_period_ms, true, reboot_permissions);
> -- 
> 2.39.2
> 

