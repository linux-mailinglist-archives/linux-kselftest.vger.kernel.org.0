Return-Path: <linux-kselftest+bounces-4224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A662B84C68E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509CB1F2791C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8D200DA;
	Wed,  7 Feb 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNnq3fMf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6A20B28;
	Wed,  7 Feb 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295664; cv=none; b=SqagBq1mMwrkD/kkNHuCKsHiajdV+5m6QxXy/R4PrrBqtNfw2H1++RhIZFMa4435LTvvNsrJskj3jIsDFLgosmeNvmVkAmbkUJvNvJKDNtpUTX3ntIWSSaRgvy0oLk7FO29rIGE2aj6GWXWWIHPrfEg3oBuVk4fAOfR3Nnuh5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295664; c=relaxed/simple;
	bh=GNCOdcDDyq/1NLW7gyIwNzWiCnIN2b2fyZWE+y6K3Vk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QLT6ypU5aZ93Gji3E1v/Tt5z9rl3ClrC2D22VRlXOrlnYYKXOGDpW2OLbqdM2xI1D426EzELulbdIXjex2JUhJtFW1WTfII0Shj2JVrhX2ESzAt4ynUr315z5cwbz68kwoPwUx3Hc5yKB0UPVO9UHgZ2QlgjmmGGHwJb3x9tpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNnq3fMf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30f7c9574eso47622766b.0;
        Wed, 07 Feb 2024 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707295660; x=1707900460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj4qPaMqnd9zvKedeyiEsUW9fSkzif8DNAdYYIQAxxY=;
        b=mNnq3fMfqRQSq0ntsDrNHh7nWgUHRlm0XIFrZ1J49/NwRCFw3NzvKAKeh/IFcKK8Rc
         Bsd//YHF2lL8rVma5Fffl69nGqj/+TE/1kYwmOnjFacoCPGg3nOYHd5U5VSwhFeHXw1e
         hzjNAtyqVWWJqzaTDdxEafu+71gIZ0L+88UD6JqZXWk3f1a+pSnJlPyAfJxwPfYernqi
         SvYLXwAhzcHPXh3Ia7MTogGDoiMPC/i58NwkGDIsRvPr/N9wl3GNuxO3IubOcb9jBowA
         B70vL5Om8wLFSq57+LZaGOzy+o8UEDETPv3gH1luGxL5qfbotR2C7KymBJQNFThRKqg9
         XDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295660; x=1707900460;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj4qPaMqnd9zvKedeyiEsUW9fSkzif8DNAdYYIQAxxY=;
        b=iFHqbUMi3gAOLqecaqvUB1cKCGfu7YDASNq5aq+NiT5IO1j7Hw1E+idOd5D41TrimM
         Fd3hyX1a7XQgx9FKVERQpRkifxr91O1+e+rj6h2f+ErY+ohrLX+TpVeGTPyg27ip2mL3
         pCb+tMeVuNhaKfNq9986XmhU8I02frF8YjJpmBOIpKRvIOLHojA8a4QODX/De+HfWbc3
         ctnf8RRQcpA48M02LZxp/Carhk02N6diI4AWljlCdoXsgI/4CRsRB7Mm0WlWKCem5nOu
         0UKGrVnjEJp0UpBsng1UjB+fh413AV+b7SLCfL3xsXq9rrCO5mtwQ3OrKdUewcNbxu2R
         TaLQ==
X-Gm-Message-State: AOJu0YxRTju8W6MzY5UcEfAKbxKhpYhKj3ieyAC2h8L8eR8Kbn7V5aRG
	DQgY9DlHh1fwxA6/XB2nmOe6WfmjNiFORecT5jkyo02hVanm/JEB
X-Google-Smtp-Source: AGHT+IF47eTBssASZHFBQHUPdVTL2sd8ymlIBQS3sFcE44/e0oqTP4d4WKnMkzyy/1zrot22kLO7yg==
X-Received: by 2002:a17:906:18a2:b0:a38:4b66:4200 with SMTP id c2-20020a17090618a200b00a384b664200mr1702660ejf.57.1707295660122;
        Wed, 07 Feb 2024 00:47:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXz+tbM5ryfemC1cx72pU+5wNDFh6HzwogLpRXC0HdVl5P+RkXzlB2okC+Bj5W40NV2hrKIh63klT1ZYWS3D8SffIEt1VfshC9egB3lFuiPFPtvx4Fh4MMvZpGynRuCbkMECy/CI217RumAlLel4Ms7bwHYSe6gM1WT6b4RUP5W3+4AN0Szfvaf0XBkrM5OdiQeoD9e074HyPgNgAFa6aayJLyqWl6Y/15+li9cLWO5I9yUhKwP9ig5fR57rfAaKpOsKIwuPrqS1ozhnnVbZHzaRPREjN2/PYwBGIIAFthCsT1tyuZ+Y4/R/Ga6S2Gtw9LhwARAjlxLV5YTfsya9CwAVoe+0tRNiYrhStXwToLsFMQ02i3eCdD4DnJ0Bj0WlhP+NNRRkA7hym5s5qAfNSXLNFw+Es6ZXOr51X51thFPKFVLAdE=
Received: from [192.168.11.39] (54-240-197-227.amazon.com. [54.240.197.227])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906115a00b00a36c7a7b4f7sm503528eja.207.2024.02.07.00.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:47:39 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <6d66b3ce-2be6-4111-8f19-9234ee92b15a@xen.org>
Date: Wed, 7 Feb 2024 08:47:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 04/20] KVM: pfncache: add a mark-dirty helper
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-5-paul@xen.org> <ZcL3CdGHv5FQHBVD@google.com>
Organization: Xen Project
In-Reply-To: <ZcL3CdGHv5FQHBVD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 03:20, Sean Christopherson wrote:
> On Mon, Jan 15, 2024, Paul Durrant wrote:
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 7e7fd25b09b3..f3bb9e0a81fe 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1399,6 +1399,17 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
>>    */
>>   void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>>   
>> +/**
>> + * kvm_gpc_mark_dirty - mark a cached page as dirty.
>> + *
>> + * @gpc:	   struct gfn_to_pfn_cache object.
>> + */
>> +static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
> 
> Any objection to kvm_gpc_mark_dirty_in_slot()?  I want to make it clear this only
> marks the gfn dirty in the memslot, i.e. that it doesn't mark the underlying page
> as dirty.

Ok, that sounds fair.

   Paul

