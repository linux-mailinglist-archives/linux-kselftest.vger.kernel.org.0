Return-Path: <linux-kselftest+bounces-3140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27B83025A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497FE1C20FDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168313FFC;
	Wed, 17 Jan 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcxykHDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302813FFA
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483946; cv=none; b=SvGrCSTRRQn8BRT6oNskWRg0egoSZG+8qq5znZWIEfqiBZIuBj3hOiwfwVxViKFRNGQOoTAiLpNRS5PWsDtkR1N/tdbeiTfy6pEvPbbZBXJeftIKlOSst/Ybl492y5TZ/ZbcLZbgrKtZwsqk4Y660tjj2yF32VidmkLYKAKSFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483946; c=relaxed/simple;
	bh=/imKL3+ayYzmNpJJNpvrotqiOdwTSn+f9XCWxjze8j4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=LNwK0h8G5jszV/tGaH3f/74a4KV8WBvaYIbtcQi+kBalxJizavVB/0e4pDWlhSccl0Z4llN+n5bx1kGrjlbiPXuXHWxZTi3hZkZTYyYJXDYdU4ZEjBmSonbYofv0lxdzbWZ/ChVlQFJs2xo7RSr/yMovTAcDn06objVhAlmPoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcxykHDn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705483944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8qxUADM6Nge0ZwJSS7NywWKjA81kvR0HBVtizsU1Q+o=;
	b=FcxykHDnJouAYu71wDRsolJELeaDOzHQGO6kZyMPPPcKaD3yRNtcWLy5yzCVpiZ6NH3BSd
	sTnfxCHVJsLjCx/0y4hlDPJ85NDCfnd8TU3o4837w5Hykg5/XkPAddIWN+HrWE4oqjdF0r
	3lnSPvDYMAXH6bMtEDIA9AvKQMtzI7Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-DrN7lQWLOVSPjJp_NwHNIA-1; Wed, 17 Jan 2024 04:32:22 -0500
X-MC-Unique: DrN7lQWLOVSPjJp_NwHNIA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so14669665e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 01:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705483941; x=1706088741;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qxUADM6Nge0ZwJSS7NywWKjA81kvR0HBVtizsU1Q+o=;
        b=wA0911LoC4nzh5fDbFQdyYHaRLbLw3KhDcNheWX9cmCYzlGgipAWeCok5NNqk18SEP
         cvkzDSdCae4/izWQ3D3eZ3grHbXPfGRlj+gdGm/M5/BVjh1k8sAOb/prQVvXVsk6icOm
         KkPRD9/eHHGDIQSxgAJ9x948GbTSJCzmQ+w+H3enwrNvHqfqXZU7RrHzNtOrsK83F3I8
         +17exGzwbSW/iDJLvcnu+Zod+wRI6Ap//PkoSGZfL4klueT0EI3IKijlRfhjvAoTpTa0
         EwTeZNuaI+7hWxBehcA7KEd/5g6ZQlJykEuYclaofZya9VMuW7fyXNRUk+nND0sAvi0m
         5jUA==
X-Gm-Message-State: AOJu0YwMpxrIOVVY8a+shM6k8EN0mBiODq5b6kM+6JFK6Mmg68Ou8CAP
	d5emlIDuyGb8GQCoETfkB2yk93/rAOFBOeCvs80S+LkAGmUR0NMAXJiXMu83Osi04bpOCKVkusQ
	FX8hlZf+18584XRx3dgJPfUPqjtmWHgoTHHhO
X-Received: by 2002:a05:600c:35d5:b0:40e:89e8:107a with SMTP id r21-20020a05600c35d500b0040e89e8107amr773718wmq.3.1705483941454;
        Wed, 17 Jan 2024 01:32:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEub5ZACmCdZpuL32hhjWjk/eQjhAUjdokVzr1TdN5lc8FiPsxoyenSDdUOv2kFBxz9M82oAw==
X-Received: by 2002:a05:600c:35d5:b0:40e:89e8:107a with SMTP id r21-20020a05600c35d500b0040e89e8107amr773702wmq.3.1705483941054;
        Wed, 17 Jan 2024 01:32:21 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-208.dyn.eolo.it. [146.241.242.208])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1213459wrw.57.2024.01.17.01.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 01:32:20 -0800 (PST)
Message-ID: <9716ed0c1a9f06256d42ed493cda6b7a43cdaee2.camel@redhat.com>
Subject: Re: [PATCH net] selftests: netdevsim: add a config file
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	shuah@kernel.org, jiri@resnulli.us, linux-kselftest@vger.kernel.org
Date: Wed, 17 Jan 2024 10:32:19 +0100
In-Reply-To: <20240116103430.600fdb9c@kernel.org>
References: <20240116154311.1945801-1-kuba@kernel.org>
	 <397aaa82985c749f03d0c6dc034e479d49df1b32.camel@redhat.com>
	 <20240116103430.600fdb9c@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-16 at 10:34 -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 18:40:49 +0100 Paolo Abeni wrote:
> > On Tue, 2024-01-16 at 07:43 -0800, Jakub Kicinski wrote:
> > > netdevsim tests aren't very well integrated with kselftest,
> > > which has its advantages and disadvantages.=C2=A0 =20
> >=20
> > Out of sheer ignorance I don't see the advantage?!?
> >=20
> > > But regardless
> > > of the intended integration - a config file to know what kernel
> > > to build is very useful, add one. =20
> >=20
> > With a complete integration we could more easily ask kbuild to generate
> > automatically the kernel config suitable for testing; what about
> > completing such integration?
>=20
> My bad, I didn't have the right words at my fingertips so I deleted=20
> the explanation of advantages.
>=20
> make run_tests doesn't give us the ability to inject logic between
> each test, AFAIU. The runner for netdevsim I typed up checks after
> each test whether the VM has any crashes or things got otherwise
> out of whack. And if so kills the VM and starts a new one to run
> the next test. For make run_tests we can still more or less zero
> in on which test caused an oops or crash, but the next test will=20
> try to keep going.=C2=A0

I see.


> Even if we force kill it after we see a crash
> I didn't see in the docs how to continue testing from a specific
> point.

I think something like the following should do:

cd tools/testing/selftests
make TARGETS=3D"net drivers/net/bonding <...full relevant targets list>" O=
=3D<kst_dir> install
cd <kst_dir>

ARGS=3D""
for t in $(./run_kselftest.sh -l| sed -n '/<test name>/,$p'); do
	ARGS=3D"$ARGS -t $t"
done
./run_kselftest.sh $ARGS # run all tests after <test name>

Probably it would be nice to add to the kselftest runner the ability to
check for kernel oops after each test and ev. stop.

> So all in all, yeah, uniformity is good, the hacky approach kinda
> works. Converting netdevsim to make run_tests is not a priority..

I agree, but also will put the all the above possible improvements in
my wishlist ;)

Cheers,

Paolo


