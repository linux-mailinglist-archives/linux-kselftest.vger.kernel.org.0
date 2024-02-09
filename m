Return-Path: <linux-kselftest+bounces-4454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A538284F948
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C54295161
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6778693;
	Fri,  9 Feb 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHjHDrhR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFF76905;
	Fri,  9 Feb 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494726; cv=none; b=ht1fZSPDJ+q98BfZaB8yNVedJdlP+PQGhBhkyKZ2UtrFXoTcriM4hB10H8Gv/Kv5lA+TrFl+Z0Ecbhu/EHqEukVYePDWfFPzT1nAHPjzTmyofho6xctn1enTzOm2ZK2X4FJk2QntXWalZ5OFx9Ssio5XZKKXYRfrcTERqPJmKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494726; c=relaxed/simple;
	bh=OyS7cKgx+8/j7nwgFm8s59L6NWyY+XVkT2WE7cK09P8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SOAD0eucUB1Nq3Xq/nH5G7tGHIyKYXrvF1nsMXRvMM9wDW2fp6XL0xVpxtk7vKSHfa/7yeFgNBPBAd+9NtvAHvV3ZmdFZszjYpOW7cBFoIm3vawN1om3QfN1NsAv87k5Mj9vsFG77FMjhuwGCau8bl+v19lC46HCJYVgV6hHHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHjHDrhR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337d05b8942so611249f8f.3;
        Fri, 09 Feb 2024 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494723; x=1708099523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yROLjKjKvHqt96A03T7z7gjxYxKm2yVmYfDv8IQ9Muo=;
        b=PHjHDrhR/JWtNCZABdR0ymln53do2mAZfLaqD9UkvLZ0Djl8UMSUmg0Hj71y/xD7ea
         JjprzZCP5Jerl38wV43Fdww+FlHJl9x3NjRbS92CYuKbbA6sz1IHbj6CCtIGZA2s1CYI
         Ls5CG/U7Fd9ebyndBvXsJR7LOQBOwJQcStfoVP3QYDLWSypoX4mj/9DJA/TE/prJFyvM
         wCJVDOHbE+YkRL/Qll35gf2ATf9XLZye4FeFwVQ1MDBXB0MDDEXdA9wxprYSmrOlJyya
         6ATD8Y+tpF03ij4+fob21xZhCbI/Zt6if+ZIQhseCwUd0tvWyuUNVHYKYT/0qWT+/Wdc
         kQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494723; x=1708099523;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yROLjKjKvHqt96A03T7z7gjxYxKm2yVmYfDv8IQ9Muo=;
        b=IcxbhXH0/9Tt5111xM+YJU1/FZISFyDm4mj+69GnwnhVFUx3V3jkKzEBEzTegBtrEe
         5GviVHekWFGHGfYFeLzsgMuRRvxUfF2yY+QZgUNpuLvSankHrCc19Sw52u9Er4KXUcfh
         zK9SzWPbd23CmNjn2VB1DaIms4o9RIjxf9/2qhi2npLZeHdQMVt+uN8oMmkkMVowAaWh
         0RhbhJ/T4gXUdWf4FFhW5ZLtY/1mJXdzwMe53C3kFZowS3z+1etl3+6zJVIVJGHUx/NO
         CtrqB4PnArNq8nSigVw2rNR+t5amqEaKsp4EMl5dptfCQ4VZnBAPNy2sAS4exknLPyzI
         PL7w==
X-Forwarded-Encrypted: i=1; AJvYcCWLoNQwW+/pau5JPmvw+rNe10YFkLtv1jmnm6cx2J1ATdQz6i8emA07jIrySuIHcBq38G4O/QA4xc3G7OOis1oEqV4ZtlXn5tdeRg7ikLCmSqfLy0BFvjkeIzFNPqFAx1YqGIX8UAx4RdFhkx02DcdlywlZIdT1ApWz5Nl4XAfv7K8XnKA+1CNr4uiRjEyetyy/RmbOmC6NtH3NINGA
X-Gm-Message-State: AOJu0YzBu5fxWIqTchnrQ0B6IaYqIR9NwQeJVO64pNx77IBjDTtISZkv
	ejEr3OP8BZm5gc00K+i12RuyRr3z0EOIb6h+Q9K95T19d8PXoJQA
X-Google-Smtp-Source: AGHT+IHOF6VXideo9WCm/ScE1inf8+41nllDO4E+RHTz4hlfFoiR9a5kXvXJq12xSWxJt+oOkd6Jbw==
X-Received: by 2002:a5d:4105:0:b0:33b:3ec8:12e6 with SMTP id l5-20020a5d4105000000b0033b3ec812e6mr1292236wrp.44.1707494722467;
        Fri, 09 Feb 2024 08:05:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/mae/TLMIWkUAZy1WxwAnjy3AUOPAnpN3tHWS46b0oi1z40Ggl+EYgKud+9QLZ6+6CrUbTd8m5GVF6O2JGdUuR/QWUMfHrLQ7ifgeEvjefaxEE66Ns/rT3OXDYaCUoycuZZFTXdhcMVcbmmlJaAjpkZnVMTC67UQvtyLTI6qKPx8KvhcVggI37saJxO5POdh5oobPdXw86+Y86dJPHLuekK3t71JX1iE1JGOUuFM35kXZpFBGg94zHh4J9nyDxjFsvvEMpMGL2kTaI71S9nnVG++6/r5TZvq6VIbh/7DFO2E/yxemsOu5G7NpADPuxYrF2PgCnislylHnhUPR302Dx7+2YZjEyXWFN+cYEaK2ghdo951de5vKi+IBCyy84pj1AV7P72tfpYtU+JAPc1osE6W/fRQPKtRs3npUyKwy0MwIsiI=
Received: from [10.95.105.41] (54-240-197-227.amazon.com. [54.240.197.227])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d56cd000000b0033afe6968bfsm2117218wrw.64.2024.02.09.08.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:05:22 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c14a3f2e-4cd1-4597-947b-a149e8ea52f9@xen.org>
Date: Fri, 9 Feb 2024 16:05:12 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 04/20] KVM: pfncache: add a mark-dirty helper
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-5-paul@xen.org> <ZcZLw1KGje61A9Yl@google.com>
Organization: Xen Project
In-Reply-To: <ZcZLw1KGje61A9Yl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 15:58, Sean Christopherson wrote:
> On Mon, Jan 15, 2024, Paul Durrant wrote:
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 7e7fd25b09b3..f3bb9e0a81fe 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1399,6 +1399,17 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
>>    */
>>   void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>>   
>> +/**
>> + * kvm_gpc_mark_dirty - mark a cached page as dirty.
>> + *
>> + * @gpc:	   struct gfn_to_pfn_cache object.
>> + */
>> +static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>> +{
>> +	lockdep_assert_held(&gpc->lock);
>> +	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
> 
> Can you opportunistically have this pre-check gpc->memslot?  __kvm_gpc_refresh()
> should nullify gpc->memslot when using an hva.  That way, you don't need to
> explicitly check for the "invalid gfn" case here (or you could, but WARN_ON_ONCE()
> if the memslot is non-NULL and the gfn is invalid?).

Ok, sure.

