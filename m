Return-Path: <linux-kselftest+bounces-36749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522CAFC876
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C022F177911
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D12853EB;
	Tue,  8 Jul 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTqd8RUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFBF230274
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970562; cv=none; b=Wjasq+Ym66DuViGXxw4dSOiAMTdmXKKelt/M6ecgx7lrgh4Xjb0oJgunnwKYCJ9or4dOCKU8N6LXfEJ64I5RzCZ96nmtJOZHEwZ6sj/fIqCRuIr6Sz9UwHeeQ0rXT/q+m2+JxtCWonh0dk/WXz6axwfkCqZczjwDSqSP4n5diPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970562; c=relaxed/simple;
	bh=nDKaw5wp3wPv6Su7DJn1ZlaCFO+KFc/YaXghu5EPCUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fFpp/sknF7nvrrB0Nx2YE3+Tw7QpJ4aAhE+RWLt2NGgugvIDxihiqXFvueOmaFtx85++1UhBpdGozI8xKglOMvKkunZdjvIp7E/du5YzRq2fs81RI4fJK17xjgo9xKYQv2qHV72E0SEuYecDeoTzLRhtNK4TV44pcMqM0o6Agek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTqd8RUq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751970560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CzUCEXFgRnyn/r8sZIiHWX26XZZ+a95NsXDWMh+fb0=;
	b=PTqd8RUqV42xSmKqd20wsvLKA91UxeAi7S6q4pyl/N6xeEjvNGG8U9VWUckdK61Nlu8x1f
	vWGlDt6rwAqs7FHTacpsft8wL0nS1oOpH3oookvBJNWgww/7+16IKDKJ15QqtLng8Db3vh
	y45Of+ePZiVTa8XAKGVpzSfkX3OWS+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-lvvrXgj9Mc-sWzycktMZ0g-1; Tue, 08 Jul 2025 06:29:19 -0400
X-MC-Unique: lvvrXgj9Mc-sWzycktMZ0g-1
X-Mimecast-MFC-AGG-ID: lvvrXgj9Mc-sWzycktMZ0g_1751970558
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so34198675e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751970558; x=1752575358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CzUCEXFgRnyn/r8sZIiHWX26XZZ+a95NsXDWMh+fb0=;
        b=heHHi+LHqLhv66fusJxbf/8m92QCx/UghSwbJyKzF3TjS68v2G16jJUI4uUnoGADy7
         KxgnyZHyc74NIOP7ifHHBCOleJeXh4KE0llQOCQHlZcEvxFMa0EHISXJYKh2CQ96djeH
         3xKHIoQxcItq5elTRLixkI09kIy4Jf5t7KLcQsYpa+NSRDZulRueHKR5GiTW/E0CjNrH
         X7t2FH1PXO7b+aVyYxdTFvSqAvrj3lsHss82UpmPUW15aHzMS5MUjbcyQDnJ2GIPLuvB
         WrJr8gKWb9Wv0rLqQbNuxJpo7gT1pU0hJnad/95cVlh4eXRMOHUH6UycOwSnPMmsUiIS
         7Flw==
X-Forwarded-Encrypted: i=1; AJvYcCUOE5OE0Lm5jCOAqpZ3gcw9kGuEUL66BnPV+YFUgeXzVekMB1zOcH5lQKHBrAzFeGoI9sVdHSI4Tb5oz2M6zVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1i1CRJYWaFx+WfmF920ld9eCOG3D/uWCcMU2k5ufZ89wnguj
	v49d46PcEy32VoKxEAjW6lcSO76/9q1NN23TAlhQSSWo4j+7UPPh/Oa8mjuV/dhm4ptYXjoBR1i
	ql5H6+VvmHVKWIDFfDtnXKE0qAuVPcAMqCEQi4hWCKPStNYD4d3ZKQ9I0PQqy74fqR6aLFA==
X-Gm-Gg: ASbGncsi5ZF0HUcKfyBi7vp8zxBeSw94MYNcZViJ8kc0Dcl7BJRMIKCQ6ZWSyiPf+oO
	XtlRw1T0QpKrx9+Cpb8PkUOOMIPg8vwecT2UxLlMB1t230QYvLGVpgrwgKe0ZHZu8kFRV48DWE4
	OA7jCaq4T32FBbHcfXrQc2/9vZ+7V7XGeogRWETrENkV0ds4cQQE4JLgqW6QPljvn0ZKt/jl9KD
	cjxN03kGIHTjcAD6f4uGafUgSjJO+5qwbU1r0UADdocVX98SFG2GZmoIlL6JkX6a3d6nAGYIpMV
	ws4NYCOZa/2Murw3TTsbOBfgQWNjHBIifuuD6xZ7Rzk8k4JVjH++LYwWIcnBKufeLAY9Gw==
X-Received: by 2002:a05:600c:1551:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-454cd523b5amr27866885e9.30.1751970557694;
        Tue, 08 Jul 2025 03:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV0sIn/btpu+R8moG7ALddhsgbp///BKMaHji+kT+s2LKs30wzMAiPIvbc826P3wci6D5VQA==
X-Received: by 2002:a05:600c:1551:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-454cd523b5amr27866375e9.30.1751970557268;
        Tue, 08 Jul 2025 03:29:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd44ef0dsm18172565e9.13.2025.07.08.03.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:29:16 -0700 (PDT)
Message-ID: <13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
Date: Tue, 8 Jul 2025 12:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
 <20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 5:28 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> +	struct dualpi2_sched_data *q;
> +	int old_backlog;
> +	int old_qlen;
> +	int err;
> +
> +	if (!opt) {
> +		NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are reuqired");

Minor note: typo above ("reuqired" -> "required")

More importantly: the above is inconsistent with the below code, where
AFAICS it's not enforced/mandated the presence of any Dualpi2 option.

i.e. User space could successfully provide a TCA_OPTIONS with no nested
attributes.

Am I missing something?

Thanks,

Paolo


