Return-Path: <linux-kselftest+bounces-23323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179329F1025
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71A7283781
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751461E1C07;
	Fri, 13 Dec 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvr9lYcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECC1E1C09
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102205; cv=none; b=n6VVlZcAVDbEOLPb01FzlYx2P1SOVi+0AQ8a+WCrE+eaPtcq1Mx5ZW7wxt5P2gMJDDfxiBeayMr08kyr7qn6tPJyLyGVrNpADYqT72yPsu/hyOZXWKLpiMliSKd6U4Syp2V+qhC0vp+EZ2rYy0hBzu9O8HVuR0KtxYL2e/oM5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102205; c=relaxed/simple;
	bh=oBcSJQ2t3grJhtRmAoyfmj/BiN/0ePGUbmAHrkcnY0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIFkbOc5QdbDow0LrXiyNyjDcsVkwESFkkFDVCyhGRVk3gomPPcc1j0ousdFnHSWojCVMfClWCKZWRBSUEbU0NxGfnNeF3sbknalgMKz56X/xN7SEuhh9WHe/gcr1pkhYn1XAWr1POwgJaCxNsGeMCQms30yj6zL3MaBD2zwoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cvr9lYcF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oBcSJQ2t3grJhtRmAoyfmj/BiN/0ePGUbmAHrkcnY0k=;
	b=Cvr9lYcFua1VEBfDHdzvLkAIqMeiGkOUCbsaEfVSwoHQ26uHfokpQ3Oz8U6Pk9aJhN/2hS
	DVvxFJ2OW93B4iUWoqch59xquR8wrzyl56m44FdHXIYLnK+jz7gO9E5Z0y5FFfrgvSw2n0
	BywPJV2cD/cFTeUE+px5fGm2jCG+MFI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-N2Z_Cbg_PuCe3d9dpWC5AQ-1; Fri, 13 Dec 2024 10:03:20 -0500
X-MC-Unique: N2Z_Cbg_PuCe3d9dpWC5AQ-1
X-Mimecast-MFC-AGG-ID: N2Z_Cbg_PuCe3d9dpWC5AQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3878ad4bf8cso1213943f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 07:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102199; x=1734706999;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBcSJQ2t3grJhtRmAoyfmj/BiN/0ePGUbmAHrkcnY0k=;
        b=l6hZqWCLtLDa6c9vheZEb3shnXXlkQvKervRIARwxu0y3/wT8IPNC4XLNmQmkhBQwC
         kEjpJaV585NYCcJfMVc1bGWP7Zfss16kSHE1eoJh7RKzwrfQBfzK08gMsQ2Prwa81bKV
         Pk4Ha7tcsqr1YhKbFTXueybxSIAz+h6FbGftvSZIfZacAYNgyZXTprdrkP0hZqq6735r
         E4cZ+HFNOsC8cw9gnrrigCV/+MHsGfXa7uDrPmpeUgzzZLHpFPmUoPjwhMkP87KzpTvl
         u/vBD6LbexjggVQNpiDPdb0QonhwxennAb2smw10ZGkTiKpCne9rCkpLQOIuC5bEAEsw
         tyjw==
X-Forwarded-Encrypted: i=1; AJvYcCXMiNADcU3vAiYVIfv2RlbicfXuIugbKyVk4EAFNTXsGjmSeC/fJCtdfG0Hdf21sVig2vrD1MpchJD3fKajtTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfIZIVh0BUcEi1BtRAzdi9VxQi3K8JebfPYTVgT1kI+1zzFCR7
	g/jLpDNa33aBOKCOM4SqoMq8cKo74WflOruoTqw4htCClh7opJQCFRcEeQ35adjemaO84TRhE9G
	ymxAe81nBvn36kwZu6eKxZmmWDjmTOti5gdPbnmjSqGsjHfZbhExk7TU3GNDCVHX+DQ==
X-Gm-Gg: ASbGncs99lPE7xtWgkLCr3zwpu2tJlU9rGfwpcLsA5zfMnEF8qyCuqv6y122HHfOg8C
	Gb7a7XvT1dvSdaD7w476XE3hfe1Uh/nmxNEQCRrAj5HFMTubODid9R44J6d3W/FOo6OlHzUtDei
	maIywW9N9wUE7ssDeeObWJ4/yRnLJyF+SKdUaJX3FEOOu1rvyPUruZYM0BcrdRzrJA1wqDWRX5K
	lJgR0czolCl7x8RSFqEOF5p2BT1G/230ziYcPJSoZdVxbZUc7HTZSNYCg7MwcWWk54ArF3rzRN4
	meZ1m2U=
X-Received: by 2002:a05:6000:1848:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-3888e0ae4e6mr2179710f8f.24.1734102199436;
        Fri, 13 Dec 2024 07:03:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfmoqcWVGaoAEdxBU9PUF7o693pCscmUutfo3TPGUnwsDrq4ACd1XfMkd86Qb9YrgGD48O2g==
X-Received: by 2002:a05:6000:1848:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-3888e0ae4e6mr2179654f8f.24.1734102198868;
        Fri, 13 Dec 2024 07:03:18 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514beesm7452649f8f.71.2024.12.13.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:03:18 -0800 (PST)
Message-ID: <199437fe21ad5bb47ce81c560fbeb0495b5f9ce3.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	 <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Shuah Khan
	 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Date: Fri, 13 Dec 2024 16:03:15 +0100
In-Reply-To: <d1e64ae2-9a16-44af-afca-a1940f27d4ef@efficios.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
	 <20241213095407.271357-5-gmonaco@redhat.com>
	 <d1e64ae2-9a16-44af-afca-a1940f27d4ef@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Fri, 2024-12-13 at 09:29 -0500, Mathieu Desnoyers wrote:
> On 2024-12-13 04:54, Gabriele Monaco wrote:
> > A task in the kernel (task_mm_cid_work) runs somewhat periodically
> > to
> > compact the mm_cid for each process, this test tries to validate
> > that
> > it runs correctly and timely.
> >=20
> > + /*
> > + * We select one thread with high enough mm_cid to be the new
> > leader
> > + * all other threads (including the main thread) will terminate
> > + * After some time, the mm_cid of the only remaining thread should
> > + * converge to 0, if not, the test fails
> > + */
> > + if (curr_mm_cid > args->num_cpus / 2 &&
>=20
> I think we want=C2=A0 curr_mm_cid >=3D args->num_cpus / 2=C2=A0=C2=A0 her=
e,
> otherwise the case with 2 cpus would not match.

Right, good point.

> > + =C2=A0=C2=A0=C2=A0 !pthread_mutex_trylock(&args->token)) {
> > + printf_verbose("cpu%d has %d and will be the new leader\n",
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_getcpu(), curr_mm_cid);
> > + for (i =3D 0; i < args->num_cpus; i++) {
> > + if (args->tinfo[i] =3D=3D pthread_self())
> > + continue;
> > + ret =3D pthread_join(args->tinfo[i], NULL);
>=20
> We'd want a synchronization point to join the main thread. I'm not
> sure
> if the main thread is joinable.
>=20
> Perhaps we could try calling pthread_self() from the main thread, and
> store that in the main thread struct thread_args, and use it to join
> the main thread afterwards ?
> >=20
> > +void test_mm_cid_compaction(void)
> > +{
> > + for (i =3D 0, j =3D 0; i < CPU_SETSIZE && j < num_threads; i++) {
> > + if (CPU_ISSET(i, &affinity)) {
>=20
> Including the main thread, we end up creating nr_cpus + 1 threads.
> I suspect we want to take the main thread into account here, and
> create
> one less thread.
>=20
> We could use tinfo[0] to store the main thread info.

Good idea, that would get two birds with one stone.
I just forgot to pass it but it seems=C2=A0the main thread is perfectly
joinable (just checked), so that should work fairly easily.

>=20
> > + ret =3D pthread_create(&tinfo[j], NULL, thread_runner,
> > + =C2=A0=C2=A0=C2=A0=C2=A0 &args);
> > + if (ret) {
> > + fprintf(stderr,
> > + "Error: failed to create thread(%d): %s\n",
> > + ret, strerror(ret));
> > + assert(ret =3D=3D 0);
> > + }
> > + CPU_SET(i, &test_affinity);
> > + pthread_setaffinity_np(tinfo[j], sizeof(test_affinity),
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &test_affinity);
>=20
> It would be better that each thread set their own affinity when
> they start rather than having the main thread set each created thread
> affinity while they are already running. Otherwise it's racy and
> timing-dependent.
>=20
> And don't forget to set the main thread's affinity.

Sure, will do!

Thanks for the comments, working on V3.
Gabriele


