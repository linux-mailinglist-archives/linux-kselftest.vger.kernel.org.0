Return-Path: <linux-kselftest+bounces-703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C697FB931
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E236228258A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D74F5E1;
	Tue, 28 Nov 2023 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUoqSiyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF9109
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701170133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwvmjFErIGzwz5go6JPDHcyZkRWLzYD3EQT1Kkemfnk=;
	b=IUoqSiydIkw8KkNlR6JHp2TA5W1iN4OdPbDWc3INONNNTSPj8yxd5SAeC3ShJk5OhBki8o
	IqyQrm/RbttZcMuVByMzsmQi3gTvsKDa4gMRLv+SLxPEhk947uGuQtYVxTCbhkiTGSkxxQ
	zlcXZr1d/7e+qONA7wDtmkbyP7+Q+24=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-8HzUDhzNMzeHsKqDWt8xyA-1; Tue, 28 Nov 2023 06:15:31 -0500
X-MC-Unique: 8HzUDhzNMzeHsKqDWt8xyA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b38501d82so27972115e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 03:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170130; x=1701774930;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwvmjFErIGzwz5go6JPDHcyZkRWLzYD3EQT1Kkemfnk=;
        b=SpYq+rZ14BF6bc/+xHEK/xMXZt1/zEbaP9PvS5RuSKbl3rl12JVFCEuyrcv4ezgkcn
         DkiIUn+fA9pP9R80Ctwjn+4Fs8K64JQB6YMozLfYYEvPGS81Uo8FgMaP+3LnLx09SAqH
         sgE3nYkWhaSPdsrF/hxohn2tvdrtOVYWDvvJc0hoAhvQ8ZhJjmmIEA6TX10UAq9pv3FJ
         PFHlbHSJZnZyCwRD6/skBRM3El1u3BgpOAG+PqFu38pC9Hj/mkG1Wv9B98j2xo7j5jdW
         IWkpqEycqq3Q31d9tOR/pNu/DESpEkiin2j1ZXpzQcHgyCKVV1Brl6eAKcVJ6alMy9OJ
         Wv+Q==
X-Gm-Message-State: AOJu0YykZd8JHAbHv/a4IT8ioCkc4vLZMZzyycaJzuWvyzCaQlxOj/RO
	wzVwVQYaFqMKpqLhvY1qwQFRzImNvmlolkP7cf5KtmbuWJxxX+v6fRIdNi1mQSaWm40GqvM4FVT
	tdcQsGu+Vv18dZhTisuz2gEvT4Ahn
X-Received: by 2002:a05:600c:46ce:b0:405:37bb:d942 with SMTP id q14-20020a05600c46ce00b0040537bbd942mr11304275wmo.4.1701170129909;
        Tue, 28 Nov 2023 03:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjIkoXG2gDHfX1ljO9mtdizJ2dUC2E1WgpYfyZokwGf55M1EY3JopOUWWYB/pF4LqfYH+Xmg==
X-Received: by 2002:a05:600c:46ce:b0:405:37bb:d942 with SMTP id q14-20020a05600c46ce00b0040537bbd942mr11304257wmo.4.1701170129524;
        Tue, 28 Nov 2023 03:15:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm17744555wmq.12.2023.11.28.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:15:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marco Pagani <marpagan@redhat.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: run test suites only after module
 initialization completes
In-Reply-To: <20231128101627.65399-1-marpagan@redhat.com>
References: <20231128101627.65399-1-marpagan@redhat.com>
Date: Tue, 28 Nov 2023 12:15:28 +0100
Message-ID: <878r6icenj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marco Pagani <marpagan@redhat.com> writes:

Hello Marco,

[...]

> @@ -737,12 +738,14 @@ static void kunit_module_exit(struct module *mod)
>  	};
>  	const char *action = kunit_action();
>  
> +	if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +		return;
> +

I would add a comment here explaining why this condition is checked and
what it means. Maybe something like the following ?

+       /*
+        * Check if the kunit test suite start address is a virtual
+        * address or a direct mapping address. This is used as an
+        * indication of whether the kunit_filter_suites() was used
+        * to filter the kunit test suite or not.
+        *
+        * If is not a virtual address, then this means that the
+        * kunit_module_init() function was not called and the kunit
+        * suite was not filtered. Let's just bail out in that case.
+        */
+       if (!suite_set.start || !virt_addr_valid(suite_set.start))
+               return;

The patch makes sense to me though and agree that is a better approach.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


