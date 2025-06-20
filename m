Return-Path: <linux-kselftest+bounces-35457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA80AE20B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8B11C2401B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F71F5842;
	Fri, 20 Jun 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2TkRkrU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805F1E5207
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440048; cv=none; b=UylWqloHHrr6hrnu5OdwANgI5HIxCIErH5sMTQkDGcf9LoSVbLaaG/P3PcamYIqu+PZQJC5MrZBc5p+1H1eLKMSlYJ28CngIhxAG7a2AT56mdH4bsU4a8kzbPZ4iUYn1bg/bbggf85tfZivkuP5atp/JOkDnhya7a3mDDATwGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440048; c=relaxed/simple;
	bh=7H0fGYjbt2p71NCXLWJbMz2qxs1wwA9sa/Mf9Huru7A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dCF92ES3rZwugJ6HlW7VdIDADqgLJlqZcoqPT7d9qV7FNBnJQA4r8486jdYQ54DjtEwnNjzD5FsODWwmjB0fFGt3kXbSfJIP4zHReli2gCHwriapUcaM1p2x9L4IAtpYKZYi2EZ3g2Id9XLjxqpjib/PgL1J8rr3Fa1mItPA1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2TkRkrU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750440046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7H0fGYjbt2p71NCXLWJbMz2qxs1wwA9sa/Mf9Huru7A=;
	b=G2TkRkrUz1sjUQEy2Pe5R8J8OZ6pAh+qzwqGqW1xd+Ui7IKpUN2CkcDt9KcerZ3W7OjrWW
	Vu8i2LoUum2o+v4l+gNBsr7MhBCI2w1WQa+LtDk8DCzv70k/tYQuuSWfBm3a3uYg+/RUJ5
	JMfQ97XCvMDFVefv3gvDtzXQWLW6MOs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Oq4-NwIUNpOaD5n31c2O8g-1; Fri, 20 Jun 2025 13:20:44 -0400
X-MC-Unique: Oq4-NwIUNpOaD5n31c2O8g-1
X-Mimecast-MFC-AGG-ID: Oq4-NwIUNpOaD5n31c2O8g_1750440043
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade354a2f6aso167179666b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 10:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750440043; x=1751044843;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7H0fGYjbt2p71NCXLWJbMz2qxs1wwA9sa/Mf9Huru7A=;
        b=DwgPNMiY9GTAT5X6aKbR0pvAzlIiQZHw+rEnEitRufM3wegJL/mtrtJOh6Ht3nm9FH
         XBQRTjMwxrQFDFPOS4dAR/TnEokauzf7QXeyydQuCfVCW2speeqALXwwj3ECvM30mo2X
         PvZVIpKADmcXr0KK8Rd1jHjKuj7jiY/XRm3Vq/Dlibu65HBjmVCwBcdkNhRmqAOWT217
         badt6bCbgeC/lqW2uQbyuERGPKJBfTCbwskBb5I0Aa2gtg0lOUB9jX/RlvxAistaaOJj
         hCtkOkGWGOfsVuQObsLc/C5mWcLti9S2dmjfH3N6uZBFAFrjGZ2TUGEbRVNr3FcV3sbu
         h7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV4X5C4dY7wFdrQk82LpYd8exs0biyakpMKyq+3l4RSZArIx3x5EqVT+LF94I7AVejDGAcaKw56NzOpJJH7SYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyD7CuWy0Znufmar1h/LjbOZemto93VgG1rOHIUQtUbtDLirzj
	jUsGervNqrDwWxxXZi5fSvjuSel0w4pp3qgspUPM4VkfthgTyAYgTI85o2fZer0mfLsQ27aIKpg
	3PlxtDYuoqKHiZBkrUZLkTxkWmyuPaF6EvefmKzudY/9Lbf/6GZ2qocyMK+BDgqQiN6GsDQ==
X-Gm-Gg: ASbGncu5TbI/eAwQlYXfCmwZvwBsgG5gKIs6DyzAVkOHIf1he6tTDzDPpRCyvOIDqN2
	YJsLWL7zGySdrQ1Mx774ZQNtjUzOLHPBDbSuYVlDuCfphqUvmOmbs07HTbJ5AwnwhlJ4ezt3Z2F
	D+AXNOAg7Vcatg0BwKNTWs8ydUJ/shhpF1I50hEH9XfRW7m8fvjIhT5n0TQ+u4VoOu8wfOwotQk
	uisu3CIR9LJhdk8TlsmJrp03bJSumx+h3JuDEV5DJzcmd3G/RVd7bKh6srZ9oj3wib/anfinmKc
	GlZC31RntdRzo1Ix4z6Y
X-Received: by 2002:a17:907:7f8c:b0:ae0:16e7:3d45 with SMTP id a640c23a62f3a-ae0579520b0mr365711066b.5.1750440043327;
        Fri, 20 Jun 2025 10:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDcRVxZng+oGBUNfoH5ARE40YRyymx8NWH6kz5sovCOec8moiDLjoMXSwpfLU/ALjiRAvAnw==
X-Received: by 2002:a17:907:7f8c:b0:ae0:16e7:3d45 with SMTP id a640c23a62f3a-ae0579520b0mr365708266b.5.1750440042909;
        Fri, 20 Jun 2025 10:20:42 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7f949sm191789566b.34.2025.06.20.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:20:42 -0700 (PDT)
Date: Fri, 20 Jun 2025 17:20:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@redhat.org>
Message-ID: <70fe4209-4a31-4957-a658-727081f8291a@redhat.com>
In-Reply-To: <2606da6a-3a13-4db6-855e-8dcc61c45b45@linuxfoundation.org>
References: <20250613091229.21500-1-gmonaco@redhat.com> <20250613091229.21500-4-gmonaco@redhat.com> <2606da6a-3a13-4db6-855e-8dcc61c45b45@linuxfoundation.org>
Subject: Re: [RESEND PATCH v13 3/3] selftests/rseq: Add test for mm_cid
 compaction
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <70fe4209-4a31-4957-a658-727081f8291a@redhat.com>

2025-06-18T21:04:30Z Shuah Khan <skhan@linuxfoundation.org>:

> On 6/13/25 03:12, Gabriele Monaco wrote:
>> A task in the kernel (task_mm_cid_work) runs somewhat periodically to
>> compact the mm_cid for each process. Add a test to validate that it runs
>> correctly and timely.
>> The test spawns 1 thread pinned to each CPU, then each thread, including
>> the main one, runs in short bursts for some time. During this period, the
>> mm_cids should be spanning all numbers between 0 and nproc.
>> At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
>> is selected to be the new leader, all other threads terminate.
>> After some time, the only running thread should see 0 as mm_cid, if that
>> doesn't happen, the compaction mechanism didn't work and the test fails.
>> The test never fails if only 1 core is available, in which case, we
>> cannot test anything as the only available mm_cid is 0.
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>
> Mathieu,
>
> Let me know if you would like me to take this through my tree.
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for the Ack, just to add some context: the test is flaky without the previous patches, would it still be alright to pull it before them?

Thanks,
Gabriele


