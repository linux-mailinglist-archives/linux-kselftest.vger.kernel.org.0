Return-Path: <linux-kselftest+bounces-45400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A43C51F58
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D5E1889216
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCFE3081DE;
	Wed, 12 Nov 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcD5XfAp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQqDbML6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6126F467
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946635; cv=none; b=MqXpTJvCLSZ05p2wkB81Tq0+Fj0MVq5kepbJXz3/UJaU8A79kDKgcCWrxi/BbNXfT8hAFz1nQPP9zcaoqtyEjbet6p99OLUql8ldNsobnDqPGvauTHLowl+feHtMIL5u797KxM3C7BBpoAWVV9BgobUjYc9nIoIs24ikEGYZRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946635; c=relaxed/simple;
	bh=SDyYLyP6tCKgZow9SIBWdRS3PYcrbQQi85B2bhjoTbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4D7C9Zd+fl+/qSuge5iBuCPTdJ6sTbW6wwutdTWi7cYnsz6hEFQrDo2TGVG4bCV/Oo9rUGGcb1fHzb5/PqmeaFnrQjgu9IULRUJmwUbnGL122cR985t3ALkBVMOUcotukVDZrqs+MydLwFvkEGQr4gnlCBXX18q4otIE97BLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcD5XfAp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQqDbML6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3H0HyO28+OYSSXAxEHzY6dM2GaftH10W5eTlFdtLkc=;
	b=KcD5XfApUn51sMHsImre0sW1jaCdRWI2JwCmgA9ouyT9RootRotaYINgHcDoAZWNt4DZWV
	EGaEwNWOZiQ7ksvWowpA7eahqFcI7ArtjtQNY34KWRQEYbSd/e6orE6xpNK5WM13SmxzPq
	LAWNklKBSXDocHJCOqsE0fyW/jV9Hsg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-7MxQfF8hMhyGevdmDEizpw-1; Wed, 12 Nov 2025 06:23:50 -0500
X-MC-Unique: 7MxQfF8hMhyGevdmDEizpw-1
X-Mimecast-MFC-AGG-ID: 7MxQfF8hMhyGevdmDEizpw_1762946630
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88051c72070so14272616d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946630; x=1763551430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3H0HyO28+OYSSXAxEHzY6dM2GaftH10W5eTlFdtLkc=;
        b=dQqDbML6wumCG6VgYQJwTyS3ejhi5+rOkDts0wdsCVJy2LqLxP7utTnWN3WGmdecV3
         7x/kT8bQDVlfEE5ZxV2bmbHuHqZhQhqrW/4fp5pRh+8tJ27+nQCr3h2HZy8OHj+XpYJv
         KBQ7A77vq6bqIcfd8E7cO4vUkl3fdKPeMGNEpGVQkUGV6ni4hrLHFmkJy4OkQ9BDKCYx
         FP0S89UUmVsNDR1zv2y7ZtOx0cYeB/e6o+wgKwwjCF8IQJdbN1p1RVe27ANdH682zZL0
         XuVbhTqatYXEEKQVPvlAjZsXR54evkwkMmIXwpPIxLXZbIDGoC/LJZbP+K8sCbsQ+smT
         cytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946630; x=1763551430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3H0HyO28+OYSSXAxEHzY6dM2GaftH10W5eTlFdtLkc=;
        b=gIL0zNIZVGnHN0jsJ6tuLMgRPrlOSRuHFepn2lYrLbmE1o/2LQFe5EkTmTznyGrxos
         jvKLwhuS4t7rukk/lQwHUSMcbQzi9gQuM57LRb7dAWL7erRMFAVgFNZqvKjcG1xQTy9M
         i+5134NWuPNTCEZuKSZ8xa6atYYTClc/nuF/VCzT11fsL4xEQJPyCV9Qgcg9OZY7vkNx
         7f/WZEDC+e93cbjlOPCO+SaWY8UJvd8dVgZ2In4S1xh8Og4nwTELFuuM9O1v1MEXVJT2
         Ny+gPPCnJCFUGCEbEXib0iv1Z+pRSV8Amsh4Sd3f04wwPhLQP2ic8C1OZa4rukE0YYOX
         bhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTbp433H4vhQzeSu5KNYhlogct3EsEb57JvPqM4oAz06yrhA+F0UJw/aVzaRU0xpC1EmxYd2EFEeRTFWmc2FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTV/KmSUhLUj8AQC9K5E6cZSPHDnXnllLGAIx2WQCSY3Znucu6
	SNnQ2mKackPbV/lRCgKwmOtnedrp60NZLQuI6yqoiPgmoWINmpN+N4JVdDvU/kP+mOYnvT9wCtI
	/vEJmAw0f5Ims9cAvskgZtO7tAFljXq/NgPt+7/sBF1oCG9xHp7bgBXguqljLsSZwy8FLeA==
X-Gm-Gg: ASbGnctMZlYjbOybVOoanF5UBvqfoIsSsks14KscDz5CK/EDo3OCB388TiAVyffMild
	Pd/gXoYIheC37aqDRnVhGLJZQc4hd1LIHOzFIlQ+MUJqucLaiJnsYSC46mt81UBIKWlo1a4f5/K
	Hu52DtmpE0Jn6f3Wy4Z3cEiQ1w8ScR+aqOeRhJPVyEjDfWC1zZVVGziyqtlTa9xLjsvRPuAIZQT
	1oLEWMDbyN1SahEJMsGXhTco6xJUgBXJI/w6N7v1TIgDNtvmWaQ3DI/KT3jZN5YTJgljP/9mCBB
	UvfvfGtuxy6qPB1qF7m/IDXlsQVR6vnQSCAPMyvTyZcSmxlNxv9QhLqYjmWtyFeaG1ZMK3Xwsmj
	7JSIwBSDGmlMt2sTd0EDW6K5A4SZrMuRdAiX7NsfaxTlIfcgO9Gs=
X-Received: by 2002:ad4:4ea7:0:b0:882:4be6:9ad2 with SMTP id 6a1803df08f44-882719e68e7mr44666286d6.33.1762946630289;
        Wed, 12 Nov 2025 03:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH75JP6UyDj3zoFvW86TbiZUWcqb8so45eTwS+F/Ht1XSgKOAe4vkrTmnLDJKvoh14SKJ1KRA==
X-Received: by 2002:ad4:4ea7:0:b0:882:4be6:9ad2 with SMTP id 6a1803df08f44-882719e68e7mr44665946d6.33.1762946629843;
        Wed, 12 Nov 2025 03:23:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b4045csm90028026d6.30.2025.11.12.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:23:48 -0800 (PST)
Date: Wed, 12 Nov 2025 12:23:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 05/12] selftests/vsock: do not
 unconditionally die if qemu fails
Message-ID: <6t3kq42haafazobjbrnmcppg4bhyzfbmkuyld3h2y3rq5xaehr@olnyeve44x5l>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:56AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>If QEMU fails to boot, then set the returncode (via timeout) instead of
>unconditionally dying. This is in preparation for tests that expect QEMU
>to fail to boot. In that case, we just want to know if the boot failed
>or not so we can test the pass/fail criteria, and continue executing the
>next test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 13b685280a67..6889bdb8a31c 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -236,10 +236,8 @@ vm_start() {
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
>-	if ! timeout ${WAIT_TOTAL} \
>-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
>-		die "failed to boot VM"
>-	fi
>+	timeout "${WAIT_TOTAL}" \
>+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
> }
>
> vm_wait_for_ssh() {
>
>-- 
>2.47.3
>


