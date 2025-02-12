Return-Path: <linux-kselftest+bounces-26478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831FA32CEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A33188CCFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C22580EC;
	Wed, 12 Feb 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hafMovTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAC2580D9;
	Wed, 12 Feb 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379885; cv=none; b=VBckoaSQZgGddGbRdzndS+K+4bwxWme2Seo5OPXxpqwRiI24DgiUeY1YPJdNPxXKsUwhmpaCfgLeJKs8VUIqk/r8hOLNLXtHhOuEoNMH30U9qYQ+FQP3ng8VTKlwWYrOSYOYBumZR2yTxIbM7pNyAiavs0hJcFELWu/LmL/nJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379885; c=relaxed/simple;
	bh=Bfidi7anesqYs999M9Ik6ywb85mPeR+VxYEwuDAAFOU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1lmKtz/lGq0lJMUulqXCYcvnIvtXnhWqgCwV7cgFnOkLDn0laal988Vv+QzoEuNebFHWWFG7PYPGYAGO3kZbyu8JHgOkGsM59BFfG/PueEA0mK9bQEZvKUNI5YIcc2WTIbsspGuPUST0mDOfxkVa8jOFd+1HrJl5bTbb3vq4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hafMovTN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso47187005e9.1;
        Wed, 12 Feb 2025 09:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739379882; x=1739984682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7x9dWz5+kt+yK4VtjE7r4PpL/wI+I4YOt5i78vMh+Y=;
        b=hafMovTNwM6qiexAvRxMY6gjD6fSWxxxnj+6c5Do/tj5+CGqV0WvEv+Nag5S1PG3cx
         N3qESwMa/XSgQXEpG9+vvqbSjh4oqvCO6kbHdJMJCr6HU5yduPLmYkoS9TZJD2Ss4Sgz
         dhZ82TstaGvhry+MS9J+A+v4CnMjKFQB0Q+x9/AJ5hTKGVVaN4d6xJbpUetVLM+aYs2a
         Id2N2MmqT6ysdE64ucSMhZj2jTVLnFVwYd4wxhlUP1rRZPmDhN9Ia+VNG3RUQfBV4rdI
         NHbnPajouiQRhm6xm5EdepNfaWaJvrXbgi1+hxqHgZ74rfi0I36XRsxcfHzjqbrHBtGl
         O/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379882; x=1739984682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7x9dWz5+kt+yK4VtjE7r4PpL/wI+I4YOt5i78vMh+Y=;
        b=Ssc6G543a1Hx0MZYKQ268Tje1uOlvnOihBn/rsNj6FO2Kd1Zcp/XBF2aF9pwUrmtU4
         bCdVIdujJIAMcWVP7FNP1CNdIxufyn7JKHg59cUPTM1QzjlRZLiR5ocAU/2OvpQ9gCJq
         TRZKd+/1NW2fGndBICQYIH0wkQFfK8Uw9Nl0p/qzeACj+YWaawLKRdAXu4s+RGq/y9pW
         vzdQHUdLCoFJhKAPiPRbhvcLxEICT9htDOLkohlNJOmvtCnp05j2UjuCxmVCdgrQ4Bxj
         t0q6gKseYwoWpPiI42fIIoC3HrZAmRg+cEJqVbFk24jBwyrhzfm6EbfGBmWic6VtKtSf
         1KaA==
X-Forwarded-Encrypted: i=1; AJvYcCU6UVZVDWkTckMRofvjL5VoGjLlTDCFDSGu/7oPzL2y5gZZGvnNS+arQ5/k7uMvcK1v8zST4zyeg1cx602Q@vger.kernel.org, AJvYcCW+jsk9xUNtsoomrDbKVwau0d7z98uu23qcwozFp0aCt5RH2lJskAc3X/i3q+/5pjnQPc+B0Xq3noKrksryDjHO@vger.kernel.org, AJvYcCX+eoT57ikk2gKU5OkJxBKsdLCL2BffpjEjT4sYzGcrEKJmhXt9Sf94x5PvNZ/AUjzJBsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBqhPnrKgF6+qaRRpXjPDia3hqzw0xiYrEutSXZ3q7a9NwzgV
	ZJB++O5/j3mQtjvhcru/DTpncDpRLE6ZByiUAy7rXLPkiTtH3l7n
X-Gm-Gg: ASbGnct3wma8AD6jKDQUf6v48I27d2QGpXhesz9fNrchJugEHWPJ6ppG1R/1vXmBu8Y
	ILxcMj58ePZbp/9iqBOPVjDaWATlbhdssDGqQr18S4323IiCBdnpdtzm42GUjO+WNlsF2VWlmki
	xgAucshC1IZu86jbVjbz7oY7IJz3W/4nDU8i2/aejSKHabl0LCgAV4qD+3Ap7SupKVBtR6oIM7m
	R1YdRjy52Qf0TqPldh8Wg1bFJJV8+bGIvXMbpm7y96Q0IcvGUH3THz0Vdur5RSP+SthtWP8jvpF
	vsHXKHiESadzXxxMEJSRjfjcm9PAuEw=
X-Google-Smtp-Source: AGHT+IFDrW6X+85TE5d3qfk8XGG1Z1AhG0IbM9mne5W129Zyv1eca0C1OKyE5SjomlKof7boeX4iEQ==
X-Received: by 2002:a05:600c:6046:b0:439:5a7e:5c5e with SMTP id 5b1f17b1804b1-4395a7e5f79mr27622725e9.26.1739379881461;
        Wed, 12 Feb 2025 09:04:41 -0800 (PST)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd2750829sm12883804f8f.7.2025.02.12.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 12 Feb 2025 18:04:38 +0100
To: Yan Zhai <yan@cloudflare.com>
Cc: Brian Vazquez <brianvv@google.com>, Jiri Olsa <olsajiri@gmail.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
	Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <Z6zUpt5Y4I1p0A3n@krava>
References: <cover.1739171594.git.yan@cloudflare.com>
 <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
 <Z6nEsGSbWqCSaVp3@krava>
 <CAMzD94QZQjpwOA8Os3khG32d2zgH8i=Sy1VoudRCGqZudyHkag@mail.gmail.com>
 <CAO3-Pbqa_oOm-u318mTwqPfuRJ2_kdk+ou99BOu53A3O_wEyZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-Pbqa_oOm-u318mTwqPfuRJ2_kdk+ou99BOu53A3O_wEyZg@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:21:38AM -0600, Yan Zhai wrote:
> Hi Brian, Jiri
> 
> thanks for the comments.
> 
> On Mon, Feb 10, 2025 at 8:47 AM Brian Vazquez <brianvv@google.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 4:19 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Sun, Feb 09, 2025 at 11:22:35PM -0800, Yan Zhai wrote:
> > > > The generic_map_lookup_batch currently returns EINTR if it fails with
> > > > ENOENT and retries several times on bpf_map_copy_value. The next batch
> > > > would start from the same location, presuming it's a transient issue.
> > > > This is incorrect if a map can actually have "holes", i.e.
> > > > "get_next_key" can return a key that does not point to a valid value. At
> > > > least the array of maps type may contain such holes legitly. Right now
> > > > these holes show up, generic batch lookup cannot proceed any more. It
> > > > will always fail with EINTR errors.
> > > >
> > > > Rather, do not retry in generic_map_lookup_batch. If it finds a non
> > > > existing element, skip to the next key. This simple solution comes with
> > > > a price that transient errors may not be recovered, and the iteration
> > > > might cycle back to the first key under parallel deletion. For example,
> > >
> > > probably stupid question, but why not keep the retry logic and when
> > > it fails then instead of returning EINTR just jump to the next key
> > >
> > > jirka
> >
> > +1, keeping the retry logic but moving to the next key on error sounds
> > like a sensible approach.
> >
> I made the trade off since retry would consistently fail for the array
> of maps, so it is merely wasting cycles to ever do so. It is already
> pretty slow to read these maps today from userspace (for us we read
> them for accounting/monitoring purposes), so it is nice to save a few
> cycles especially for sparse maps. E.g. We use inner maps to store
> protocol specific actions in an array of maps with 256 slots, but
> usually only a few common protocols like TCP/UDP/ICMP are populated,
> leaving most "holes". On the other hand, I personally feel it is
> really "fragile" if users rely heavily on this logic to survive
> concurrent lookup and deletion. Would it make more sense to provide
> concurrency guarantee with map specific ops like hash map?

Brian, any details on the EINTR path? is that just to survive concurent
batch-lookup and delete?

if that's important use case I guess the map specific function would be
possible, because it's broken for maps with holes as you described

thanks,
jirka

