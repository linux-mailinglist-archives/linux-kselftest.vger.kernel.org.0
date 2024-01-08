Return-Path: <linux-kselftest+bounces-2713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A5826BAF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A41F22303
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433C13AED;
	Mon,  8 Jan 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOP41iJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978F14274
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jan 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704710553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+r2fYi5GswwOIpq/KUCbsfARWs5bIzb/5yg8FLKiuo=;
	b=XOP41iJxNDBRT1Hc7O5oCKPkHY4cTF6Gbh2IhR8w3kemyn1t+Rc9x/s+zarCFIZo6nGtWD
	0hXwYt1lgJReMHHvODkcp+FjL1N571i9KRlfGHaua5D4AeFNwSuaG/4gSIxrEf974UPKr5
	LUCzaz5Wh2pO/iId107WuSuxbjWsUjU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-RnFeAVSqMDC1Dd3bYG6FUA-1; Mon, 08 Jan 2024 05:42:31 -0500
X-MC-Unique: RnFeAVSqMDC1Dd3bYG6FUA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78319f5d6edso211179485a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jan 2024 02:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710551; x=1705315351;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+r2fYi5GswwOIpq/KUCbsfARWs5bIzb/5yg8FLKiuo=;
        b=PUokzeQ8ecAGd5MLNnvHCRbEaMkLS6EPO96vIO0grsZlPfuhGLviKKhGWJT64FnGI7
         Ca49FMLVKbjywCiy+tujbVCDUeb1nFQoBqZy9T89YIRpnnM0L3VjAEeLF0dAkZM5gEeM
         XAzakpUQpyZbrQoR85pMZkANWVlCBrVRPpUCz6LWy8e6+p+g3URl0F3hFKRAYXZbgCml
         CJBL4BJmXQaepUlEuSSpEAmt/dL2DetRdimvSFj+7bYiGETcdLgcYisNx8uynbUtDiSI
         dUPtmrtsepeS9v70IecSPhjugcqq/zgBd+JnyIA8db1mKTOxpSieP9gFs7rMaMGwnM07
         3QkA==
X-Gm-Message-State: AOJu0YyzyTFY/BWs0O7Sliu7ej2mXRMqQ5ng29GrtlCQzuvy7HB5uReD
	8GwcRNXYo89WT+IaJVgjpGRujG/vY7HGPW5oGO9R9MYA83aD/Kvyrul6DUcZmbnWxUm1aXq0IR1
	SVcXgRG0Uep56lxkRUky69STq+6ol8jwFEVXZ
X-Received: by 2002:a05:620a:5343:b0:781:577b:7572 with SMTP id op3-20020a05620a534300b00781577b7572mr3517201qkn.67.1704710551414;
        Mon, 08 Jan 2024 02:42:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkW4yie3FuTD9oNS2SS1mGtIhe2UW2QQqteBJuOJDUuID0HDhy3F+KPbsT61NUAUiMF7Q4QQ==
X-Received: by 2002:a05:620a:5343:b0:781:577b:7572 with SMTP id op3-20020a05620a534300b00781577b7572mr3517186qkn.67.1704710551175;
        Mon, 08 Jan 2024 02:42:31 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id g17-20020a05620a219100b0078327d52206sm146382qka.63.2024.01.08.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 02:42:29 -0800 (PST)
Message-ID: <d2e2c852-aa6c-42b7-aa73-1b366dd48fcf@redhat.com>
Date: Mon, 8 Jan 2024 12:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/10] MAINTAINERS: Introduce V: entry for tests
Content-Language: en-US
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
 Theodore Ts'o <tytso@mit.edu>, David Gow <davidgow@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong"
 <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 20:02, Nikolai Kondrashov wrote:
> Alright, here's a second version, attempting to address as many concerns as
> possible. It's likely I've missed something, though.

Happy New Year, everyone! Hope your holidays went smoothly and peacefully.

Is anyone still interested in this effort? Any more feedback you have in mind?
Something to change?

Thanks!
Nick


