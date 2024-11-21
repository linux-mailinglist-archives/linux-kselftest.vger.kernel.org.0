Return-Path: <linux-kselftest+bounces-22388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430929D4877
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECCAB20A9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A81C9EB9;
	Thu, 21 Nov 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwbcy+4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199F12FB1B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176502; cv=none; b=dA9+RiXBWjhfURQ1dDADOSPjaIfUL+RsTAdBbRxDluN7/0HtffGWxHwRCNGk+l+gPiSYBVpCZswo1r92yIe4YUItEc71c8b5kveR4knaROxrkOf+gtCvY6KSoQT1rFcu6D7vy7VXd/PkcLTZU3r1UVcEd8csBCZcVnop/b7QJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176502; c=relaxed/simple;
	bh=tT7YBJNorA78NtW+h2g6Bp30Fo2ROMFtaucoSo7S5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR7Q/gx4SMPlfRyzydjqHZM5x/dYqS5Z437ftojw4DMuo2xQZzUk9p4iX1ZLg1HUn/ALNehSHg5piwkt5MpFJldKFENH9yTfz+evErsNRdEKs0ypUMIwzaK5T22AhP59ZCnKQG1h6kk28hqN0n1ig4jPoPjiqDWAl4CTqf0U0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwbcy+4/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732176498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiLOQpixEQH0kTmOgak1nkUr3AduAJzONuvMstNuPig=;
	b=Mwbcy+4/l1nJ+CU27Q5c1lAUCwdLYnGce7A4mQ8qBgttZOVP/ytDsXM4XujZqmq9zHOcRz
	Ebv3X/+eahbJV0pX0cHqF0Vmy1mmysiiQyB826wr9qjpiIOa8rfKKG6kBa5Faz1xqkOFOC
	FYx/0/NcvHDPr0ZaaA7Le9pxTWClEYk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-oS4wI22-NIq7wZk4jhVhCg-1; Thu, 21 Nov 2024 03:08:17 -0500
X-MC-Unique: oS4wI22-NIq7wZk4jhVhCg-1
X-Mimecast-MFC-AGG-ID: oS4wI22-NIq7wZk4jhVhCg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0710ca24so35832366b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 00:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176496; x=1732781296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLOQpixEQH0kTmOgak1nkUr3AduAJzONuvMstNuPig=;
        b=scL29/ke8msKpaos3YboxwHi4z3/4pjSn9WK8RbijPmvTVK+DES3iKzBOW6dEpTSvb
         CFb1NFqJLwvVHZnFszFpxKY8BQ3AzGjq0izN0r6oJBuV3QMVIvZBA7Vrm++GyOl6V1qS
         nipFO7YZI9ejX0ldcY3P+P1+5woLVa2k8onCd3E7vdpxVIu6uhhJYVycnL6KF6Jp/slg
         5j9jzdGL4M09P7zaAQtHX27DLgqa+ClyzEHlKvRPLVlR3FPbw1GulTKvKQe5wSJ88CKV
         SxEyzmOTYKrGgxb/eZSh5wBB9l+v6iES7oUgkuDRa4DdtuqMm3SwLPswTe9zbWob6ri5
         W5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVLUowC+5ZtgdXz6BOHe2r2IndcZB/CRNoopYF5t1eWn+mz6eZVMKjdPDRQ4h/tD9l9BuWEtVIWAStEs/eaJK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKxNt0eZIdzLG434VCAd5fRzaO51kgisDC9T+gRLwdQnthQUT
	QvOjYWxyBZSHRD+b78m7e32GDgB8Nzw3amfU5BhRm1P2hbJFBXyEiXoQEGZzctUPpY/4/V683pw
	wG4XQmXzhSNKi+HrAVSSeH+s4tscXFA6BU/c3EYcQAnzc8qG5b5DIARXQ7qAhbP2+8A==
X-Received: by 2002:a17:907:9281:b0:a9a:29a9:70bb with SMTP id a640c23a62f3a-aa4dd55f301mr584433166b.14.1732176496201;
        Thu, 21 Nov 2024 00:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLV8GtgiUmwTWOW4ibJlykXJcnoVzc7grG0b7K1GLmAjXqBnc3tKQZzmq3ICbt0FpI7LwCyw==
X-Received: by 2002:a17:907:9281:b0:a9a:29a9:70bb with SMTP id a640c23a62f3a-aa4dd55f301mr584429666b.14.1732176495606;
        Thu, 21 Nov 2024 00:08:15 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41530e9sm50378566b.39.2024.11.21.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:08:15 -0800 (PST)
Date: Thu, 21 Nov 2024 09:08:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
Message-ID: <dpt2h73fnzgzufuvilmaw5lbs2nydc3572xqn4yoicateys6cb@reuefsarvhka>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <673ed7b929dbe_157a2089e@john.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <673ed7b929dbe_157a2089e@john.notmuch>

On Wed, Nov 20, 2024 at 10:48:25PM -0800, John Fastabend wrote:
>Michal Luczaj wrote:
>> Two small fixes for vsock: poll() missing a queue check, and close() not
>> invoking sockmap cleanup.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Michal Luczaj (4):
>>       bpf, vsock: Fix poll() missing a queue
>>       selftest/bpf: Add test for af_vsock poll()
>>       bpf, vsock: Invoke proto::close on close()
>>       selftest/bpf: Add test for vsock removal from sockmap on close()
>>
>>  net/vmw_vsock/af_vsock.c                           | 70 ++++++++++++--------
>>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 ++++++++++++++++++++++
>>  2 files changed, 120 insertions(+), 27 deletions(-)
>> ---
>> base-commit: 6c4139b0f19b7397286897caee379f8321e78272
>> change-id: 20241118-vsock-bpf-poll-close-64f432e682ec
>>
>> Best regards,
>> --
>> Michal Luczaj <mhal@rbox.co>
>>
>
>LGTM, would be nice to get an ack from someone on the vsock side
>though.

Sorry, is at the top of my list but other urgent things have come up.

I will review it by today.

Stefano

>
>Acked-by: John Fastabend <john.fastabend@gmail.com>
>


