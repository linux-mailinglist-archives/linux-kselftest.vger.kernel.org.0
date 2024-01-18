Return-Path: <linux-kselftest+bounces-3191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5550C8316CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 11:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E45287A1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EA22F0F;
	Thu, 18 Jan 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwNU3k4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0022F06
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575005; cv=none; b=A11NvEPVZqJkeiBN3B9wCp2flIfS4P+CpVv/mILEnHF4Qznw8XWo/4nuJzSGJN45NeB0t7tuZ6wcOSa5mxY9ShzWAn7K/5Zf3hF6+HlCsE6m7zGH5s6IfXwiqIuiYaC7pR3NF3t4Ho/O57QIsU1/sLLnXGqU4F3K6jD8VXxjCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575005; c=relaxed/simple;
	bh=iS1UBtJ4OBMXqQe+yabzwrfh5jXGDhXxcStRJOoFJXw=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=J0AItbqzwgUtVHzAZK0uv1wz9kG9q8ChmYvqA6CIWcdpWPaXyGp1VLD2sjZQxIKgeGTyxeRbsAwwqsxn7ScucXdEwAo7UGtV55NWYfDxIPtmT7snx1+kF1PC9Rt97LL//JObYEnhK9qqPnLtfoHPkwXIpKT/bZeHT+7gp5Wr/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwNU3k4o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705575003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q0/q77NncMD0jBBUR5vFOhwaFJD9FMGYhyvsY0gR92s=;
	b=iwNU3k4otNYXjPkx8SSvJFDii1UbbcmeiQVo3eNvhP64LQ4/zZkIuffeGmQOTo/UOKLgtX
	wT4h4mA+8vRwFuh8XBoehnbkeaJqaXltKL/nr6cnR0D0aev0D99UtGycMpYNm1E+bt5al9
	j9goUwR+vulGf0tOirV2ojyOhZgkSn4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-sxkuLaBeMWOGqLlMNqKJCA-1; Thu, 18 Jan 2024 05:50:01 -0500
X-MC-Unique: sxkuLaBeMWOGqLlMNqKJCA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4303fceaso15484885e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 02:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705575000; x=1706179800;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0/q77NncMD0jBBUR5vFOhwaFJD9FMGYhyvsY0gR92s=;
        b=xDJri3kHcqp64+nF4dWUwhrUb7AwWRZHqqYX1/jbtH9LfDHHk7O6/Lw71COLVklRIV
         0FQiqXFzErLsiQqSPyz2+Gx5ijqOzjgtx8jwXmU+ju8zUUSP/Rw/RZvHUwm+WR3pLWB1
         rTWqrn/6YXApnwEE/fuy00JtSjUIsdX3CSWzp2FIvX06Gs7ap14kIppatTh/OugVvQ83
         zXsNPRkzgtdgeLuCAT/jp94LnYUtxXlmZSha5aD+pnUKiT952yHliofLU3Yx8Bv4+UH7
         0GH3X/yE01YF06J+gH7qQxOo6IsWg6mls+xeJaH/PiPEd029U6tZF3nETaCzMYJio/b4
         DSsg==
X-Gm-Message-State: AOJu0YyoL3uehIeSARpjfW1+VJScdIvW5JeWiXg2rlcexbplccR+pOzw
	K2N2T/8Ho1J7v5QARVD531yx6qtXcsc4KMGEelStHS7vH4rgx/LSdMpqQBcQ/iBXbwAyFIihYr5
	U+qMyhCicO1IJFgEycuQifvjy03xnM7knr1klt2TqiVXCat6kcuFdOqrQabxK494ntg==
X-Received: by 2002:a5d:53cd:0:b0:337:bfd8:65d with SMTP id a13-20020a5d53cd000000b00337bfd8065dmr824456wrw.0.1705575000369;
        Thu, 18 Jan 2024 02:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkAojxtdSGVC9kAjz4umARt5DNykNnouEJPSZdDo/JO60dJoWaCSHSNAsPfS72ZeCgCXHTtA==
X-Received: by 2002:a5d:53cd:0:b0:337:bfd8:65d with SMTP id a13-20020a5d53cd000000b00337bfd8065dmr824444wrw.0.1705575000055;
        Thu, 18 Jan 2024 02:50:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4012000000b00337c485f1d2sm3378976wrp.82.2024.01.18.02.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 02:49:59 -0800 (PST)
Message-ID: <ac41b2993cd2c77332ba0fe57ae4a5433cf9a2fe.camel@redhat.com>
Subject: Re: [PATCH net] selftests: netdevsim: add a config file
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	shuah@kernel.org, jiri@resnulli.us, linux-kselftest@vger.kernel.org
Date: Thu, 18 Jan 2024 11:49:58 +0100
In-Reply-To: <20240117073957.783fbe2a@kernel.org>
References: <20240116154311.1945801-1-kuba@kernel.org>
	 <397aaa82985c749f03d0c6dc034e479d49df1b32.camel@redhat.com>
	 <20240116103430.600fdb9c@kernel.org>
	 <9716ed0c1a9f06256d42ed493cda6b7a43cdaee2.camel@redhat.com>
	 <20240117073957.783fbe2a@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 07:39 -0800, Jakub Kicinski wrote:
> On Wed, 17 Jan 2024 10:32:19 +0100 Paolo Abeni wrote:
> >=20
> > I think something like the following should do:
> >=20
> > cd tools/testing/selftests
> > make TARGETS=3D"net drivers/net/bonding <...full relevant targets list>=
" O=3D<kst_dir> install
> > cd <kst_dir>
> >=20
> > ARGS=3D""
> > for t in $(./run_kselftest.sh -l| sed -n '/<test name>/,$p'); do
> > 	ARGS=3D"$ARGS -t $t"
> > done
> > ./run_kselftest.sh $ARGS # run all tests after <test name>
> >=20
> > Probably it would be nice to add to the kselftest runner the ability to
> > check for kernel oops after each test and ev. stop.
>=20
> I wasn't aware there's a way to list tests! That should work well
> enough we can run them one by one with make, that's fine.
>=20
> ./run_kselftest.sh only seems to work for installed tests, tho,
> in tree it says:
> ./run_kselftest.sh: Could not find list of tests to run (~linux/tools/tes=
ting/selftests/kselftest-list.txt)
> So perhaps the wishlist item would be "make list_tests"?

Yes, kselftest-list.txt is created on the fly by make install.

As such step could be constrained to the relevant selftests directories
(see the above code snippet), and a 'make' step is required anyway to
run the tests, what about using directly such target?

In any case I don't mean to block this patch, let me apply it...

Cheers,

Paolo


