Return-Path: <linux-kselftest+bounces-37222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961FB0349B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 04:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA993B5DB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 02:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDCDDC5;
	Mon, 14 Jul 2025 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N89qja+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DE33DF
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461138; cv=none; b=oX2ouniq3GH29fTJk0e2HI4P2S54L9rxYy7616raIgseND9laYcVyU8RZMmsEdRsL2MFXk4OVpjeaHODUNStQo+UA4/x7OoheQGuZYqSjiLEok7PEbP2ZavEbUlAYA1uroCgLEvGLDuwMlH9omsFl7/B1gk7p1x50ejQN1p+fwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461138; c=relaxed/simple;
	bh=kYetEH8EXvPG3oRRbUafwPccWu07b7TgcQ3nK/PWz6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwQ/qTmSIMEXCYGtgBfFe4mlUktot+decEbUw+FJ+43W/kae7VyFyoFB6UaPQ/Hgc+e01LbDzXbKVm1R4fY89ohMMZDyapDWb4HRHHDq7xu/iZzSx5nJ1xXRsEWPnGqfUmJNuVKBsRPi8VqzU1Ys3NbPWMMQRntGgdLfAlkdHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N89qja+q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3a604b43bso643266266b.0
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Jul 2025 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752461135; x=1753065935; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG+EqU31LjDY0rxsVXRvh11h8jbd96upL75m845wWxc=;
        b=N89qja+qEH4nb3DgI2In9mQF5rG24vDvrutU7JYURN568HLWEUc1I4ueiOwief399P
         PnUWKIuUsckroPyJ1ENNMGupX+LTui/8fB2Bx6GgHpLdImFEixMTRikzMv5o/MRCHHQK
         K6MbtnLu8yPVBU5zqH49ZE2QJjW23iKhRQTDesjomj3uNzjFClgCy35thcIAuRilLws4
         FY3WqtWe7eYDH+G4Qm+8FHyOGZT51DwBV/+e9FYPq+ZyPzJF1kFN+nJYjfQIZFa/RS/V
         GnmpceqZmi11/MpjrzD/es/KfceYRWqNT71E8AM7RXj9cT4Isd/GaPjcjI1Z+/QVsoYW
         W7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752461135; x=1753065935;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oG+EqU31LjDY0rxsVXRvh11h8jbd96upL75m845wWxc=;
        b=jz/KNg3fXLlRV7j9UHom56xzcGZMiTL/mnfp4WkN/ZPexoy1WFsDUDvzj3I8ugkTqt
         +M+K7EFDaThulkyVKw2JHZEhkNvBCc/LLhDL1P0++viesIpWLywK6X8XyNuXeSQYhAuH
         iIHPtyc4wQ4ETwdx3qL7ez1GSalH3mBKMYZpyFriVA/3NgKmrVhKnYJYu8OlIjCLats1
         ig5DfcUAdV2tzDCUiT5r1HBElRrZtd0bH9CK4Ec6MC5UaMgDANrbmfczFYqLu693M/YV
         7pUXtd9VfDCTgeB1eMA5OljR1OkdteJz6ZkY3BYZzh8kXBl5p9PlLmlvLBHFCltt0sIC
         64rw==
X-Forwarded-Encrypted: i=1; AJvYcCX2DL0FHGpgeMA9VBFrHU8iBsgmhqg4r7CHvEUm9sz//E+1qpr+60RxU8WrqD6urAr/FlsTCSmxNPRqOIBK7SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxBT1JIROrrSmGTvR+6rUSxx2MC0XDLgXQhI3foCF0/LCK8zv
	9o2xVsFFfeH/4y2OlUq3/N0OHDaW/OLyiUHZV/BAx1eBEzUXRg2DgzUd
X-Gm-Gg: ASbGncvCDtTk8LGkSNrQQY12DneCZCUKLdnbjHacyeRdtpW8B7eeBgMn+j/1TnVhl3W
	0o79seIUmMiOhU7GOotnDho6+wTCEpw1uXQipHSHmSe7FJDJHBgtaBFdfVuMnCRUJItWoBg/QmT
	O4m+96GAx0AP+CpPUJuikDBfVxvxlRt9T8STFJeOSkhQ+hhzTLDKe3wijec7vpDkFpZgm8TR6Q9
	dXkZoz2frCscFx1pmmrHoIBVXaYMZRBntXNZfCOOuMEsrpPTQk5LpVqHrfPdgsqxvFxqcXPbSLk
	fGlYhTAa1HPj9vXhOcohHJus/xu9+H1izdhKHvgujotmEDVwSNkVGliGkkmPOLAdXsL/t6FREu8
	XlQGpscf5o6L2qj0xy/iCag==
X-Google-Smtp-Source: AGHT+IHGtRe8EFfh1hYadjrhzjsSqtJqAm/1G7H3WUAtna7LHp58rR5a4n8y5bN58JERDNV9pNojeQ==
X-Received: by 2002:a17:906:f599:b0:ae3:5185:541a with SMTP id a640c23a62f3a-ae6fc11239emr1123267066b.54.1752461134976;
        Sun, 13 Jul 2025 19:45:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645adsm743476766b.107.2025.07.13.19.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jul 2025 19:45:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:45:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, riel@surriel.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC Patch 1/2] selftests/mm: put general ksm operation into
 vm_util
Message-ID: <20250714024533.m3id5ovvsm7vhrwc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
 <20250604082145.13800-2-richard.weiyang@gmail.com>
 <5f7f1281-c75e-4cfe-b51f-8d6ed001200b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7f1281-c75e-4cfe-b51f-8d6ed001200b@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jul 11, 2025 at 05:37:54PM +0200, David Hildenbrand wrote:
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
>> index 1357e2d6a7b6..115422e9eb68 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -486,3 +486,74 @@ int close_procmap(struct procmap_fd *procmap)
>>   {
>>   	return close(procmap->fd);
>>   }
>> +
>
>I think we should just let all these functions open/close the fds. So there
>will not be a need to pass in the fds.
>

Sure. Will update it.

>> +int ksm_use_zero_pages(int ksm_use_zero_pages_fd)
>> +{
>> +	return write(ksm_use_zero_pages_fd, "1", 1);
>> +}
>> +
>> +int ksm_start_and_merge(int ksm_fd)
>> +{
>> +	return write(ksm_fd, "1", 1);
>> +}> +
>> +int ksm_stop_and_unmerge(int ksm_fd)
>> +{
>> +	return write(ksm_fd, "2", 1);
>> +}
>
>Can we make all these functions return "0" on success? This, way, the "write"
>will be an internal implementation detail.
>
>E.g.,
>
>int ksm_stop_and_unmerge(void)
>{
>	int ksm_fd = ...
>	ssize_t ret;
>
>	...
>
>	ret = write(ksm_fd, "2", 1);
>	close(ksm_fd);
>	return ret == 1 ? 0 : ret;
>}
>

Sure will do it.


-- 
Wei Yang
Help you, Help me

