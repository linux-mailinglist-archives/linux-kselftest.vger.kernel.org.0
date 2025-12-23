Return-Path: <linux-kselftest+bounces-47924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD258CD877A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7432430184CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997831DD96;
	Tue, 23 Dec 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVCLiS3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB731E11C
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479240; cv=none; b=HqzNs1Bnf9cVqDKmioSvZvVx1lHJoEZ+Ack/Qp+AFOpckrQkTvNfXRTtLCFC14ZcTinCkTAfRoYxre+yBHVEM2WTx+P7iNF+Ak0/1uSufaJd0FItc9iMEjiSUP0A1mXDDOxWaOmqQ4AR4P8nbJzY0qfwlNyMdxcoE7V+1ZJPoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479240; c=relaxed/simple;
	bh=wrmq4RenFXzbX3r+9dnxq68WYSe7YlZUwq3pD+h3bX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy4RhGgwE/59uwNYNDV7RUxfxonzhM6G6rx9JwDUnjo153OR4USkDAyS6u/vvkiDSQxaQkYZfFE4VWsMoeWVpTRR+YHPLMEqGjRA/yWW1CIvRB9o3uo4uO0RrO03ULLh8LUqchRC37ttJmLnPf5gKGxv5QjyfuugLMBiVvE3bFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVCLiS3+; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47755de027eso27655825e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 00:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766479237; x=1767084037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUwtgrMapZPA5zIKs3/MUFaPRl4dU3pm9b/uTBHe6g4=;
        b=HVCLiS3++41fZNlJ20zlGkOeaMvSxC3AEpBNwuk79fRZNAp3XHZvGyGbp427rKSziO
         w8KG28vPMvTFoLjNS4PFhn0KfshL+Ovx5400bv9ZmIRZKujkLCWANCBoOa2VHcfsuvJN
         kQsXdAPELfw9vJK/irvhgHbJ1W/bhrGSwO1na/haiz20OMPaDoDlB4RzGp1S5vW1rXDM
         +bs/Cl6Ll6VYBIatd2xbtuyw/VbSTzmGdyDAfbIOCK+0eTW++EBUwTWNwe27OXC06/Us
         UC+IN0fMnZYOHeUKB8O55hoiJMI3RHkc9baErOAWaujFSA9PHgoyNekozKix6TAHqcG+
         TmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766479237; x=1767084037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUwtgrMapZPA5zIKs3/MUFaPRl4dU3pm9b/uTBHe6g4=;
        b=qFmB6cdU0vU3TCF2SPdHR45N7NubAjSwXy/QArkgRdkzAjqBHeXSdvvrL4jLucTzmK
         t/ap3q0k7GUlM+KZRvVtyqBMKCncloDaOqLV44o+YR+QLB3eczwGmpmrq1NFEPWaEZqV
         MEDxVIyt3Jvyff9T4wpqt8tVKhgiaVACi3sS8qc3G84dN4+nwUdLghwRO6TA9PMJBXA0
         7VqG0MWkHFKErBoRYwa9Xx6YwkxPNUFu7s5CPb9ScjVgXKncKNhqMZjB6vxANWsdr7U3
         V7LcK5M4BWfrVu8MW8iyPF2A7cu4Ri4yyAMI/vco+aOq3qKz/kZmLXzTK4fhrmMZx7mA
         ywcw==
X-Forwarded-Encrypted: i=1; AJvYcCX62S8E9mpliv1/Q5qYFWPyQzruT5mRbIpQQwLRSyJj4EWkyDf+pTdkJxvWtMUsucCexDrT2QLVH4JnTwfqahE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxE/r3rAEtz/plDxWCu8IpN+XfgsNCOOFBMXnHTE66vrnEDb5
	tKUTzh1iT7heelrGaS6siFhztljy4IE6NkhhAwdiiYj9HQRK/brmWwZk
X-Gm-Gg: AY/fxX4EQKXuQCj4eJawSCKT1OTknsRxDhbj8c1H5vNdn7ED4hpYUxGY9W/DV3+9YMd
	Bw/K4F1q55G1EgIYP20szO/B+wmRwpaxfcZr67gtsGQIN50vMRBuzpWokETsGGXm9ZpLdr5AGiv
	r66Vh7FzSrOU3TzcUuVMVxW5PTHovNRsJnXZT1icX9Eu4Da1J/+ITryX8Yj3JyMldraOBFHhz2i
	qyuj5Q0Cbt41wgeQiFLLtI3l2E+EwpKG7pAVz6ipplHWaXm3vRyRZUU9PF5kCIhcJuNuJOZ51SI
	TsWfUodbs5qzEiQPBOvq/Vkw99EQGuA4ha6Ghl/G5w9y9RpaDIDVhnJYHL3M6O5qUsJcLonIQM9
	o0YbVkE1iFbKfLBfnLRkp2LVVqbqJwKTRwG42xLbaIWPunra2N1XQTR5ENwlm40h9B76lJ5oXJj
	L6VCxlyJ1l5CCn0gJmu01tdmIb7xsS0rC135LC19b4gVPq042aAbU=
X-Google-Smtp-Source: AGHT+IEpteUBeVyvK/GkVobHH5hYn/GMx0SLjKyrRDaOqelnxJtOqBWZOo0NwrW+rNFfDjpy5x73Jw==
X-Received: by 2002:a05:600c:5246:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d1957f707mr151767255e9.21.1766479237056;
        Tue, 23 Dec 2025 00:40:37 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm26831637f8f.18.2025.12.23.00.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 00:40:36 -0800 (PST)
Date: Tue, 23 Dec 2025 08:40:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Li Wang <liwang@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long
 <longman@redhat.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
Message-ID: <20251223084035.67ba1b76@pumpkin>
In-Reply-To: <CAEemH2dZ3DxDPWuV1Uze213CqoFHec9kK+MeteigGANYTUzbqA@mail.gmail.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
	<20251221122639.3168038-2-liwang@redhat.com>
	<20251221221052.3b769fc2@pumpkin>
	<CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
	<20251222094828.2783d9e5@pumpkin>
	<CAEemH2fsAmhAkGAQb9rtD2WLUc7QMb9Q5dusG3S8LsJbNKsO_Q@mail.gmail.com>
	<20251222180509.b12684e112195ac3f7ee9389@linux-foundation.org>
	<CAEemH2dZ3DxDPWuV1Uze213CqoFHec9kK+MeteigGANYTUzbqA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 10:41:22 +0800
Li Wang <liwang@redhat.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > > It is best to use strtoul() and check the 'end' character is '\0'.  
> > >
> > > Hmm, that sounds like we need to go back to the patch V1 [1] method.
> > > But I am not sure, @Andrew Morton, do you think so?
> > >
> > > --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > > +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > > @@ -86,10 +86,17 @@ int main(int argc, char **argv)
> > >         while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
> > >                 switch (c) {
> > >                 case 's':
> > > -                       if (sscanf(optarg, "%zu", &size) != 1) {
> > > -                               perror("Invalid -s.");
> > > +                       char *end = NULL;

Initialiser not needed.

> > > +                       unsigned long tmp = strtoul(optarg, &end, 10);
> > > +                       if (errno || end == optarg || *end != '\0') {

I doubt that use of errno is correct.
Library functions that set errno on error don't set it to zero.
The only test needed there is *end != '\'.
(end == optarg will be picked up by size == 0 later - if that is actually
needed to stop things breaking.)

> > > +                               perror("Invalid -s size");
> > >                                 exit_usage();
> > >                         }
> > > +                       if (tmp == 0) {

No point checking for zero before the assigning the 'unsigned long' to 'size_t'.
So the result of strtoul() can just be just assigned to 'size'.
(Ignoring the fact that size_t will be unsigned long.)

> > > +                               perror("size not found");
> > > +                               exit_usage();
> > > +                       }
> > > +                       size = (size_t)tmp;
> > >                         break;
> > >                 case 'p':  
> >
> > Geeze guys, it's just a selftest.
> >
> > hp2:/usr/src/linux-6.19-rc1> grep -r scanf tools/testing/selftests | wc -l
> > 177
> >
> > if your command line breaks the selftest, fix your command line?  
> 
> Yes, I am ok with sscanf() :-).

What was wrong with atoi() ?
Or, at most, strtoul() with a check that *end == 0.

	David

> 
> In fact, write_to hugetlbfs currently only accepts arguments from
> charge_reserved_hugetlb.sh, and the way the '-s' is used is not
> very diverse.
> 
> --
> Regards,
> Li Wang
> 


