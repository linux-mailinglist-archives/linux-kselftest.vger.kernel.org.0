Return-Path: <linux-kselftest+bounces-44812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB5C362CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611F33B4C2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FBB3148D8;
	Wed,  5 Nov 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkPefxPo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ogqs4TA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7693314D2
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353702; cv=none; b=ePuTrKEix5ebUEFkMdsI4L/HfgbedjLOhOjcVXu50+tR7hTW8yacJsz1yqnNbmptP61THUtGsqI3KRW5gIg6WFBU0yWf3uYfZkcRI2qCrmAUeszA7Aa0uJ4ZPI8e3wkbuVaRPx8MxpD9LTbUly7rTQHXMuUwdb7qWJbKq7su09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353702; c=relaxed/simple;
	bh=Un+S3Mc0QD8v6wfj3eL3xXYh+ndupS7pAvsfKuhFm4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDkQ4I0EmsA25VEcW+a0m36hXCWuWwTLmk951gQFfJFUrsFz/AWRR0uOPEmXoWrjDR8CNzPvGj2kmk79VV3iTO/UPZ4AiYv47YrEHWVfwUo7USfPVzV9JIyx6EV64OwvU/MxSxgiFVxnkaK3Fv2JisFKljGc4ej0fEse6duoPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkPefxPo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ogqs4TA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
	b=FkPefxPo1R3VY9Nr+VH69Xgp/pOzVQHgdF/xFpeyqQFDDI+III0k71FTVChB7nSjOgI+ZU
	peSZJ3fBUvb6+UFg4WKK4lSMeXISVTvSzj2lC8mf38wRDUtJkxmYlMLIARXWcieUUjPmrc
	pHOFvYYk7Aicm13nd6vMTLRzEZ6LlEA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-B5KHoAzpPA6deJ4_xY-ptQ-1; Wed, 05 Nov 2025 09:41:38 -0500
X-MC-Unique: B5KHoAzpPA6deJ4_xY-ptQ-1
X-Mimecast-MFC-AGG-ID: B5KHoAzpPA6deJ4_xY-ptQ_1762353696
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429cd08586cso2115061f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762353696; x=1762958496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
        b=ogqs4TA4j3DjXybCnMBUFnNFyVmbxlBQF2CJdj7xhm/0hN1rSUywZsZpThzYYfLoYt
         JX9xMggCkPcX/i1inK+yg6tbcJIOPbRe4H4tAcBbzL/FoH38wpg5To+etsnbJStKJ71F
         9fhFebhgqcUGY1QUP1oRpscft+R2S+UW3ArcTFEqwzZsgQlOYxIpoS79Id2ozEUuwXcu
         4yMAUXh2Bn9icQnmCq3LfuhQyrBEKvdhAXimAc/57jwoQ6Iw4oP4oqvIcLNL+1UZzzn/
         Z59mwzSBYhz/wGHe2jNJRD8sDk7PAEGEW8bM7yLnuMTgFgnu6++/m/B3tuAQaBC3hsIx
         pm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353696; x=1762958496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83D8bblxyw5BuUWQPyxb4QzkQFd3XzPLsRwrCQzA9jQ=;
        b=F6EUm9DjnH2pOy+ZkgicCs67j1PLW+Bbb+FgqyMufv0U+NSHTpPpfWIkNMf30tv31l
         vypqO0qr+NHRX9gU6w1QSKvGNtg65gjuzoSulg6fxu+QJ2z/UxZbtoz7Nf2G18mD1R2q
         j9Lo5wbz/LpAQoQvr1jh9Dd/f55bJ5g64XPCEMlLOW+Q8yyc+30bGN/pyDv3vGWZ3lJU
         a2TAJK6ZznEOt3W4sXoOc0Q0x/MDYHXHOmIcaVtPuWyqlvdR4Yo+BEP/X+Be/6PhvzN3
         j0IJzaRzUznePvr4bKCNcgJZoZHWdXuO8AigX2oC7lnODFxOQpH/uN2vbpvTC2fCoY5w
         u38Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPWG5m3/TLfSYZFnhY2TTsnyh8PsEH9yKia04hbjSBUJEX6cZ3g+SKgTL1GHCOuhIUlLaLSU6ZEPVr2bhanIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeY8OBpG6VUVgTHrgat+tQ0v7HexMR5pkDZrb5ffyAu9AW3l9
	0XYYPLt/PICukMLFIO0HmqORAGE62d11BpWP7a7FsWRpNoTfGHI35DdqHRltl0Wcn1hDTRsYV1v
	89clu1P6bc1REO/rjpyvbXse0fEIWMd/qsRpDnuN4UsxZSDnsDbg5FEp+a+/pU16NRjePbg==
X-Gm-Gg: ASbGncv7e+rlm4UoaLEsAz+XuW+hnCO34LC7uGWwdByQz2Y64LG5htufZ1PH9/zLsi8
	bfp8uY32PsLX4v05HrHUUxqly7tSictwju6/3E2gkbwMZUiRYEu9iTsyKunA5W+xTpvCSiUlBTy
	n6yhm+neOO/YKNtvJGmIxS4dnGeEp7coPU+yrIMBLEDnabFCfIIGcEF3IO0W5uejTVAjttspwBF
	ulsD1RSwycKWU8BA0zvY/+siTba7TGosX2zCyiNDgz2n12JvbYGe4I+Cf/p7798oDhYSYuHGiDb
	xZ0DutEr19HsaqhrJZ5rFYJwKMrMELadZeK97NU/sSdkye/Anm0vA4Xom3vVKXy5DvklcpwSGYU
	=
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr3305570f8f.3.1762353696172;
        Wed, 05 Nov 2025 06:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdNjVd77s4VsvkrZ4AU/ubU7KMUlzm/N0GSTkO1qZtkX4KqpOh8zmlKt0hs1ExVKOK4eMg2Q==
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr3305546f8f.3.1762353695682;
        Wed, 05 Nov 2025 06:41:35 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12058326f8f.3.2025.11.05.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:41:34 -0800 (PST)
Date: Wed, 5 Nov 2025 15:41:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <fodit6zue6iwtqgk54qy6fvmegklnsgh5437h6ofopzhc77i4q@u76zkisp4wie>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:57PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add check_result() function to reuse logic for incrementing the
>pass/fail counters. This function will get used by different callers as
>we add different types of tests in future patches (namely, namespace and
>non-namespace tests will be called at different places, and re-use this
>function).
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 940e1260de28..4ce93cef32e9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -78,6 +78,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc num
>+
>+	rc=$1
>+	num=$(( cnt_total + 1 ))

Can we just increment `cnt_total` here and avoid `num` at all?

>+
>+	if [[ ${rc} -eq $KSFT_PASS ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${num} ${arg}"

Where `${arg}` is assigned?

>+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${num} ${arg} # SKIP"
>+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${num} ${arg} # exit=$rc"
>+	fi
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} 
> 	localhost "$@"
> 	return $?
>@@ -510,17 +530,7 @@ cnt_total=0
> for arg in "${ARGS[@]}"; do
> 	run_test "${arg}"
> 	rc=$?
>-	if [[ ${rc} -eq $KSFT_PASS ]]; then
>-		cnt_pass=$(( cnt_pass + 1 ))
>-		echo "ok ${cnt_total} ${arg}"
>-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>-		cnt_skip=$(( cnt_skip + 1 ))
>-		echo "ok ${cnt_total} ${arg} # SKIP"
>-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>-		cnt_fail=$(( cnt_fail + 1 ))
>-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
>-	fi
>-	cnt_total=$(( cnt_total + 1 ))
>+	check_result ${rc}

Oh, so the arg is in this scope. mmm, can we pass it as parameter?

Stefano

> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>


