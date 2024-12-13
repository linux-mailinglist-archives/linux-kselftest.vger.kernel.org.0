Return-Path: <linux-kselftest+bounces-23314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295409F0B21
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2A21664E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FB1DE899;
	Fri, 13 Dec 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnn4lL0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FB1AC8B9
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089506; cv=none; b=K4mjYr6fdil9RSPXpro7IukJGpR1yDb4/TA5vu90cVwjwPrws/4Pqlzbv9gf59znnCMCH00Pw6fz3gZ5+URb0ZxK/VJGjbYppO9cJQvmWusOIW7ANYxgup1H2EeiZKtCjePUmsr/uYjZozDOIjZYeVKm8AHB3kUR4WV+1/C9WZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089506; c=relaxed/simple;
	bh=a7m4bFXrXJLnDmxxGYmlQ6gOMwQRAw150r5fPTyWsY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbaPZ5hUIhOlY37e36aZhd7XNnpCX2iTiOX6JE0DZG1/Oldywr7Bj1jvHdwfFUb9ZCPpyf9QHaKUxpNyQiGPsfDCraTBQzRlIdszM3JsKYHka197YvlSZGiPh5HeXtDLFZOPPIEwE+5SXhv6mvJZyMmiiRkNbNxDFkmDV0n2U0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnn4lL0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734089503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LA1MdNqnVl2M5tE7C+xYNHhC6zMqlfDAUaHlPhnPTw=;
	b=gnn4lL0E9g82mrCClPDPZfoPdvGQ3GO89wxzvL0Udnii15wcATkoh9Aduudx3+Tf5pc2W7
	1K8kGcmNTKYvn+428e68volYI7GB9Wh12tpDre/pSo9hXSac87e0ZSStAbHQJy3u1xZIOY
	QUWq8C2ajCeWsWdg+nD7rdK4Yk3hm2s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-HrB0qHdHMhCewBDas6hQuw-1; Fri, 13 Dec 2024 06:31:39 -0500
X-MC-Unique: HrB0qHdHMhCewBDas6hQuw-1
X-Mimecast-MFC-AGG-ID: HrB0qHdHMhCewBDas6hQuw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3862f3ccf4fso600355f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 03:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089498; x=1734694298;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LA1MdNqnVl2M5tE7C+xYNHhC6zMqlfDAUaHlPhnPTw=;
        b=wAdZmbEa/XAfuMdpOLquOCMSQlNIPp8HeTW3+igLgR8yXuCN5qPXR+SkjiPfz0wu/I
         tvpe/pXyUh5A0KeQkBJBCCwczxSi2mIUKHyFwUhvH/C4zKMJQZYjPdfd7Aw1BIupuFAO
         nRCe8oWcL7D0lLlTmi4BbErBVzPuOf9rLtC9KMtwuKTeJY8US1Aimt+Fa3BBuQPJG4K2
         ZKx8fR4fNlGqST1WDDpYuYY1YNUQ81fVqfxgkbvfE1cmy1NTZH4K9bDxrTi7oxG1NevQ
         0PMojKG+NOH9vLvWugMzOGzT+PNor7Aj0/VFXesXSdRfIr4p0CxzbXp8VIKin/oNHyie
         5g4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOhCzNVpoVegYmc69vYAcjDOjm8Dw/8KF/lvqLr9MUumZl1lY/s1kQSM2PIchXm4b13xKHrxPiBOeDtf0ZKOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4Oh9aL46WONppkEdgWakCqEXQBBoNYGpQONBVsl82TTezR3+
	nqC1DB4cwDu+Va9xEeZJ9nMf3VIPYcw3aDKm0faYi1dOyCpgqVozEIGKpo40T8U8HbkFLoSCaoh
	eBjtZCDtdFxO1+iw/eLPuUZMRPBiOkysnJhKbdm1kpQaLfg9/8cpyNo3n+/suLoAraamtNvsipg
	rW
X-Gm-Gg: ASbGncs1Jv8KXYuU1NVFcop5ZwX53Ejna9GAr1ysGn6kzyQGVANZ82EbTgE0UJnwz0t
	zveDJPPyMztSoQ5gLo0Q5mDkyK15i8tDHqr0p0xTmS0FdAE2m8mwaiu5f6jcqp8Sldp/f9IHzhC
	/it0rDCI7VD7Dy/vBR6+gZrzRiInhhFAWChpRKwEINvHvy6QZSCm8ETwletWtBhirJiSqhvfZMt
	nkrw1jVwzwsqk13orHzNPZOWJ5lDUMH+3BPtK4xTbV2m3zfhH5SPZWrqkxt2K3B3qzM8f00iJNn
	Tx6JkPM=
X-Received: by 2002:a5d:6d03:0:b0:385:dc45:ea26 with SMTP id ffacd0b85a97d-38880ac244fmr1622423f8f.12.1734089498116;
        Fri, 13 Dec 2024 03:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgMs36iw2eBDK+bKYO9UpdsQZJbbyABbG+SohxQ7EUMAPumZJ5gVhyrbA84M6jrczW1CkjBg==
X-Received: by 2002:a5d:6d03:0:b0:385:dc45:ea26 with SMTP id ffacd0b85a97d-38880ac244fmr1622388f8f.12.1734089497692;
        Fri, 13 Dec 2024 03:31:37 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782521845sm6781912f8f.106.2024.12.13.03.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:31:37 -0800 (PST)
Message-ID: <7cf8c25f325d433c2abc473f3d877067e216ff6c.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Shuah Khan
	 <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Date: Fri, 13 Dec 2024 12:31:35 +0100
In-Reply-To: <20241213095407.271357-1-gmonaco@redhat.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: multipart/mixed; boundary="=-8FZMQ6942QnxILGUQGmB"
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-8FZMQ6942QnxILGUQGmB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-13 at 10:54 +0100, Gabriele Monaco wrote:
> OVERHEAD COMPARISON
>
> [..]
>
> I will post another email with the scripts used to retrieve the data
> and
> more details about the runtime distribution.

This message contains the performance results produced by my scripts, which=
 are attached.
The tracing is done via bpftrace while a simple bash script is spawning and=
 killing the loads.

From the histograms it's easier to see the distribution of the durations an=
d if there are clear outliers.

TEST RESULTS ON HEAD

Running without loads on virtme-ng

@duration_max: 426
@duration_total: count 13, average 75, total 987

@durations:
[25, 30)               1 |@@@@@@@@@@@@@@@@@                                =
   |
[30, 35)               2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
   |
[35, 40)               2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
   |
[40, 45)               0 |                                                 =
   |
[45, 50)               3 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[50, 55)               2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
   |
[55, 60)               0 |                                                 =
   |
[60, 65)               1 |@@@@@@@@@@@@@@@@@                                =
   |
[65, 70)               0 |                                                 =
   |
[70, 75)               0 |                                                 =
   |
[75, 80)               0 |                                                 =
   |
[80, 85)               0 |                                                 =
   |
[85, 90)               0 |                                                 =
   |
[90, 95)               1 |@@@@@@@@@@@@@@@@@                                =
   |
[95, 100)              0 |                                                 =
   |
[100, ...)             1 |@@@@@@@@@@@@@@@@@                                =
   |

@processes: 12
@threads: 12

Running with cpu loads on virtme-ng

@duration_max: 2508
@duration_total: count 35948, average 20, total 742603

@durations:
[10, 15)            1889 |@@@@@                                            =
   |
[15, 20)           17278 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[20, 25)           10742 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                 =
   |
[25, 30)            3327 |@@@@@@@@@@                                       =
   |
[30, 35)            2350 |@@@@@@@                                          =
   |
[35, 40)             326 |                                                 =
   |
[40, 45)               5 |                                                 =
   |
[45, 50)               1 |                                                 =
   |
[50, 55)               2 |                                                 =
   |
[55, 60)               1 |                                                 =
   |
[60, 65)               2 |                                                 =
   |
[65, 70)               2 |                                                 =
   |
[70, 75)               0 |                                                 =
   |
[75, 80)               0 |                                                 =
   |
[80, 85)               1 |                                                 =
   |
[85, 90)               0 |                                                 =
   |
[90, 95)               1 |                                                 =
   |
[95, 100)              1 |                                                 =
   |
[100, ...)            20 |                                                 =
   |

@processes: 129
@threads: 129

Running with fork loads on virtme-ng

@duration_max: 41
@duration_total: count 21, average 34, total 720

@durations:
[30, 35)              12 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[35, 40)               8 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
   |
[40, 45)               1 |@@@@                                             =
   |

@processes: 3592
@threads: 3592

Running with thread loads on virtme-ng

@duration_max: 195
@duration_total: count 1286, average 31, total 41082

@durations:
(..., 10)            326 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     =
   |
[10, 15)              10 |@                                                =
   |
[15, 20)               0 |                                                 =
   |
[20, 25)               1 |                                                 =
   |
[25, 30)              61 |@@@@@@@@                                         =
   |
[30, 35)             377 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[35, 40)             264 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             =
   |
[40, 45)              65 |@@@@@@@@                                         =
   |
[45, 50)              32 |@@@@                                             =
   |
[50, 55)              12 |@                                                =
   |
[55, 60)              13 |@                                                =
   |
[60, 65)               7 |                                                 =
   |
[65, 70)              10 |@                                                =
   |
[70, 75)              10 |@                                                =
   |
[75, 80)              33 |@@@@                                             =
   |
[80, 85)              26 |@@@                                              =
   |
[85, 90)              13 |@                                                =
   |
[90, 95)               6 |                                                 =
   |
[95, 100)              2 |                                                 =
   |
[100, ...)            18 |@@                                               =
   |

@processes: 129
@threads: 4096

TEST RESULTS ON PATCH

Running without loads on virtme-ng

@duration_max: 42
@duration_total: count 20601, average 2, total 45496

@durations:
(..., 10)          20304 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[10, 15)               1 |                                                 =
   |
[15, 20)               4 |                                                 =
   |
[20, 25)              29 |                                                 =
   |
[25, 30)              33 |                                                 =
   |
[30, 35)              11 |                                                 =
   |
[35, 40)             156 |                                                 =
   |
[40, 45)              63 |                                                 =
   |

@processes: 12
@threads: 12

Running with cpu loads on virtme-ng

@duration_max: 774
@duration_total: count 38612, average 7, total 281558

@durations:
(..., 10)          34607 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[10, 15)            2558 |@@@                                              =
   |
[15, 20)             735 |@                                                =
   |
[20, 25)             454 |                                                 =
   |
[25, 30)             225 |                                                 =
   |
[30, 35)              17 |                                                 =
   |
[35, 40)               8 |                                                 =
   |
[40, 45)               2 |                                                 =
   |
[45, 50)               4 |                                                 =
   |
[50, 55)               0 |                                                 =
   |
[55, 60)               0 |                                                 =
   |
[60, 65)               0 |                                                 =
   |
[65, 70)               0 |                                                 =
   |
[70, 75)               0 |                                                 =
   |
[75, 80)               0 |                                                 =
   |
[80, 85)               0 |                                                 =
   |
[85, 90)               0 |                                                 =
   |
[90, 95)               0 |                                                 =
   |
[95, 100)              0 |                                                 =
   |
[100, ...)             2 |                                                 =
   |

@processes: 129
@threads: 129

Running with fork loads on virtme-ng

@duration_max: 457
@duration_total: count 45683, average 19, total 878511

@durations:
(..., 10)           8452 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
   |
[10, 15)            7287 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                    =
   |
[15, 20)           12727 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[20, 25)            2942 |@@@@@@@@@@@@                                     =
   |
[25, 30)            2975 |@@@@@@@@@@@@                                     =
   |
[30, 35)            7305 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                    =
   |
[35, 40)            2994 |@@@@@@@@@@@@                                     =
   |
[40, 45)             676 |@@                                               =
   |
[45, 50)             180 |                                                 =
   |
[50, 55)              57 |                                                 =
   |
[55, 60)              19 |                                                 =
   |
[60, 65)               6 |                                                 =
   |
[65, 70)               4 |                                                 =
   |
[70, 75)               2 |                                                 =
   |
[75, 80)               5 |                                                 =
   |
[80, 85)               6 |                                                 =
   |
[85, 90)               4 |                                                 =
   |
[90, 95)               5 |                                                 =
   |
[95, 100)              2 |                                                 =
   |
[100, ...)            34 |                                                 =
   |

@processes: 3982
@threads: 3982

Running with thread loads on virtme-ng

@duration_max: 1046
@duration_total: count 38643, average 21, total 833034

@durations:
(..., 10)           1631 |@@@@@                                            =
   |
[10, 15)           11027 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           =
   |
[15, 20)           14832 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[20, 25)            1338 |@@@@                                             =
   |
[25, 30)            1112 |@@@                                              =
   |
[30, 35)            3781 |@@@@@@@@@@@@@                                    =
   |
[35, 40)            1994 |@@@@@@                                           =
   |
[40, 45)             464 |@                                                =
   |
[45, 50)             262 |                                                 =
   |
[50, 55)             200 |                                                 =
   |
[55, 60)             294 |@                                                =
   |
[60, 65)             620 |@@                                               =
   |
[65, 70)             256 |                                                 =
   |
[70, 75)             119 |                                                 =
   |
[75, 80)             232 |                                                 =
   |
[80, 85)             220 |                                                 =
   |
[85, 90)              55 |                                                 =
   |
[90, 95)              30 |                                                 =
   |
[95, 100)             19 |                                                 =
   |
[100, ...)           157 |                                                 =
   |

@processes: 129
@threads: 4096


--=20
  Gabriele Monaco=20
 Senior Software Engineer - Kernel Real Time=20
=20
Red Hat=20
  gmonaco@redhat.com=C2=A0 =C2=A0=20


--=-8FZMQ6942QnxILGUQGmB
Content-Disposition: attachment; filename="func_benchmark.bt"
Content-Type: text/plain; name="func_benchmark.bt"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgYnBmdHJhY2UKLyoqCiAqIFByaW50IGR1cmF0aW9ucyBhbmQgaW52b2Nh
dGlvbnMKICogQ2FsbCB0aGlzIHNjcmlwdCB3aXRoIHRoZSBkdXJhdGlvbiBpbiBzZWNvbmRzIGFz
IGFyZ3VtZW50CiAqIGUuZy4gYnBmdHJhY2UgZnVuY19iZW5jaG1hcmsuYnQgMzAKICovCgovL3Ry
YWNlcG9pbnQ6c2NoZWQ6c2NoZWRfd2FrZXVwCmZlbnRyeTp0cnlfdG9fd2FrZV91cAp7CiAgaWYo
YXJncy0+cC0+bW0gIT0gMCkgewogICAgQF9tbXNbYXJncy0+cC0+bW1dID0gdHJ1ZTsKICAgIEBf
cHJvY2Vzc2VzW2FyZ3MtPnAtPnRnaWRdID0gdHJ1ZTsKICAgIEBfdGhyZWFkc1thcmdzLT5wLT5w
aWRdID0gdHJ1ZTsKICB9Cn0KCmZlbnRyeTp0YXNrX21tX2NpZF93b3JrCnsKICBAc3RhcnRbdGlk
XSA9IG5zZWNzOwogIEBwcmVlbXB0aW9uc1t0aWRdID0gKHVpbnQ2NCkwOwp9CgpmZXhpdDp0YXNr
X21tX2NpZF93b3JrCi9Ac3RhcnRbdGlkXS8KewogICRjdXJyX3ByZWVtcHRpb24gPSBAcHJlZW1w
dGVkW3RpZF0gPyBAcHJlZW1wdGlvbnNbdGlkXSA6IDA7CiAgJGR1cmF0aW9uID0gKG5zZWNzIC0g
QHN0YXJ0W3RpZF0gLSAkY3Vycl9wcmVlbXB0aW9uKS8xMDAwOwogIEBkdXJhdGlvbnMgPSBsaGlz
dCgkZHVyYXRpb24sIDEwLCAxMDAsIDUpOwogIEBkdXJhdGlvbl90b3RhbCA9IHN0YXRzKCRkdXJh
dGlvbik7CiAgQGR1cmF0aW9uX21heCA9IG1heCgkZHVyYXRpb24pOwogIGRlbGV0ZShAc3RhcnRb
dGlkXSk7CiAgZGVsZXRlKEBwcmVlbXB0aW9uc1t0aWRdKTsKICBkZWxldGUoQHByZWVtcHRlZFt0
aWRdKTsKfQoKLyogU3VwcG9ydCBvbmx5IG9uZSBwcmVlbXB0aW9uLCBzaG91bGQgYmUgZmluZSBm
b3Igbm9uLXNsZWVwaW5nIGZ1bmN0aW9ucyAqLwp0cmFjZXBvaW50OnNjaGVkOnNjaGVkX3N3aXRj
aAovLyAvQHN0YXJ0W2FyZ3MucHJldl9waWRdIHx8IEBzdGFydFthcmdzLm5leHRfcGlkXS8Kewog
IGlmIChAc3RhcnRbYXJncy5wcmV2X3BpZF0pIHsKICAgIEBwcmVlbXB0ZWRbYXJncy5wcmV2X3Bp
ZF0gPSB0cnVlOwogICAgQHByZWVtcHRpb25zW2FyZ3MucHJldl9waWRdID0gbnNlY3M7CiAgfQog
IGlmIChAc3RhcnRbYXJncy5uZXh0X3BpZF0gJiYgQHByZWVtcHRlZFthcmdzLm5leHRfcGlkXSkg
ewogICAgQHByZWVtcHRpb25zW2FyZ3MubmV4dF9waWRdID0gbnNlY3MgLSBAcHJlZW1wdGlvbnNb
YXJncy5uZXh0X3BpZF07CiAgfQp9CgovL2ludGVydmFsOnM6MzAKaW50ZXJ2YWw6czokMQp7CiAg
ZXhpdCgpOwp9CgpFTkQKewogIEBtbXMgPSBsZW4oQF9tbXMpOwogIEBwcm9jZXNzZXMgPSBsZW4o
QF9wcm9jZXNzZXMpOwogIEB0aHJlYWRzID0gbGVuKEBfdGhyZWFkcyk7CiAgY2xlYXIoQF9tbXMp
OwogIGNsZWFyKEBfcHJvY2Vzc2VzKTsKICBjbGVhcihAX3RocmVhZHMpOwogIGNsZWFyKEBzdGFy
dCk7CiAgY2xlYXIoQHByZWVtcHRpb25zKTsKICBjbGVhcihAcHJlZW1wdGVkKTsKfQo=



--=-8FZMQ6942QnxILGUQGmB
Content-Type: application/x-shellscript; name="runtest_mm_cid.sh"
Content-Disposition: attachment; filename="runtest_mm_cid.sh"
Content-Transfer-Encoding: base64

bnByb2M9JChucHJvYykKZHVyYXRpb249MzAKCmVjaG8gUnVubmluZyB3aXRob3V0IGxvYWRzIG9u
ICRIT1NUTkFNRQpicGZ0cmFjZSBmdW5jX2JlbmNobWFyay5idCAiJGR1cmF0aW9uIgpzbGVlcCAi
JGR1cmF0aW9uIgoKZWNobyBSdW5uaW5nIHdpdGggY3B1IGxvYWRzIG9uICRIT1NUTkFNRQpzdHJl
c3MtbmcgLS1jcHUgIiRucHJvYyIgLS1jcHUtbG9hZCA4MCAmPiAvZGV2L251bGwgJgpicGZ0cmFj
ZSBmdW5jX2JlbmNobWFyay5idCAiJGR1cmF0aW9uIgpwa2lsbCBzdHJlc3MtbmcKc2xlZXAgIiRk
dXJhdGlvbiIKCmVjaG8gUnVubmluZyB3aXRoIGZvcmsgbG9hZHMgb24gJEhPU1ROQU1FCnN0cmVz
cy1uZyAtLWZvcmsgIiRucHJvYyIgJj4gL2Rldi9udWxsICYKYnBmdHJhY2UgZnVuY19iZW5jaG1h
cmsuYnQgIiRkdXJhdGlvbiIKcGtpbGwgc3RyZXNzLW5nCnNsZWVwICIkZHVyYXRpb24iCgplY2hv
IFJ1bm5pbmcgd2l0aCB0aHJlYWQgbG9hZHMgb24gJEhPU1ROQU1FCnN0cmVzcy1uZyAtLXB0aHJl
YWQgIiRucHJvYyIgLS1wdGhyZWFkLW1heCA0ICY+IC9kZXYvbnVsbCAmCmJwZnRyYWNlIGZ1bmNf
YmVuY2htYXJrLmJ0ICIkZHVyYXRpb24iCnBraWxsIHN0cmVzcy1uZwo=


--=-8FZMQ6942QnxILGUQGmB--


