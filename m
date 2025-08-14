Return-Path: <linux-kselftest+bounces-38943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC07B25DF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79AE9E73B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896E628CF7C;
	Thu, 14 Aug 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6VgBr1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6D28D8E8
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157524; cv=none; b=DGxnsriR++g8dL+i5pOlKqlkhy5M8xQJlXJuzKex+3UHziWcIlmVZzXqbGOw7SW8JzByvAwbH8OKDfBCNimG+7hZe647+Wd2or7CssHzyoNyxWy9jOqxylr1p3sffJ0POOPoHr0fVVi4fp6N8DiTNexCELR5+myg/OUq8iw4CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157524; c=relaxed/simple;
	bh=KSWLnoTBOlNzYx5x5XVZJ7YKJEDG7DMm3pzboACqSU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eVxXYr6R3sS4Fo4A9/O2cIeOywgLFelHfDOx9nYTY8RoC1EaoYQiekKhP3x/Rc717wfOuSAnR5YldkC4MVJ+7cAwAVZLpYjp92yc+fIjdQrY5Jg3vTa2PQRjtF/ej30mPyI6RI0bHxf2lxBo4xFOWGYhhTQt1g4LQJ1gDMrM0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6VgBr1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755157522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh3fAUzpnwErAtwtO1rLAD+DknqFNguq3c79rP/CRi8=;
	b=J6VgBr1/V9v0l4omZcuG3BNDnZXBHagQiMsXrO7f9yQFfUyQE/6rcYviNBDqdrk0ZfZZqD
	dD2ZG2psrhsy2Jf/e4KzoSjSRMe25nPBhTWVW40IwtWvu+5sbtJCBsSi6BYRPVHoRNpr3u
	3TrkzZuNv9QnN1BlrhaDXMeotfR8474=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-59Pr4tpIPf6flZDe4H3jTw-1; Thu, 14 Aug 2025 03:45:20 -0400
X-MC-Unique: 59Pr4tpIPf6flZDe4H3jTw-1
X-Mimecast-MFC-AGG-ID: 59Pr4tpIPf6flZDe4H3jTw_1755157520
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a927f570eso15360626d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 00:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755157520; x=1755762320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh3fAUzpnwErAtwtO1rLAD+DknqFNguq3c79rP/CRi8=;
        b=UVB+rta583hakzFKezxATI3G8LqhzJ81HdcBd4gV6whhOunzyLuygEBJYviZpY0pBM
         mDa8AoQTNrXV+Uiukj+VlQPWFehJrsV2GbWwydipuQHjFSo8a92cYa+qiv6V2bNVGF+v
         ZcRCesE1ijPlLiHD9BDz6VHt3wdZt4Gi1Fxj4FctjToryjDnwu2yvTKIA9cmuRScxzQo
         Zdj4oKhY7YhForxa5u7A5RRqdyP8DkYU9dzJ7nO2lCD4NsbH7Ja1rTjMCYVtbrUQziYf
         JSuz8/5qTvYyqqsc9N3HRTCgG0hf7ANel4nqbTAePme5M9R2sCH4YxJfMfBkUGO6nDeK
         8I4w==
X-Forwarded-Encrypted: i=1; AJvYcCUeA4wKl08hsKC2YvT6jYXjFTDjScJj3hmcrna1GLjwfyWOtWdWCkNOQDjYnM2RGrHTkw12xhdovPuTAna5OIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTlNSeQTOekd37WgShzeOJEHQIcTnj2YafVRZmYVc1cWruERF
	X+C7IJOhB/sdAOkdO24HQIqO8myCUPPgyuzMEjS6gpI/4a1NvgkT8RPyzaiM3KreDQCoXgterJS
	tpCNUjKNfcWvOE5gqXJRsu65lzYQaBxuBS2dboKMkKx+CiHqdrs9jHGm0UwzJp4AV98gv9Q==
X-Gm-Gg: ASbGnct4DB0UPhr4Dqck4rQZNyhLo7Tar76Bls2YwRwK+TVIeWDo8/nBbzIJMXcKouW
	aFifJer2buxQ6VUNHksZv1Uz7KIDSyvCOnqyLRHZ5ceCqNEZc7jXXzwdOIuf4KE1INHRrwKNh1i
	49CGGj044d2Zm+kzTQv38huB70A2sJi9OK+Ww9dPliKVMagxMUc2DdGZZVTDef4n3lwI77DzJTC
	zt11+Rd+vt6OKLtL7vCJpR+RATjPym/8JcwD9YbcCZJ/QwVz+kzINtBWfaZG0PTWJOxJqAWVvJY
	qEt64EEL5VM6JPxRwtVZmHI2itIjuiC3dGykDDnI0dJ5ZTTi5QGmoFkh7IdqcbyZ5wyfEn1p247
	9FE+qX94wFGc=
X-Received: by 2002:a05:6214:2aa5:b0:704:7fda:d174 with SMTP id 6a1803df08f44-70af1cf09bemr31867706d6.2.1755157519991;
        Thu, 14 Aug 2025 00:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6lRrp4NlQG1ZkIRQnCbAccBSIpsmnxNsHLJGiUzBCfXvnS33GU0a29KgbaqXmSBQXEvaOA==
X-Received: by 2002:a05:6214:2aa5:b0:704:7fda:d174 with SMTP id 6a1803df08f44-70af1cf09bemr31867416d6.2.1755157519405;
        Thu, 14 Aug 2025 00:45:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b0692csm9715536d6.46.2025.08.14.00.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 00:45:18 -0700 (PDT)
Message-ID: <274729ea-8db3-41e4-9dfa-f33e5e65222b@redhat.com>
Date: Thu, 14 Aug 2025 09:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
To: "Livingood, Jason" <Jason_Livingood@comcast.com>,
 "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dave Taht <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/25 5:43 PM, Livingood, Jason wrote:
> Hi Paolo – If this patch series is delayed to the next release cycle,
> what release number would that be and – more critically – what would the
> timing be? 

See:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#git-trees-and-patch-flow

net-next is open now. Patch need to be re-submitted and will be
processed with the usual timing.

Thanks,

Paolo


