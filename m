Return-Path: <linux-kselftest+bounces-38201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BCB18A6B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E7762215B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EE7EEB2;
	Sat,  2 Aug 2025 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6R21FMM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14812139E
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754101347; cv=none; b=PRjCEhauKIHV2thncEW+XCfv7FRm+JJdo6SzJubvZszHcXyKfazZVbJHvodyUBgXcTiyvjPnHK4pG1HcAJZluFaiSG1o/tz3gEj0VTOWDxL9kNpG5s8SZeTGMM+2EymOxiR97g4W/X6856G0g7Hlag8etsVyzfK9yEu4FUBFQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754101347; c=relaxed/simple;
	bh=kXYrRSg2JD+bzbe3qtTUC+WfJmIjjXSC4tJN2qisO+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJHRNuWgIvInsfB9fyT1Zk0R1YKJkgMSarCE4NFpghxHNwTyBwMV0v4FhDUbzomBgPDTv8bg3LZqfHdToRMGiyxQ9mCcAhXLRNeOhO1gLoxVdLBGWqIna6qAeKeXMaruqvRZBBSai68mMZz6Ui/El7Fko7M0v/j8YAUHNFQS1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6R21FMM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso5364709a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 19:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754101344; x=1754706144; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSG1LeV3cVwQV3wuVeNb8LQrAKUqxETgJKTWaJErw04=;
        b=l6R21FMM8T6gr+3j0olRbrbusOV91Dd2OVREBISswVwyfrSxOxP/oiX1PwFpl8+kcE
         /VLtpyvjrlCuhcIhtkoMK2EUR3ypu0bPDVh40VLk9NPf4NYW/GzWnwo9kBNdaOALvL51
         IwGo1pWmSOOwvR3z2m0gabIn58UAezNyY1KVBExkhwWmM9fbCviAG1lFBeoZHt9AVeLn
         hB5J5WJeZGi12y9iBFgeYtcnJud82CZhBHIPbGAPDMdEcdCZAk4tpme7m4bDU1/zY7pZ
         /hiTdGzU8Q4e+IzSGIXVjq5iKQjvvze2aDa+xsSsTBnb3xMx8MjHBCBFe2t4dWD5m+cF
         b3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754101344; x=1754706144;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSG1LeV3cVwQV3wuVeNb8LQrAKUqxETgJKTWaJErw04=;
        b=oFZGiAHaIyxSBYhi0vzI/ghSnAKmC7dHhOAP+h53r99TvvMLdkbzQTeEJ/j9Qih0hY
         nRSlHe7fAroo3r96gnuvciCrh6meIMBCbpGLnrDcUi8GvRxwvXIzKCnz8DTXA+xJIp6R
         tgjWZrJtjPOMSpP7KExmwBN3oB6RJPT9CGoVNeH8Tez1HERjCrojF1oU9mVq3wFTyfxO
         hgLXjqdXIS9J15CqnVAY0wxM/8DAmHDPlouDO+eTqp+RsPSMczjmSl83VeHZVdCYzYq1
         K9cqg5/q15QSQadeqpHwkeIHWAlj85UIRvZ80aoBiyHE5xmxyc96j73Asba90yvAS34N
         ApHw==
X-Forwarded-Encrypted: i=1; AJvYcCU+NkcY1k4y486ei+Uis56zUrcUxg7NJ7UqE5gRmEhOyqB+OyKFsDT7KvmcUd5HhJt5x5NtNuHfJotcxtqbCOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+JRNt5YDEBXTnEwTfDxJJ1MVuH0wSzbVYjRJs63n8Cde/E5z
	lYxOo2I6YIb/ddTyloPCb6r2bHdvsl59WvrZ1bOWio0TMvZ9454p8+g/
X-Gm-Gg: ASbGncsKZzkZERBBd54RjH1UPyVROi6tqOHmPbYCeUQxVgksuVfyPb/dgGtr4xdLnaP
	0Ql46zJNJkEfYvb3KtBnbbJI+U9PGha7R1IvnsKpU0zpHPC4iRn/UPMiHLl2pN3FDurdiKBaZ9C
	1YYzVw/r++0TSGZsrSzqHUEog3yDb2IdrxaAiBZ8Z+xwG0+i4FSIAEP2/7yYvrSGODispI8cfZA
	YYxXlwW3/+3y19Zza/9XdeCVjw2PW310tuRxw44qYgRJbhAj+083bgDpph4xjzL78qKrhqSGO5P
	f7nVVci2VuklvsL/Dhp+ublHXsTHZ1LXHk6KQVl1xEcqASba5hlN+DMdrOmrc60BZEUiIbg3Cid
	J/jyZd6m5zeo1bR8GAslZAw==
X-Google-Smtp-Source: AGHT+IHDiFo+GXkK3xhr9Jlv8TPjtoUbMQljTtFnbkUlqH0I7+/3roo41mHr6kloA0aNXAxwf4/OXg==
X-Received: by 2002:a17:907:3d90:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-af9401c3e49mr199013266b.41.1754101344137;
        Fri, 01 Aug 2025 19:22:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436c2sm361389366b.141.2025.08.01.19.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Aug 2025 19:22:23 -0700 (PDT)
Date: Sat, 2 Aug 2025 02:22:23 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] selftests/mm: link with thp_settings when necessary
Message-ID: <20250802022223.qjzvuuhwm43hprpl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250801085444.27182-1-richard.weiyang@gmail.com>
 <566ff1f0-e6f4-4888-a901-4995a84d15b7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566ff1f0-e6f4-4888-a901-4995a84d15b7@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 01, 2025 at 11:02:35AM +0200, David Hildenbrand wrote:
>On 01.08.25 10:54, Wei Yang wrote:
>> Currently all test cases are linked with thp_settings, while only 6
>> out of 50+ targets rely on it.
>> 
>> Instead of making thp_settings as a common dependency, link it only
>> when necessary.
>
>
>You don't state why we should care about that? I don't see how binary size is
>a problem, why do you think it is?
>

Yes, it doesn't help on the binary size perspective.

I come up with this when doing some test. Each time a change in thp_settings
would rebuild all the tests. My intent is to speed up the build during coding.

Not sure it worth a change.

>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

