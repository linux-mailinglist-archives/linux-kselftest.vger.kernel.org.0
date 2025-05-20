Return-Path: <linux-kselftest+bounces-33394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695EAABD66B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4077B3AD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C127F73E;
	Tue, 20 May 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly0Gi48E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58442686A8
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739377; cv=none; b=Mn1K7+7sHAIRTMiF2cn87OkClO7NS7Ny7UVFnFhbCHAv0i6rcwdr7N7KXZggOncSEmWNMYWUD1NQzaSkEooDyKK/dA7SDhpKgoV6FbtNGtMAnFtDhzRFuKrnDhAyGQElyb54u3g12iV3FyhLUPYb50IH/DwB5gFBQtk2xkuZqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739377; c=relaxed/simple;
	bh=DyjGjmIKPnH7C36i8ffActQ/GQ9mwbRyIId9YRlceUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A87kpkqSy3UHy0ESAILfhoWUffJaUeVxh4SYwSB8p3i34NiLkE39jRL39pAOMXojZNLGbE+jwX1P7mY9PlnjcjR3YHpPS8K32bwb3IwDaVDfP/4Jon80AycIKVDqUfrocr3uGQVeqMYd0/+sptz/YMh5E7sSLqQN1NSSbvYRtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly0Gi48E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747739373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DARJsHp4jsWx/AeNTG3Ix546yRHwSXlPjjzPU2VmlJs=;
	b=Ly0Gi48EC6Ro1oYwtH1YQy21QYrxKNSW7z8VC3gtjyFYN/72+rWOsg673CXNmmZ1lZna+S
	vipqRQSkWN/Rmfuy5nszAsN/lHMdiS+oBJq5LxADRBbrwwFsHCCjoQE9qHt/LhvqKrpmu/
	PUYpANs2HwQ5C5rjUQ0C1MhUbUpHJMI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Gli8kDyjO72x8VHJtNfP0g-1; Tue, 20 May 2025 07:09:32 -0400
X-MC-Unique: Gli8kDyjO72x8VHJtNfP0g-1
X-Mimecast-MFC-AGG-ID: Gli8kDyjO72x8VHJtNfP0g_1747739371
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb8f9f58ebso439405366b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 04:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747739371; x=1748344171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DARJsHp4jsWx/AeNTG3Ix546yRHwSXlPjjzPU2VmlJs=;
        b=a8RdS75g5cOvLh0bBmQs6zwWV4jtBdmJB4pyyZZUbePZa3Fkyt0Sm7LlmVZC5VPZ+C
         23d3KpYMvRe5Z7GNUnAI8NocMq4p5CP/YpoJUzzn1XnMvR2hH/g1OCDkZ5mTUeSATTES
         Bhqg0xdnhHSc+tAywEMiCFmnv8l2tk2kedPoDRQwkuS8iSlvi/1QNDFVohSvrcMdKCqs
         q4OxNvamat0w/XRSnvlz0/hpFDR3Erj/RJ129m3kUDQu4kO3dMqctiGyW4T2F0RSik3E
         YeDPT613yxp7cdvFJss3QVuQxMLhs5oGoL6otV5Z+L0lEJYly1WcGvN+LyKOfPpvJKvf
         /qLw==
X-Forwarded-Encrypted: i=1; AJvYcCXiz0MZsPQjGImIgkxLrh2Wlal1QtABJqdhjURGThDZLfyDPl+3Ct3BXkbTNQW4txfPtzV1QVcpE7Oxp7MGiik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKeyTd1j02zz4cTEZra83sIitQkTOMrvri19LN3HtHc398EYM
	pIJJ2o6riCqq3d4bAARBaiAh35oe0Do40bKST55r+kEZAhIaovbgUBCTyfr8ZoFT1EEpEb9Khrr
	+UXYGGJfpqKknj1BYvchNkefOevERAP9Pl2368AdY9YRKqjUxzSTm+yhcbYWTBZf+/OPGQw==
X-Gm-Gg: ASbGnctPsBqzhbBKdu63ZJh0vHy0Vsh+b29e2nz5h7u6zBiMoK2OKacyyBYwLcAQvFj
	4E3QEPsNi0q/Z+lAdmUXC3MvSzRLY9Q6W2S/4j/YHJlGlc+OLe3zPr7Agr2KabtBgLOHHOCok1Q
	7o8uYYnvi6BdUPXvU18pkKl/0s3sXOdyf0nuVoH/pQmFkFfKGDwtkBtwhRxJy6yr6c8EhQMQB8m
	ZqawzWA9TtDDkyIeWQpzpradfNniRLeyRyxtM+A6btO5d9fgEa0H4yFNjf7fEsFpugaZFEgBaX9
	jtuUewVI+BV4ao0XNmxSymSOLTPAZGqhPtTGBdQLLtPMyqQjPg7U4ulXRWd7
X-Received: by 2002:a17:907:d26:b0:ad5:715b:d1d4 with SMTP id a640c23a62f3a-ad5715bd3b3mr675885966b.32.1747739371288;
        Tue, 20 May 2025 04:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVmZPA0gP+lVwuu4tl/IU00u142/ZIBl7HKt5LlJNVBoXEwIpfvNF2MTZxVOWT8Ao84FYsRQ==
X-Received: by 2002:a17:907:d26:b0:ad5:715b:d1d4 with SMTP id a640c23a62f3a-ad5715bd3b3mr675881166b.32.1747739370698;
        Tue, 20 May 2025 04:09:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm722395766b.69.2025.05.20.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 04:09:30 -0700 (PDT)
Date: Tue, 20 May 2025 13:09:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <w6aizeb2i5m52e2ifqcikgwdbrkkbc46sf4hx5b6jsm7o4drio@n3dzlatb426s>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
 <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>

On Tue, May 20, 2025 at 12:58:18PM +0200, Paolo Abeni wrote:
>On 5/20/25 10:24 AM, Stefano Garzarella wrote:
>> On Thu, May 15, 2025 at 03:00:48PM -0700, Bobby Eshleman wrote:
>>> This commit introduces a new vmtest.sh runner for vsock.
>>>
>>> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>>> H2G, and loopback. The testing tools from tools/testing/vsock/ are
>>> reused. Currently, only vsock_test is used.
>>>
>>> VMCI and hyperv support is automatically built, though not used.
>>>
>>> Only tested on x86.
>>>
>>> To run:
>>>
>>>  $ make -C tools/testing/selftests TARGETS=vsock
>>>  $ tools/testing/selftests/vsock/vmtest.sh
>>
>> I am a little confused, now we have removed the kernel build step, so
>> how should I test this? (It's running my fedora kernel, but then ssh
>> fails to connect)
>>
>> Would it be better to re-introduce the build phase at least in the
>> script as optional (not used by selftest, but usable if you want to use
>> the script directly)?
>>
>> Or at least I think we should explain that the script launches the
>> running kernel, because the config file introduced by this patch
>> confused me. How it's supposed to be used?
>
>This is the usual selftests schema. The user has to build and install
>the kernel including the specified config before running the tests, see
>
>make help |grep kselftest
>
>Also this is what we do for our CI:
>
>https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Thanks for the link!

>
>@Bobby: AFAICS this now has all the ingredients to fit NIPA integration
>am I correct? the last commit message sentence could possibly be dropped.
>
>Still it could be worthy to re-introduce (behind a command line option)
>the ability to build the kernel as per Stefano request, to fit his
>existing workflow (sorry for the partial back and forth).

If that's possible, I'd appreciate it (not a strong opinion). Otherwise 
if we don't, I'd say take the use of the direct script out of the commit 
messaging, because to me it's confusing if we don't plan to use it 
without the selftest infrastructure.

Thanks,
Stefano


