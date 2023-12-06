Return-Path: <linux-kselftest+bounces-1296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ADB8074E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9201F21182
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9A47762;
	Wed,  6 Dec 2023 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQV69eSS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07AE137
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701879837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEeLgq3tKfeo+gDdZ+RSrAtJVLsXviPr2EfsX6Jr+7w=;
	b=CQV69eSSBUiFKz/NWaJxvQdmGsxOcmD7ehgIMz84jxrATHXgCM4n2AfP5x5fGFTBnL8BgX
	jYYqBcU9DZMkWcliyyku+D8SusL9jLnFB72VaoCyWgpthKC7yffCYQEBoXM0mxUOQxvf8O
	K4jYPtmp4NKk643LY0BrLvwcctIXYWU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-sVArkIdgOc-eu7g3GzweHw-1; Wed, 06 Dec 2023 11:23:55 -0500
X-MC-Unique: sVArkIdgOc-eu7g3GzweHw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b310b5453so47860285e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 08:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879834; x=1702484634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEeLgq3tKfeo+gDdZ+RSrAtJVLsXviPr2EfsX6Jr+7w=;
        b=lFLVCO7koSk3uQcPmNDs2DSKQADrl0O4CwdrL5Fphv6/Xy0svghKHZsNUqlRn560lk
         kLxqXvfALwxt3eN4Rzny9Wo2p+VYYxwMhalfLoUMQwIZfZ9OUYZGYXa/8/2Nu7ICdUZM
         ZsjvLoizwzTmV/5QO9VjEe1vE4qIUojtiQmYaPb2UJhGfMTCxvyURpRme6lOiMnWwhJ9
         soAJhHFpN1VJnxBAi15DZI8QLglG4y0Y0soyGnDKgLRGuyWxGIK9p+J7Phq/sNu7nAQi
         TdRjtpB3ZwtLF7ySDveAl3exjy82IWAA8SaCg2652F5Aok93OLLrJk/XIjPrB89l9oS9
         G01w==
X-Gm-Message-State: AOJu0YysX+n+vSBe1rUUh2N9NWiNtq/NZ7s3q0knaFBEuBf5qxh/kWjK
	oy8I46e938Ma+6okE9VltNP1gi5KQIJ9EZUwQWpd5W5BnaCsJHT9NQplQUCpSIbHg9dPZ6Vzfxg
	384Bxpyt+rzftCaEvZF5fZ95KNhSx
X-Received: by 2002:a05:600c:54f1:b0:40c:838:a695 with SMTP id jb17-20020a05600c54f100b0040c0838a695mr664575wmb.174.1701879834183;
        Wed, 06 Dec 2023 08:23:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwz5MnYWQbASuNlLkNiWsEDxekCPXedq1zH8YxfdaJZ9iXOBY3+Os5iiOyqzo1HtFVVnI73g==
X-Received: by 2002:a05:600c:54f1:b0:40c:838:a695 with SMTP id jb17-20020a05600c54f100b0040c0838a695mr664563wmb.174.1701879833914;
        Wed, 06 Dec 2023 08:23:53 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05600c3d8c00b0040b54335d57sm178976wmb.17.2023.12.06.08.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:23:53 -0800 (PST)
Message-ID: <f64c8105-5373-4dfb-b48c-655221accd19@redhat.com>
Date: Wed, 6 Dec 2023 18:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/10] MAINTAINERS: Introduce V: entry for tests
Content-Language: en-US
To: David Gow <davidgow@google.com>
Cc: workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
 Theodore Ts'o <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
 CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-3-Nikolai.Kondrashov@redhat.com>
 <CABVgOSnCNJcEfVp_k3emEHziYx55ecNaEj4fsbcfgrsCN4CrNQ@mail.gmail.com>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <CABVgOSnCNJcEfVp_k3emEHziYx55ecNaEj4fsbcfgrsCN4CrNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/23 10:12, David Gow wrote:
> I'm pretty happy with this personally, though I definitely think we
> need the support for tests which aren't just executable scripts (e.g.
> the docs in patch 6).
> 
> The get_maintailer.pl bits, and hence the requirement to not include
> '@', feel a little bit 'off': I'd rather get_maintainer.pl kept emails
> and tests separate by some other means (either having --test _only_
> print tests, not emails at all, or by giving them a prefix like
> 'TEST:' or something). But that is diverging more from the existing
> behaviour of get_maintainer.pl, so I could go either way.
> 
> Otherwise, this looks pretty good. I'll give it a proper test tomorrow
> alongside the other patches.

Thanks for the review, David!

Yeah, I don't like the '@' bit myself, but it seems to be the path of least 
resistance right now (not necessarily the best one, of course).

I'm up for adding an option to get_maintainer.pl that disables email output, 
if people like that, though.

Nick


