Return-Path: <linux-kselftest+bounces-45401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D920C520B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34C004FE7E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FC32FE06F;
	Wed, 12 Nov 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRKSnGcq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdFDwoYi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB563257AEC
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946652; cv=none; b=VfkBa9vxRqQ89iwbLw+QAr9SVFNRRVLlal3LneYgFVWjQAe+2BzW9VeYebyYdLiDQgfxYsXxV43DYCZEqmzKzdxLiTZpowpEWAdGBRnKG8yQ8QZbkPB2+LC8nisaK/eCBLy93SSAtjEiwVHwxs/ftqMLVrSoGkF+Pum4hcQrHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946652; c=relaxed/simple;
	bh=7/0V7WKhYDg3U+bnov+MRIZUZa6EKfNx7qtPM/VQN+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb3byIf0sfKiDfxUhxiBymZASj59EgLmLShapVNNukTjuBkg0YDVw2OCFurdWnDmr9eZopXXkB6tMg7R3UfkklE1nxNr3LNAs+LEC47lK//fz/STaxjI3o4h7YWK5kZdmEKV6/hqnLEHxzHcVg8C89X2mkJvhwGvysdTxweQ3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRKSnGcq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdFDwoYi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
	b=BRKSnGcqbJqhlXL1laQoe8+VU8jtb5TnD1ELoenUkLd78pbcg530EFnVnLEdL7VwijALJt
	cfDtM25Rs0ukVlLnMrC/NcDfDtORAraQo/FFWFj6mmq1xTRqkJhIY9h0D0sKiaPBWuJil/
	eXB1om8hwjUzcHlvr/LKAoXbjeuiL8U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-zt0RHBBVNrGPOdkzYV5vPA-1; Wed, 12 Nov 2025 06:24:08 -0500
X-MC-Unique: zt0RHBBVNrGPOdkzYV5vPA-1
X-Mimecast-MFC-AGG-ID: zt0RHBBVNrGPOdkzYV5vPA_1762946648
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edad305681so13778371cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946648; x=1763551448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
        b=fdFDwoYiemwCy9WiGcBYbq9Q913Kvvfa0+2wntbchXUbzL/pnh4l2Yr5JAzVsC24p+
         7skjiAdo3GzkK9TZTk+tGCRJXaP3kOCGf5hIbjVPI7YBKPyZIGaNGH0mUW948QMhRbkR
         YZA/c9bKSUnpqzcMcHqDXHb6DcQ/Xl766UGmdu5Nx3RPzUuLZ0yUpBIO9Z3cBNh9twCw
         9MeFs9xHaBxrTraxJIfZvndG8TWXcxc1sVlSD4yLHxu9kpuWie7vFmxqUgzXpEg2bSos
         P5yWKj3/f4ZrPa5+iTv9PoEEkrBu7ucnNLC0PrMiuGjKm2EFUiIDDaj4OVeADlnjc2rY
         TOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946648; x=1763551448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
        b=vGzWZmSNnQ8lG+q+1fP3Ltlqx/WPx3C/WxFFTKiIRciprEkMAxfybQTaWodxfjMua6
         qmQWLS2n5033CCkjoa/ixwqCCHJsdVhdzmMFAty0YdN4eBdVnK7/jiFDkza2Nqg7LaXr
         U9Ovviwg0a9N0Mv3zH3aM8N0nvia/mnw+pGm2ub+7VEswbOnNdH7RuXdSElX+kohYFCL
         72lN3z7UNjJb8RRai+xUDd1ZIs/MDyM330L7fcdxn7bJG1o5SoorYcL2Ncxga5G/BW/h
         93uWe6j0V3hUbdcimnHilhfptlcv2za62m4ooXIrroIQJX2zu3OnxvRhboxE38eCbH3v
         UtGA==
X-Forwarded-Encrypted: i=1; AJvYcCWu8pPh1cWTEWgYDIIiORah0bf5amCNW3YF0ygBv3nO98PwvrJEjv96KsZEIzMG9+pYXXaOOLLruKCLsqJVtyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3aJlONw7Fsom0VKm7seIlLY4zS8vBQ4veEeAoc17kjVu0JXj
	uz7t/GzFsoqQwKmmMQJ3aTk93O37u3YpIRtu+d+vVdtB6xxjapOWbM85vZjA0pmseJWJ6pCkTns
	x4+wJ1ds3XDzsaJ5ErNz+0KiwLSPU7hFHiV99PFKHxHP8QmII/hjvFGUfQl1BCizmR889fA==
X-Gm-Gg: ASbGncsJdIl4OKsvht0bPVmkOqfZYzncgq0RWiNfG2yHFsNaK9imXPHUx87KRJ5TH6V
	nTAHfm6i/LzQUonqHg0duNfP+M+N95nOXthqxtm0LWIHNyt6jKg7MMu38hp9q8ROjYPJDNpM1ze
	fQahC0Kh/A9IXtJh+tXwFE+2ZUpet/BbM4h3EBl7A3PM/OmN2itrGD24jZcOoxQtksx0dnau+zR
	mPYCxUBjZ5GnCVrQW9Fhq4j0tyAvcxWnmyyOQ/IIzWts0cmMyQssRTZS1wDWlRYzJdKCuYSZRWi
	WliK5zDxeB9nMcpVc75GIrQHi01zvOr+vJOlgzuKxyRq0syY0ID3dQ0zs753GegzX1Z+sQNMPJm
	Bl5M48KIblEmhDxnFJD0Wx410I7G0Y16TRPrHgHhgafOB0vjMqwo=
X-Received: by 2002:ac8:7f0c:0:b0:4ed:afb4:5e2a with SMTP id d75a77b69052e-4eddbdd580emr30525761cf.68.1762946648360;
        Wed, 12 Nov 2025 03:24:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi9lfYrqcHRO06/1BdvE4+TDOFgR+mc1Xy/qr6FjnRCvkl3aS8R3iVlzWEotM9WMLpQRj+pQ==
X-Received: by 2002:ac8:7f0c:0:b0:4ed:afb4:5e2a with SMTP id d75a77b69052e-4eddbdd580emr30525511cf.68.1762946647933;
        Wed, 12 Nov 2025 03:24:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6f88sm172172785a.30.2025.11.12.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:07 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Message-ID: <jnhqclrso3uy7ptqutykcsaocu2fh26wi6jm6s5ny4eldnv7zx@4wblegex46a7>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:57AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reduce the time waiting for the QEMU pidfile from three minutes to five
>seconds. The three minute time window was chosen to make sure QEMU had
>enough time to fully boot up. This, however, is an unreasonably long
>delay for QEMU to write the pidfile, which happens earlier when the QEMU
>process starts (not after VM boot). The three minute delay becomes
>noticeably wasteful in future tests that expect QEMU to fail and wait a
>full three minutes for a pidfile that will never exist.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 6889bdb8a31c..bd231467c66b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
> readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
>-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>+readonly WAIT_QEMU=5
> readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
> declare -A PIDFILES
>
>@@ -236,7 +236,7 @@ vm_start() {
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
>-	timeout "${WAIT_TOTAL}" \
>+	timeout "${WAIT_QEMU}" \
> 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
> }
>
>
>-- 
>2.47.3
>


