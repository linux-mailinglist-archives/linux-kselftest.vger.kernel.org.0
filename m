Return-Path: <linux-kselftest+bounces-46870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047CC9AE8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8393A1DBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8730DEA9;
	Tue,  2 Dec 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/kSiBhK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoM5yYaT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0630C63E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668359; cv=none; b=rt0CaPtC9ewbxJ0y9o/vxuQxW2EfIwNGELW8p5ZWXop/s+1ISlzix/NbmsWqwPD5qyDqujC/75k0OgZ6j79MVhYjNqfOkyxClbz7Y1PEFkML00zJBVLQSevolkEfU8LKMu5oL4dp1IcifNvFJw2AK9wqQ2qU+VDsgp5KnF3aLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668359; c=relaxed/simple;
	bh=fh/Jj35tkhjEYdxNP2DeGwH8posCscq1/yAsepR1Gn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n52ao3gvQDmgXdbDbsYqNF4fn5lHnKmDfI2AU2xapUj2vFlHsCrD3I5rQLsM1iLhs4gP8o+FVz0d6zNXr921GPYRxOevZkKn+64AXsUTy20oxXc1+G9iQDTUKgv5jwe294LcUewGuLMDjJ3MP1jESnbM0ufB/W20blDlq1WGhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/kSiBhK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoM5yYaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764668354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PMkBJ3jqGuxhzGxj8q5ujXEQJkMs5T+aOdk2vs/fKM=;
	b=O/kSiBhKmVXMEg11TSleQia+BgA1Tv7fAw9LV+GRLUSUxo3YpCir0iRzFUyDntV+Ty3trE
	YzaGEU31V212/QvBL3/8wKKfa5QofalsOWl+cJMjFRVtJj8k3NCfm1kRtT8yowtPOAkyGE
	XTXsZgygz2u3aNyJfN/HkciDviZL6IY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-KReWrd23P8mS3S1ha6n4bw-1; Tue, 02 Dec 2025 04:39:12 -0500
X-MC-Unique: KReWrd23P8mS3S1ha6n4bw-1
X-Mimecast-MFC-AGG-ID: KReWrd23P8mS3S1ha6n4bw_1764668351
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e32e1737aso5831834d50.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764668351; x=1765273151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PMkBJ3jqGuxhzGxj8q5ujXEQJkMs5T+aOdk2vs/fKM=;
        b=ZoM5yYaTVlXW3xlTy/HJ6dMEwm6+lxXBWnoF9nMmCL8A5/FWIPPsMCVzlBaDeIuaiU
         Cc0WEbI0su+hfFh+7X4IUZm4EHbZ0f+YMRT9s689GMpAyb3Cxta1V/C7TtOa1Kh2lvM1
         +lEdVV/u0SBM6zohyDJMAupRFyEvAQDEtLfL4BqlEAAr61vxPkMhJB+4qoI72ge0ZLU/
         8zVFGHBv7yPwlUyBagxfHcGznJAZF24bC9ZZPdmYmd/XoUa0Fqfp5EL33HM7cixH9+ve
         wP8qBiDsPpZKCq+Dz6BfX/QQl9+FgCxie9diR6sr7uqdoliIQy2pVYQK8aA8MAUDeAG3
         9A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668351; x=1765273151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PMkBJ3jqGuxhzGxj8q5ujXEQJkMs5T+aOdk2vs/fKM=;
        b=FwpHmVdFiNAqZtlIETu5tFqo7p/Y0D6GoNq98wq1Ijayzqf7/Fmr3DHBWk7ookkGrb
         PI3pvTVV9lNJoHQZNm6+BM3voPEgiC1uqSqvC6PmPtqchUhey+QFVuCGEvHKW/4VCH1X
         vc4DDcsLOKkY1FoMBbkTSR2S8zjW8fTdOGdqjUp+8vcSQKksQnUsdxr0qAekHWKErADg
         H6dpgeyA8AgIZWBL1eDO/csXLL8TKfWqWa8FujktySBQ2rdNxTTbYNzonTbCmBx1E2R9
         cnxWumBhhb3o6IYsjyocwQk2Oyj9L/GaCZyuZ4KRYJV4hXV7NxxqJ8NFNaCqfhMtwz22
         uupQ==
X-Gm-Message-State: AOJu0Yy2r19QN7kSke8P63Ik4BndLGv8bSsKCA8mn1rH/74+kxKHDdkn
	RtzOyzZVHfbyI7eOt2uVPcV4vGEFOij275FJwRKeKShI9Hp0sCTQ3K7WF08H5rq/YThhe7rB825
	eUb+G+ftGvAEbuTctBXLAR9hDaGaGKsbZ3tMARH/JLqtHQmaqurpAa73c51kEVkClu1+30Q==
X-Gm-Gg: ASbGncv5dGzhQEGe5qqsCGO6vF2/O+hAJjmUEn6p6aYEw915Feia80k+++X0aaUpbZm
	z/HnflnNFq7K9wV9l85ElhjZCtyXE2sHalkB4fVIiGuyE5DOWWFZcmLn/P0JIf+Vb/BDl5lOt/V
	ZFS32dUhM0iaN86V/dTTMlmsh66PalRPjEqsacJTjKpO76bHpn87Nc0n4zQMoSAeIpp63roo32X
	a/331jdPz1TY/ahAP7gXXwwPDmDolZkwKIbGoggvEiG4JsY6MbZmf/2f1MwDVLIGkoEtFkORw1E
	Bo8hOtmzmfO4vNqu7H9wh2yr/qQ9ifKnVddwe39SGNmmxzXA9/sX9rAJO39buB5DQ959/rFCzJO
	50/f42zckBpBOSw==
X-Received: by 2002:a05:690e:12c7:b0:640:decb:4537 with SMTP id 956f58d0204a3-64302b2c8e6mr30698769d50.58.1764668351502;
        Tue, 02 Dec 2025 01:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWKQ+i5bqFZm7//7GYVsSKxVMOBPANik6NYt+jiekHdH1VddhXBg0QSY7EECKghHytlG2NOQ==
X-Received: by 2002:a05:690e:12c7:b0:640:decb:4537 with SMTP id 956f58d0204a3-64302b2c8e6mr30698758d50.58.1764668351141;
        Tue, 02 Dec 2025 01:39:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c484722sm5995288d50.23.2025.12.02.01.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:39:10 -0800 (PST)
Message-ID: <5f4331ce-7ca1-4109-99b1-90e45d9026ef@redhat.com>
Date: Tue, 2 Dec 2025 10:39:07 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] selftests: ipv6_icmp: add tests for ICMPv6
 handling
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20251126201943.4480-1-fmancera@suse.de>
 <20251126201943.4480-2-fmancera@suse.de>
 <341a110e-7ba0-4846-abf4-5143042c8e80@kernel.org>
 <30ee83e6-bed4-43c8-bbe2-ea19fbf17ce3@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <30ee83e6-bed4-43c8-bbe2-ea19fbf17ce3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 9:58 AM, Fernando Fernandez Mancera wrote:
> On 11/29/25 4:56 PM, David Ahern wrote:
>> On 11/26/25 12:19 PM, Fernando Fernandez Mancera wrote:
>>> Test ICMPv6 to link local address and local address. In addition, this
>>> test set could be extended to cover more situations in the future.
>>>
>>> ICMPv6 to local addresses
>>>      TEST: Ping to link local address                                   [OK]
>>>      TEST: Ping to link local address from ::1                          [OK]
>>>      TEST: Ping to local address                                        [OK]
>>>      TEST: Ping to local address from ::1                               [OK]
>>>
>>
>> VRF based tests are needed as well to ensure this change works properly
>> with VRFs.
> 
> Thank you David. I am reposting it with VRF based tests once net-next 
> tree is open again.

While at it, please have a look at the shellcheck reported issues:

https://netdev-ctrl.bots.linux.dev/logs/build/1028021/14331024/shellcheck/stderr

Also, not a big deal but you could possibly simplify a bit the `ip addr`
parse code using json formatting:

ip -j -6 addr show dev ${dev} | jq -r '.[].addr_info[].local'


Cheers,

Paolo


