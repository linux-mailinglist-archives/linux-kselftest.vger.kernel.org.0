Return-Path: <linux-kselftest+bounces-48761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193BCD13AA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20D24307AB49
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0D2E8B67;
	Mon, 12 Jan 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXgSTxtF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioGvxbv3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7282E093A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230927; cv=none; b=psue0qI5uCKCQ+egZSTeqLgeCwU1U9viZVGgGEnX2/ddYbON81fIl0AO0yFahJMxxNTERfLTf2VDd8VaczdGNvehFoZ4uv3K+HZkK3stcFMSd7N+nySyujSyo6Rsrmg7IZlGy9xsPgpihoKyeQCWsLTGsifhMX2x2+VbVY06abs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230927; c=relaxed/simple;
	bh=UWmSshBEHQ7KxE8MnHPkIfsFEU9/Q6SjGSI/Gge/kD8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A/3eYOcLfQZCSWcJDuqeXUi2VwxYdvoqwQUbX0j1GEvCfspCTc2kFRTufrgEGcIe8n66E/JATANoUP2ocrj5dixmACZuEpGHj4YhH2V//jN4A6v57jeQSG+PUBIz4tWEwRx7VdX2tZihy7G8OpSfeKLI0VfONIppeqI1AgAPKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXgSTxtF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioGvxbv3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768230924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBnEhkF7Qdzoo2GNW/2wAAQ4zQejO2Ma9rGc252Ro1o=;
	b=fXgSTxtF8BeRwYvyPxf0xpdqKQp7oJaynfulySPqH4D+nuhihhlIPdV2u08X/qC7/5EiKj
	tInBfdBseyodOCQk+bhA+vGHz7vb9qPGBEcNTKOPvEojhlSQqFEhqcR2Ik0lwIAjTF4mAG
	r4k39TefT5w6WppMko9p+YL+fg4a+mQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-P3tXk8ckN7meUBqGy40mvw-1; Mon, 12 Jan 2026 10:15:21 -0500
X-MC-Unique: P3tXk8ckN7meUBqGy40mvw-1
X-Mimecast-MFC-AGG-ID: P3tXk8ckN7meUBqGy40mvw_1768230921
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-890805821c0so219285926d6.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768230921; x=1768835721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBnEhkF7Qdzoo2GNW/2wAAQ4zQejO2Ma9rGc252Ro1o=;
        b=ioGvxbv3KePlaaSTy5wqTAqfaMPBb7jFEBOvmyp1gXHqCeS6U7WOtjPN+HGMDrEI4V
         p6FfEQy1kafw0OI9oqueCm7CMl4tFj6NByWvaFm07qVReKjisc/pDAl9pFvmtL7qK3BT
         Ck8zDj8dk4i6RUTc17Uc2lU5hB3hMb+035RVg3LnvSX6xHyQwdvg6MFpKA2/luEQ0pFg
         h5Luum8SQ40G05TbtnelPwm+XVQ6K/mCG1jBdlnt3yroW3Hquyj7MqpF9wBshxuygRWL
         MnWrGsHolYYrJfZj5ZAYMneMzUqob4EHAE00kRblHCg9XKvS/vaG1EkrcJtS1vx+Qdyp
         1lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230921; x=1768835721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBnEhkF7Qdzoo2GNW/2wAAQ4zQejO2Ma9rGc252Ro1o=;
        b=HoDtE7jAM7ESZtWPG1CP1+PpwgyqF39p7JJDZv9HoHardlRUoQHLNLrykn6bM+A6+o
         8+kt26YzQEcSlkiNdAqNnB9fCdzVJ/7J3VVD1TzwJ/2AurHHLf6HuRHYfrCd3EoeRpC+
         2/mZqo7sG0F+OTm14jhyduh8FI8U3mMTvAM8lOjVS3yzwgUuA+tXRmZmS1bZinjkVgYQ
         vjlBTKvTJmydf7MZV1qC1xjVUKyryu6D7wN+q53H1J6BtRF4Rch9qhahFU6yiXT/Ix+j
         9IDMHGx9FdO1GCPjLCLe02Sf54GlPAoGbE/c7iKnV06RUiLJA79gHFQgaxHEQpNgkTvW
         Hl5w==
X-Forwarded-Encrypted: i=1; AJvYcCX9xjhDjXvuAvR7BsBNXMxx1j7DPNaQiRs7MsmmR7trHBko+lryXN8Ja4NdFOTTOSgpGRyOomV6AcuaU3/tcl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzhC+5L8HUTq3ka9g+1PnyfPoUSD0BHRSMUhdmqQp5snSR6BI
	96ztNkair5bDwLIn3x90rMJcd7Lhe6bSHENPGfy5Mw8yL71OO+DvZEi417cRTd+4gFPIBgKUSdz
	XmTEmqPP3roQZ3NBo1bvtlW6xyk99dDwrDZPBeGO/MEBi+R4JeZ6AgeSdNxXuD/DxdrBdQw==
X-Gm-Gg: AY/fxX7NFDb6v57qWSD1NgognTXH7Ul8xIdZK5oFxSX/B/t5Bw8sMgYHxP1qdpCJqFc
	M7wHU8Hvj8AORpGSM7Adlg95oA4lCzrNUzmlg6PqrL+dbPFs0WstnpkK+dneRER+gt7c5EkCcfI
	7GU9/udLIX/nTxLYX7y7bRmDHElWiir/730eqWceV0N6Ok3abVAClGCLFzSC3+qbIUHyMJ4dsog
	Asro6QRxg0wqgNMEKGVignDM8pAXk64o3hblEDLbykBajsA4y0mx/9aX6xC+sguNCueRjILZCyD
	r+FSTKDJKr3jWW3iL5lStj+tMJQqniRXFKriygzgCDNvSvR7ygpUoax2InIUOT0IBZTVW/7bqWk
	Xua16YnJqRnNOa9TtmdanaXA6Sw6Ju1J5naTeq/8C00lPI9tGU2/pHyFR
X-Received: by 2002:ad4:5b87:0:b0:87f:e1b3:2014 with SMTP id 6a1803df08f44-890842d60cdmr242991856d6.66.1768230920854;
        Mon, 12 Jan 2026 07:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEEvjOnKFKxOB5sHeF3FHbEdls66ozWBRKEY9iiOUfJDVYVV2wAJMexcKiVyLElIE1U7IUUw==
X-Received: by 2002:ad4:5b87:0:b0:87f:e1b3:2014 with SMTP id 6a1803df08f44-890842d60cdmr242991006d6.66.1768230920201;
        Mon, 12 Jan 2026 07:15:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm137736816d6.43.2026.01.12.07.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 07:15:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9a1b7583-7695-484f-a290-807b6db06799@redhat.com>
Date: Mon, 12 Jan 2026 10:15:17 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong
 <chenridong@huaweicloud.com>, Chen Ridong <chenridong@huawei.com>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
 <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
 <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
Content-Language: en-US
In-Reply-To: <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 10:08 AM, Michal Koutný wrote:
> On Mon, Jan 12, 2026 at 09:51:28AM -0500, Waiman Long <llong@redhat.com> wrote:
>> Sorry, I might have missed this comment of yours. The
>> "cpuset.cpus.exclusive" file lists all the CPUs that can be granted to its
>> children as exclusive CPUs. The cgroup root is an implicit partition root
>> where all its CPUs can be granted to its children whether they are online or
>> offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs as well as
>> exclusive CPUs that have been passed down to existing descendant partition
>> roots so it may differ from the implicit "cpuset.cpus.exclusive".
> Howewer, there's no "cpuset.cpus" configurable nor visible on the root
> cgroup. So possibly drop this hunk altogether for simplicity?

Ah, you are right. I thought there was a read-only copy in cgroup root. 
Will correct that.

Thanks,
Longman


