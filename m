Return-Path: <linux-kselftest+bounces-35242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5BADDFD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34707AB33E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD82264BB;
	Tue, 17 Jun 2025 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWphmN7i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3F2F5312
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750204672; cv=none; b=Jnpd1OyHxHllWqNxF4MBOHHdu51zWtRIBO0Dn+rNKnEvwRJE6kKzkeHIEZ2PS1VqAVhF9YqMyXdW62O5td71YQaskcm5s95s0T2gQIYxEkXcHCplzQ0tf9whpCvDPAFqSNiVLEYpltwi7Dp7kYOJlW7UhubDTRTwSO0qVNcA3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750204672; c=relaxed/simple;
	bh=qRT825UO0KXpuKBCswrhsoYxjt4uKHruly1wbkXAwMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebbuqy2F7LqbSaYi8vXGLOrSDy29MerO3id3PWiNEiQy8ujgJd4jLeDbO2+GLixlfHUvz2zpiAxlvYDhoegK4jzU7RGePE9zPuvengdx3do79UScFQr55/QevyrpynXXo4EKWPk0XkJ12MRb7AYpyMDMrHUZ6Tp8WGV2s3YV8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWphmN7i; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad8a8da2376so1038010766b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750204669; x=1750809469; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0v/VIGGFRBOKy2NixM/6qmx+LZ7QqTsO+2kYYbypfLg=;
        b=IWphmN7iwLYJOxXEzT/Kus6m0iTxfXXYqG/gilNh3UbjM4c4DvYWLjbkJOVDMVxENW
         NQC3FOayoKL8vG3N+LulEFOSBZ5Uj0gEEPqjPT7VuJJcaDr7SSMQQv9R2nNdPAaaMUkl
         iOSiGp6YlWJGBZIrZWw6L1cgvVhwK6KUHTuuWGdY5oxpF0u+qrDXobd7KBT+2oK8EIFN
         fSnFlmJoJzd+5egSBsOO9xjVkW/adj8dcb0nZXVL1Zxb6EBJtnclBcEaM4oTDm44BQB6
         1nHcjOlAHI740t5ndze1cns5XSXofUIpAzHSuV9vnpxsWcymeB6rT11luDp4kNerDZEu
         4DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750204669; x=1750809469;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v/VIGGFRBOKy2NixM/6qmx+LZ7QqTsO+2kYYbypfLg=;
        b=DIcybFVCzgFd6MSwU4ZC2Pz/bh37CH3Y4/6isFvYkXSWDW9zA7kIVLcThqXxavnc36
         H+Pw+TwGw+BlvMfxVI2+OsI/vdWrT5Yr9Oe0byqwr5D9bfgH19But2L3PnXSNSHkB0Ll
         INAfB8C0wYHKz/pC+vxeL5oIF4ksJNQ+M5wBk/AO3HcZhpb8UGB42qNwXtTa+YODQlIH
         HnTwVB05Cc6zCFyJO4DYxS17a4Y+5pKwxgn7ixIGSbxWjI6dXNjfA0IiwsgTiWirgB0P
         5JPAaii1wAqXmRuKekmFBlame4+3yCLyt+dcSt6enkXagfcK9GTN2ypywNl+1xVgzpn+
         s1ww==
X-Forwarded-Encrypted: i=1; AJvYcCWnQx4ZavNepMlLaCsL+YL2d2rVapGTEtUMtCHLqtxSzEdXceApQmd7pUwOlB4eAuzw5dGtNDlvdC1ph5xmqBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDyuTe27vxa1juyQfJjeyAY4WuUS0YjbEXLsHvojvc/UhFMoc
	3PHWiMlmjNqW/1QCpCC+Y0vDvBgKxkLa8xe+WQa3zJesG25VKoKhRiTZ
X-Gm-Gg: ASbGncsKn3Rc6AiotEA7Fsvkf0n/ifg/uJKro3mdOmAuhBCWLEKNu7nw/yXyZpVeiJg
	taNbtL2pE1J9mNyobkm6jFDX5P0ElSHck2ye9GVutbyS/AA1sLzn6KTrXws4XBztxX/IDFHGzcD
	+SlUFHWEfuK6i70GBkrVyTz8auDZsh63ahj1GG+plVbqjHo6ICYYQSOm1j4fZ9qULAp8PE8oHX3
	lYDDcqME3Fm1AfyK6Bl4rWyI55zfCn+vNaTbVsYdo7n6mXepWjpaUkthqkfWGH0BphuzaQGVTnZ
	WFzPkUuf/SzrKL4nH+bE2XW/uH5JZLZq76MVbcTRRmECvZy/XxFHev2C2SE9yw==
X-Google-Smtp-Source: AGHT+IFva0Y8Ks0n5zHw4i/Mn22uxkr3unCwvX/SX+YZmwrKKuvBW6XX4st5lXAQNCQ8gquF5vfeyw==
X-Received: by 2002:a17:907:86ac:b0:ad5:6c54:1147 with SMTP id a640c23a62f3a-adfad4bf5cemr1567977366b.48.1750204668838;
        Tue, 17 Jun 2025 16:57:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c1f04sm943267466b.54.2025.06.17.16.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jun 2025 16:57:48 -0700 (PDT)
Date: Tue, 17 Jun 2025 23:57:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org,
	linux-kselftest@vger.kernel.org, usama.anjum@collabora.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
Message-ID: <20250617235748.pbw2mrpneol6gajb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
 <20250617093230-7c07d08b-5956-4a78-863c-f35cc300815c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617093230-7c07d08b-5956-4a78-863c-f35cc300815c@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 17, 2025 at 09:35:12AM +0200, Thomas Weißschuh wrote:
>Good idea.
>

Thanks.

>On Mon, Jun 16, 2025 at 12:23:38PM +0000, Wei Yang wrote:
>> Each fixture could support variant. Add fixture with variant to verify
>> the behavior, so we can validate for further change.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  .../kselftest_harness/harness-selftest.c      | 34 +++++++++++++++++++
>>  .../harness-selftest.expected                 | 22 +++++++++---
>>  2 files changed, 52 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
>> index b555493bdb4d..2fd5310b33c7 100644
>> --- a/tools/testing/selftests/kselftest_harness/harness-selftest.c
>> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
>> @@ -118,6 +118,40 @@ TEST_F(fixture_setup_failure, pass) {
>>  	TH_LOG("after");
>>  }
>>  
>> +FIXTURE(fixture_variant) {
>> +	pid_t testpid;
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
>> +	self->testpid = getpid();
>> +}
>> +
>> +FIXTURE_TEARDOWN(fixture_variant) {
>> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
>> +}
>> +
>> +TEST_F(fixture_variant, pass) {
>> +	TH_LOG("before");
>> +	ASSERT_EQ(0, 0);
>
>Please log the variant value from the test itself and the teardown function.
>Also I don't think we need the pid logging and before/after/ASSERT in this test
>also, it is already validated in the other ones.
>

Sure, per my understanding, is this what you prefer?


FIXTURE_SETUP(fixture_variant) {
	TH_LOG("setup %d", variant->value);
}

FIXTURE_TEARDOWN(fixture_variant) {
	TH_LOG("teardown %d", variant->value);
}

TEST_F(fixture_variant, pass) {
	TH_LOG("before %d", variant->value);
	ASSERT_EQ(0, 0);
	TH_LOG("after %d", variant->value);
}


-- 
Wei Yang
Help you, Help me

