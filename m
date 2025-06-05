Return-Path: <linux-kselftest+bounces-34386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D9ACF4D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA1189B778
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC5C274FF0;
	Thu,  5 Jun 2025 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsaF69Wc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42D13D51E
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142561; cv=none; b=MNgxrPEcAV9vW+f+rWxHRjvwXXm7EZY/0R+v4h3nEPeVs+lJa60vi9LuMNMY1VbVrix9n+4kWGAjPXvkhY4KNXo8Y2CZkofyoggCkuBXbaV2hXQoNZ7mDgtCvMz7cq92E3yygaJvjebiGTZsc50SqnQgk1NsIPViGw6WX4iha1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142561; c=relaxed/simple;
	bh=zfq5wGQEYYPXKJy1KBLzl6se/AvSmjCRFz1/iOsgqGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9VhRnEN95Z6ZnijO9hYstikrwQg8N5xeM+ER7yEHqnKNEHVm6X2Q7AJ0SGqGhlKDUA0MI1R3bsvOb6nOO2+oB1LWjliEQe5iTJQXsSf2KqXRifr7t+FVKeAIpztvt5Le21oVfde5XBHqsxW/WfgRvWzsxNzyT5hJ/E/HWyCjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsaF69Wc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749142557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUzjtpH2AknbI6MKSLc/twrL54mOcBPBM8fuNqf7SIo=;
	b=EsaF69Wc6h4HvH7lardPbF5HXZTj12SKt9Gq/JMWnr/A7AXesHtV/Rokz6cbcj6qU7yOD8
	7KVjUQepdxBO25cumJFiNwEDErxojPwjhC0RuiObcgbAlYh8OnQWANqFrb6lpIX4M4u4pK
	H9UO6DJ6tQv4MGu7qLZg8wz0Z+/neUY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fU2c-JRBMJaa4H4nqZHCYQ-1; Thu, 05 Jun 2025 12:55:56 -0400
X-MC-Unique: fU2c-JRBMJaa4H4nqZHCYQ-1
X-Mimecast-MFC-AGG-ID: fU2c-JRBMJaa4H4nqZHCYQ_1749142555
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so6348945e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 09:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142555; x=1749747355;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XUzjtpH2AknbI6MKSLc/twrL54mOcBPBM8fuNqf7SIo=;
        b=O5EQcsblgxVmCbs94gp2Qpm/4F+sbif4idhAdj9p3XIDrVcp3uIgpHp8fLJmdb/5Td
         4+guiktrxvyB5T1Gj6MVPUYL1ep56QfTTQawiya4Nwjrg/IsM0mcQlcxX14pgeZMCngB
         vSTI/Gq5BBP8EWy5zaChP/ffy4FgV0OSt/CVY9Tt+EBr70CI81R9iNaQIpy6J2W8kd9/
         K13eOHp8tgVi8LEmt+4mjXRtCaM9TTkwavXsjfsWtS829U1Zv4YbxJnQ+gxZeJV8c/WQ
         85sgAX8jyeJGzAeU48gYXrxYxOhCumwIbbUjEzFMgtXKXioIxaQrE2zql+k5Z2UJAygG
         osgA==
X-Forwarded-Encrypted: i=1; AJvYcCUvytQto0mDgIiXHe5wgsOqbsPHEt7CRE8HiLlzOhniX2xBs8YS8poMTkIgm9luShL+J1wLhcvSYTnylEqHe3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46VXmNmcnllmtKI70weelH5edLhdVeLn8uCMd5VObIO3CaJiK
	ODle8rHC4f/8KlbRNuF92LcfSBFM/Z+4iGm4FvNgX5GtlqHE7cXFQ9vfIhqLbLBJI6fKMQAR269
	XOSWOqUW8cp++W4K8QbsCV4d4FEjB5pNsVeIjFsu6dQK3GkiXpJJbCjxqQzeFxWOsu/B+ALGxc4
	EsKG1B
X-Gm-Gg: ASbGncuxE0KsgxTZiVsWf+jDJfrIWqwc/tIOeSQUomQT2RX1Tnlt6KKXE4G7QQrlJRk
	niOXKESKIeZVil0WbFyh8sI5aayhCvGDlDvETIqIBtrcEui5YXNxyOY0ipOYQvbSSd9SJEOEcYc
	NdmWtx29xIVRdTGrAOs7DSMUNOhs68HnNVj6RTycZVVwt93ZfuLrTNVyj6Bar6/Vo3ndmKAou6G
	UgPm/HcZjSbHaBFnjRIQvD534zMXihK0q9uA/pAnsI7JvyU/HQ6GwsLJLeE0KSAwypfBUpu1mpD
	NgKb3iRChiQsp9ZKmGTmqk7iCu9ARX7S1tM8JwFsa4HIC7EMrBJTW9/YaCFB2F4muqVa9vinNmw
	SMio7ms8Q1VESjjMhz0rMD8khHsyJS8eyw89d
X-Received: by 2002:a05:6000:4202:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a51d92f980mr7261596f8f.24.1749142555458;
        Thu, 05 Jun 2025 09:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl45OMSH2oGOxGFF8fYhZtb/OW/fhLtvp347132i+bd+16jviN+pwNHRIDPdq8viBiRE8Mww==
X-Received: by 2002:a05:6000:4202:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a51d92f980mr7261568f8f.24.1749142555048;
        Thu, 05 Jun 2025 09:55:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2? (p200300d82f27ec004f4d0d38ba979aa2.dip0.t-ipconnect.de. [2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b7b0sm25194671f8f.10.2025.06.05.09.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 09:55:54 -0700 (PDT)
Message-ID: <077b6af0-bef3-4f1f-b785-9e351d01a89f@redhat.com>
Date: Thu, 5 Jun 2025 18:55:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
To: Mark Brown <broonie@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.25 18:42, Mark Brown wrote:
> On Thu, Jun 05, 2025 at 05:26:05PM +0100, Lorenzo Stoakes wrote:
>> On Thu, Jun 05, 2025 at 05:15:51PM +0100, Mark Brown wrote:
> 
>>> That's the thing with memfd being special and skipping on setup failure
>>> that David mentioned, I've got a patch as part of the formatting series
>>> I was going to send after the merge window.
> 
>> where did he mention this?
> 
> I can't remember off hand, sorry.

I assume in ... my review to patch #4?

What an unpleasant upstream experience.

-- 
Cheers,

David / dhildenb


