Return-Path: <linux-kselftest+bounces-33393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69397ABD5AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF6B189C817
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA394279324;
	Tue, 20 May 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZCxduii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D0274657
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738708; cv=none; b=ETdSIsqbRf4oMxp+sj5bEUIKKiLqHZ1eWe2zk2pkWpyxJv/xw+YU1UvWr0JUM7NX6Ql3W7DjPljo1WxJy1i6Gbi8E9pOqH01G3I25W+jAqEvFo7q9DFWhyDbkhZErbFJgWFt84YTK21YiZWN1UqIxMKDatB5+b9jwvGdBOj/zyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738708; c=relaxed/simple;
	bh=XCjhuqMISSLiz8GE+zUfY3bVdPUVO6omDyP1PQiJ4QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKkdis0hyHBxzc4lmbDICPC/cRr9krUtktk2cIMhFo1nPcBAg34iBYxOoy14wXUVPQkV8924YVsn3tAalKEDQ83lZvPGyFuTzw1qn0/ks7X+niheQS3APRGmKur5nos1UjJU/HwHNInxiJNwQQOkAmiaLNthU03XvjTnn0FcAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZCxduii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747738705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D274b/Kowlx4frHiCJWZP9nEutUPctu6wUBTBcBAl+Q=;
	b=UZCxduiiwG1i3l5yH8810Rrkg3u55lHPVTYquZqV7p81FwpEt3eH+8DYwVEiJTLuDX6PeY
	vG+MC/EG/ZoBAtchDhKj/+1RYLAzYikOkA+TE54MK4jj3Zb/8Y7UtaTGZ3x2w4OmeJAp1s
	bYtz5uLyHfPxU7pxh2IZ/k701NFAqyI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-rqqvtrpzNW6DhlcvPdFRrw-1; Tue, 20 May 2025 06:58:22 -0400
X-MC-Unique: rqqvtrpzNW6DhlcvPdFRrw-1
X-Mimecast-MFC-AGG-ID: rqqvtrpzNW6DhlcvPdFRrw_1747738701
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso43772475e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747738701; x=1748343501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D274b/Kowlx4frHiCJWZP9nEutUPctu6wUBTBcBAl+Q=;
        b=LJPD209FVXoWiWE4jPfYZAeFhVicPlCGa/IvYb1PIXI2+cnL3PcqKReOJv+kVSXViY
         K4/JbIiDw15hJxIR9eKAa6bzKI/p41CNAWYHJtQmZSyt3Bo69sOwYNpgkcaFgfcGUovJ
         KRBBF7GUmnBbl7/fX7yiqz03xxyCoPxmNEhVIw8T3ZDKOFvJnAhiubC/6icK8TaL0/Nt
         Uw14/XTN2B+8Yk4kTjRGrgM7PUJXhOyq6xF2NxXD3Bg5XdcOmE6bqcbjWkBDFU3PCev1
         Qj03uJr3eMr2wOkQhuzQvyabK5RSBI6/ouZmiMJPKAVb3zTq5tBWyXSevQt0mOp1H18P
         6XLw==
X-Forwarded-Encrypted: i=1; AJvYcCV9G2/yMRBRAf5b5kh7ItpZqDR161bc4xj1M2ht5cE7id/Y+gUagNVHKxKLDzq1RWumGwMhyHf5xuf0pmipmts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKlv3x4aOUkW4/cgs0d5caPOGJxXAZON24zWD1MlLdIkgR17+
	Q9paJnjCV3pfZscSTKi8CELEJNgmD8cbAYvYG0eT8eVFsSuC2ZM/HZHnDxsXk055DiM+AjfScbD
	Pc2TkxsgF2td/UdscIUWkdtXhgZSb4tBhH70RAQ11z60xxCE34L/prq7i64lbEJdOOl0JGA==
X-Gm-Gg: ASbGncunM+3DnAT8KqyCC7ryOw7BXRomEBfZyq2WBfywDkcoxASYO34lrVyG0lxMLG2
	aPR1UQf8iCLUjggdoS4/6lePpKvDaZYbJB8GM5IcwjiGkqYfjF75vAWwyuHczyQra+DZ+oDCOwT
	K3iDzZWjJPVI8k8VbgkImnTCyCezzFQ4NCxsYE5UPMr1G8/tMYUCd4nfsk9/UdXy8J8/EeGjV3G
	RwQtcjeSAGUeuA9CGzjBF4GYimwbFxAX2X6SP+6gsapP+mQBd0OL/belY0JlbOIY7jYbtzE53BL
	WigzNZam+4G7ZWPbCoyQWVlv7sGNGIh4or3FzTKQXkRWjxH3Ob81hwlv03I=
X-Received: by 2002:a05:600c:34c9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-442fd671d12mr138378695e9.32.1747738701187;
        Tue, 20 May 2025 03:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvQyiml0UoaDF/88g9sn8ucNfch1PfIPLwL2A/DSRiTilof5rRlAsf3z16t0LsF6Ckj58VyA==
X-Received: by 2002:a05:600c:34c9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-442fd671d12mr138378435e9.32.1747738700827;
        Tue, 20 May 2025 03:58:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca9417dsm15708833f8f.101.2025.05.20.03.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:58:20 -0700 (PDT)
Message-ID: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Date: Tue, 20 May 2025 12:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> On Thu, May 15, 2025 at 03:00:48PM -0700, Bobby Eshleman wrote:
>> This commit introduces a new vmtest.sh runner for vsock.
>>
>> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>> H2G, and loopback. The testing tools from tools/testing/vsock/ are
>> reused. Currently, only vsock_test is used.
>>
>> VMCI and hyperv support is automatically built, though not used.
>>
>> Only tested on x86.
>>
>> To run:
>>
>>  $ make -C tools/testing/selftests TARGETS=vsock
>>  $ tools/testing/selftests/vsock/vmtest.sh
> 
> I am a little confused, now we have removed the kernel build step, so 
> how should I test this? (It's running my fedora kernel, but then ssh 
> fails to connect)
> 
> Would it be better to re-introduce the build phase at least in the 
> script as optional (not used by selftest, but usable if you want to use 
> the script directly)?
> 
> Or at least I think we should explain that the script launches the 
> running kernel, because the config file introduced by this patch 
> confused me. How it's supposed to be used?

This is the usual selftests schema. The user has to build and install
the kernel including the specified config before running the tests, see

make help |grep kselftest

Also this is what we do for our CI:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

@Bobby: AFAICS this now has all the ingredients to fit NIPA integration
am I correct? the last commit message sentence could possibly be dropped.

Still it could be worthy to re-introduce (behind a command line option)
the ability to build the kernel as per Stefano request, to fit his
existing workflow (sorry for the partial back and forth).

Thanks,

Paolo


