Return-Path: <linux-kselftest+bounces-19707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505C99E096
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909151C21C0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F31C68AA;
	Tue, 15 Oct 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdM8f/3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381821B85E3
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980070; cv=none; b=l2CcOlSkUlX062o0fKCCvwFLoz/+xLjYt3QKMK611U1/pb3Ty3rRMPDW84J0shE2dr+CXAjDpku5JV0Nn5oRUPkFo1ccBQp8FAiQXa1MfxeiP9kTpStilCrgUtckYWgFVrlwWrYoL4X+frqug62E/LlxhWZRvL+FkftchHPiI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980070; c=relaxed/simple;
	bh=huAJ1quTTVf9I7zIA1DxYzuxMyL3Ic5yTgUo81F9fW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1heQES73pJ9KFahpiMrt7pT/Mg8pEndjKE6K1jUSjATg/HbbboLmXgC3q7H4Ij8+p7oEFtAx1WZAGrCdi6bzM/i6jzpN27qfAcmGY+bHopU35BUb0ghL10/I9TrP5eEyDLS+YlWka+5/HmIrMG4SxM4ZaJ+UswvYuacOZBt2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdM8f/3x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728980067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovmdFPXf/mk8R/1ge0kg1lpqUjDGEvD34K1g7jLLqgo=;
	b=RdM8f/3xofD4HXBlwLi3I56XypEVMeqma3/u3fu5uMns2/1FHGfB6WvHaHBYofpmoSCuCW
	gBv2AvGJUMm5ab7bWtNZovFy06I5m9TnGyynfWv8Ndx47hYYnMH4MQ0dY/uG9qo6R1CubN
	rad+xq9Wk+iatKuvRtv2pg3qaToAOB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-ZWSnLXqIMP2BLqJBHK4unQ-1; Tue, 15 Oct 2024 04:14:26 -0400
X-MC-Unique: ZWSnLXqIMP2BLqJBHK4unQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431159f2864so26518935e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 01:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980064; x=1729584864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovmdFPXf/mk8R/1ge0kg1lpqUjDGEvD34K1g7jLLqgo=;
        b=sIvKQN7BQygFI5AShOCk/YnofONAv5goSSclDEZwefAz0be5/MddjdoxzoXjlUD0qN
         wka/3zueK6QhN1abFFw/xqobL0Cui8kqAdfwOPjIF9hr+zzeCLERO9eicG2/1aMU1Xw5
         wDfWQR4TLFJYS6tGYwKCmbZFrmce41/oaLhdIcCb2bf0ESCRrJszDM9GRhzJer34Mm4o
         +yw+oe7Irji6u+chj1lRGXzZgwiZTI1a5tnnxKSmZ6CJj8paxPwG3GOyu7dHnD4rAhm/
         lkc9hB08rGQZp7+jkyHFZXYE3D2qzsNkJE2O+g2AadsmAbuqCjjTPnmH5h2Lk9lzgoHY
         rsmg==
X-Gm-Message-State: AOJu0YzI+EU5aYdCmrG1XQv1t4Jzmez+sKXiLjCPic+NaEddXBw8U4lG
	jALI2o00v6TrV/Xh5eOGGA811/AH6SuIlSydnD3jgN976LeWMC+4qnXi5JSrM/bqbMEuVgsDtNw
	BOpbazErv6vtky4+jMW9jiOO+plvsHBbk0vCdmS9lXYF5BIbh+umvORnqQnkcwT7M1w==
X-Received: by 2002:a05:600c:4ec7:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-4311df47618mr98786575e9.27.1728980064563;
        Tue, 15 Oct 2024 01:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQLgzwoml0dhiEu0fUCEh7JGHCpNVpyeXag9LTrZVLQNlOQxnNBGgh/VQejL3rJ8a4BvtE6A==
X-Received: by 2002:a05:600c:4ec7:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-4311df47618mr98786325e9.27.1728980064088;
        Tue, 15 Oct 2024 01:14:24 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43144c7982asm4255355e9.14.2024.10.15.01.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:14:23 -0700 (PDT)
Message-ID: <85f5d99b-52cf-449d-93da-57e7504685e1@redhat.com>
Date: Tue, 15 Oct 2024 10:14:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] selftests: RED: Use defer for test cleanup
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, mlxsw@nvidia.com
References: <cover.1728473602.git.petrm@nvidia.com>
 <4a9b24fa7e582bdf457b550bb27bb1e227f05b48.1728473602.git.petrm@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4a9b24fa7e582bdf457b550bb27bb1e227f05b48.1728473602.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 14:06, Petr Machata wrote:
> @@ -450,6 +415,7 @@ __do_ecn_test()
>   
>   	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
>   			  $h3_mac tos=0x01
> +	defer stop_traffic $!
>   	sleep 1
>   
>   	ecn_test_common "$name" "$get_nmarked" $vlan $limit
> @@ -462,7 +428,6 @@ __do_ecn_test()
>   	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
>   	log_test "TC $((vlan - 10)): $name backlog > limit: UDP early-dropped"
>   
> -	stop_traffic
>   	sleep 1

I'm wodering what role/goal has the above 'sleep 1'?!? It looks like it 
could/should be removed after moving the stop_traffic call to the 
deferred cleanup.

Other similar instances below.

Cheers,

Paolo


