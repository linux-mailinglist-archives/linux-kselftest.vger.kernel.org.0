Return-Path: <linux-kselftest+bounces-3752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DA842BFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEED1F25183
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471E78B5E;
	Tue, 30 Jan 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRvb/2YD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98E5B5CA
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640081; cv=none; b=KinMW87oc2rxxf5NMYfts2tXR0zJJzpp9OJarRDfK89jCd53jwvymKdkB3CRAG+Toep4qPW4VIkAyTINMUU8KRbFVWZrf3bkBRl76CUU0ZazYe4Ly/yy6rdBmy4Aa/8qdFeqxl6fi+vjB75SL1jZVeAgHAWD9s0OcMIbKgig/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640081; c=relaxed/simple;
	bh=gDDcUE6g9gBwt1NmVrUfXXqqkDrzBbdo/C9YjtcIXG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBdswNgwXXx5AqaAbO9uH8EZQ9Tz8GZ0doz4GrE+JI9pO+Q63MITGnDkD3GWdFediHqx6Dw24VwTbUZ4c6wnTlEj3ddhnD6jYkclK9h4RRsXi5Z+9yhKv9wc4LAbmLTYwPNl3YGcexqIpAwSj/iO1Nz0fna+1D+T/wrDI/xNhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRvb/2YD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706640078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2bwc+mQL6C/91m4UiYWrsmKalc17+Sz1UB9Xs7+dNW0=;
	b=KRvb/2YDSCPdFGF5kTirrNAU+mDv+MDFkNRgQO09BIdXikq1GE5wp8z6Ys24yFrp5KjGFz
	ECP5lWRrbSQM9mtdj4+ngymDw755wK2b7/vvwzrEnsvEAl9amw6yOi+oTtq1+fiU5+Hjgs
	yAVY67bZQJKAaYst0IVRS1P5kcXHlYo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-0IU6ZRSEM9i1b-p75Dalyw-1; Tue, 30 Jan 2024 13:41:14 -0500
X-MC-Unique: 0IU6ZRSEM9i1b-p75Dalyw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5111de3fc23so124294e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 10:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640073; x=1707244873;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bwc+mQL6C/91m4UiYWrsmKalc17+Sz1UB9Xs7+dNW0=;
        b=qq1+kglVBPfqoWYny+QC/A9yO410Mq2JIdCdtq5Bq/PZFjg6vTb0CiTuTDVBt6S6ZI
         cEb3XrrMNd+dRGfqDC/XcPS/D6oHGNzSex+4RiABuHmO61POdbzxeQhiTehP3kdevWc6
         gE2w7+rW/WJS5Sqx9JZy2qFOoc/FuzwR7QpYAw1Lv0z87fTckw6E4I6vK2eYA02Cknoo
         9ozgAnctKfnmi9mXejXka8lvESGYw8cyF5vk65ZI145sYKmLrUgjPvU4etU9qqFuvJNt
         wI2gIMPvGI0u7wxsmYUL9v3uR4tGU1YO35eMurtcJZcOx9gPIu+c2A0M+oOv/c3VcoT4
         Lpkw==
X-Gm-Message-State: AOJu0YwNYUWmSvVJTjITy3xDkZ4a0dGj1AwImxw03KCYDqF0NFKqH7lJ
	Btd1N3lscAP2RHeec8VJ38kS49c/QFPVsaNuzLgCabqYAeS7vRUk4F+xva/dYJH1Q1ozJwcDFR3
	TPbK4nkCXqBHHkzuHVg8JrANfoBr86vCkvbeVkhAhoiBk11jjjvI8KG1WQG2c02NLQg==
X-Received: by 2002:a19:914b:0:b0:510:544:792 with SMTP id y11-20020a19914b000000b0051005440792mr6330663lfj.0.1706640073415;
        Tue, 30 Jan 2024 10:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7CiSZRQ04X8yuecqu3jcW/CBGI0gl0b5ZeN7gMChTG8Vk6qSxcVxFuUatqpdJUJypOgKUCg==
X-Received: by 2002:a19:914b:0:b0:510:544:792 with SMTP id y11-20020a19914b000000b0051005440792mr6330648lfj.0.1706640073001;
        Tue, 30 Jan 2024 10:41:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b0040e39cbf2a4sm17868663wmq.42.2024.01.30.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:41:12 -0800 (PST)
Message-ID: <785a9d7b1ce68f8131e6f9c8802981ac7ad75948.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>,  Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Date: Tue, 30 Jan 2024 19:41:10 +0100
In-Reply-To: <20240129083933.6b964b3f@kernel.org>
References: 
	<21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	 <20240126115551.176e3888@kernel.org>
	 <a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
	 <d67d7e4a77c8aec7778f378e7a95916c89f52973.camel@redhat.com>
	 <20240129083933.6b964b3f@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 08:39 -0800, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 17:31:33 +0100 Paolo Abeni wrote:
> > Uhm... while the self-test doesn't emit anymore the message related to
> > the missing modules, it still fails in the CI env and I can't reproduce
> > the failures in my local env (the same for the gro.sh script).
> >=20
> > If I understand correctly, the tests run under double virtualization (a
> > VM on top AWS?), is that correct? I guess the extra slowdown/overhead
> > will need more care.
>=20
> Yes, it's VM inside a VM without nested virtualization support.
> A weird setup, granted, but when we move to bare metal I'd like
> to enable KASAN, which will probably cause a similar slowdown..
>=20
> You could possibly get a similar slowdown by disabling HW virt /
> KVM?

Thanks, the above helped - that is, I can reproduce the failure running
the self-tests in a VM with KVM disabled in the host. Funnily enough I
can't use plain virtme for that - the virtme VM crashes on boot,
possibly due to the wrong 'machine' argument passed to qemu.

In any case I can't see a sane way to cope with such slow environments
except skipping the sensitive cases.

> FWIW far the 4 types of issues we've seen were:
>  - config missing
>  - OS doesn't ifup by default
>  - OS tools are old / buggy
>  - VM-in-VM is just too slow.
>=20
> There's a bunch of failures in forwarding which look like perf issues.
> I wonder if we should introduce something in the settings file to let
> tests know that they are running in very slow env?

I was wondering about passing such info to the test e.g. via an env
variable:

vng --run . --user root -- HOST_IS_DAMN_SLOW=3Dtrue
./tools/testing/selftests/kselftest_install/run_kselftest.sh -t
<whatever>

In any case some tests should be updated to skip the relevant cases
accordingly, right?

Cheers,

Paolo


