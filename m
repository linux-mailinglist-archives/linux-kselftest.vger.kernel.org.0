Return-Path: <linux-kselftest+bounces-45402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BFC52087
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15BA505F41
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C830C34A;
	Wed, 12 Nov 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic1Pjo9L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS6O0bCC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61030AD17
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946704; cv=none; b=FnN1kvY4ipcGwc3kKJdmTxmUUKSfRM7XELBsSLO5ju27lYn7BA3Il+Dmsxpi08VFYHW2ldpFh+9oQ5Kxmtbhw4FGqmHeIoUCNb+5KIpAN92dgLoQIrBBkcOw97jS52QBYAw+aa/3poCVWUY0xkSJRoZXgQO7TcHRdtVLe7EfPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946704; c=relaxed/simple;
	bh=7Pu0o2x/O51dsOpfT3kiDBb6OdNE43A6rRDatL6h080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FndQVyRV0PjWI2g2VNV26uuCn4xiZMRVN6Iqj+4/j89jTRqUgq4lBMbKLRjASzBjZgMNUhjbUPwR1pGLP5+2Sl22ccVVRBDbNv+TGJrs/NYuq78+4VSpekUbSQVG4k0ZxEnPQ+kK4K/PAODda/adkxm+rV9+w5NwJVLwKuVo1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ic1Pjo9L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS6O0bCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
	b=ic1Pjo9L3JFoaJs8/10KGQpDqw/H8OewVv93cdueooWGMuvqJ60VZyNFjXMVr8bnQqisPk
	y4o6dsyj/GAHObhbJJ3QzK9M341X0zq6KR7a6skhk86hCITho5I9g9MR6t/5eo1nq4t63D
	xOi6rFnGuRdsife97CbxxIAMxuTpMqo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-oXNVb8ErPy2pKVaeqfCaWg-1; Wed, 12 Nov 2025 06:24:59 -0500
X-MC-Unique: oXNVb8ErPy2pKVaeqfCaWg-1
X-Mimecast-MFC-AGG-ID: oXNVb8ErPy2pKVaeqfCaWg_1762946699
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88041f9e686so18869066d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946698; x=1763551498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=CS6O0bCCGIyzstZHWQso3CaY2SZlNzvT12Csfr2FoQLqb8UNiEYCgEgFff2Xfd2ak4
         LF6nwUvq7TZfqEP6TU3MvLmPuBLI5+HPbaE1qGO6ZbxpixjO2GQLEMQ6XSzAk2Kkj8a6
         cSnblLmWyxj2eXY7Nn+o4OAvIhzsMWLj8RgsXh8sykPYzioLl3VBYw2cSZNwlOedsZ/U
         1xaDJ7cT/gLPb2CYmo+0rw1hE+v65Wds34wF1NCIqsMKHJ7zEDDJt/+FOhPb6m3c4cDE
         ubsazwaK8EQAzRpab9VBSKdMI/Ax09U+jh+pTvp7r1SEtBomx2pmpSuK2USsvQqjAg9q
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946699; x=1763551499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=tlxqzsFyq7LLoDXWN1Y5dNSGpd4ivTUPg+xOkK+10aZ530l4GjjB0utse62p0uPQZY
         gFDlzzy3iZB43hSbQ2pPjJLX/PBZGzrrR5b1PBc1oiSqJqJJymX5V3l2jZoLyG07/ZE5
         xSzXDuzFsA3OORKqOespgIAlCSobcy6mY85at+angfh9iA0aDLS1+w5NY7vWmiu2hczK
         LrOAXq7SvPnARQwRZI4S//Xca5Bgc0VST2ntcEegLg9HrUOdhpTYb2gh6h/v2H3wKKes
         4QeLsj2qS/a4OluU7HE8EcIBa0SyQ4GaDEYsYa5a2qBXb1e7JKw55nVZJaBEcgApxOys
         S/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCt7SHTnsaGkhVWscPe36lq6gw8L6h0yKmj0bQFuQVcdn7UxdG+rlCLUH+HGZQ8f9pZ15UJcTgn10IqnlkP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWw3PUQDTvgY9GEbic0gzUrmfzb2qPOZ746UjkqrzYulFr6pc
	TIWFum1+0Qwa3ycIPBeTfoVj1mFlLgcZ5jQQrRs1kYfvQRwnNQZR4xz0LJI8G4Ysyyu8L91EXpq
	aDLOnBHlzrOgtnC/UeNd3/oJv4PA5o87ea0XnNqMKLGft/CNcdeepkjufk4RdYDLavRtWaQ==
X-Gm-Gg: ASbGncsF//jzT4zKDXjbLfNWtcYJ3r2pm8Bv4RT9JcSP7qfBBiqbMO+J+abFhQDMSLq
	+QXph7dpcat47NPkzazK7R6mISFlkR+EZbnLDKVWsf01vDGv2CU8NIGuohtAWE/pDtsyU/YD8uD
	WFLqFO5OsS818WQB9ZNlIj7tkq8AJ3Jbu0lKGvQyIhLBbZt+J9PV3EFVzevJ/zDNLeUtsQLX5hx
	EUxZZnTW7GH1wxaAjGmz9OF/urMe4pw+LOu33qFvoePRZqfTIIWhAmTLT2Omnb181M5Z71TpeGy
	rG1yijGwCosSYPk5kFyjK4tYF/5ApmKuyEGQ+FowGrizba4lT0cIEeMsiBOKZfvoVmSJXyB3k0L
	g43iCtZ5MIK2R/zpYG+r9Fsu2PtU81j9L+RoJa13e+HgN1hFFjPE=
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868226d6.53.1762946698647;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg23TSNoDmt+ZtfObVKbv3IEADZ/iTaXYGqZ7/Rp75tiUGAUlZRDyDCgloNS0C23doS3gbzg==
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868006d6.53.1762946698263;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm90041186d6.53.2025.11.12.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:57 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <2ujds4l5ji7pdm7lczttukisjdoo5z5ufufw4kd3qyls26o64o@43yt3nkohsm6>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:58AM -0800, Bobby Eshleman wrote:
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
>Changes in v4:
>- fix botched rebase
>- use more consistent ${VAR} style
>
>Changes in v3:
>- increment cnt_total directly (no intermediary var) (Stefano)
>- pass arg to check_result() from caller, dont incidentally rely on
>  global (Stefano)
>- use new create_pidfile() introduce in v3 of earlier patch
>- continue with more disciplined variable quoting style
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bd231467c66b..2dd9bbb8c4a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -79,6 +79,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc arg
>+
>+	rc=$1
>+	arg=$2
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+
>+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${cnt_total} ${arg}"
>+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${cnt_total} ${arg} # SKIP"
>+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
>+	fi
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -530,17 +550,7 @@ cnt_total=0
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
>+	check_result "${rc}" "${arg}"
> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>


