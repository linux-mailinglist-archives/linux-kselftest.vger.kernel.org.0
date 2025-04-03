Return-Path: <linux-kselftest+bounces-30064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9779FA7A450
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B04174B6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED924CED6;
	Thu,  3 Apr 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvS3dYfD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF9199FC9
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688131; cv=none; b=lHGeCV5LA5coCNVFroUi8q3Du/9IThwTgbt5wVSXEfOLaKuV/TCbytnDFBPIH2rRks9GGV4VHlWpIVXO5kOIKy5nN+r3m9Kol00WmNDxGgIaKz8WHgS0bmzlTleDyiQ4FTh/B1xqoCKBJGg/2t2H3jGJBgbWPTyLcjUS+4XoWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688131; c=relaxed/simple;
	bh=X8K2hZQqJMCGMpB1ml3pgOIG+WSAB71YixBcihVOC/4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dwO3cLiUyfamlCWndx2Bcq38higojSNLM1Q7k95/iLj6Ou0Ot0NX7g5TQKK5SLLdeZvwVXLLrVfVZa4+2js21Q4K5z+AMKlggclcWcKs5Ff8gYEP0PIFLVtPC1fu+xQ723GFYrgOsDhi9/RhL7ybVVIP8NTBqRSWrWD6j/NNRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvS3dYfD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743688128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lyWZ8gblDVHe120rUXUjARVSAokRrQ5lvfAATMT9n4=;
	b=cvS3dYfDK0c42IgU3FMXxTaMak5EGaz9n+qv45xMK4XS3fHcGeyonQnJujlEdLaxIMNoBa
	8eE5JVnhrStOYD3PwsizbNBIp2zJaeGX/YB/5sI6udX/npk7I/XzFxzXwqNEvuQ5vwNdt9
	CoES3tcZ882cyghTUfUdiXBFHTijM18=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-O38bYrXfNnSgGhr3WB1DDQ-1; Thu, 03 Apr 2025 09:48:47 -0400
X-MC-Unique: O38bYrXfNnSgGhr3WB1DDQ-1
X-Mimecast-MFC-AGG-ID: O38bYrXfNnSgGhr3WB1DDQ_1743688126
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4767db0bae2so14685351cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 06:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688126; x=1744292926;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lyWZ8gblDVHe120rUXUjARVSAokRrQ5lvfAATMT9n4=;
        b=cuV1AWXyhPk+O5BMP2yxs5FIh50KDrPpnzaRPvY9HzvtfD5MLXnN1k+SF0jrKE2x8S
         /xQ/9SYSh47CGOKfL/YfIcEvJBuEY/RhL+jfaURwOjJylkRnmgDV0YnF2tlxrq0y1Ttr
         OcooFx0XNWZI9ndp1EX8FUY3E9mqIlRnbEDBhEO2fCqdqKwo4gAiavWqqtCcg2aeIuFx
         0b8Iq//d6BrcZSRThW+Max+NJeYf670OPFnPkrNc1XaBc1vM7Ps/aa9bazf2UlQaN0k6
         nhZWGQc6JbEWgDr5c67+2E84wMTnzm7i7ONzrAniX5n/BmqhWH3jLXDOBUIO9d4sbcJh
         EWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZq+6GPAJCNv9Ys0jE2ypTgSZgIU3UNoafpYlfI7/1OwBu2cbcKoUQba/vW4bCoxdS7ywh+JrmtaJzZN46fe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwhBYd2byWgqYbORSr9YyWyrRcIlsB9uCD0bXxGXKqPi5tKmm
	O2ZMcqxv4YiPFPVS5cqYELNtUfEu4OVtwGjNYPxcUsx1ETfBwxDziIWNBIC79kMWAaHHjbAa4AU
	MdMUIT9iTDZvZ1hs08u3G3dneX+I/Bgzae9WyPHEsQYJCBTmHKOC1cIfUaENvGTAoag==
X-Gm-Gg: ASbGncsYZn2lr2rKg+ZaE58bZ+t2swLQMCuFE/NArjRszQGvZteM0Pq997muHFCsTDU
	ERci8sgkvCAt8OY1lHygTtJtcqaQBfNqjpAlGJu/aVd/khEW5cmv7aAg09IeXNiTejgSks2sBpc
	a8tLJ3VFQSgFb9bCAzkzNTeuIEOOS54xrBbpwG7rTGIBnWLLezLLnxoleLICiCKvBkIrTnPdit7
	VMRzuYmuiiqj1X9W0cTS1vDLYL9d3eYvGcl7KiL0mP9BazYm5XQXfRFXNY/6kYXBIR12Pfn4Iz6
	as4/aoOUjCLgnvbPgTCL8Rk+uH/FxfflhRhABwJCniDHM4AZB5hIN+WT83rlIw==
X-Received: by 2002:ac8:7d84:0:b0:476:98d6:141c with SMTP id d75a77b69052e-477e4b66bedmr383982051cf.18.1743688126645;
        Thu, 03 Apr 2025 06:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo7x51vzTVDAQ2P95L9od9uzm0Cwj9FDry+VsenXXfp21aleo/hYZIXBJiuOhWfUblZcxwtQ==
X-Received: by 2002:ac8:7d84:0:b0:476:98d6:141c with SMTP id d75a77b69052e-477e4b66bedmr383981751cf.18.1743688126419;
        Thu, 03 Apr 2025 06:48:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b088346sm7967391cf.41.2025.04.03.06.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 06:48:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2d1b9c9e-a63b-4385-b706-0eee73688343@redhat.com>
Date: Thu, 3 Apr 2025 09:48:44 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local
 partition over a remote one
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-6-longman@redhat.com>
 <c5akoqcuatispflklzykfwjn65zk7y22pq6q6ejseo35dw5nh2@yvm7pbhh5bi4>
Content-Language: en-US
In-Reply-To: <c5akoqcuatispflklzykfwjn65zk7y22pq6q6ejseo35dw5nh2@yvm7pbhh5bi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/25 9:33 AM, Michal Koutný wrote:
> On Sun, Mar 30, 2025 at 05:52:43PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Currently, we don't allow the creation of a remote partition underneath
>> another local or remote partition. However, it is currently possible to
>> create a new local partition with an existing remote partition underneath
>> it if top_cpuset is the parent. However, the current cpuset code does
>> not set the effective exclusive CPUs correctly to account for those
>> that are taken by the remote partition.
> That sounds like
> Fixes: 181c8e091aae1 ("cgroup/cpuset: Introduce remote partition")
>
> (but it's merge, so next time :-)

Commit ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag") 
is actually the first commit that introduces the concept of cpuset 
partition which is basically the local partition that I am referring to 
now. It is that commit that did the  partition cleanup in 
cpuset_css_offline() which is now being moved to the new 
cpuset_css_killed() callback function.

Thanks,
Longman



