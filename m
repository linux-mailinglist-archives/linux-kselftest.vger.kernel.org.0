Return-Path: <linux-kselftest+bounces-26427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987ABA31652
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CC23A285B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB81E492D;
	Tue, 11 Feb 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1hBYkRL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DC265638;
	Tue, 11 Feb 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304043; cv=none; b=cVY0LVdGMJlUIhD9vHU6IwSby7r3CcXMExS9k/Kd+QPwKq+sGivmvl7318iPelAMHvO9Y9NV4ryiSM3a/08HpbBGepOJ7VpcMXV+GuztCK0fGNfN/KFF1VvysdGh/joqP6d3v8HxuyZ+0U8VmKw9cecExDYgsttk3YTFi06oH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304043; c=relaxed/simple;
	bh=eIOanNpHgZRp25LDvle44RVOT0SL2bgcaw3x9nsSjow=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFoOZW86vnQPH6isPOX4s8cJ5QtlFa8wPkdSXsaJ49dd2Tesql1NOhWK1F32Rl70a/LoWX6eaLbF++TUgKUNGb6+megz/h88j0SeSrjhvtxoPzgr3qL9Un99fKBKjog2+mjI8cqfQ6VxLRkAiHccYsjDox5/U6No26CIGJn1KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1hBYkRL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f2f386cbeso110978705ad.0;
        Tue, 11 Feb 2025 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739304041; x=1739908841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEbWnqt2oULWwMWmZN54fieoZru+vYPqpAY8fjJmJgo=;
        b=g1hBYkRLoVFWgbXF2Iptv3zRKGwn8vLWejUEuK6bEUf6iB6PtJYWMDhIEJFg62o1Yf
         Jgwohhj/uc1SFbLHqaReYMBRG8B8iVEslSFG/ModaM+S5AacCgFVj1w6PpZWihoQqgOW
         4ErNgDzWS5tvzEOX/MNIC05o1//Z36JYmit6ohN1taDU4Qj6hwKI8xkPk43vNL/lNxlJ
         j6Sl+QQUVQEXzp9u221+cwzV0t5J6ycuEfF2WTjcHm+cOivC9/baZvKUi2gqoxEsymCG
         EhV+EBn0S8dClUcviiZqMVQWsIEcnnWRMDQt9Ij4/zR5dqIBloYnTqDA3vejX+HVU3xf
         bv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304041; x=1739908841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEbWnqt2oULWwMWmZN54fieoZru+vYPqpAY8fjJmJgo=;
        b=V1Aij8tyVplnGoN0d2vqNSUg84TNzUIqmP4DrDVvOWlwU/qP4+qkZFQn5XAV+zAzaA
         L+gKNocvZJFtuSve+GwpFdks4JMA3v0DRK3Nljwiqboh0C/80+H6sp08HV9S6nvKSsWa
         yf727yXXHtyu19095pAFBAUdwmTZ2Jc+F34zlzqs1eTLHYIHuWupWyWyuC1KMLbZMwj9
         QIrC0MWjfqxiqP52pxzPztIoE51GpLGTYEDl6tuKoCFdma+TVMyw3Ouk8FHZ8RizgPds
         ckvxDzjCwX3iXnzWka0bQjHNYM6I/vpu31OEP2EfiewtaaYocF/j1nSNs/6KiSTIsDQ0
         TmAw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pzAtCAYbZqMcktDl15Gt/gR4rS5N//BRIXYtQaWgri+zTIXVeGUBiOAbGgvq7wikgnk098hYUyzfh0RS@vger.kernel.org, AJvYcCUtJ3niJJyl0+GZAQQe2l8AM2NV6ro3iZGrPFYjqBGmqeHEmXSahROGkXswpY4M5qBRuT1Vv+HJtYkKoTT6CRZ3@vger.kernel.org, AJvYcCVMJOUNUdl5IpKXvpoF1i0X2a3HjWYDwHD66GBT7pdyn3GP1Z9vz58dwBezrH/N+nWYLYpylQKa@vger.kernel.org, AJvYcCWDHuqPcaa2CdaNfOnctD7LM3mc6Snw6u9LfwhQBpPCxnFPZ7SsWTgmAY4mjT8lerZmLK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//jkElmFsxPjhpY7wHzWYTVefbXMUZPKlm3Fmjz1J4WdeJ92A
	D1PcIoqDgtuZCr4Q2dCxLg6orh8Gz+NaVY5zRMZacmo4jUt7c40=
X-Gm-Gg: ASbGncuRhntXD0zw5L+08S7b24o/3pRuZoFeQYWY1OUdPLzqZRYP0c+gztVhudVcKZh
	dbN6aVlBnS09Y4GmNDqy6maCFENl8M9H6i/3VK05oldk9C+ePiHDW5pu6PwQxIWZhIVHzGzoLzk
	vmCtgqAQhkwdqQwGfvj3/lImHDNyZrt51pGROljCBERRbviwVfZix40LEuzWq9eDrf+9z/YZK0H
	lgX0s1lVJV+tAfYj+3tP8vppfntiL/KyIdEVogGgS2SEaVRsrQWUbZ0kuWarpMZAOntUjfPKTut
	dLPNsq24gCuY2Ec=
X-Google-Smtp-Source: AGHT+IHfoD/faKJSbsEJohkA+bmyKwVEJPr7kJDWs691jtvM85gENPzDCyvgllWAgAzxdA+rI+87PA==
X-Received: by 2002:a17:902:e946:b0:215:e98c:c5bc with SMTP id d9443c01a7336-220bbc77f99mr10067545ad.48.1739304039817;
        Tue, 11 Feb 2025 12:00:39 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683d529sm101225815ad.145.2025.02.11.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:00:39 -0800 (PST)
Date: Tue, 11 Feb 2025 12:00:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <Z6usZlrFJShn67su@mini-arch>
References: <20250210193903.16235-1-jdamato@fastly.com>
 <20250210193903.16235-4-jdamato@fastly.com>
 <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
 <Z6uM1IDP9JgvGvev@LQ3V64L9R2>
 <Z6urp3d41nvBoSbG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6urp3d41nvBoSbG@LQ3V64L9R2>

On 02/11, Joe Damato wrote:
> On Tue, Feb 11, 2025 at 09:45:56AM -0800, Joe Damato wrote:
> > On Tue, Feb 11, 2025 at 12:09:50PM +0100, Paolo Abeni wrote:
> > > On 2/10/25 8:38 PM, Joe Damato wrote:
> > > > +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> > > > +    test_dir = os.path.dirname(os.path.realpath(__file__))
> > > > +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> > > > +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> > > > +                           text=True)
> > > > +    defer(xdp.kill)
> > > > +
> > > > +    stdout, stderr = xdp.communicate(timeout=10)
> > > > +    rx = tx = False
> > > > +
> > > > +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> > > > +    if not queues:
> > > > +        raise KsftSkipEx("Netlink reports no queues")
> > > > +
> > > > +    for q in queues:
> > > > +        if q['id'] == 0:
> > > > +            if q['type'] == 'rx':
> > > > +                rx = True
> > > > +            if q['type'] == 'tx':
> > > > +                tx = True
> > > > +
> > > > +            ksft_eq(q['xsk'], {})
> > > > +        else:
> > > > +            if 'xsk' in q:
> > > > +                _fail("Check failed: xsk attribute set.")
> > > > +
> > > > +    ksft_eq(rx, True)
> > > > +    ksft_eq(tx, True)
> > > 
> > > This causes self-test failures:
> > > 
> > > https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout
> > > 
> > > but I really haven't done any real investigation here.
> > 
> > I think it's because the test kernel in this case has
> > CONFIG_XDP_SOCKETS undefined [1].
> > 
> > The error printed in the link you mentioned:
> > 
> >   socket creation failed: Address family not supported by protocol
> > 
> > is coming from the C program, which fails to create the AF_XDP
> > socket.
> > 
> > I think the immediate reaction is to add more error checking to the
> > python to make sure that the subprocess succeeded and if it failed,
> > skip.
> > 
> > But, we may want it to fail for other error states instead of
> > skipping? Not sure if there's general guidance on this, but my plan
> > was to have the AF_XDP socket creation failure return a different
> > error code (I dunno maybe -1?) and only skip the test in that case.
> > 
> > Will that work or is there a better way? I only want to skip if
> > AF_XDP doesn't exist in the test kernel.
> > 
> > [1]: https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/config
> 
> I'll give it a few more hours incase anyone has comments before I
> resend, but I got something working (tested on kernels with and
> without XDP sockets).
> 
> xdp_helper returns -1 if (errno == EAFNOSUPPORT). All other error
> cases return 1.
> 
> Updated the python to do this:
> 
>   if xdp.returncode == 255:
>       raise KsftSkipEx('AF_XDP unsupported')
>   elif xdp.returncode > 0:
>       raise KsftFailEx('unable to create AF_XDP socket')
> 
> Which seems to work on both types of kernels?
> 
> Happy to take feedback; will hold off on respinning for a bit just
> incase there's a better way I don't know about.

Any reason not to enable CONFIG_XDP_SOCKETS on NIPA kernels? Seems a bit
surprising that we run networking tests without XSKs enabled.

