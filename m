Return-Path: <linux-kselftest+bounces-29568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682ECA6C004
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725127A9500
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48322B8CF;
	Fri, 21 Mar 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MZHWkbQV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F71EBA1E
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575001; cv=none; b=mXMJRuD5NFyWwH1wlG1QNsD7MAwolV+3gwfGqqtphuAcOhSW+8S85aP6XGI13HJUV7GR6K6hbaVcb2Xxldgwd3fQvIIOoDThTppV8k7qEoPINP/1uT0SRPQsbJ6TGmgu+MSaBaVpfyeNcd+XbA/boBi3/BY9wY0gIZpzmmG6sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575001; c=relaxed/simple;
	bh=Hjm+6X18HfhpHIGsOF0Wa+HjL7J2VCrd/SOk7TvJe8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfGG/omqY/8nmmpe8FKiKedOYqDDLiR1yEekEZIgHQ1cCgvIhcDqXpuWVfFPusu7DL9GMRRJof9DZIcg5/abosoVfmOgS//baq8pTERZLY7K4oE+H5s5KnQNab9Z9Oj+Gx/6Djg47PvfPCwv36yYIFHzPup5BiG2XgbgKxbAGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MZHWkbQV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso44051955ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742574999; x=1743179799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YALLnLfNqwU57i7wtFxN8i/4pwzBbw+w8xRGUYxzetU=;
        b=MZHWkbQV4x7bg/O4wFFFfRPlZtESaA0v8NXS4bwNrJ6AjgL6ju53tkdph3LJaiNMme
         Uzvt2rfsKBGYwXhkxusFMsVdUZtocME/uedeyElNWYuFM0pXYRhGn+chWuHm1avPkY+e
         bLTWDD3vMSIqEuSER+745abq7dnQ3YJWC0/HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574999; x=1743179799;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YALLnLfNqwU57i7wtFxN8i/4pwzBbw+w8xRGUYxzetU=;
        b=wkDU6Pc1I8lu+gH7Q4UpniuXz+nTQoi4DNHfnzBzZ1oj6/HOuHxuCxRSnClTTyjSDq
         rkJ57Rqtk13ODeh8INBJJbyDBu4uvfPFpGqb0AH4Cw6em13U6Zx5lVC7O/XRVe97hpIn
         MnhX59WbBPzoem6I24txHDJ+6ALvABAYbGr7wnr0QL4MwZwptH6NVFBuH7h2mSjtit0A
         nmTLE5IT7JgxnPBeIneSC7+r/LuleDmwEedNVUTsEo2hDkNCuJqEiBS4beR+DFIi9xcK
         8ZiOuGslVtyArOvM5uIo5ApAcyO9f5aQU0+fB0GWCtN/75MhihZ+SR+KODIxTj0l+Nht
         iL7g==
X-Forwarded-Encrypted: i=1; AJvYcCU2M+z1jg1hrqApebo7jBF7TnpFjHYMhAQsJMPWWy/CwLzP66V4f8FNmgucTxm6kNijqdKSVaRsPtVsq4amOYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXVmBHYJqXB0ayeiUujmLdPcBoOY85r3T010z8Gj/nEFgQtbp
	h4nOuM0dxaq/1XC/WhOB5U5V1P0EroGA94QjnYBgGTN2N9VvLlRnWbvPyd7LB/o=
X-Gm-Gg: ASbGncurwjJEyXdKYNRUgOl8/hHAQIlBQkiqpLUtud8LgZChMy5jdXwtpiL1oZKwmX1
	wQ9QerJQT5r4OlmpqzBhfRPnSOXZjyTCuw4LbLdWjyfFuNkxBl/qy1ahrH4F+m8OysoScUCH6vQ
	wcDTsI8pyOxAIpdQFSYmAVS3XeEK/0cRiCLxkS+y8Hw0qLBkbEg5TvoQu5NlLjhhEhHfuKdzRMB
	MtfTRYU2To9wYq168SEEf7sHXd4ylZxMArD0SYsKpBZmXlibbhfv/VuaaxTmNmNGz7pOUUcC2k9
	fCM2tVZMwJUlw4BXylyRhPgG+4UAnysiyqBHht30JVdehE4W9ZmpYkq/tWd+w1NNNjhkZFUwxC6
	SppAKQERJN9kdMBHk
X-Google-Smtp-Source: AGHT+IHqu8khKPmdrz5ZxNhApg6woYn1wpjz3geiCjpfYxV9ENASu0IFRk3+3jTmUaVHH2l595zxFg==
X-Received: by 2002:a17:903:46d0:b0:224:160d:3f54 with SMTP id d9443c01a7336-22780da858bmr63728105ad.31.1742574998924;
        Fri, 21 Mar 2025 09:36:38 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39772sm19205225ad.25.2025.03.21.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:36:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:36:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>

On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> >> I don't know the entire historical context, but I presume sendmsg
> >> did that because there was no other mechanism at the time.
> > 
> > At least aio had been around for about 15 years at the point, but
> > networking folks tend to be pretty insular and reinvent things.
> 
> Yep...
> 
> >> It seems like Jens suggested that plumbing this through for splice
> >> was a possibility, but sounds like you disagree.
> > 
> > Yes, very strongly.
> 
> And that is very much not what I suggested, fwiw.

Your earlier message said:

  If the answer is "because splice", then it would seem saner to
  plumb up those bits only. Would be much simpler too...

wherein I interpreted "plumb those bits" to mean plumbing the error
queue notifications on TX completions.

My sincere apologies that I misunderstood your prior message and/or
misconstrued what you said -- it was not clear to me what you meant.

It is clear to me now, though, that adding a flag to splice as
previously proposed and extending sendfile based on the SO_ZEROCOPY
sock flag being set are both unacceptable solutions.

If you happen to have a suggestion of some piece of code that I
should read (other than the iouring implementation) to inform how I
might build an RFCv2, I would appreciate the pointer.

Thanks for your time and energy,
Joe

