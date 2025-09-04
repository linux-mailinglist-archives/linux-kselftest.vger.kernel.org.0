Return-Path: <linux-kselftest+bounces-40752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47604B43548
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEA83A4C09
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7622C08DC;
	Thu,  4 Sep 2025 08:13:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46626B747;
	Thu,  4 Sep 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973629; cv=none; b=Ncur61EDkp+qFWbedvYcCaTHLlmrVDx+hRF9Oy2BeL5wh5Tq6YewNu47+iq/NUqX7+oGqXIF3YGKBvQagb/4Gmvt3vQ0zf2FoCOhyXKr1DfnOaZQe1IzlVAURImypJbfbA2eFz110dJzxIqjqj4jHOFJpf4AFhFQMo/HzNb29cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973629; c=relaxed/simple;
	bh=jz7Es75mrp07l3ocxFRtg6Pi0DrCm+Sch724BCJO8Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVok3UQgcn2idbQMasiUA3evLC75GnPVBQcuvLNRAtpWHVTFDYfptgfFPSJIK8QhdhHE2Io2ubE5KTDMV86qcP14tpwF4/kRINikZWFafJZVMO9joJvWGTCKNntqaaVJsMsXuRym+RvTFdPn1qwKFIodewF6Lcjl5RVCV9yKXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0449b1b56eso111940766b.1;
        Thu, 04 Sep 2025 01:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973626; x=1757578426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX5LtwmQbu6jHYJEj8ucqc0L+IqxjK5DhENC7XQ5Ye0=;
        b=qwkoy/Kqt2ogEekSTw4XwDYnmGQYZTjzwcBrYecEzttxNdyGzjhbs3tRa4+zebmOFM
         ZZ1ODNubqpSKwMiIlPPOr2Vfl9qINpxuPUsFwxhUnYNi/ofBag0OrOyn4Z+P6+ldDM5e
         AXoOss6FQPBEORskMOzusu/psOBDygR98Lz+ly9oPkepxfSUq4G5DGyWlev8f7IDnEiA
         JS9YRHXCLmhySXuDfwhYF8IStSv9hsGHgbIZ3PC7hbPk0L5dM764deACGxQvtz4qB2oU
         nS4A8ttnpPOm64YveJJOMAe0qxWysco1qoQAQIdGDeykqYRkJBN3XPF2kuhpNyotGPpP
         Tdzg==
X-Forwarded-Encrypted: i=1; AJvYcCVmdhE21Jv4QJik0SGHXp+5lJVyVt7Q4+3hk+0ra7BvU0VDodLGMclQwgRn/HXosaM0wrVnuQCsg9glvNM=@vger.kernel.org, AJvYcCW9s/d1qzk/LAduRwU6aWlcpzGq+ogKKsox32m+sezH3Haa27il1YU/18AIaJNC5c/1klTf1Nij@vger.kernel.org, AJvYcCXmlaXcZkoA9VVI7cj6N4OXXq7OAsD/wGdjzl3FCYTi0EWloXonEk6EpX5ON1l8sHxjqJctVU/NTCMBEHNtA2w6@vger.kernel.org
X-Gm-Message-State: AOJu0YwkI68WoHd9b8bIURNcG+jx1pORGbi9vI8NLIsVvS3mTPb1+icf
	UoEp4UYCF70itQqt1lF8j11/PvrDOOblxoSVB3UixUxhmDnmlbDYNxzCvgJUVw==
X-Gm-Gg: ASbGnct0AHRavrakawuogB34/FMtL9DtuvzE00sbhDMNU8PLl1gy42wJlAWbeQ/iZMi
	1MN8QtTLO3qYFDI+hTi4FgzvOJoEa8XffqIsDv+VH/kDvRXRvU1U5GSUzrIBy1MBQptsapo+2X4
	OKciBZa5bejasJ26WUxym7pr3TD1DNy1mnetvhO1ySijYsnjxDByayqjkWzP1zicgBNSia4Dyh0
	nbJAkBbgW+Hgr7FIPqtYRTkXBZgCm5gEGmhBOMiZxtTiFTBhb3tSemdNHVZWsbAzYfdxYf2mYzJ
	3xoUtubm5eR8zTzfxZp5HIMCnkQv+Q0eeQLSmODHtOpV7NOuA5aHhN2uxMv8LilHS7SA8e7Q9jT
	nn8HU+4ODc/DB
X-Google-Smtp-Source: AGHT+IGM+krb7kpuShV0AtMieM/V796VzI126b7yZAD3pc4xke2I36+i037d/kBSbPkx46DHdqr6fw==
X-Received: by 2002:a17:907:7607:b0:b04:2105:e226 with SMTP id a640c23a62f3a-b042105f2fcmr1100658566b.16.1756973625489;
        Thu, 04 Sep 2025 01:13:45 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046aa92242sm326639866b.59.2025.09.04.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:13:45 -0700 (PDT)
Date: Thu, 4 Sep 2025 01:13:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, asantostc@gmail.com, 
	efault@gmx.de, calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] selftest: netcons: create a torture test
Message-ID: <retdlwpwrggmkm4fhqxp4gsfyz44ym656ymy42ulgsxqbs5m3o@j4p4xpsyokgl>
References: <20250902-netconsole_torture-v1-1-03c6066598e9@debian.org>
 <20250903173746.5c04c306@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903173746.5c04c306@kernel.org>

On Wed, Sep 03, 2025 at 05:37:46PM -0700, Jakub Kicinski wrote:

> > This creates multiple concurrency sources that interact with netconsole
> > states. This is good practice to simulate stress, and exercise netpoll
> > and netconsole locks.
> 
> Oh, when you said "selftest will be posted later" in the fix I thought
> you meant days, not hours later :) It's better if the fix and test are
> in one series.

Oh, I remember I read somewhere that new tests usually go to net-next,
and the fix goes to `net`

That is why I split them. In fact, the tests showed up earlier, when
i was moving the target_list in netconsole to be RCU safe.

> Regarding the test, I think it makes sense. Tho is there a way we can
> reuse more of the existing code?

Maybe. The only part that is similar is inner core (4 lines)
create_and_delete_random_target() that I could reuse if I rework the
other tests and the library.

Basically creating a new function that would do the following on an argument
(instead of NETCONS_PATH):

          echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
          echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
          echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
          echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name

Then reuse it in create_dynamic_target() and create_and_delete_random_target().

Initially I didn't think it was worth it, but, I can spend more time on it, and
see how it looks like.

> Do you write all these scripts by hand > or get AI to write them?

100% handcrafted test, very unfortunately. I've created the selftest to test my
changes to test some RCU changes I am going to propose to netconsole, when I
ran it, I got the memleak issue.

> I was hoping you'd add more tests relating to bonding.

I am happy to do so, given I want to get closer to netpoll. I will not be able
to do it right now due to lack of bonding knowledge, but, I will add it to my
TODO list.

> To confirm bonding still works. And as I mentioned I think
> bonding is still a bit buggy if we "propagate" multiple nps and then
> remove them out of order..

Tell me more about this possible code path. I can focus my this initial
selftest to exercise it. 

Thanks for the review. I will send a v2 with more core utilization and then we
check which version is better.

--breno

