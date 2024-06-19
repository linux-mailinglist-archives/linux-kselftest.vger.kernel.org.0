Return-Path: <linux-kselftest+bounces-12255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444F590F398
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E7B293C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829115EFBE;
	Wed, 19 Jun 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w9bel0pK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DF15EFAC;
	Wed, 19 Jun 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812584; cv=none; b=VCgQZFNsRFQ78QLAMYlBfDO/IKpIEGbnJViQMp+yOj3W1lcWdxJof50FEQU/mZQgKh/W7WysbquwOPra4mKmddswg5ImhTtHfX/PtGvx3kO+oZFvg46j5dfLB3zqzrxCPDp0/ijTuI1LnwlhfJoDV9GCbPVSch1w7rPF4eoZrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812584; c=relaxed/simple;
	bh=qVFiV6fvIAdt+msPlYj4zF9r0yL04OzXmen0AIs9Bek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QknAv92n/EGWRNilvRJUBtN3gHUd3/S4UzoTn52QIo1ijnq56+nOsBL9GcjO5eFLxL0B+3B7TixrDrwjfzOOsSad48VZ5Ohxy04TFV+Ks+l2my3EleCnCebJ6VCAKs2XoPMOWVbAaBEXkDyAZJDISK9G7mvMIlpBjxOQzXaNf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w9bel0pK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718812581;
	bh=qVFiV6fvIAdt+msPlYj4zF9r0yL04OzXmen0AIs9Bek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w9bel0pKAw/GWTTQsgU/KgHWCmR+LN56PnoIgWo4Tr0ruwOU5RTp9cDdWRmdXuYZf
	 kc6KRbxT/JvDKGeFUtMS3vrdZy9Fzni5nqHmIpx8+prA2pV0x3+7qzDlll4ipB79VR
	 w5peLdXbpPO55P22rmOldRmfLg0F6mFGjRy1pL7CNvJ206He4OKYAqIICDvXv6fXVr
	 IVqrictBwtAXrnS/HfLoqu/Jz9iPwDb4aqaOvWLxuTiHr+fzv8+eKsSZZ/O0BPQ1qZ
	 zUVCbx32SFRFDQFLs4S6klnagb5eaMb/BY0VDzcloWTzesmW+nrk6PpVL7UrhJxyOb
	 vP3WkOvnz+aTg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1198E37821A9;
	Wed, 19 Jun 2024 15:56:21 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tim.bird@sony.com
Cc: kernelci@lists.linux.dev,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: RE: Testing Quality Call notes - 2024-06-13
Date: Wed, 19 Jun 2024 17:56:56 +0200
Message-Id: <20240619155656.49768-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <SA3PR13MB637241E8BDBDDD625D4F5129FDCE2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <SA3PR13MB637241E8BDBDDD625D4F5129FDCE2@SA3PR13MB6372.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tim,

On 6/18/24 19:29, Bird, Tim wrote:
>> -----Original Message-----
>> From: Laura Nao <laura.nao@collabora.com>
>>
>> KernelCI is hosting a bi-weekly call on Thursday to discuss improvements
>> to existing upstream tests, the development of new tests to increase
>> kernel testing coverage, and the enablement of these tests in KernelCI.
> 
> This is interesting.  Is it possible for me to join this bi-weekly call?
> If so, can you send me info on how to join?
> 

We have sent an invitation to the meeting, let us know if you 
didn't receive it and we'll resend it. Please note that the meeting is 
currently scheduled for 13:00 UTC, which unfortunately is not very 
PDT-friendly. 

>> In recent months, we at Collabora have focused on various kernel areas,
>> assessing the tests already available upstream and contributing patches
>> to make them easily runnable in CIs.
>>
> ...
> 
>>
>> *Boot time test*
>>
>> - Investigating possibility of adding new test upstream to measure the
>>    kernel boot time and detect regressions
>> - Need to investigate available interfaces for reporting boot/probe times
>> - Multiple measurement points may be necessary, need to establish a clear
>>    definition of "boot" first
>> - Influenced by defconfig; testing with various kernel configurations
>>    recommended
> 
> I'm extremely interested in this.  I was planning on creating some boot time instrumentation
> and a boot time test, this summer (before LPC in September).  I would be
> thrilled to talk to other developers about this (either by e-mail, in your bi-weekly
> call, or at Plumbers) before I get too far into it.
> 

That's great to hear! We're just beginning our investigation by reviewing 
the available interfaces and assessing how to use them in a potential 
in-tree test. We would be happy to discuss this further during the 
testing quality meeting on June 27th, or sooner via email. We'll reach 
out once we have some ideas to propose and discuss.

> If others are working on measuring, testing,  or reducing boot time, please
> consider joining the "Embedded and IOT" micro-conference at Plumbers in September.
> 
> One of the chief topics of that micro-conference will be boot time.  Please contact me
> and I can let you know instructions for submitting a topic proposal for the event.
> (Or just submit something at: https://lpc.events/event/18/abstracts/)
> The instrumentation and testing of boot time would be a great topic for the
> micro-conference!!
> 
>   -- Tim
> 

Thanks for the heads up, we'll keep this in mind!

Best,

Laura


