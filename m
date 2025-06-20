Return-Path: <linux-kselftest+bounces-35412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003CAE16BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786347A352A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE3253F2C;
	Fri, 20 Jun 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjTsfD2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05EB239E60
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409592; cv=none; b=fP2VdPzAAXrFuazly3twfYqApd2r3ulO7My4WoSM9v8BV+oAYzmfGjS5p5FKjrBysFSb4Dm6v7mC/Tuqu94SwP4v+XWOKv0y734+mtqtgej6xcaWCnz5zsfEYjTy2lINSlrigY48qIS5K4uEEBKcLRjOE/JQVnQgY6PiUVjTXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409592; c=relaxed/simple;
	bh=JIU/9yYM5EZgzXh5wRxwPBoghOZ1RoTsAWY8AkKF06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9T7LDn1OOvkaj2xRuJEFxr4tsbA6ygY6AFWt6HGlV+fiGewzKB8INEIsZZfsgDMkTmigxNu/zrc4mfr4YiMhjQSH7oCel30nOJBoWiTEB8C5hccxT5xunZWw11QyBFLWgsylZA6aseecK73w/lCnVcOjdIHzbXPF4HKiLdv8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjTsfD2l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade58ef47c0so331287066b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750409589; x=1751014389; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Di86I0v1fFinSjukA7NSVgoRqQHM3T8kpFJfuapM0E=;
        b=JjTsfD2lcECJzY6rGuvUW4uy2rJ07Ikhta1TV5ABV8ELPeuhvDf7pjVohxGnRp9Ksy
         KFKcT8RTgKCi8si+lPd6ZwfUnIUeq5LG1CmWh5apoYdeQFtzCF/eGj02WhCFpN3I8486
         PzgaqAxSFxV83z/kXXO9dtb6bZVu1L/3QAfD+aa7ran3Jc0EcAHdLOnvIBzPLDXgcvjL
         /A2EwyI4Zo6n7gmLCV5emOa1B7ZZc59MMjYU1REkGVQB76uLQ1USD3YgNd/fuey1wH7j
         vbEarz6MtKe4AsoEa/yG3MdcICfugi1/3w+PW7q/kSkCJIrodqOcLHxnuZYXPATwcgB4
         l2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409589; x=1751014389;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Di86I0v1fFinSjukA7NSVgoRqQHM3T8kpFJfuapM0E=;
        b=VMj0s/AZ5z3/oGnLZiSlrgFygdcBRx60N6W/qSKkeCI72tsJLfwCqFpyR5S96dtO3U
         kc4jxWPQxH3XZV4TebVlkZG4ysiZj9FGQhXpBLQ7stAwOgCvSuUnfgDNUzfxaQdiWQt5
         e7seWoSnFcUW+DY+b0nXFXM0UGF4RBttSJznpq9SqrgaFoUuTY96H1wczB+PAAINIa4J
         SkfnE9QCOUv8raYB3XTsOXukDmw8RLLChZ7Q4WwZKzu4czo8O3CNvuXq7hr5r74qvVpy
         HmbGI6G1GbafcmNIgvqA7VULZ6vaAhRelZHbdWM45/LVJVBdywewAO6BZsnQCxcfufyn
         SRqA==
X-Forwarded-Encrypted: i=1; AJvYcCVVhvyvM3FDL+9bqmL9JtKtjtJ8G0+BNUV2qnSEpNoPfmssWtpf4ZOh38K3iZWQS3mKNrtZxtKPM6SZbN1wDkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyME5p4mzS2lqjStYCbMa5emFOTMohyQMuOL/xbe+zALqnxZf9K
	O+OVlsbHdcKG6dKMRdop0XEZSPk0vdpiiFpGwiSCWxA3Yg1HgkLPAHKj
X-Gm-Gg: ASbGncvOuLKz1+/YLh0x8wAegB1ef9AvvoWTFQzSn8SyZX+OejQl2QsPukwNvekF6gT
	DTMwRCJHxmPoQ57w5elfB7WqIBdpd83Orpi41kmiOpf5mpEG4zxL4JK2vosVSrJOHa1Ecmc3+8P
	TnBPZjXXJu8gZTcXOi8UWxGk1V0BQmY2W8PgXHT3SMAvlw8Ebnx+X9Udec5GL2oWPDpUAkgDwM3
	WBI4gqqB4xq3jwyqHeuHLhxafjnFNnVtspPl4MxKgLsEKfqsSF/254fbwNAFyVjPz4BIL/w5vsR
	YH83w2MyGV4dW49rZZycjjbS5Yxks2hMTIq8EWYUfgKCzVd8xZO8bWYz2NJsyg==
X-Google-Smtp-Source: AGHT+IHbhzIK+aPoHW2uFarYGeRxrfySLD9u0FrPZbSeDJhNVeRLn2g2puJiN0iLFIDNy8BNqUUnlQ==
X-Received: by 2002:a17:906:c14c:b0:ae0:573f:40bd with SMTP id a640c23a62f3a-ae05ae4d3bcmr152444766b.11.1750409588664;
        Fri, 20 Jun 2025 01:53:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054206fddsm126307666b.150.2025.06.20.01.53.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jun 2025 01:53:08 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:53:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, thomas.weissschuh@linutronix.de
Subject: Re: [Patch v2 2/2] selftests: harness: Add kselftest harness
 selftest with variant
Message-ID: <20250620085307.pxsfd6udwxsonjf5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
 <20250620032815.14543-3-richard.weiyang@gmail.com>
 <c186f47c-3078-45a8-b677-7b5d5273fd5c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c186f47c-3078-45a8-b677-7b5d5273fd5c@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 20, 2025 at 12:12:40PM +0500, Muhammad Usama Anjum wrote:
[...]
>>  
>> +FIXTURE(fixture_variant) {
>> +};
>> +
>> +FIXTURE_VARIANT(fixture_variant)
>> +{
>> +	int value;
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(fixture_variant, v32)
>> +{
>> +	.value = 32,
>> +};
>> +
>> +FIXTURE_VARIANT_ADD(fixture_variant, v64)
>> +{
>> +	.value = 64,
>> +};
>> +
>> +FIXTURE_SETUP(fixture_variant) {
>> +	TH_LOG("setup %d", variant->value);
>> +}
>> +
>> +FIXTURE_TEARDOWN(fixture_variant) {
>> +	TH_LOG("teardown %d", variant->value);
>> +}
>> +
>> +TEST_F(fixture_variant, pass) {
>> +	TH_LOG("test function %d", variant->value);
>> +}
>> +
>Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>

Thanks,  Muhammad :-)

-- 
Wei Yang
Help you, Help me

