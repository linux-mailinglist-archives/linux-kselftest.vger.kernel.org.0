Return-Path: <linux-kselftest+bounces-26954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC17A3BBA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 11:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAE3B2241
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF21DE4C6;
	Wed, 19 Feb 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2exDrwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34BD1DE3B1
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960945; cv=none; b=KROsQr51zHq1pWYGpNu3j/H4ijZwGLxvl6gKU7j56Nqf5JeZhdZp1WtuReDfiYpnBA5nOIYu7Zj6o/lWMBt5/d6untLLrt0m0clQsHRZNae7n9Ba1+zjkvBiyLsfNiJwqXm7LB9+KQDqO0oJZSfkvT2fl/MOAhmn7+SSMssYwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960945; c=relaxed/simple;
	bh=KmZ5ajCGsmMtxPtx6lFWMFy5vKtZAWai7zkdN2IydG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pbz4V6kYe7fJK85wRttcMajZdRs/VxQi2Ufqk7+EVkJ4nixlHLbP98/+qtaax2Ie5O4Wrr9GQlWfAiDRpPk67kAsbH1uyWebaDCmrlyBy9+vMuHoFATsZyz08NDfhi8cw/3tMXaNXPi22zDDj+0D9jpU/G93zFox6QCyDJlNa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2exDrwG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739960942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KmZ5ajCGsmMtxPtx6lFWMFy5vKtZAWai7zkdN2IydG0=;
	b=J2exDrwGkQ3wV+emfm7/T0qA++dPNdRlfVAKILmUmFT578k2XBxpMk3xHRPi4KDsE8NeMF
	srqVSZkD2xZgYTztj2UMvL2XMYj2tCaroCo7vqVwFEw9MEJ5NbIptRUHTZskWnoU9kjBJK
	mbEJUNg/Q2rNo6Df40wUfZJsB0OOUpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-CHjHazR-N0qMJ5OwCMak_w-1; Wed, 19 Feb 2025 05:29:01 -0500
X-MC-Unique: CHjHazR-N0qMJ5OwCMak_w-1
X-Mimecast-MFC-AGG-ID: CHjHazR-N0qMJ5OwCMak_w_1739960940
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f27acb979so5059542f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 02:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739960940; x=1740565740;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmZ5ajCGsmMtxPtx6lFWMFy5vKtZAWai7zkdN2IydG0=;
        b=CEdT8lQB+MnAj4WMW8HEUq8t1pZrb/+YOtbQmJbuZYPgxFNZQNbK8fs1o9dcImWZIA
         CgygsjLQm9cE+QlGkgLWfZQYlSNTZdIDqTcC+3DQw8hn2TsuF17HWnkp9Nt1xkHSeNdL
         Yvoo+085sGxLBhyZkzVT0SpV5vEfc/15QUTb8jheJSC52qBK7zBmA9RcsEGUycDKpswq
         mmf0e7o4zKVsqaMluLkPLlEjKQQ7PJ/faZExfPa8gUOJimgECysPdRjwjDMJ9S8Jbt66
         /VJxz3NilIElp+wrCaDxJJ5BiimIMWdHFUneSUUk28QyVPrNAn4qpek5JFNs4tv8BCjX
         l3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW8yY4Bl/9r980/RLsrDXFe4vV5gWSOmHVfjuBsIiyakFuJ0a//BRKyPYvviquRt1MJtp3MT7KZgCR4/yIrG20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiUvqpNuDqqt6sOhzFvRukdDkxlC47awk6HKMHGPw0AHwnlmY
	zgRVCpjVcTfP8N+bKsWexIdGe2mirRuqumX7zvkq4OzaXQUw5ooMDtz4s77IIVURqPPwd8oYTwf
	q/iOmVCqbLQyw4upTGaMpxFpnc+xusi2YOwDfsVheEDkehY8Adus6sAaeh1h1FJnvgQ==
X-Gm-Gg: ASbGncssiYssj2RC1vAmjq0eeWQ0+1QdY05yi2YWR5tJ0sHqYfhZO2M0YtbtswJSlz4
	pwhpePGCQXuojJkLKzebX6pB3v/pCuLdsNowvOlnXTbutgpTiO1PQpACDa79xgWrz4VfXXGgneM
	6QCGmEsvLd4btyLsa+GuCenQB+3Q4KVxtxwhpQbu/6sPWMfH0vmQdC29Xwk3Gx+6L9zJgYwJS5Y
	P9ghjVjwlk0ug0MwTO2OLHnk2oacSw4Ql/z7INUCWG3DoXl1v4ANjyeZtsTCTuu+L9AQyYR9TvT
	VRob/A9Jgh/7+1UBeY7YKvaVr5zpv5E=
X-Received: by 2002:a5d:4d85:0:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-38f340677a9mr11940530f8f.42.1739960940038;
        Wed, 19 Feb 2025 02:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX4l3XnwGj5iI5iIwJhLUZxaYwE8XwogtZmAZmicFid0uvz2Ao/SLPmwQ87+MadnmNKiUjMQ==
X-Received: by 2002:a5d:4d85:0:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-38f340677a9mr11940517f8f.42.1739960939726;
        Wed, 19 Feb 2025 02:28:59 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm17665396f8f.39.2025.02.19.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:28:59 -0800 (PST)
Message-ID: <e74f656e58c1c0a113de87b745a13aeae7370f6f.camel@redhat.com>
Subject: Re: [PATCH v5 3/3] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
	 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar
	 <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Wed, 19 Feb 2025 11:28:57 +0100
In-Reply-To: <60671af0-204d-413e-9b65-00b526764ab9@linuxfoundation.org>
References: <20250210075703.79125-1-gmonaco@redhat.com>
	 <20250210075703.79125-4-gmonaco@redhat.com>
	 <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
	 <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
	 <60671af0-204d-413e-9b65-00b526764ab9@linuxfoundation.org>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 16:45 -0700, Shuah Khan wrote:
>=20
> Please send v6 with the suggested changes. Also change the commit
> summary to
>=20
> "selftests/rseq"

Sure, will do. There was actually a V6 already, so I'm sending a V7.

In the meanwhile there was a discussion about the approach. I'm going
to send as V7 what is closer to the approach in V6.
I opened another series for the other approach (scan in batches), which
we may continue depending on the review of V7.

The test should be mostly independent on the approach though.

Thanks,
Gabriele


