Return-Path: <linux-kselftest+bounces-30061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01AA7A3DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AE07A6551
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3B2528E2;
	Thu,  3 Apr 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MS2BBpK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86B2512E6
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687230; cv=none; b=KxVMilfHkd6bCMhdY62f7ga+N3OV7afp2ow3KS4NB1hWS1PHHArAo5IZAHiHeS3Wa3ZAKPz+Rr1a1Jlebwpw8bbLHgUVtkOA1HdxHHVq0Zws08HVpUWy7A4R52l4tLbAmH+3OcuoGISTI45dYmmMw7fdWT2jK+lE69QDRWfZgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687230; c=relaxed/simple;
	bh=lc2kPBAUmFssEFHlFoZTIb5ZMulQItOIPpogF+GOBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjavdH69w/B5evtPs/6lW3ifO/9sUXRGj/R1hzhpvi1YouCyhICyXUzTRthZ/0liioNN1DfhgCFIexfu/UcqwBqzs2Jjbbo80LIGuSRu07YjkxYc0hCGo2nSimLs+bK+cJ/YifKRo72x06oOW9g/KnO+OKFUyh5oXb7eYVwbXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MS2BBpK4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so591811f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743687227; x=1744292027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc2kPBAUmFssEFHlFoZTIb5ZMulQItOIPpogF+GOBDc=;
        b=MS2BBpK4jF96H1cgO9M1r1+ao2T5RFgHwAJnpbz1/0lPyIUTnimEJW13nV4ugNUUIP
         lqcxa+eNdau4Ox+kneB6LMt6+1zpPMDjCTz39pQMflNmtKq0KCy4Y0LpgfPZT8ZH6DqY
         +mHc+XZIPyTMrc51qN6CcvIIyO9q5yCRnMoMMwYGZwwPZNx+aVwxzv8EhqJrXhqEKsYL
         HmKnOCz7tNHdOrd1W9RMDNlaX4XniRyJth8V+k2zJ9MWfGLnTkz8VdfPjJoY3H+LAAOx
         icVm5/Wy/Qt6xX28LmwZscnDFb+WM23EOwDFkvt60AxXY2YlDtTW5FH1zc8TeBZvHorq
         NoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743687227; x=1744292027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc2kPBAUmFssEFHlFoZTIb5ZMulQItOIPpogF+GOBDc=;
        b=otJXsDam5giHtXwZFU90GmttFsIn8Z/dVtZcdCOB8HLoN9lYEuhPWBsDuEiqhIo2Y4
         gnnZyknxujnYRi/oHJh2xH7jQI731Cn+tUqIwS5cuHZADx5N0+iKgsBrM0qGGMOaochs
         KTVqtPIlHfCcir1mo+uWekFT4zIqMbYDbzUJUN+HEYzSsln1Y3OUvX9sApPdJcWedp6m
         R7/sERKsCaT9BrLUxcO05lEeDmMWdO2C4suW0XaM94GqtHv30LfDg3MejHLE4gX7waxm
         V9Kpvh+tVNUVvwbPx7ju8HelfZBhlvEvwNvWnyUtxTTmvObzJGDwLHpPx9mNCovircHb
         4PjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXpcUsZeCVcc1rYIrI9S1ArnvibxdvRAAzfPSqWYAeYYqD1Os4TGOtc1Ns9ZDA5Tt8i+7dy9b2ClCHJnLiqHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkl8vlXn1OFDf7CmF34Dfp6uZBXDblhuuYlmLB0+9d3/EiyA1
	qosC66eNTCZ0xQ+4TumX5uvn/TTkNIpRM419enFq8zKua1UAJt1RvA/VBFIgzhJ/BQCBrxHySlA
	g
X-Gm-Gg: ASbGncscbgZUuhNQXrbNFFVljal/Bf69EsLzuTscWv/1+QWeGWZa1s5THLxJPAHc3e4
	kdKMJKKxxKLWgOrvGjHNq7VOeR3jEOow/3WTMYbbqIKm4/1rwLxJdB3ZWyc108jCqdjup+MFA6R
	3up72vJKdqu1TwALwVecmYo+dnNOCcsKO6ICUob2xcc+A/7Sa6VVnHGmiKwVW2L3ukQWu4YxoOu
	LoiMWR32u5lC+bi8cHN3FR3ScSf3L17bLZaPD0tiA57E5fMqiHMwhN9IVkKWJN6yXpnNf85g9Yc
	U1hqPi7qYmhvlw4gwZN6iiegJxh5LWlvR5Y6TucOnneYCtk=
X-Google-Smtp-Source: AGHT+IGPQ6nwxEwKgFP3ExKTxhy07cHsFvtpQAvnmiKOVMha0c8lkk/HwjAtM+b4ugng/LTLNl3c5A==
X-Received: by 2002:a5d:64e8:0:b0:39c:d05:37d3 with SMTP id ffacd0b85a97d-39c29769556mr6233270f8f.34.1743687226677;
        Thu, 03 Apr 2025 06:33:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226959sm1768861f8f.82.2025.04.03.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:33:46 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:33:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local
 partition over a remote one
Message-ID: <c5akoqcuatispflklzykfwjn65zk7y22pq6q6ejseo35dw5nh2@yvm7pbhh5bi4>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-6-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjejnus3mirkel3g"
Content-Disposition: inline
In-Reply-To: <20250330215248.3620801-6-longman@redhat.com>


--pjejnus3mirkel3g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local
 partition over a remote one
MIME-Version: 1.0

On Sun, Mar 30, 2025 at 05:52:43PM -0400, Waiman Long <longman@redhat.com> wrote:
> Currently, we don't allow the creation of a remote partition underneath
> another local or remote partition. However, it is currently possible to
> create a new local partition with an existing remote partition underneath
> it if top_cpuset is the parent. However, the current cpuset code does
> not set the effective exclusive CPUs correctly to account for those
> that are taken by the remote partition.

That sounds like
Fixes: 181c8e091aae1 ("cgroup/cpuset: Introduce remote partition")

(but it's merge, so next time :-)

Michal

--pjejnus3mirkel3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+6ONgAKCRAt3Wney77B
SU6VAP4ynbl5wnoim3pRoEDFYW9TwsFFO1oqvsJdRQbrLPKb/QEAsizzl8zjyzkV
3IT57x5+x3Tpe2KO9CLsl/Pj29WW2Ac=
=P059
-----END PGP SIGNATURE-----

--pjejnus3mirkel3g--

