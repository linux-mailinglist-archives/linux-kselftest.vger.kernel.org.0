Return-Path: <linux-kselftest+bounces-46239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71136C7A546
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id AA4F636FDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C52E9730;
	Fri, 21 Nov 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8ssUXmx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V272h6uP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FE1E3DCD
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736148; cv=none; b=Xu/KzjCY0aUrYJguBHS2icPdca/0TtzTuEntJ3txfRDza4A4N/h2KHySkvz815+T7tqFtz+N7Ybycg8IY3g2Xa0uB1ULmmJRlrmbnuMjX8WmmDJzpoSbRiWjpP78COI3fnTEGGbI1bwJ0RPUAPtnvoF3GN9NFOidDUBI2wekq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736148; c=relaxed/simple;
	bh=tL0PrPRXzvFMNUmQZS+jeR6hm5nHn34kXXtan4Z4rYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsMTm6/apu4lkQpNcOoSsr2wor0XBTVWj9uV1UcOC0fa4dADC+SLMNxeid2KJxmgFBkIuJhnaS7PPL3boS8gvlu4tVG8XldqS7RS4Tjuw+VGFoRS69O0elWSGuot0uANaoitX1dHPlb7bWqCfl0Jt/4FlFJvgZMQc38oIpxO/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8ssUXmx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V272h6uP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ff3oUHYY/i63OgG2+W0AQ3qdCRaCGyr4AzC1ltc0qE=;
	b=V8ssUXmxFQZRefMvlmr2v4mIHqNsCb1xpPXCS9LGsfb8ZHj0EK53CYhzEYjUROZf5Duy0v
	tTJkPz++aKI8djApO5Q3KkuoaTlUJmfXZ645BHWNSrXXGZpLx7WcWcP4xfaKa8M90qIZhe
	IvKtGJACfEtYf8LWMTbZvtJ4zalsDkg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-tNoQvD8TOO6SXIVZ3DwKRg-1; Fri, 21 Nov 2025 09:42:22 -0500
X-MC-Unique: tNoQvD8TOO6SXIVZ3DwKRg-1
X-Mimecast-MFC-AGG-ID: tNoQvD8TOO6SXIVZ3DwKRg_1763736141
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7387d9bbb2so159421166b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736141; x=1764340941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ff3oUHYY/i63OgG2+W0AQ3qdCRaCGyr4AzC1ltc0qE=;
        b=V272h6uPvKDmLWXeTnrZtJUWLFDAaaY1sZAO7reLFizcQYkESVK+tT+9qrNdNMc8Ci
         8Zkv9Yh0ESL2ODfjJBh6+TQKsER7Tyg3VT3Yr6/xBE+ALo3nkeWFVbm2UTiC0DOxRyAE
         jipPIAXKZRuexsOMobnma9+IGGimlhlrfiTiB2pqd9w9x/HhhQ5MPuY1IfRcRJbM8Blu
         pDUQDRXw3+zpaOzZ7ROaj5MHc23RWoVssOum9Rp2uqDBQ4Ga2QmhPh7tNS2FKin760TJ
         1kBT4ReV3WZOZfvbn4w/wbOgn5NYTe5F5a/Dv7XFyK5GTgNYAuJS8L7O3m7j6YYZWT3I
         sEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736141; x=1764340941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ff3oUHYY/i63OgG2+W0AQ3qdCRaCGyr4AzC1ltc0qE=;
        b=gLG2SRA6Qw9sW9W2NOOyVjJi9KrsAFbQjVK2M2u7h35ALzijgUeDjd+oCBhIRtHzSl
         vO20XT8pfRegPursjvVBIPmRJUV/7nE8BfGJqCHagT4telHQ7RugofnykwFNHBMx5sup
         xPk29PM+P0FO7jC5bUMbBgN9fnk3fcXWW7zsfy8dftDF8K8PCl1CYFFz8DpDUH8TJPeY
         dzJXulmjKYW6+UHkbYI5h5V00R5Y2ocVyjNzmaFU1v7rBQSb2fD5fBdqIRCwELqbc+Pw
         sQ5xUuYiM83BxR4+QG29STgSMzHIVestEUui4ZKB4PrjC8W/urNdmaYkQDgKVz29H/H8
         OZXA==
X-Forwarded-Encrypted: i=1; AJvYcCXC8oJBRTNF7fRVafnEeKiRZdqindyoUd3ptneKHJLo8YTwbXfw7KxRrYAwFjHRxvScCsg1ve2XRGjVVDDacoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu1zQVSBEmup8WUAF4QB3egxd0f9FVPuAhZFaoOwdD/4kq97a3
	e3G1LpRHvwP676PzpegWSpbQGoKAgBwOQZ9fwvlhyVgHj5cniPzBzY82PjtxNQF6XHNEuO2ly0K
	JBBJIIZKEp1uIj0bnPOyObizW/O8fg+xrJgQPIXExmZHIhazj/vZY9qqx5e9ZN4oXkRjgXw==
X-Gm-Gg: ASbGnctyfgmIojrHnD2kDjjlRrzrSlale5Xfqju3h6m4DJgcSzygbwBBKo91VluDz6s
	XGYDTYGeJn6McNVIK5bqlqnttW9aEJKMn6JI6zfFWEZAO3mH7EdCOYfe7nY9i1GEpj78Zhx59++
	WX82rXefDeJC0wZpB4fMn3PyoVr46VXa3DHnx4K+P2GZaColq2+67q9fiJNyoPc1b+5+4rDADMv
	99YQQEMFaa5NqD/8uwikA5zhXqlmCX/YeZUgl31kbvZgWsQtxBxhhJGQQQM6kVznH1epMM6+GpI
	dwFGv+oCAA/QiQRL5ox2dzJZz4NFvlY89Y37NhmBjFwy2TmiQWmto0wQdFqzG7tjGJhmpzAzl63
	+AfWO2qDrnyodpZJU6V6Y2qfgv2VbnZI4BCBGUGJFrovtDXsKk4ROzZuVdY9h1A==
X-Received: by 2002:a17:907:3e15:b0:b76:6c85:9b60 with SMTP id a640c23a62f3a-b767125f72amr248162566b.0.1763736141018;
        Fri, 21 Nov 2025 06:42:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpQh6yhHLGUKo/wsq6kHeGVp0vh9x4lS+/i68Gveg8Lfs4eInJ/Ie4BbRYyCHHJYP4NTl6tw==
X-Received: by 2002:a17:907:3e15:b0:b76:6c85:9b60 with SMTP id a640c23a62f3a-b767125f72amr248158866b.0.1763736140567;
        Fri, 21 Nov 2025 06:42:20 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550191c8sm460235266b.54.2025.11.21.06.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:42:19 -0800 (PST)
Date: Fri, 21 Nov 2025 15:42:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Message-ID: <xswlfomv65abcbcp6vcjzu5vr7hen4rvayviniyjynawvq5ghn@wmp224bnmpd4>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:40PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>These functions are reused by the VM tests to collect and compare dmesg
>warnings and oops counts. The future VM-specific tests use them heavily.
>This patches relies on vm_ssh() already supporting namespaces.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- break these out into an earlier patch so that they can be used
>  directly in new patches (instead of causing churn by adding this
>  later)
>---
> tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 4da91828a6a0..1623e4da15e2 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -389,6 +389,17 @@ host_wait_for_listener() {
> 	fi
> }
>
>+vm_dmesg_oops_count() {
>+	local ns=$1
>+
>+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
>+}
>+
>+vm_dmesg_warn_count() {
>+	local ns=$1
>+
>+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
>+}
>
> vm_vsock_test() {
> 	local ns=$1
>@@ -596,8 +607,8 @@ run_shared_vm_test() {
>
> 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
>-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
>+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
>
> 	name=$(echo "${1}" | awk '{ print $1 }')
> 	eval test_"${name}"
>@@ -615,13 +626,13 @@ run_shared_vm_test() {
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
> 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
> 		echo "FAIL: kernel oops detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
>-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
> 		echo "FAIL: kernel warning detected on vm" | log_host
> 		rc=$KSFT_FAIL
>
>-- 
>2.47.3
>


