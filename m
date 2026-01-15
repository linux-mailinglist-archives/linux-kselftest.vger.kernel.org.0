Return-Path: <linux-kselftest+bounces-49053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 816EBD27989
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 19:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E04EA3227A9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26D3D3CE0;
	Thu, 15 Jan 2026 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BknnGhFq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BC1509AB
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500553; cv=none; b=NjIy1ygziYT6o0EKk3n6gosVe3qnI9JxQ6xj3aovEgckbU+1aNRJ96eKgGQ4VNRS6EcSnvKErwcOdr76R0nWxxh/QgVH/RcqB4t+0TPVhDwWVrAUx9VpxBxQiMsiy4XMvJpaPho1pSAq/HxpQ/xnPZfFOvh5yhJ3eaMzHDJLLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500553; c=relaxed/simple;
	bh=s1vml7vcnt1Rp1v6JVpJDpiVuPBFnkJqBrKshWU1rJQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QrsU6p0YrIVk6gi4CR+/eS9zwAbGHGzCZyvZXRdg/j0OzSIAzNK6t7ogq3vfbs2XqySdsuKGANEREmxfZHlLJvbIrPCMBfp1otQVFSP1znzG3BCIzPDZTMXd+db0Or5oK1AdMElIywCpxj8u2IwEmZZQqdVf5o5aWVVGyJAchMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BknnGhFq; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65f66b8be64so3272506eaf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768500551; x=1769105351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1vml7vcnt1Rp1v6JVpJDpiVuPBFnkJqBrKshWU1rJQ=;
        b=BknnGhFq8OrNPzWB+WrXMMBfTRU6JPm7P4WLfuDAaYkVSkkD2cCZSP0AEumgfhJ8rL
         /ggzvyn/lhJc3/Lkf0g5gOHjRl00WP9GOV8VJZlc1hC7G9i0cWd5U12KFyXsDbyYHCxd
         SoZpLKehgGmwQCC5VcvzsUMbSjMIOhJcRG8s6PIG1wWUUCDps2o4u4ww3Ei+IyRQ8pbU
         gI1o9458Id7pJ7P4j1p/GEhp+LixJW/W1+Fp7BHOSWbbefawRYL73vs9lL5kp9t48uZ5
         ukIuZqu42u/yDvZqrGShQaSs5hgUN19tjTLovkY5/E6VOujbu0IOibGw/qbvK7mo1d8l
         vnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768500551; x=1769105351;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1vml7vcnt1Rp1v6JVpJDpiVuPBFnkJqBrKshWU1rJQ=;
        b=Q7b+CZPb60YULabYD/VOknwtqmUHxj+d8nrIdBfm431kNn/B0W5xMt56U9XtnG+3pY
         bTm/tb//09ODOlv7p79KCLey/y8Mn/qVgzDaWSo4ya7DeWujSmmWrEB14YX57/cmDX3w
         3uvTGphYvaawsYacOsv9UiQDJlxC+TsYk1lPhBwerQUy/LqlOzjCSbY/eypagxY8607P
         EEUJA/yxuAf0/L4QR05Eh//6w693KZvCWMAXeAAnTJB2XF37prZWx3OnXeIjcAs0a+H4
         OW7G4uP8qCSBAqtf/lYh24YEGxayX/ZHR04jFfBgsxOQxUFjincIbX4aYNTB36wULEr1
         GBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPTOPZ+a0qk8fPMyUiCJpP/wvijVrcAGquhLaCH7zYZUCnbSJ9xYFKPlIiXnPTBMx/R1Kmqe6s85ZKu4J1Gz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqK5mImQLrWti2h08DLdDBE7ehyWa1sFYT623w4qS3iB2GN2T3
	nqK7wThOiui8J/XVIuEeYuNhDJrxe1ilhDAjId8S3Rke/C1UGSUOHyA5SDfadtt3FHYSu+wPJkH
	nbfRAATR+JuSZqArwT4bDmwOIBQ==
X-Received: from iobet8.prod.google.com ([2002:a05:6602:4c08:b0:957:5463:901e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:480e:b0:660:ffa9:e2ce with SMTP id 006d021491bc7-661189e47e2mr16014eaf.83.1768500551087;
 Thu, 15 Jan 2026 10:09:11 -0800 (PST)
Date: Thu, 15 Jan 2026 18:09:10 +0000
In-Reply-To: <aWjlfl85vSd6sMwT@willie-the-truck> (message from Will Deacon on
 Thu, 15 Jan 2026 13:02:54 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntpl7a694p.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 00/24] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: Will Deacon <will@kernel.org>
Cc: oupton@kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Will Deacon <will@kernel.org> writes:

> On Tue, Dec 09, 2025 at 03:00:59PM -0800, Oliver Upton wrote:
>> On Tue, Dec 09, 2025 at 08:50:57PM +0000, Colton Lewis wrote:
>> > This series creates a new PMU scheme on ARM, a partitioned PMU that
>> > allows reserving a subset of counters for more direct guest access,
>> > significantly reducing overhead. More details, including performance
>> > benchmarks, can be read in the v1 cover letter linked below.
>> >
>> > An overview of what this series accomplishes was presented at KVM
>> > Forum 2025. Slides [1] and video [2] are linked below.
>> >
>> > The long duration between v4 and v5 is due to time spent on this
>> > project being monopolized preparing this feature for internal
>> > production. As a result, there are too many improvements to fully list
>> > here, but I will cover the notable ones.

>> Thanks for reposting. I think there's still quite a bit of ground to
>> cover on the KVM side of this, but I would definitely appreciate it if
>> someone with more context on the perf side of things could chime in.

>> Will, IIRC you had some thoughts around counter allocation, right?

> Right, I was hoping that the host counter reservation could be more
> dynamic than a cmdline option. Perf already has support for pinning
> events to a CPU, so the concept of some counters being unavailable
> shouldn't be too much for the driver to handle. You might just need to
> create some fake pinned events so that perf code understands what is
> happening.

Thanks Will. I have a few followup questions:

1. Are you suggesting this be done whenever we enter a guest so the host
always has access to the full range in host context? That would be the
most dynamic.

2. How should we handle the possibility a real event already occupies a
counter wanted by the guest? Is there a good way to create our fake
pinned events then force a reschedule so perf moves the real events out
of the way?

3. Is there an existing fake event type that tells perf not to touch
hardware?

4. Can you point to any example code that already does something like
this?


