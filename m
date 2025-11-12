Return-Path: <linux-kselftest+bounces-45397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBCC51EB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA303A77D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9EA2727FC;
	Wed, 12 Nov 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxnbJJSX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="COdfgtHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44135CBB7
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946138; cv=none; b=VORzSRRBBm4LfQdO/j+JhFBob943Bz6G4uiQEyc1qRMx/skLx5gkVUA4NIV0KeAw/UT8JCg83XQY8BgOhoiUHFaOOaGlCRMtlnEJXUv0tW4gN9CkfAWukQxfROzgTSkURrQWrf7OGqVyaOv7jpKWHfinQrZJky6HwdIcxq3O7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946138; c=relaxed/simple;
	bh=KV9j6tjQ5QXn5f8pxeC8kmzLrI6wkQRac7WkDx7/HyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ9wqnnT/EMYb5Iuf958mQFL5bQsbkHw7soIygUsbjyHPm7JDBJl6bYk3yInrcCLX/32o2cDfC6ApL+oV6bHKi7Dk+cava54IXHSOgs6ZYnGl8zFMNFeSCvFmy9WI7Zd7YkXozNTAoYezkWxmGvw0+VR3vl/a6o0z8AvKCRAnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxnbJJSX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=COdfgtHA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
	b=DxnbJJSXU4oHRChdVs+LYgGOWb8JGQlYEj75q9KE9oj5gHs13Yo8htEpA4XXFURv6d53ha
	kXMNq9Uva5GF0D46CIQvom5ki/Z+5TVm72bVIP/Z8SXkz2hD9dwe5XixLL5lmjqfw+ftsV
	PLB9YlqIKxUX1I+frLPjtMJRegLLDmI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-ayoUjYQWORqNKngemOfpIA-1; Wed, 12 Nov 2025 06:15:34 -0500
X-MC-Unique: ayoUjYQWORqNKngemOfpIA-1
X-Mimecast-MFC-AGG-ID: ayoUjYQWORqNKngemOfpIA_1762946134
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edae6297a2so27366741cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946134; x=1763550934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
        b=COdfgtHAszEd5Dj1x/EbjnDEZFSAzdwvZ0DtOrep6HOyGys8ISoSJyZB1z8lmeGgt3
         nOQFQAzXGEj8/J0LrjwTcB1VBCxrgKobr9exmijFRTW6Ei17vzhq45HeKbrVo2AoLN5e
         az7ZYMrQ/kn9ac4+TSj1LB9jGYlVz20rbmfymjJ4QEdmi9RuKdTlFtJdqThBVS0o10fD
         kxEgetbwsbRY/6Z6GmPVGiQKIcegyB/0YU6yVtDJdsptKMq17Q95zREIHt+barJrfgof
         FRnvmrzelMEwlwY0SfakHCR7Um9iHagm6pFFgqF8au6dj1yvLDUr1GX7XwPD/fBOQGWd
         eyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946134; x=1763550934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
        b=DotW0SKq5Vdx3v+COLRppZ/cudQvMw7C5ao2uprTL7WPm1dWI2+pLOI3EETea6FbzE
         P2Ok0T4TlzMk3KLzat2old9R5wOTR4JMKNQIM2zdXBQgt+TBWGz6D3T2AVx+ocz6HeUe
         ljUmiAJnoq91tT8Vryz22YIhsE7bN3qhcKmIqkg26hKDkIFbQVCVM1zejx7uOQAktSAw
         Nxf0YQ7iDCfvIGbFHv6Sts2F8E+ltS5Y+s9Y4CTgoZc5pnedOUEtst3dIZErgnGiAFBH
         AJQxHQMkfoQPWtDy3oqllCrNkH1L7PXCz6nFpdQZKN6nLhROi/ZMMnYj1M2I1HXrULjt
         32uA==
X-Forwarded-Encrypted: i=1; AJvYcCUKCPF+zYCT7QQzn4KO4AkVKfyLVz9gWM8eUcqOt+C+yYV/pEWylzfkxbySf2eldWo6YxjmUx0QTev+XxzHHm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqB4FUvwQGOdGV0QvlsXl8O6GU8RvLBQEnxpHEBfwfSW4KEyIu
	YZaEFFeq3WyQt/04UwiCEkcpKgSPWINBrfrdWG0hKF662Rc+dS1wRQaqdiN46Vi+dsKQ2Mat8wT
	pdPqqsLne3nzZ57QDeuHtLGR1UtjSsH/9CeG1B2I5Sq3mPP7ol3kdlhMm5qhlFRz1DLWOkw==
X-Gm-Gg: ASbGnctMe+EXe/LjjFlu3QD/s36G58qrAL3M6BP2SFt5msolvCEsxohpLgFWzr61RqU
	bfM+GH+IWWbeKO/ZG7x4dLkIeFTNofdOdMATKekLEsEIt6Jjl0YoKsbuzz/NHQX1otcOte/pfeX
	ie4sw2spOhDBL9L8XztAG1+UYz3oPZuNkMEhHdQz/cUosD0Mti4JcVyzv7gAoWXGG2rrfor4WFJ
	o+Le3wzfci51B2R9W6AyeyyTVw2AfDr6YCVeGXSChKfPDs6SK/878aJUlC9gVgd1M0BVfp1W207
	s+ZJ6DI0J6TJcSz8sIxjooi1rw6bccx2FwKHHsBtRD9U7HVIJbHMWsKh/LRyIiaDk32Thjp39qv
	OR0ZP8/w9NIGdcRFDh/oFaC0Roj76ldU74ZBfBdD5ljXMYgZNLGE=
X-Received: by 2002:a05:622a:54:b0:4ed:69c2:3b13 with SMTP id d75a77b69052e-4eddbc6a48bmr30774381cf.9.1762946134034;
        Wed, 12 Nov 2025 03:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzBmGdmGhOlYiVIRlWZU30TyBg9MVhguagEmUrNtm3qfqZ/uALNevR67J4XeGgywzJuDlfEw==
X-Received: by 2002:a05:622a:54:b0:4ed:69c2:3b13 with SMTP id d75a77b69052e-4eddbc6a48bmr30774101cf.9.1762946133569;
        Wed, 12 Nov 2025 03:15:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede379ef71sm2086971cf.0.2025.11.12.03.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:15:32 -0800 (PST)
Date: Wed, 12 Nov 2025 12:15:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Message-ID: <wlflavm4wt3focsl6w4ylu2p2itwz7jl3hbcnczuyi5mfew7nu@rd6wflle5gjt>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:53AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Rewrite wait_for_listener()'s pattern matching to avoid tripping the
>if-condition when pipefail is on.
>
>awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
>exiting upon finding a match causes false-positives when the pipefail
>option is used (grep exits, SIGPIPE emits, and awk complains with a
>non-zero exit code). Instead, move all of the pattern matching into awk
>so that SIGPIPE cannot happen and the correct exit code is returned.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- use awk-only tcp port lookup
>- remove fixes tag because this problem is only introduced when a later
>  patch enables pipefail for other reasons (not yet in tree)
>---
> tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bc16b13cdbe3..01ce16523afb 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -251,9 +251,11 @@ wait_for_listener()
>
> 	# for tcp protocol additionally check the socket state
> 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>+
> 	for i in $(seq "${max_intervals}"); do
>-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
>-		   grep -q "${pattern}"; then
>+		if awk -v pattern="${pattern}" \
>+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
>+			/proc/net/"${protocol}"*; then
> 			break
> 		fi
> 		sleep "${interval}"
>
>-- 
>2.47.3
>


