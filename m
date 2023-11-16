Return-Path: <linux-kselftest+bounces-209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC87EE04A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AAA280FA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F02F84A;
	Thu, 16 Nov 2023 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7YTNNue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A0C4
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 04:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700136054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJEaqLcE8LMZlLtaRlJKiYIAGpgF6F9Co9xx2cwkfaM=;
	b=T7YTNNue0grbMReHcmcODeYYKcwetwe0XBe0USyrRjKHqdLSwW9pyxkZqhnSY8Od93hsAZ
	FUcgCfnlVOqYbSPr9tw6IVP1LWnxoWZ3EexBh07zxk2UJd60i12HFrmGWBsKO3rcqbGlxC
	3Wbq09qtV1Dg04aflSZodzP/EHambqo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-jVVxb83VPRafnmxMKB8_vg-1; Thu, 16 Nov 2023 07:00:52 -0500
X-MC-Unique: jVVxb83VPRafnmxMKB8_vg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cc9224395so8961981cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 04:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136052; x=1700740852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJEaqLcE8LMZlLtaRlJKiYIAGpgF6F9Co9xx2cwkfaM=;
        b=BnV4zocErqXSx8huh1SVsc0lARt3olErpv1Jd64Z6ONGi30jfQ1VEOalwIuuk3wPHs
         18YW+047+HNLlS2M1K0wLoBsLaJsqK4AXb0RNqf1wq1oJuAjKGda4VxuIqu3kK7miZ65
         HCaeuEW70uI5sEXvOmOvrordRnaDMPBWsMW5kitL6BfOpB5WTreTCNdFuSHsHNbuaNjf
         Sf8YmTxukiThT9sqYmzZQnz7V+Lj2mywU7PZsSvbVAxIwpvEi3uZgURM1RXkWvvKDa1i
         sxV8dnI772xch9+xRjG6GA+gxU1E4KsbFIqpAUpWAMqsDgcjtm3BtKsdkuubfmNPucXQ
         hjQw==
X-Gm-Message-State: AOJu0YxohKby02m+VXjlN476VWKCOGVJZXpXyi1uMDZl5Z35Dwt6WeCL
	e9zs+GFXHcV6UMUycWAGW+hsTpFjgE9uidrcY63OGfI2WZ8mLZqOgyFfwe0gUq0rGP+iWryMGOk
	NXQEUqQYXiLhWGV1Yvzd0s/FQniq5
X-Received: by 2002:ac8:4e56:0:b0:421:c9a0:3e9b with SMTP id e22-20020ac84e56000000b00421c9a03e9bmr10037086qtw.3.1700136052282;
        Thu, 16 Nov 2023 04:00:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1/IWAdCHnltnz/yj6txJliOQv9AD9LCa2gapSrP4v9cvJOfR3amYIwYxVui43ueMcT5wRmg==
X-Received: by 2002:ac8:4e56:0:b0:421:c9a0:3e9b with SMTP id e22-20020ac84e56000000b00421c9a03e9bmr10037062qtw.3.1700136051926;
        Thu, 16 Nov 2023 04:00:51 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id df4-20020a05622a0ec400b0040331a24f16sm4294893qtb.3.2023.11.16.04.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 04:00:51 -0800 (PST)
Message-ID: <e2d18278-1fdb-440e-8009-4ec49749b71c@redhat.com>
Date: Thu, 16 Nov 2023 14:00:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
To: Joe Perches <joe@perches.com>, workflows@vger.kernel.org,
 Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "Darrick J . Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <2e8979163c8ed93f6990c6a91c34cdf96a76daaf.camel@perches.com>
Content-Language: en-US
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <2e8979163c8ed93f6990c6a91c34cdf96a76daaf.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/23 20:31, Joe Perches wrote:
> On Wed, 2023-11-15 at 19:43 +0200, Nikolai Kondrashov wrote:
>> Introduce a new 'V:' ("Verify") field to MAINTAINERS. The field accepts
>> a name of a test suite which is required to be executed for each
>> contribution to the subsystem.
> 
> Perhaps this is simply too much overhead
> process requirements for most kernel work.
> 
> While the addition of V: seems ok, I think
> putting the verification in checkpatch is
> odd at best and the verification of test
> execution should be a separate script.

I agree that this extends checkpatch.pl responsibilities somewhat. In the 
sense that it requires you to do something beside changing the patch itself. 
OTOH, checkpatch.pl already requires Signed-off-by:, which prompts you to 
check and clear up your authorship, similarly requiring work outside the patch.

At the same time, you're supposed to test your changes anyway. Sometimes it's 
manual and one-off, but often times running an existing test suite is at least 
beneficial, if not required.

In a sense, this is not *checkpatch.pl* itself requiring testing, but 
subsystem maintainers (who are opting in), and checkpatch.pl simply provides 
convenient means and an entry point for raising attention to maintainer's 
requests, and making it easier to discover the tests.

It also does *not* verify test execution, only alerts the contributors to the 
need, and requires certification. Again, similar to Signed-off-by:.

Nick


