Return-Path: <linux-kselftest+bounces-40707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4A4B42A15
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAAB189B6F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048236934C;
	Wed,  3 Sep 2025 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfMxEENU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D843680B9
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928494; cv=none; b=fbLnS5PpclGRiRmsXz3tJPLqL9YR9SwPj03NzIoQIPRvkwGSg6ctan49XeFUhpSl1d0qPOl4jW/eqrjLcRn2Fh0dSyjekmqENPvyvYVHW/ReJYQhRIptL9RDpNkfk8fzuJiX3mvydXGzIllItc2qHnYVjja4k4WsKQSFhnsWtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928494; c=relaxed/simple;
	bh=AnLl03C3lEMWEuhKP4zlQA7qh1JCTWIkpSGbgait56k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaYO0NUBcjc4nq+zd+R/WhAXetYsLBXzyFmNyCEwEU23Y+tJSfmxJNzupx+p0btXlM2//06u1NzkXzPoUgRWr5Ft2w9xA3Ds6O8YyOoArXoHMgl+ZsvFqctdU9EEndtYz7e3zQCtBmEGkEVg2XddWtZeTWWqnwleIhuQgK6/0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfMxEENU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756928491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcrdCi/QQ2Pi9AawoI2D1LHbeyQi4TYyEyYByMDtp+8=;
	b=HfMxEENUcY9K9lJnfmtBY8fhNJ2OsHJ1O5mV/ET83uRZXFpqlTfOFMsuq1O1n10G9S8YhN
	MJTw4cJWl++uIdXJO51r4SBDYPhQxHIfEC3dYfO4C0JVu6MHPklpRj47sSTCMJWNN1QtmD
	7+bOzSfRfBHR7+uoRQvBuuXG5aHSrXo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-9QuJDftpOMe4pmhLkgex4A-1; Wed, 03 Sep 2025 15:41:30 -0400
X-MC-Unique: 9QuJDftpOMe4pmhLkgex4A-1
X-Mimecast-MFC-AGG-ID: 9QuJDftpOMe4pmhLkgex4A_1756928489
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afe81959e5cso19766666b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 12:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928489; x=1757533289;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcrdCi/QQ2Pi9AawoI2D1LHbeyQi4TYyEyYByMDtp+8=;
        b=YNT74ZE51KQqEhLFGKrp0wZMc5Na7d04U/HoUP1FRffQZmJ+VmlTUk7g4N1tfICOXp
         ZQFN2R6vVEOPjw1GWT2Yx3qP+gx9OFDk5qffFaB3HsUiTfsqDUKlGmv7wLm4wToXeZ6V
         tb5JNiLZl/KdfinWj1DphyjilUkrwUWu1MpvxGB6VWvyy+kjGQ0+U50+nM7CrW0xXeo6
         SQeomgAfoOjkHYTBCpcyMCkuHQOEbKzVi6Hb9MQSqw5hJu2o0a/xhpd7IFTPImYLNlW5
         C4jSLupF+NywKisq3QfkOk6E7Z9HlfmGADq0y9BFtKDuCebsaYqDNUPGAPTeW6ClVmMP
         jImA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHlUU8jHl3kXs6QJmNGlT2tyO6Vf+6wiEutVlmYRSUJ8MIPx1bKEoaXa0e3Uk5++EpD8Cuete+hP0Z4Zu6JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZT/CHubAJyVtS5yea7XuChLlf7laiJ5HtniJGC1KkOdGV1Ct
	IG4KO0O5XTKJ9wSfJWhOO5QWSlPc18hF7DrCKNstAdRPhXbEtzLZI5Drh1RUpJbsVPW8Zkjv21B
	XZqIvlrGkOJ2sK8NldwD3BvrG2MwLGqlciZ0f6S+BHV1J+J+vyZkUWIqFnM0ZQlsMOYJ5
X-Gm-Gg: ASbGncunfRLqEnbVtAnq6mnqN4UpjIWNzZd4lyhxCAEBFz8FkTcV/8WWrWNB9zReomI
	FWOPw0GlJk8WEJJ0abLdjmMt4Jcq4kj5fTEgnO4ncCbmw5cbZgn0EHhwtVHRtuhhjGx/26y7kw2
	L8Kz+wSK3sj45WFx9M1ej0MgIz9S6M6956tuRkHpvdNKWqXS8DIhG5fnF//AJwNfs6ysQ9cQby4
	r+gpT5DMSzHsvpfjOCWKN8J5m/J+H2UfVarEOC2SdN4mVGNGWGBdGTgs9XXlZK48VCOimC+m2bq
	C5gwKSpyb1zDrn1g7F6/jq2E3JD7yR83Qz3FeXara6L3zNbd3yvK6qKW+mQYCacCG1vPla09EA=
	=
X-Received: by 2002:a17:907:9808:b0:afd:d9e4:51e9 with SMTP id a640c23a62f3a-b01f20bfb23mr1654946966b.65.1756928489000;
        Wed, 03 Sep 2025 12:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYpszeOoco4oO7Qi8zM/uizj0H2Y+lWNHl3YoEbRLN0QQfvHzIRAK9mKQMhKDLrctQ/N7Qjg==
X-Received: by 2002:a17:907:9808:b0:afd:d9e4:51e9 with SMTP id a640c23a62f3a-b01f20bfb23mr1654944066b.65.1756928488639;
        Wed, 03 Sep 2025 12:41:28 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f888b95sm161394366b.34.2025.09.03.12.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 12:41:28 -0700 (PDT)
Message-ID: <64d235b2-ea1b-4e48-9c2d-9f22be50929f@redhat.com>
Date: Wed, 3 Sep 2025 21:41:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasecmp kfunc
To: Yonghong Song <yonghong.song@linux.dev>, Rong Tao <rtoax@foxmail.com>,
 andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756856613.git.rtoax@foxmail.com>
 <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
 <809a98fc-2add-4727-af98-6f72e16c71e7@linux.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <809a98fc-2add-4727-af98-6f72e16c71e7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 18:39, Yonghong Song wrote:
> 
> 
> On 9/2/25 4:47 PM, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
>> the case of the characters.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Already from the previous revision:

Acked-by: Viktor Malik <vmalik@redhat.com>

for the series.


