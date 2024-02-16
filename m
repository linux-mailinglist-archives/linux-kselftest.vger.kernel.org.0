Return-Path: <linux-kselftest+bounces-4853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDE857E83
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290B6289FE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067012C552;
	Fri, 16 Feb 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RntgdMrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5512A17B;
	Fri, 16 Feb 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092221; cv=none; b=Z2w+Pt2TnZYkkPxv1UPFgfZiG+UO+bNwBme/mSoodsIjVYKR+tr1dzELKEvjLXex8iAK2cbdxiHCb8T5C1OArIsHDiuBuyXsCoNR7EOIxTpRP1e9JKGH6Oznm9TCvFTHjqfbQW3HeYSTa3Bcubz4hcO+nP2jH1MqCPHJCa/5c00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092221; c=relaxed/simple;
	bh=fU0hwmRGyFTOLSAjpHgGpOPMJ/0TXEpq6Pv7k51TnvE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=A00hsDCRQFaVdIhjoAKXowit4YJ7Wgu+XD4d8i/WMvYg4c/jgHUvRE40SU75N7JCH8bFNnlTY1mLOCyQkCTbHn7mviRZq948vYpcYYwJg+nipmCAnGTuD+Ru66L544wNtAznKF27a4T/sYLqYlZliWJsgr77vmBNDz0uueKPEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RntgdMrA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394ca0c874so552494f8f.2;
        Fri, 16 Feb 2024 06:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708092218; x=1708697018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrZU1p4bqROFpqXXAVPV54W+msblPmb4h2fJiYyz+t4=;
        b=RntgdMrAaPVOeC6xckt0BKHNN17uQK9Lwwpo3C7f1Md/n4MmAQTMzoT8661p0FvuiC
         OaLUrT4vV5hKI6OcZ05EZbg9fniig7CrRe4XxEr9B/vNZnnQlwFNlboyDer1npsXWtP0
         6a4g6UTAtT4GDcLEiLRjed5catI/fn1buYhu7gHAd24XeV86kMeJoDmcjgyM94eDQUBI
         Y6IxSkNDc7nYiGShZgUMhsS1HGpyy+/BItRl2ztpLz95n0UARq+I2J8NjEtqcf5RAW30
         2nM2FRHlhmC3LGmmxv2NXd3WlYUuOn7uN1tr2zBXRzVPaQhL9lGXaqkerueWogJ/CZWY
         daHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092218; x=1708697018;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrZU1p4bqROFpqXXAVPV54W+msblPmb4h2fJiYyz+t4=;
        b=F2b6ejFUjPjtf7VX8V3r8zNHA02UjYdAzi/j5iZsd1whFeGTo+E5X8sF7/2F0GjFsK
         ZWsbU6bfd3YZLH57uQCsJPXX9iyqUgD39K2TOi++sd14pQFm72NTbNBJ5bnI1Uz7m5Pw
         H9ZbuCXcnYAg0aBmgfpd6yfC7lF8FZgOoTNcYzC51p4i0DihNN8IPTTwKRvWOFQIkLGN
         JwBA/ME5bvQPPacu15UkM0kJ1IyFMCZVodXcaicokKb78k/WUxY3kyT2OB/H3M+fpzg8
         70lUTkpITxB1vng5KwXpPDeJuGrRjhzcG6nzyq+jF6cIiQDIdJ6E0/PPQ/jsWDN9WLFM
         yY1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4JGz0uBMK9U5zvIiOqbYntWIiakaHTjK2YYWDDiDBG4a8qpo2hVqyEfDPE5q8iT/I5+Ff06bOWBMJ2NWNyDBV2TCXv1jOY9MksBLZx54/rFbzsqdEuRfNpr8ZW8z1Zo6q6i1U2+8i8NTaQcymqKTRkcWniK4yNUENmmMfB+IJ8f0Kxjr2wUPTru7AK/HC0FdTZrOgtRRWkEsVUQnbz7qfwk9KPui1oLNr93jAHmToeMsBdInii2CRkA==
X-Gm-Message-State: AOJu0Ywg4EubUlpsNKvDmlAdq8S0oUCgf03vLyu9vtaHTFXoDrtHFpPL
	5eNlIgaKC1ttJrcWVPlIHs/yYXh4ZbFvrJeluUTB72WRzPCWrIDJ
X-Google-Smtp-Source: AGHT+IGlmQaMTRNrUCkgqD5x0iLG0XTzBquhOs3ZOzxy3JwdHfWyExLj/iT06IsbaC6HFAePFRpmFA==
X-Received: by 2002:a5d:4b50:0:b0:33c:e32f:fb7e with SMTP id w16-20020a5d4b50000000b0033ce32ffb7emr4200150wrs.2.1708092217730;
        Fri, 16 Feb 2024 06:03:37 -0800 (PST)
Received: from [192.168.14.15] (54-240-197-232.amazon.com. [54.240.197.232])
        by smtp.gmail.com with ESMTPSA id u5-20020a056000038500b0033b66ce7ae9sm2357799wrf.84.2024.02.16.06.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:03:37 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <df6ad8b9-4e53-4357-ab17-e9af62342849@xen.org>
Date: Fri, 16 Feb 2024 14:03:33 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 21/21] KVM: pfncache: rework __kvm_gpc_refresh() to
 fix locking issues
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240215152916.1158-1-paul@xen.org>
 <20240215152916.1158-22-paul@xen.org>
 <23e7ec31a67a73fe94b2b04dbca26ea5ca1ea238.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <23e7ec31a67a73fe94b2b04dbca26ea5ca1ea238.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/02/2024 13:04, David Woodhouse wrote:
> On Thu, 2024-02-15 at 15:29 +0000, Paul Durrant wrote:
>> From: David Woodhouse <dwmw@amazon.co.uk>
>>
>> This function can race with kvm_gpc_deactivate(), which does not take
>> the ->refresh_lock. This means kvm_gpc_deactivate() can wipe the ->pfn
>> and ->khva fields, and unmap the latter, while hva_to_pfn_retry() has
>> temporarily dropped its write lock on gpc->lock.
> 
> Let's drop this from your series for now, as it's contentious.
> 
> Sean didn't like calling it a 'fix', which I had conceded and reworked
> the commit message. It was on the list somewhere, and also in
> https://git.infradead.org/users/dwmw2/linux.git/commitdiff/f19755000a7
> 
> I *also* think we should do this simpler one:
> https://git.infradead.org/users/dwmw2/linux.git/commitdiff/cc69506d19a
> ... which almost makes the first one unnecessary, but I think we should
> do it *anyway* because the rwlock abuse it fixes is kind of awful.
> 
> And while we still can't actually *identify* the race condition that
> led to a dereference of a NULL gpc->khva while holding the read lock
> and gpc->valid and gpc->active both being true... I'll eat my hat if
> cleaning up and simplifying the locking (and making it self-contained)
> *doesn't* fix it.
> 
> But either way, it isn't really part of your series. The only reason it
> was tacked on the end was because it would have merge conflicts with
> your series, which had been outstanding for months already.
> 
> So drop this one, and I'll work this bit out with Sean afterwards.

Ok. Sean, I assume that since this is the last patch in the series it's 
superfluous for me to post a v14 just for this?

