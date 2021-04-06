Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE63558DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbhDFQJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbhDFQJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 12:09:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76FFC06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Apr 2021 09:09:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y32so7517220pga.11
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Apr 2021 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4a/4YHv3JxQpEzv09S9kusNf9ICn+oYA1ZctOwQOXqY=;
        b=rPv/WPI61zJvR+SqeD/PRp7WZPQP1azAMVLLxsGmCg9WwJ6GYAEv0dJivPlEOOcrFr
         HUIwY60rXdiDjDETsyDc8s77pIyU2BeB97Ty9Eo/xI3skX2FKW6xTv2vJ6R5mXyTjMlZ
         vbQiN+xdFD2TJ/TpayLtC2CwkRSEJ9InmUmX9e2WkAcmEm2mCyYu+YBksoBHaII87XOh
         3wXn8ILoPEDnwofbjwneHEkX+k8H+vZ0AAV4/T+u66gAZVmnahqjaJVYLq0jxT7Gd8xv
         2/6SvqpDy9Cd7eXZBtlnNfsv8P15w8iBLW4I2lYWPh2QHuTbryA319hwOobBNhL39n6+
         N26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4a/4YHv3JxQpEzv09S9kusNf9ICn+oYA1ZctOwQOXqY=;
        b=uHrNk+/3ZI5bGqfTlu67Tdxqhh9TY9lIBey3nBdjUBwS+trg6/jw1uYY8LUPUFSW21
         o8otJlp+xlQrbev8yu0eMbyogYtEQzG58SYgUrazyuYAXWJF1by9BqFRkWVpTOSEn0HP
         rLPKQXmnWv2+hSHttEU85yJRN4PCUFep2Qsn2XZwlWrXXj8s2t0Yq0obeE/itvD/4SgQ
         bS/k8pIYqhOuFxnzQsVaJdTdlNSgP8eAxUXOHA72E6jqYhvpxkkZv6f8Ajx6KGYZCl9C
         LrgRNd8rqR1npM3Rx1A0Fd7EbIvUqNkAt8PZ3MGlYE2EIqIWbwbejUiDN/QM7Lsq0KYR
         mbXg==
X-Gm-Message-State: AOAM532jyJNZniyVOkEbtvwSDZReWeZB0SBx0Na92dYTPo+F7woA1T0V
        qDQFyjVETnsGiQT4m/t6jywNoQ==
X-Google-Smtp-Source: ABdhPJx1YgZHW/piOT0X4kjZvHal1VF7O1qAiZkkNs2f/l+keI/fNoptH0eWbnXx1/x5zT0YD1LPMg==
X-Received: by 2002:a63:ea50:: with SMTP id l16mr28420726pgk.70.1617725344407;
        Tue, 06 Apr 2021 09:09:04 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id a21sm2906605pfo.189.2021.04.06.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:09:03 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:09:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/4] KVM: x86: Fix a spurious -E2BIG in
 KVM_GET_EMULATED_CPUID
Message-ID: <YGyHnLXhV3Iy/AtE@google.com>
References: <20210406082642.20115-1-eesposit@redhat.com>
 <20210406082642.20115-2-eesposit@redhat.com>
 <87k0pfcx4b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0pfcx4b.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 06, 2021, Vitaly Kuznetsov wrote:
> Emanuele Giuseppe Esposito <eesposit@redhat.com> writes:
> 
> > When retrieving emulated CPUID entries, check for an insufficient array
> > size if and only if KVM is actually inserting an entry.
> > If userspace has a priori knowledge of the exact array size,
> > KVM_GET_EMULATED_CPUID will incorrectly fail due to effectively requiring
> > an extra, unused entry.
> >
> > Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 33 ++++++++++++++++-----------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 6bd2f8b830e4..27059ddf9f0a 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -567,34 +567,33 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
> >  
> >  static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
> >  {
> > -	struct kvm_cpuid_entry2 *entry;
> > -
> > -	if (array->nent >= array->maxnent)
> > -		return -E2BIG;
> > +	struct kvm_cpuid_entry2 entry;
> >  
> > -	entry = &array->entries[array->nent];
> > -	entry->function = func;
> > -	entry->index = 0;
> > -	entry->flags = 0;
> > +	memset(&entry, 0, sizeof(entry));
> > +	entry.function = func;
> >  
> >  	switch (func) {
> >  	case 0:
> > -		entry->eax = 7;
> > -		++array->nent;
> > +		entry.eax = 7;
> >  		break;
> >  	case 1:
> > -		entry->ecx = F(MOVBE);
> > -		++array->nent;
> > +		entry.ecx = F(MOVBE);
> >  		break;
> >  	case 7:
> > -		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > -		entry->eax = 0;
> > -		entry->ecx = F(RDPID);
> > -		++array->nent;
> > -	default:
> > +		entry.flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > +		entry.eax = 0;
> 
> Nitpick: there's no need to set entry.eax = 0 as the whole structure was
> zeroed. Also, '|=' for flags could be just '='.

Agreed on dropping "entry.eax = 0".  I could go either way on flags; I do like
that the "|=" is consistent with do_host_cpuid().

> > +		entry.ecx = F(RDPID);
> >  		break;
> > +	default:
> > +		goto out;
> >  	}
> >  
> > +	if (array->nent >= array->maxnent)
> > +		return -E2BIG;
> > +
> > +	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
> > +
> > +out:
> >  	return 0;
> >  }
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> -- 
> Vitaly
> 
