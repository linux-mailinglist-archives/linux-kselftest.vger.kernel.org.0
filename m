Return-Path: <linux-kselftest+bounces-36012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA79AEC15F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152A01888FAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3725A2C3;
	Fri, 27 Jun 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ko+fs5wv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6320E315
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057143; cv=none; b=SSMWWSctKLs7mH35RuGdO0CgAMLf5Am2su6u3ymMkPtZ6kc9s9F/OfoIqq14I6wAzuDYnNunBe2bcpd4e6zFxxiXcFttLwPj76Xjx27BMnNSVy+yDugoJXOqsES5X9LseiU1Juo+XEscYoylb+JDnSOUvPrbRlXGy8MTIdXFeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057143; c=relaxed/simple;
	bh=tdvLWFsh/wI9WWSqIsGVNp6UW8sVmmyQUHoavqrwGBE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=TjccE6jSQwrYvqGhK2XediTk6kfYmCA2ct5bEeRPRv+9rGWp4PrIYmj1XVSNnvkXFLnGEk4qs8aXV+0oIYbF+QOrqLd1z+CrGDUZcgmbhzpo+Y9tE6/0CTFV7jkqS/osMBhlytp5nMmR9jrQib0dvgtuHqbQXX1JB9j9jUWOWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ko+fs5wv; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-611a646d93eso155100eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751057140; x=1751661940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtzxPj829hxx6a8LNGtfeNdfTNyEQAZxil+yeQpRBG4=;
        b=Ko+fs5wv4uMytKM8pW0AJLOBZnoXOsG09Q+tt0pCgXuY627EtTamIQ3WkgNwSZ3dPO
         yxSAsf0dw6WGFu8v1DZEjztVsW2L4lK0S4v0G6m1qrMdyXV3HMw4nA02AF1FZamFKlHv
         oOpz1fiG2vQdXOGrEcGoXxgyjuiMt5Z697uKKtgyE7J6x/M9N7bykXR0FZ7KRcEcXsdx
         bgYEk5AKAYWV3MaDJObI1Yq9U/opK9BqFeMn1iCHm7p0STdvW4AxCepFMhs+u9LnCGX7
         UCsww4YibYqoRs0g/ncy7ypLAzM0phrJQRabBRvO+tiE1+EM6eMvOsBK6RSD5LNbhETp
         kDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057140; x=1751661940;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtzxPj829hxx6a8LNGtfeNdfTNyEQAZxil+yeQpRBG4=;
        b=QY7pZ7zDhKo8/eee3IXcztLj59yZG/p8sAE5n3wmJX+1PGusRp49YUCV1n4UsnDp7z
         J1HOKIG9W0I/GL7SGTcq2k4yT074PejaK5H6SoKgN70WGbHRHoXgr7YHy8dAcJm4IztJ
         prafMRodqCYt4djm0Lg1OBFOdEdxRe2dp+2Z7svCMQcj/R4bxQ7TOVUgBa5qeYNC65tE
         KByUzd+ZAQZmTjQzPXeNLDJZtRlOahrSR9OFQ9O/KZhZTu5Wb6P3QlJ8DSH/aLj8Keae
         KrjDSL04ynXtkQDcGgvIo0cXR+lUTnrpRP13R6/Dv0HUi6QAZbxUzEpuHKMoV/616hq7
         ACbg==
X-Forwarded-Encrypted: i=1; AJvYcCXooNVZrqErzBuAT/f3bIf+11YvqUj9HfAziG9eD7bMfuNkPlAVl0Sdm1XLO28icFYKA5Qos7rHJoCUwHUKh60=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcd6J64OnpSTuL9l4NsL/cVIeJvCqu0dN95pcHwU74qXiTJqNs
	fUiOSg82yVmHuYexsMEsB7HGWpX3xW2xyCldTfK3re+SpxsgawyqIv8rPatoHphc4phgG5dS2bq
	loVzUOnQXuh+5E2MGzarV7PRfCw==
X-Google-Smtp-Source: AGHT+IEVJG2F41QRpFsQcHOZM3LLETHwJl5cQHVqdrJwuBS7mGDCrIIEijxTBzEQVHHKwtJ80l+vFT15a5JN0DRDMA==
X-Received: from oiu5.prod.google.com ([2002:a05:6808:80a5:b0:3f9:9583:af9b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:21a7:b0:406:6e4b:bd91 with SMTP id 5614622812f47-40b33c489d6mr3625383b6e.7.1751057140014;
 Fri, 27 Jun 2025 13:45:40 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:45:38 +0000
In-Reply-To: <603eb4c7-5570-438c-b747-cdcc67b09ea6@arm.com> (message from Ben
 Horgan on Fri, 27 Jun 2025 10:04:21 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntecv49aml.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Ben. Thanks for the review.

Ben Horgan <ben.horgan@arm.com> writes:

> Hi Colton,

> On 6/26/25 21:04, Colton Lewis wrote:
>> There's no reason Enums shouldn't be equivalent to UnsignedEnums and
>> explicitly specify they are unsigned. This will avoid the annoyance I
>> had with HPMN0.
> An Enum can be annotated with the field's sign by updating it to
> UnsignedEnum or SignedEnum. This is explained in [1].

> With this change ID_AA64PFR1_EL1.MTE_frac would be marked as unsigned
> when it should really be considered signed.

> Enum	43:40	MTE_frac
> 	0b0000	ASYNC
> 	0b1111	NI
> EndEnum

Thanks for the explanation. I made this a separate commit because I
considered people might object and HPMN0 is already an UnsignedEnum in
my previous commit.

Do you think it would be a good idea to make plain Enums signed by
default or should I just remove this commit from the series?


>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>    arch/arm64/tools/gen-sysreg.awk | 1 +
>>    1 file changed, 1 insertion(+)

>> diff --git a/arch/arm64/tools/gen-sysreg.awk  
>> b/arch/arm64/tools/gen-sysreg.awk
>> index f2a1732cb1f6..fa21a632d9b7 100755
>> --- a/arch/arm64/tools/gen-sysreg.awk
>> +++ b/arch/arm64/tools/gen-sysreg.awk
>> @@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" ||  
>> block_current() == "SysregFields
>>    	parse_bitdef(reg, field, $2)

>>    	define_field(reg, field, msb, lsb)
>> +	define_field_sign(reg, field, "false")

>>    	next
>>    }

> Thanks,

> Ben

> [1]
> https://lore.kernel.org/all/20221207-arm64-sysreg-helpers-v4-1-25b6b3fb9d18@kernel.org/

