Return-Path: <linux-kselftest+bounces-8897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB68B2D75
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A36281E68
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D12156988;
	Thu, 25 Apr 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5sSIXoq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE55156871
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086631; cv=none; b=d3SvVaAZg5GFy9woLyva+JxIsECMTZXFZju63wHj01ugHH8Ud+5b/MsW09olzP1cAes/SYoa+6VkevtU3RhpeaJ3Bq7Kcr0aPJ35sqm1q67lP5+X29iV5US5P11I/q9XcaWg4fnnGzA3SjhpeZw0bPr5uCfip9NZlhYxwIoTvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086631; c=relaxed/simple;
	bh=zTkgFfAHRBc68cUsuLXVtOjsq96hByN4x7hSD1bfdOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lgDI8dg5An/TqPNYiderFDIebdPowoSxqoe0m1g4O3lIvBQRgoNMgcSa8qFQqKg/TMWuriZHv0v201Yr6O52O/j/Q9ltGVUuzBWfl1XTAPo65zENTacYZGlQfL95nGctbI6aCr/jw+pF5//XLvzZp/2lFLuoowC7kVQF1DmXHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5sSIXoq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6edddd0375fso1717544b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714086629; x=1714691429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUCYtH/HKWn8ExkVR1X+jCKv2DoEuOQK+l1YHfMHQfI=;
        b=D5sSIXoqnRr6ulKefBtpEoOHyLPfHzqUmlHk88pZmt3mdxh/kB/Nsz6GsuapNtCmVC
         dTcnjQ1TohaB89agucwuxvlUvwcQVIcg7rzOZFiBxWoSldVQYnSNzN5c6zF85YPTgL0b
         hkhTE2yI0zQFc5LzvQkNMDGs8dW77Y5VhzTHwhELr0FCwWgFwpuYT9Nf1E5BYXZvhe7n
         ztJu/iLbZ8O+zJn9UWxXhQaAbwSiQtO7YJTYynxSw/TpFxYDJ/dHrSEIwgvkNRbn5aDX
         uoMPVDkwGMvnpOJn4KPHlqsdtr1WRGNATjz8O03zHqLHr14d8GwLm2ICbRYTDWGjm+Fv
         iL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714086629; x=1714691429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUCYtH/HKWn8ExkVR1X+jCKv2DoEuOQK+l1YHfMHQfI=;
        b=Q0i42fhNKCR2np3A3mhZoIwW6S5mSIUKYzQ2NpDw5I0EUW9E8VEKh2dixAhi3mxjN/
         09kTfJWVY6ZcEMB1pbwgdwZX11hJbm1sRIUwrx3n0J6FJ1flVXbYC/VrlzcPGicxRvSF
         ZzAEs4EpeO0X3UM2QZ9HrGdAtPwgm25inHDP5FwSSxqXlTJmYI6hnv3aj7kaj1IScguM
         9AuNt2oOjkcBtRGOXrG0ZumVemWlQsVo+CYX+Mst5+fOnmkDJWq5rD7ZXjetzMN5IFNH
         2qW3xK6rqlygpXC9z/JRka3xQT0c8zkvDb9+U3FWx7ciBUpOddiIRu2Wb/RgTbJJVUM8
         hsdw==
X-Forwarded-Encrypted: i=1; AJvYcCUPoUL/qHTzru8brydDi8ZoJFCy3F3KWzSiEnwiCZPfXc2TlaHfRX1tz+cZgsGjckh8UCDBjArppSJFnDBkdCMLzCxEX3RpMsv40dshAjcC
X-Gm-Message-State: AOJu0YxODDYY95lvzqXTutAKE7O1lshvIhy2Pvj2KjWPJILORBouhAmU
	XEBZXt7fAwLrFKBDuFb1Mhgq8bY4wsMAFCZ5Vd9ppPF6wP996Msrrl1EUJU6Klmm7gfKjS1KjSc
	Yzw==
X-Google-Smtp-Source: AGHT+IH0UTRcNBzj9dVGQdexjLGjpnROu9De3Yy6jBzcIynbXQRGZUM1KMZc6bjFlVeH/OJV6ny5L1PLpUc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1708:b0:6ed:95ce:3417 with SMTP id
 h8-20020a056a00170800b006ed95ce3417mr99147pfc.5.1714086628911; Thu, 25 Apr
 2024 16:10:28 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:10:27 -0700
In-Reply-To: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com>
Message-ID: <Ziri424B_R9GXA9Q@google.com>
Subject: Re: [PATCH] KVM: selftests: Avoid assuming "sudo" exists
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 15, 2024, Brendan Jackman wrote:
> I ran into a failure running this test on a minimal rootfs.
> 
> Can be fixed by just skipping the "sudo" in case we are already root.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> index 7cbb409801eea..0e56822e8e0bf 100755
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> @@ -13,10 +13,21 @@ NX_HUGE_PAGES_RECOVERY_RATIO=$(cat /sys/module/kvm/parameters/nx_huge_pages_reco
>  NX_HUGE_PAGES_RECOVERY_PERIOD=$(cat /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms)
>  HUGE_PAGES=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
>  
> +# If we're already root, the host might not have sudo.
> +if [ $(whoami) == "root" ]; then
> +	function maybe_sudo () {

Any objection to do_sudo instead of maybe_sudo?  I can fixup when applying if
that works for you.

> +		"$@"
> +	}
> +else
> +	function maybe_sudo () {
> +		sudo "$@"
> +	}
> +fi
> +
>  set +e
>  
>  function sudo_echo () {
> -	echo "$1" | sudo tee -a "$2" > /dev/null
> +	echo "$1" | maybe_sudo tee -a "$2" > /dev/null
>  }
>  
>  NXECUTABLE="$(dirname $0)/nx_huge_pages_test"
> 
> ---
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> change-id: 20240415-kvm-selftests-no-sudo-1a55f831f882
> 
> Best regards,
> -- 
> Brendan Jackman <jackmanb@google.com>
> 

