Return-Path: <linux-kselftest+bounces-25657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5509A26F9E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5087D165659
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6420B1E1;
	Tue,  4 Feb 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J45efOV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B520AF96
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666565; cv=none; b=gqp0ieYtU4gUmIutjRVZ2MZa4Qw3jjyhSVg4HZ3bfh/vKZ9gx6rQR2ZR2c26Z88HFQLWA/Sjx+Jg1DOqQJwIz9BG0wooBBzNCZdYOkzWrEEIsHL75PgBYlFeRpaS5hoFjKmkWvxECSg2fJCQCyWADkm/u1o+WY8kYLMWhieQkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666565; c=relaxed/simple;
	bh=4beXukFVHQs5nCd6JCJWPrisRK6PKYiJfHKwE1xknk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTi3jUtxCwRYj5Bya8Hf7uiCmBGv1zQpG2oW/Oej7KT1NdBKeQQnFovtuLNMCfI4OM/nMOLUtXAyTBltFkGbXk81sFA3ke3tPtxlMSOYztbvv2Hoyv+5z/spFJ43AJx0oXT2Pvq8DkJ2fIZD+EBcRwgsbpid3EL7hEKuTAZDPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J45efOV2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738666562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4beXukFVHQs5nCd6JCJWPrisRK6PKYiJfHKwE1xknk4=;
	b=J45efOV2yB10gJHZmgAX/gyK39kiWyyT/lh6zJxLCxx41GfpkVdMGd7SF57WD3FkilFRRt
	UvIk3KWLlh9MDn4lEum8uVHDz5YKufeNI4kUTE0UH2eNRuc3541GgzngnhOCtIvEQJ5MV5
	YbOV4JvKqLILngWoiQr8/rt4rZENWtg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-lvLtpoExO8qNoZl2OWS-MA-1; Tue, 04 Feb 2025 05:56:00 -0500
X-MC-Unique: lvLtpoExO8qNoZl2OWS-MA-1
X-Mimecast-MFC-AGG-ID: lvLtpoExO8qNoZl2OWS-MA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43628594d34so28266675e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 02:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666559; x=1739271359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4beXukFVHQs5nCd6JCJWPrisRK6PKYiJfHKwE1xknk4=;
        b=oepbuNxTtwEXIqCM60rnzIea16hSHkXzzPLOBDmC4fb8LDWkjCaCa3r0sZSXxZ7Mp4
         +rFS+VX22xvDtkx0mJY/l/6l7ZOdw6VwyeQ7wlRvGHL9xtJgswWR/5p1ZvoJUtvQWsam
         /ixqTPijMveIdiu+ZzjAeeYGjQhO7bxkvZNfkh5IhiyFZjeYbUySrodKp3D1pbW+Skxl
         xDQpKAvlkVIwPBLxYn072+K3X1dS7g7EXcgKv3hSo2Qno4WS/PRAg4vqJ91k5K9zOERX
         TdBHy+e0p+2rKZClOSVc+9cjVZDlli02OEG7crEZG7tAbJQlRgnED78g6W2nJhtVNz68
         uuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV85C+DSaj98lbiE6XoKFvldxUDynY2bwEnroD97kuTipKl3cBYh9UqLf9ORqvvwRN9tghATeraBEi86O47mK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+CBBtsuQOXKQBfOCO8uXM/EI0JRpewyVHq52bico+26SMMRe
	pAxXuHqZMNC6/C2atDWQGl0R/q8zFOIREdRp2syrvOZUX2vpbh3VpUM3a1NKJwZLoUfQXl0psvy
	AuEmScp3o5DnpvGRecK/KrPwyek2lt3eN0fn6vju00BS+qyUKLiyOdUWl2ALBm1UaNQ==
X-Gm-Gg: ASbGncuLoZKG+h6uM6IqP3V0jR1i317SlfNL8JYuSvM/GLfsPt0aRM7V7j4SQd5IfAK
	hqLo9clBGHuXkT1ENCibYSCuH5PAbG8/FvZAIiXz4VQAqxjwzh0UMne86fwSlGoRwOdeDLJRDqe
	W+DgOptOdwDsu0GOucwr7YFZN+yY5Pehm4PDxGYH6vC5SWVqD/8mD0PIR08B8lJ4Gn8JLu5V5jz
	qMaP+Waguas4BrCCZP5SOpSdteNxxdiobMwmnx0S3ecQk0V7oNsdRwLC+qJdznu8otqNCAO6erG
	b+61MNIqsD72AdGzhge534sGqwaYmFBYscM=
X-Received: by 2002:a05:600c:a04:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-438dc436a08mr231815265e9.30.1738666558937;
        Tue, 04 Feb 2025 02:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPKWXjdX96lQCIbHeahFyYNkKOqGVKxcOxbbsF5GMJwC3hZR+QmB4vaH/E0IBr/11HWe+7+Q==
X-Received: by 2002:a05:600c:a04:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-438dc436a08mr231815125e9.30.1738666558603;
        Tue, 04 Feb 2025 02:55:58 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc26cefsm220335895e9.13.2025.02.04.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:55:58 -0800 (PST)
Message-ID: <835481c6-0ac1-47a7-84b2-fa5a135186c2@redhat.com>
Date: Tue, 4 Feb 2025 11:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/10] net: pktgen: enable 'param=value'
 parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-3-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203170201.1661703-3-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 6:01 PM, Peter Seiderer wrote:
> Enable additional to 'parm value' the 'param=value' parsing

It could be language bias on my side, by I find the above statement hard
to parse. Could you please rephrase it?

IMHO something alike:

"""
Enable more flexible parameters syntax, allowing "param=value" in
addition to the already supported "param value" pattern.
"""

Thanks,

Paolo


