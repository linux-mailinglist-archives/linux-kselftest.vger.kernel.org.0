Return-Path: <linux-kselftest+bounces-36730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84335AFBD3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 23:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D893AEFAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6528507E;
	Mon,  7 Jul 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+dqu00G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F4219300
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922721; cv=none; b=iKWhBnOzjvVnExq2hO5qNXzFPPqAYHCbLUAEOPz0ueX67SuFBIi25EXMhOPOxJ/WvY3SGVkfowOTJguUBfwLqT7G1Fsu9xIadRQRQGimssggVPA4nlLKYfZ4PQh+8SrOiAWjagup81z/SBDnZG92nnPpvBY0+O16MM00F587gD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922721; c=relaxed/simple;
	bh=5oHfqG3O17w9lU7WjSakJmAdXME54KmOmq0/lL5/hZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7dQ/x4ngSZwFGLpIofpCVNoJq30AmH6kK29qOGEkfkEpbXLibNSjBs5HcZNF4Z6HJhV/bUaDA+f+i6IcmW7CRqZewYyYJk3+uV4T9V396S1dEwmTeC9Mm64BNzz75k4OSNaSSSGBcQ+AW09rVhy+BvmdtQV/6HF1Qb4I7toJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+dqu00G; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235c897d378so32409155ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751922719; x=1752527519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNJvYTiuCPMoM+Qw7ByUKwzYFADxxCOxfSQ7GgdZSps=;
        b=J+dqu00Giw9+L2Dy1nG/O97XCSWMD2BryCxCW5UpoSH30b3ScflSuSAx3MZe+v/Xx2
         bapZrj7TLwUxQVBZFcPdOkcESbuD9vqZ8EpXakjnD4wO30sxtW01vZSjVscI6cWXD+cj
         tUK0HQ8vmWsOIItnk8Svb4yVClg/OjCllMrwl4/EYmm4mXCNId893bxAUC2/ubjlOz6+
         QDBcQhndtGa54e9EIScgFIkmbK2GkPxnN7apAxq1p4hsKVOn16j9seWdvPeHkEuURcm4
         ggZxivNp2fcEZ/+ZmSktAEsK2oAg6/tkb1LKi3r/Xk24PPpJEXgNKCqLyDpsXQESmcPL
         rl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751922719; x=1752527519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNJvYTiuCPMoM+Qw7ByUKwzYFADxxCOxfSQ7GgdZSps=;
        b=Vj6megOKEI2VDTgsViyiC3jQd3t/seyHAB5durRQ/Sl8/nQjIu5evJAcRftSKHu0uw
         +vsU1cJmp+31qCkXMPmCUrJpBZ+JH2OWOG7Ar/UqB8syrjHSBFMQ+ov85ma0LNot5rVK
         dctNzt2O9B1mVCKoCQOpnO21foAaKL1o+krzbxUA+eefCcjdQnDyThyBnMhwLPUMr8HF
         p2b+P7/YpvT6bCd7RTnlgVGaX336c0Hvrbvwz/V/sT1GXx6TXgBLUoI/ERpdvI3E43b5
         Bauu7lEiNGtw7qZr8VqQR8OwuoM+idYnZwqFGS9oU1McgFP4kfzYgl6H3sMohXpy1Ctv
         wiRA==
X-Forwarded-Encrypted: i=1; AJvYcCWwx/PE1DF1CC4yYLuObMYoZcsXu9pytSzKYHHwi7cje7vW9uBd+KYRDAA9DycNODvNd6owsNHYl/dGm4T78tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSZh5u5dKhAAjNAKR8epMUmrSDozmAw49Kj50PR6+vpR383Sn
	k/8eZqvePqn8pkLxzhayHq/pihr36N8pcFegoiUixX3vk2WGcex8eXccYMHpJ9VxIM/XH/H790W
	DsYhPtQ==
X-Google-Smtp-Source: AGHT+IGJy8/HAYZ+mJ+u83dKaw3e9sS0A0P09Sg/tbUEeisklKIzvxNCu1A0ex7hEjGeKZ6UNo0l36fO/yE=
X-Received: from plbma14.prod.google.com ([2002:a17:903:94e:b0:234:3f28:4851])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8d:b0:234:ba37:87b0
 with SMTP id d9443c01a7336-23dd1cdfc93mr2252575ad.13.1751922719448; Mon, 07
 Jul 2025 14:11:59 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:11:58 -0700
In-Reply-To: <202506271342.8913E9B@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231930.583689-1-seanjc@google.com> <202506271342.8913E9B@keescook>
Message-ID: <aGw4Hm2G1gkf2WcK@google.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 27, 2025, Kees Cook wrote:
> On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> > Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> > of the same name defined by linux/overflow.h.  Note, overflow.h's version
> > takes a type as the input, whereas the harness's version takes a variable!
> 
> Can we just update compiler.h to use typeof() and drop duplicates?

I have no objection to doing so, but I'd prefer any such change go on top.  I'd
like to get this fixed in 6.16, and as your diff alludes to, I think tools' version
of compiler.h should follow the kernel's version (and presumably the below isn't
an rc6+ candidate :-) ).

> (typeof() a type is a pass-thru). Totally untested:
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 6f04a1d8c720..cb925b883806 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
>   * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
>   * bool and also pointer types.
>   */
> -#define is_signed_type(type) (((type)(-1)) < (__force type)1)
> +#define is_signed_type(type) (((typeof(type))(-1)) < (__force typeof(type))1)
>  #define is_unsigned_type(type) (!is_signed_type(type))
>  
>  /*
> 
> 
> -- 
> Kees Cook

