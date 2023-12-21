Return-Path: <linux-kselftest+bounces-2318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EB81BF74
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 21:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4CB1C2476B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B2745E5;
	Thu, 21 Dec 2023 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="htjTw8g8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0773191
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35fd239f2cfso257195ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703189418; x=1703794218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuNcu+xSyjheqKIJeQgDsNTkefgj8XV+ZlyaXQLWUtQ=;
        b=htjTw8g8ZMl5/1bCZWg7QJZ0R2bBW3H0bSln7Nk2PsHatqe4pZT9je6JGPKugqgeMB
         1p2YJvrhC+ApTKUGcYyREZFb0dq3iVhJFoyCUcYItKd2rxxcfBSJXiUoqSdtgjLYjcnK
         sadUeqkJ55d8+Dw/4ctRnY7fGXNQr4J59/yeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189418; x=1703794218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuNcu+xSyjheqKIJeQgDsNTkefgj8XV+ZlyaXQLWUtQ=;
        b=bB9T82kSZ9fYD1wsycmbTbgKpVycsU7yEwkWPq9tsara37rfKaSHFH+NZ4aJ8e7602
         JVXn1gaH842UzLn7OGoKuLh7/2DD0aY63QIF5cSDjaWsiHyTODjC/LOW/hg4XY8vx43a
         kDK1CKd1r5tB9NKpV2Ul5vB+NYD5d+b7ZH3ROOETBuCBlwN4NAMs4k/eFh/diqGbw5+2
         caPQJJkp11lD1YUIrBRXfR8Rt1u55drVx7k/inJnzHVa22HP+8rjuJF6nymrbKSZdcic
         pFK7psN7AWKC4uhR2KUVmkmgogNRigWFZHKaG3pXNVeMCo640yWgUsjRcZ25j9eedraY
         SqgA==
X-Gm-Message-State: AOJu0YwTyNMvDWhYIrqLATjWCHfiVZSZDKwxssnwmhcX2NYKbxki6NV/
	nQrk2e3CeWv0Gebz1btEAluxpBwnrQ9v8w==
X-Google-Smtp-Source: AGHT+IF1UnXSpqilXx5/i0ZEyW2V9x9IQmgHrp0PwIlsARHqqwSbXr2zVL9aQML5DMWwebj2OtVrKg==
X-Received: by 2002:a05:6e02:1cab:b0:35f:d862:e451 with SMTP id x11-20020a056e021cab00b0035fd862e451mr384657ill.2.1703189418192;
        Thu, 21 Dec 2023 12:10:18 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f8-20020a056e020b4800b0035fc47d9014sm694293ilu.13.2023.12.21.12.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:10:17 -0800 (PST)
Message-ID: <4fb5fac7-fa3a-4988-b5f4-8025864c4d37@linuxfoundation.org>
Date: Thu, 21 Dec 2023 13:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 0/3] livepatch: Move modules to selftests and
 add a new test
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
 <55b717dba239f3bedf0da7e25925e390a63459f5.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <55b717dba239f3bedf0da7e25925e390a63459f5.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/21/23 05:17, Marcos Paulo de Souza wrote:
> On Wed, 2023-12-20 at 13:53 -0300, Marcos Paulo de Souza wrote:
>> Changes in v4:
>> * Documented how to compile the livepatch selftests without running
>> the
>>    tests (Joe)
>> * Removed the mention to lib/livepatch on MAINTAINERS file, reported
>> by
>>    checkpatch.
>>
> 
> To clarify: this is not a resend, this is the v4 that people were
> waiting for. I made a mistake with b4 tool, that first I sent the email
> just to myself, for testing, and it bumped the version to v5, but I
> asked it to "resend" the v4, but it ended up adding the "RESEND" to the
> series.
> 
> Please review this patchset and ignore the RESEND word.
> 
> Thanks to Petr Mladek for spotting my mistake.
> 

Thank for the clarification. I was wondering why this is a RESEND :)
I will wait for reviewers to comment on this before pulling them in
for Linux 6.8-rc1.

thanks,
-- Shuah


